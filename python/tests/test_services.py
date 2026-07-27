"""Application service unit tests."""

import json
from pathlib import Path

from biblegamecard.adapters import ToolResult
from biblegamecard.core.paths import RepositoryPaths
from biblegamecard.core.results import StatusCategory
from biblegamecard.repositories import CollectorRepository
from biblegamecard.services import CompilationService, ReadinessService, ValidationService


class FakeRunner:
    def __init__(self, results: list[ToolResult] | None = None) -> None:
        self.calls: list[tuple[str, tuple[str, ...]]] = []
        self.results = results or []

    def run(self, script: str, arguments: tuple[str, ...] = ()) -> ToolResult:
        self.calls.append((script, arguments))
        if self.results:
            return self.results.pop(0)
        return ToolResult(("ruby", script, *arguments), 0, "PASS\n", "", 0.1)


def _registries(root: Path) -> None:
    (root / "registry/legendary_cards.json").write_text(
        json.dumps({"cards": [{"collector_id": "L010", "name": "Joshua"}]}), encoding="utf-8"
    )
    (root / "registry/legendary_prompt_development.json").write_text(
        json.dumps(
            {"characters": [{"collector_id": "L010", "profile_path": "profiles/L010.yaml"}]}
        ),
        encoding="utf-8",
    )


def test_compile_resolves_profile_and_constructs_arguments(repository_root: Path) -> None:
    _registries(repository_root)
    runner = FakeRunner()
    service = CompilationService(
        RepositoryPaths(repository_root),
        CollectorRepository(RepositoryPaths(repository_root)),
        runner,
    )
    result = service.compile(
        "L010", adapter="openai", model="example", seed=42, resolution="800x1200", check=True
    )
    assert result.success
    assert runner.calls == [
        (
            "compile_prompts.rb",
            (
                "--profile",
                "profiles/L010.yaml",
                "--adapter",
                "openai",
                "--seed",
                "42",
                "--resolution",
                "800x1200",
                "--model",
                "example",
                "--check",
            ),
        )
    ]


def test_compile_rejects_unknown_collector_without_invocation(repository_root: Path) -> None:
    _registries(repository_root)
    runner = FakeRunner()
    service = CompilationService(
        RepositoryPaths(repository_root),
        CollectorRepository(RepositoryPaths(repository_root)),
        runner,
    )
    result = service.compile("L999")
    assert result.status is StatusCategory.INVALID_INPUT
    assert runner.calls == []


def test_nonzero_validation_preserves_output(repository_root: Path) -> None:
    _registries(repository_root)
    runner = FakeRunner([ToolResult(("ruby", "validator"), 1, "out", "bad", 0.1)])
    service = ValidationService(
        RepositoryPaths(repository_root),
        CollectorRepository(RepositoryPaths(repository_root)),
        runner,
    )
    result = service.validate("L010")
    assert result.status is StatusCategory.VALIDATION_FAILED
    assert [item.message for item in result.diagnostics] == ["out", "bad"]


def test_readiness_uses_generated_json_not_human_parsing() -> None:
    runner = FakeRunner([ToolResult(("ruby", "report"), 0, '{"profile_count": 18}\n', "", 0.1)])
    result = ReadinessService(runner).report()
    assert result.data == {"profile_count": 18}


def test_timeout_is_dependency_failure() -> None:
    runner = FakeRunner([ToolResult(("ruby", "report"), 124, "", "", 1.0, timed_out=True)])
    result = ReadinessService(runner).report()
    assert result.status is StatusCategory.DEPENDENCY_FAILURE
