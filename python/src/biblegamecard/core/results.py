"""Immutable result-envelope primitives for future public operations."""

from dataclasses import dataclass
from enum import StrEnum


class StatusCategory(StrEnum):
    """Application result categories defined by the shared development contract."""

    SUCCESS = "SUCCESS"
    VALIDATION_FAILED = "VALIDATION_FAILED"
    DRIFT_DETECTED = "DRIFT_DETECTED"
    BLOCKED = "BLOCKED"
    NOT_FOUND = "NOT_FOUND"
    INVALID_INPUT = "INVALID_INPUT"
    UNSUPPORTED = "UNSUPPORTED"
    DEPENDENCY_FAILURE = "DEPENDENCY_FAILURE"
    INTERNAL_ERROR = "INTERNAL_ERROR"


@dataclass(frozen=True, slots=True)
class Diagnostic:
    """One machine-readable diagnostic attached to an operation result."""

    code: str
    message: str
    path: str | None = None


@dataclass(frozen=True, slots=True)
class OperationResult:
    """Consistent result envelope for an application operation."""

    operation: str
    success: bool
    status: StatusCategory
    summary: str
    diagnostics: tuple[Diagnostic, ...] = ()
    affected: tuple[str, ...] = ()
    invoked_tool: tuple[str, ...] | None = None
    output_paths: tuple[str, ...] = ()

    def __post_init__(self) -> None:
        if self.success != (self.status is StatusCategory.SUCCESS):
            raise ValueError("success must be true exactly when status is SUCCESS")
