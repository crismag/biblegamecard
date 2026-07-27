"""Unified command-line interface for BibleGameCard repository operations."""

import argparse
import json
import logging
import shutil
from collections.abc import Sequence
from dataclasses import asdict
from enum import Enum
from pathlib import Path
from typing import Any

from biblegamecard import __version__
from biblegamecard.core.exceptions import BibleGameCardError
from biblegamecard.core.paths import RepositoryPaths
from biblegamecard.core.results import OperationResult, StatusCategory
from biblegamecard.services import build_services

LOGGER = logging.getLogger("biblegamecard")
EXIT_CODES = {
    StatusCategory.SUCCESS: 0,
    StatusCategory.VALIDATION_FAILED: 1,
    StatusCategory.INVALID_INPUT: 2,
    StatusCategory.NOT_FOUND: 2,
    StatusCategory.DRIFT_DETECTED: 3,
    StatusCategory.DEPENDENCY_FAILURE: 4,
    StatusCategory.BLOCKED: 4,
    StatusCategory.UNSUPPORTED: 4,
    StatusCategory.INTERNAL_ERROR: 5,
}


def build_parser() -> argparse.ArgumentParser:
    """Build the public command-line parser."""
    parser = argparse.ArgumentParser(
        prog="biblegamecard", description="Inspect and work with a BibleGameCard repository."
    )
    parser.add_argument("--repository", type=Path, help="explicit BibleGameCard repository root")
    parser.add_argument("--verbose", action="store_true", help="enable informational logging")
    parser.add_argument("--json", action="store_true", help="emit a structured JSON result")
    commands = parser.add_subparsers(dest="command", required=True)
    commands.add_parser("version", help="show the application version")
    commands.add_parser("doctor", help="check foundational local prerequisites")
    status = commands.add_parser("status", help="report repository and runtime status")
    status.add_argument("--json", action="store_true", default=argparse.SUPPRESS)
    validate = commands.add_parser("validate", help="run canonical and prompt validators")
    validate.add_argument("--json", action="store_true", default=argparse.SUPPRESS)
    target = validate.add_mutually_exclusive_group()
    target.add_argument("--all", action="store_true", help="validate every registered asset")
    target.add_argument("--collector-id", help="validate one registered collector ID")
    readiness = commands.add_parser("readiness", help="report prompt generation readiness")
    readiness.add_argument("--json", action="store_true", default=argparse.SUPPRESS)
    compile_parser = commands.add_parser("compile", help="compile one registered prompt")
    compile_parser.add_argument("--json", action="store_true", default=argparse.SUPPRESS)
    compile_parser.add_argument("collector_id")
    compile_parser.add_argument("--adapter", default="openai")
    compile_parser.add_argument("--model")
    compile_parser.add_argument("--seed", type=int, default=0)
    compile_parser.add_argument("--resolution", default="1024x1536")
    compile_parser.add_argument("--check", action="store_true")
    repository = commands.add_parser("repository", help="inspect repository paths")
    repository_commands = repository.add_subparsers(dest="repository_command", required=True)
    repository_commands.add_parser("root", help="print the repository root")
    repository_commands.add_parser("inspect", help="report repository validation and paths")
    return parser


def _jsonable(value: Any) -> Any:
    if isinstance(value, Path):
        return str(value)
    if isinstance(value, Enum):
        return value.value
    if isinstance(value, tuple):
        return [_jsonable(item) for item in value]
    if isinstance(value, list):
        return [_jsonable(item) for item in value]
    if isinstance(value, dict):
        return {key: _jsonable(item) for key, item in value.items()}
    return value


def _emit(result: OperationResult, *, as_json: bool) -> int:
    if as_json:
        print(json.dumps(_jsonable(asdict(result)), sort_keys=True))
    else:
        print(f"{result.status}: {result.summary}")
        if isinstance(result.data, dict):
            for key, value in result.data.items():
                print(f"{key}: {value}")
        for diagnostic in result.diagnostics:
            print(f"{diagnostic.code}: {diagnostic.message}")
    return EXIT_CODES[result.status]


def _run(args: argparse.Namespace) -> int:
    if args.command == "version":
        print(__version__)
        return 0

    paths = RepositoryPaths.discover(args.repository)
    if args.command == "doctor":
        print(f"repository: valid ({paths.root})")
        ruby = shutil.which("ruby")
        print(f"ruby: {'available (' + ruby + ')' if ruby else 'not found'}")
        return 0 if ruby else 1
    if args.command == "repository":
        if args.repository_command == "root":
            print(paths.root)
            return 0
        print("repository: valid")
        print(f"root: {paths.root}")
        for name, path in paths.important_paths():
            print(f"{name}: {path}")
        return 0

    repository, validation, readiness, compilation = build_services(paths)
    if args.command == "status":
        result = repository.status()
    elif args.command == "validate":
        result = validation.validate(args.collector_id)
    elif args.command == "readiness":
        result = readiness.report()
    else:
        result = compilation.compile(
            args.collector_id,
            adapter=args.adapter,
            model=args.model,
            seed=args.seed,
            resolution=args.resolution,
            check=args.check,
        )
    return _emit(result, as_json=args.json)


def main(argv: Sequence[str] | None = None) -> int:
    """Run the CLI and map expected user errors to stable exit codes."""
    parser = build_parser()
    args = parser.parse_args(argv)
    logging.basicConfig(
        level=logging.INFO if args.verbose else logging.WARNING,
        format="%(levelname)s: %(message)s",
    )
    try:
        return _run(args)
    except BibleGameCardError as error:
        LOGGER.error("%s", error)
        return 2
