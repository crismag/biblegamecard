"""Typed, bounded subprocess access to the deterministic Ruby tools."""

import logging
import subprocess
import time
from dataclasses import dataclass
from typing import Protocol

from biblegamecard.core.paths import RepositoryPaths

LOGGER = logging.getLogger("biblegamecard.tools")


@dataclass(frozen=True, slots=True)
class ToolResult:
    """Complete observable result of a Ruby tool invocation."""

    command: tuple[str, ...]
    returncode: int
    stdout: str
    stderr: str
    duration_seconds: float
    dependency_error: str | None = None
    timed_out: bool = False


class ToolRunner(Protocol):
    """Runner boundary used by services and unit tests."""

    def run(self, script: str, arguments: tuple[str, ...] = ()) -> ToolResult: ...


class RubyToolRunner:
    """Execute repository Ruby scripts without a shell."""

    def __init__(
        self, paths: RepositoryPaths, *, ruby: str = "ruby", timeout_seconds: float = 60
    ) -> None:
        self.paths = paths
        self.ruby = ruby
        self.timeout_seconds = timeout_seconds

    def run(self, script: str, arguments: tuple[str, ...] = ()) -> ToolResult:
        command = (self.ruby, str(self.paths.tools / script), *arguments)
        LOGGER.info("Invoking %s from %s", command, self.paths.root)
        started = time.monotonic()
        try:
            completed = subprocess.run(
                command,
                cwd=self.paths.root,
                capture_output=True,
                text=True,
                timeout=self.timeout_seconds,
                check=False,
            )
        except FileNotFoundError as error:
            return ToolResult(command, 127, "", "", time.monotonic() - started, str(error))
        except subprocess.TimeoutExpired as error:
            stdout = (
                error.stdout.decode() if isinstance(error.stdout, bytes) else (error.stdout or "")
            )
            stderr = (
                error.stderr.decode() if isinstance(error.stderr, bytes) else (error.stderr or "")
            )
            return ToolResult(
                command, 124, stdout, stderr, time.monotonic() - started, timed_out=True
            )
        return ToolResult(
            command,
            completed.returncode,
            completed.stdout,
            completed.stderr,
            time.monotonic() - started,
        )
