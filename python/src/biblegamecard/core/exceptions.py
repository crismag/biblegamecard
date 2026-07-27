"""Typed exceptions for expected BibleGameCard application failures."""


class BibleGameCardError(Exception):
    """Base class for expected, user-facing application failures."""


class RepositoryNotFoundError(BibleGameCardError):
    """Raised when no valid BibleGameCard repository can be located."""


class InvalidCollectorIdError(BibleGameCardError, ValueError):
    """Raised when a collector ID does not follow the canonical format."""


class InvalidLifecycleError(BibleGameCardError, ValueError):
    """Raised when an asset lifecycle value is not part of the shared contract."""
