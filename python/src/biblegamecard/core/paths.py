"""Read-only discovery and validation of BibleGameCard repository paths."""

from dataclasses import dataclass
from pathlib import Path

from biblegamecard.core.exceptions import RepositoryNotFoundError

_REQUIRED_FILES = ("PROJECT_BIBLE.md", "Gemfile")
_REQUIRED_DIRECTORIES = (
    "knowledge",
    "schemas",
    "registry",
    "generated",
    "tools",
    "development",
    "cards",
)


@dataclass(frozen=True, slots=True)
class RepositoryPaths:
    """Validated paths within a BibleGameCard checkout."""

    root: Path

    @classmethod
    def discover(
        cls, repository: Path | str | None = None, *, start: Path | str | None = None
    ) -> "RepositoryPaths":
        """Find a repository explicitly or by walking upward from ``start`` or CWD."""
        if repository is not None:
            candidate = Path(repository).expanduser().resolve()
            if not cls._looks_like_repository(candidate):
                raise RepositoryNotFoundError(
                    f"Path is not a BibleGameCard repository: {candidate}. "
                    "Expected PROJECT_BIBLE.md, Gemfile, and canonical repository directories."
                )
            return cls(candidate)

        origin = Path.cwd() if start is None else Path(start).expanduser()
        origin = origin.resolve()
        if origin.is_file():
            origin = origin.parent
        for candidate in (origin, *origin.parents):
            if cls._looks_like_repository(candidate):
                return cls(candidate)
        raise RepositoryNotFoundError(
            f"Could not locate a BibleGameCard repository from {origin}. "
            "Supply an explicit repository path with --repository."
        )

    @staticmethod
    def _looks_like_repository(candidate: Path) -> bool:
        return (
            candidate.is_dir()
            and all((candidate / name).is_file() for name in _REQUIRED_FILES)
            and all((candidate / name).is_dir() for name in _REQUIRED_DIRECTORIES)
        )

    @property
    def knowledge(self) -> Path:
        """Return the canonical knowledge directory."""
        return self.root / "knowledge"

    @property
    def schemas(self) -> Path:
        """Return the schema directory."""
        return self.root / "schemas"

    @property
    def registry(self) -> Path:
        """Return the registry directory."""
        return self.root / "registry"

    @property
    def generated(self) -> Path:
        """Return the generated-artifact directory."""
        return self.root / "generated"

    @property
    def tools(self) -> Path:
        """Return the deterministic Ruby tool directory."""
        return self.root / "tools"

    @property
    def development(self) -> Path:
        """Return the development-programme directory."""
        return self.root / "development"

    @property
    def cards(self) -> Path:
        """Return the card-package directory."""
        return self.root / "cards"

    def important_paths(self) -> tuple[tuple[str, Path], ...]:
        """Return important repository paths in stable display order."""
        return tuple((name, getattr(self, name)) for name in _REQUIRED_DIRECTORIES)
