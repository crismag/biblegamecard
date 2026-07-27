"""Command-line interface tests."""

from pathlib import Path

import pytest

from biblegamecard.cli import main


def test_help(capsys: pytest.CaptureFixture[str]) -> None:
    with pytest.raises(SystemExit) as raised:
        main(["--help"])
    assert raised.value.code == 0
    assert "repository" in capsys.readouterr().out


def test_version(capsys: pytest.CaptureFixture[str]) -> None:
    assert main(["version"]) == 0
    assert capsys.readouterr().out == "0.1.0\n"


def test_repository_root(repository_root: Path, capsys: pytest.CaptureFixture[str]) -> None:
    assert main(["--repository", str(repository_root), "repository", "root"]) == 0
    assert capsys.readouterr().out.strip() == str(repository_root)


def test_repository_inspect_is_read_only(
    repository_root: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    before = tuple(sorted(path.relative_to(repository_root) for path in repository_root.rglob("*")))
    assert main(["--repository", str(repository_root), "repository", "inspect"]) == 0
    output = capsys.readouterr().out
    assert "repository: valid" in output
    assert f"knowledge: {repository_root / 'knowledge'}" in output
    after = tuple(sorted(path.relative_to(repository_root) for path in repository_root.rglob("*")))
    assert after == before


def test_invalid_repository_has_clear_error(
    tmp_path: Path, caplog: pytest.LogCaptureFixture
) -> None:
    assert main(["--repository", str(tmp_path), "repository", "inspect"]) == 2
    assert "not a BibleGameCard repository" in caplog.text
