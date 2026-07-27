"""Shared test fixtures for temporary BibleGameCard repositories."""

from collections.abc import Iterator
from pathlib import Path

import pytest


@pytest.fixture
def repository_root(tmp_path: Path) -> Iterator[Path]:
    """Create the minimum markers required for repository discovery."""
    (tmp_path / "PROJECT_BIBLE.md").write_text("# Test repository\n", encoding="utf-8")
    (tmp_path / "Gemfile").write_text("source 'https://example.invalid'\n", encoding="utf-8")
    for directory in (
        "knowledge",
        "schemas",
        "registry",
        "generated",
        "tools",
        "development",
        "cards",
    ):
        (tmp_path / directory).mkdir()
    yield tmp_path
