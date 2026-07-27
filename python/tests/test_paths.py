"""Repository discovery and no-write behaviour tests."""

from pathlib import Path

import pytest

from biblegamecard.core.exceptions import RepositoryNotFoundError
from biblegamecard.core.paths import RepositoryPaths


def _snapshot(root: Path) -> tuple[tuple[str, bool, bytes | None], ...]:
    return tuple(
        (str(path.relative_to(root)), path.is_dir(), None if path.is_dir() else path.read_bytes())
        for path in sorted(root.rglob("*"))
    )


def test_discovers_repository_from_nested_directory(repository_root: Path) -> None:
    nested = repository_root / "knowledge" / "characters" / "legendary"
    nested.mkdir(parents=True)
    assert RepositoryPaths.discover(start=nested).root == repository_root


def test_accepts_explicit_repository_path(repository_root: Path) -> None:
    paths = RepositoryPaths.discover(repository_root)
    assert paths.schemas == repository_root / "schemas"
    assert paths.cards == repository_root / "cards"


def test_rejects_invalid_explicit_repository(tmp_path: Path) -> None:
    with pytest.raises(RepositoryNotFoundError, match="not a BibleGameCard repository"):
        RepositoryPaths.discover(tmp_path)


def test_discovery_does_not_write(repository_root: Path) -> None:
    before = _snapshot(repository_root)
    RepositoryPaths.discover(repository_root).important_paths()
    assert _snapshot(repository_root) == before
