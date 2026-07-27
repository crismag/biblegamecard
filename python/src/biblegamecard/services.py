"""Reusable application services for repository operations."""

import json
import shutil
from dataclasses import dataclass

from biblegamecard.adapters import RubyToolRunner, ToolResult, ToolRunner
from biblegamecard.core.exceptions import BibleGameCardError
from biblegamecard.core.ids import CollectorId
from biblegamecard.core.paths import RepositoryPaths
from biblegamecard.core.results import Diagnostic, OperationResult, StatusCategory
from biblegamecard.repositories import CollectorRepository


def _diagnostics(result: ToolResult) -> tuple[Diagnostic, ...]:
    items = []
    if result.stdout:
        items.append(Diagnostic("TOOL_STDOUT", result.stdout.rstrip()))
    if result.stderr:
        items.append(Diagnostic("TOOL_STDERR", result.stderr.rstrip()))
    if result.dependency_error:
        items.append(Diagnostic("RUBY_NOT_FOUND", result.dependency_error))
    if result.timed_out:
        items.append(Diagnostic("TOOL_TIMEOUT", "Ruby tool exceeded its configured timeout."))
    return tuple(items)


def _tool_operation(
    operation: str,
    result: ToolResult,
    *,
    failure: StatusCategory,
    success_summary: str,
    failure_summary: str,
    affected: tuple[str, ...] = (),
    output_paths: tuple[str, ...] = (),
    data: object | None = None,
) -> OperationResult:
    status = StatusCategory.SUCCESS if result.returncode == 0 else failure
    if result.dependency_error or result.timed_out:
        status = StatusCategory.DEPENDENCY_FAILURE
    return OperationResult(
        operation,
        status is StatusCategory.SUCCESS,
        status,
        success_summary if status is StatusCategory.SUCCESS else failure_summary,
        _diagnostics(result),
        affected,
        result.command,
        output_paths,
        data,
    )


@dataclass(slots=True)
class RepositoryService:
    """Report application prerequisites and registered content."""

    paths: RepositoryPaths
    collectors: CollectorRepository

    def status(self) -> OperationResult:
        ruby = shutil.which("ruby")
        data = {"repository": str(self.paths.root), "ruby": ruby, **self.collectors.counts()}
        status = StatusCategory.SUCCESS if ruby else StatusCategory.DEPENDENCY_FAILURE
        diagnostics = () if ruby else (Diagnostic("RUBY_NOT_FOUND", "Ruby executable not found."),)
        return OperationResult(
            "status",
            bool(ruby),
            status,
            "Repository is ready." if ruby else "Ruby is unavailable.",
            diagnostics,
            data=data,
        )


@dataclass(slots=True)
class ValidationService:
    """Orchestrate existing validators and canonical drift checks."""

    paths: RepositoryPaths
    collectors: CollectorRepository
    runner: ToolRunner

    def validate(self, collector_id: str | None = None) -> OperationResult:
        try:
            record = self.collectors.get(CollectorId.parse(collector_id)) if collector_id else None
        except BibleGameCardError as error:
            return OperationResult(
                "validate",
                False,
                StatusCategory.INVALID_INPUT,
                str(error),
                (Diagnostic("INVALID_COLLECTOR_ID", str(error)),),
            )
        invocations: list[tuple[str, tuple[str, ...], StatusCategory]] = []
        if record is None:
            invocations = [
                ("validate_character_knowledge.rb", ("--all",), StatusCategory.VALIDATION_FAILED),
                (
                    "assemble_character_knowledge.rb",
                    ("--check", "--all"),
                    StatusCategory.DRIFT_DETECTED,
                ),
                (
                    "validate_legendary_prompt_development.rb",
                    ("--all",),
                    StatusCategory.VALIDATION_FAILED,
                ),
            ]
        else:
            if record.canonical_data:
                relative = str(record.canonical_data.relative_to(self.paths.root))
                invocations.extend(
                    [
                        (
                            "validate_character_knowledge.rb",
                            (relative,),
                            StatusCategory.VALIDATION_FAILED,
                        ),
                        (
                            "assemble_character_knowledge.rb",
                            ("--check", relative),
                            StatusCategory.DRIFT_DETECTED,
                        ),
                    ]
                )
            if record.prompt_profile:
                invocations.append(
                    (
                        "validate_legendary_prompt_development.rb",
                        (str(record.prompt_profile.relative_to(self.paths.root)),),
                        StatusCategory.VALIDATION_FAILED,
                    )
                )
            if not invocations:
                return OperationResult(
                    "validate",
                    False,
                    StatusCategory.NOT_FOUND,
                    f"No validation assets are registered for {record.collector_id}.",
                )
        results: list[ToolResult] = []
        failure = StatusCategory.SUCCESS
        for script, arguments, category in invocations:
            result = self.runner.run(script, arguments)
            results.append(result)
            if result.dependency_error or result.timed_out:
                failure = StatusCategory.DEPENDENCY_FAILURE
                break
            if result.returncode and failure is StatusCategory.SUCCESS:
                failure = category
        return OperationResult(
            "validate",
            failure is StatusCategory.SUCCESS,
            failure,
            "All validations passed."
            if failure is StatusCategory.SUCCESS
            else "Validation did not pass.",
            tuple(item for result in results for item in _diagnostics(result)),
            (collector_id,) if collector_id else (),
            tuple(part for result in results for part in result.command),
        )


@dataclass(slots=True)
class ReadinessService:
    """Produce the readiness projection using its authoritative reporter."""

    runner: ToolRunner

    def report(self) -> OperationResult:
        result = self.runner.run("report_legendary_generation_readiness.rb")
        data = None
        if result.returncode == 0:
            try:
                data = json.loads(result.stdout)
            except json.JSONDecodeError:
                result = ToolResult(
                    result.command, 1, result.stdout, result.stderr, result.duration_seconds
                )
        return _tool_operation(
            "readiness",
            result,
            failure=StatusCategory.INTERNAL_ERROR,
            success_summary="Readiness report generated.",
            failure_summary="Readiness reporting failed.",
            data=data,
        )


@dataclass(slots=True)
class CompilationService:
    """Compile one registered prompt profile through Ruby."""

    paths: RepositoryPaths
    collectors: CollectorRepository
    runner: ToolRunner

    def compile(
        self,
        collector_id: str,
        *,
        adapter: str = "openai",
        model: str | None = None,
        seed: int = 0,
        resolution: str = "1024x1536",
        check: bool = False,
    ) -> OperationResult:
        try:
            record = self.collectors.get(CollectorId.parse(collector_id))
        except BibleGameCardError as error:
            return OperationResult(
                "compile",
                False,
                StatusCategory.INVALID_INPUT,
                str(error),
                (Diagnostic("INVALID_COLLECTOR_ID", str(error)),),
            )
        if record.prompt_profile is None:
            return OperationResult(
                "compile",
                False,
                StatusCategory.NOT_FOUND,
                f"No prompt profile is registered for {record.collector_id}.",
            )
        arguments = [
            "--profile",
            str(record.prompt_profile.relative_to(self.paths.root)),
            "--adapter",
            adapter,
            "--seed",
            str(seed),
            "--resolution",
            resolution,
        ]
        if model:
            arguments.extend(("--model", model))
        if check:
            arguments.append("--check")
        result = self.runner.run("compile_prompts.rb", tuple(arguments))
        return _tool_operation(
            "compile",
            result,
            failure=StatusCategory.DRIFT_DETECTED if check else StatusCategory.INVALID_INPUT,
            success_summary=f"Prompt for {collector_id} {'verified' if check else 'compiled'}.",
            failure_summary=(
                f"Prompt for {collector_id} could not be {'verified' if check else 'compiled'}."
            ),
            affected=(collector_id,),
        )


def build_services(
    paths: RepositoryPaths,
) -> tuple[RepositoryService, ValidationService, ReadinessService, CompilationService]:
    """Construct the default application service graph."""
    collectors = CollectorRepository(paths)
    runner = RubyToolRunner(paths)
    return (
        RepositoryService(paths, collectors),
        ValidationService(paths, collectors, runner),
        ReadinessService(runner),
        CompilationService(paths, collectors, runner),
    )
