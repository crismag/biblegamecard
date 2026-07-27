"""Immutable application configuration."""

from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True, slots=True)
class ApplicationConfig:
    """Configuration supplied by an interface to application operations."""

    repository: Path | None = None
    verbose: bool = False
