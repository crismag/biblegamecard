"""Minimal command-line interface for the Python platform foundation."""

import argparse
import logging
import shutil
from collections.abc import Sequence
from pathlib import Path

from biblegamecard import __version__
from biblegamecard.core.exceptions import BibleGameCardError
from biblegamecard.core.paths import RepositoryPaths

LOGGER = logging.getLogger("biblegamecard")


def build_parser() -> argparse.ArgumentParser:
    """Build the public command-line parser."""
    parser = argparse.ArgumentParser(
        prog="biblegamecard", description="Inspect and work with a BibleGameCard repository."
    )
    parser.add_argument("--repository", type=Path, help="explicit BibleGameCard repository root")
    parser.add_argument("--verbose", action="store_true", help="enable informational logging")
    commands = parser.add_subparsers(dest="command", required=True)
    commands.add_parser("version", help="show the application version")
    commands.add_parser("doctor", help="check foundational local prerequisites")
    repository = commands.add_parser("repository", help="inspect repository paths")
    repository_commands = repository.add_subparsers(dest="repository_command", required=True)
    repository_commands.add_parser("root", help="print the repository root")
    repository_commands.add_parser("inspect", help="report repository validation and paths")
    return parser


def _repository_paths(repository: Path | None) -> RepositoryPaths:
    return RepositoryPaths.discover(repository)


def _run(args: argparse.Namespace) -> int:
    if args.command == "version":
        print(__version__)
        return 0

    paths = _repository_paths(args.repository)
    if args.command == "doctor":
        print(f"repository: valid ({paths.root})")
        ruby = shutil.which("ruby")
        print(f"ruby: {'available (' + ruby + ')' if ruby else 'not found'}")
        return 0 if ruby else 1

    if args.repository_command == "root":
        print(paths.root)
        return 0

    print("repository: valid")
    print(f"root: {paths.root}")
    for name, path in paths.important_paths():
        print(f"{name}: {path}")
    return 0


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
