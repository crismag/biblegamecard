"""Asset lifecycle contract tests."""

import json
from pathlib import Path

import pytest

from biblegamecard.core.exceptions import InvalidLifecycleError
from biblegamecard.core.lifecycle import AssetLifecycle


def test_lifecycle_values_match_asset_registry_contract() -> None:
    assert tuple(item.value for item in AssetLifecycle) == (
        "NOT_GENERATED",
        "GENERATED",
        "UNDER_REVIEW",
        "APPROVED",
        "REJECTED",
        "RELEASED",
    )


def test_lifecycle_values_match_generation_manifest_schema() -> None:
    repository_root = Path(__file__).resolve().parents[2]
    schema = json.loads(
        (repository_root / "schemas" / "generation_manifest.schema.json").read_text(
            encoding="utf-8"
        )
    )
    assert [item.value for item in AssetLifecycle] == schema["properties"]["artifact_state"]["enum"]


def test_lifecycle_parse_accepts_exact_value() -> None:
    assert AssetLifecycle.parse("NOT_GENERATED") is AssetLifecycle.NOT_GENERATED


@pytest.mark.parametrize("value", ["not_generated", "PROMPT_APPROVED", "", "REVIEW"])
def test_lifecycle_parse_rejects_non_contract_value(value: str) -> None:
    with pytest.raises(InvalidLifecycleError, match="Invalid asset lifecycle"):
        AssetLifecycle.parse(value)
