"""Operation result envelope tests."""

from dataclasses import FrozenInstanceError

import pytest

from biblegamecard.core.results import Diagnostic, OperationResult, StatusCategory


def test_result_preserves_structured_immutable_fields() -> None:
    result = OperationResult(
        operation="repository.inspect",
        success=False,
        status=StatusCategory.NOT_FOUND,
        summary="Repository missing",
        diagnostics=(Diagnostic("missing_root", "No repository"),),
        affected=("/tmp/missing",),
    )
    assert result.diagnostics[0].code == "missing_root"
    with pytest.raises(FrozenInstanceError):
        result.summary = "changed"  # type: ignore[misc]


def test_result_rejects_inconsistent_success_status() -> None:
    with pytest.raises(ValueError, match="success must be true"):
        OperationResult(
            operation="test",
            success=True,
            status=StatusCategory.BLOCKED,
            summary="inconsistent",
        )
