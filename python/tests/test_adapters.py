"""Ruby subprocess adapter tests."""

import subprocess
from pathlib import Path

import pytest

from biblegamecard.adapters import RubyToolRunner
from biblegamecard.core.paths import RepositoryPaths


def test_runner_constructs_exact_command_and_cwd(
    repository_root: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    observed: dict[str, object] = {}

    def fake_run(command: tuple[str, ...], **kwargs: object) -> subprocess.CompletedProcess[str]:
        observed.update(command=command, **kwargs)
        return subprocess.CompletedProcess(command, 0, "ok\n", "")

    monkeypatch.setattr(subprocess, "run", fake_run)
    runner = RubyToolRunner(RepositoryPaths(repository_root), ruby="/ruby", timeout_seconds=7)
    result = runner.run("tool.rb", ("--check",))
    assert result.command == ("/ruby", str(repository_root / "tools/tool.rb"), "--check")
    assert observed["cwd"] == repository_root
    assert "shell" not in observed  # shell=True can never be enabled by this adapter.
    assert observed["timeout"] == 7


def test_runner_reports_missing_runtime(
    repository_root: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    def missing(*args: object, **kwargs: object) -> None:
        raise FileNotFoundError("ruby missing")

    monkeypatch.setattr(subprocess, "run", missing)
    result = RubyToolRunner(RepositoryPaths(repository_root)).run("tool.rb")
    assert result.returncode == 127
    assert result.dependency_error == "ruby missing"


def test_runner_reports_timeout(repository_root: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    def timeout(command: tuple[str, ...], **kwargs: object) -> None:
        raise subprocess.TimeoutExpired(command, 1, output="partial", stderr="slow")

    monkeypatch.setattr(subprocess, "run", timeout)
    result = RubyToolRunner(RepositoryPaths(repository_root)).run("tool.rb")
    assert result.returncode == 124
    assert result.timed_out
    assert result.stdout == "partial"
