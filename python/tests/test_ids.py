"""Collector identifier contract tests."""

import pytest

from biblegamecard.core.exceptions import InvalidCollectorIdError
from biblegamecard.core.ids import CollectorId


@pytest.mark.parametrize("value", ["L010", "E001", "R299", "C499", "V001", "D099"])
def test_collector_id_accepts_contract_format(value: str) -> None:
    assert str(CollectorId.parse(value)) == value


@pytest.mark.parametrize("value", ["", "L10", "L0010", "l010", "LL10", "L-10", " L010"])
def test_collector_id_rejects_malformed_values(value: str) -> None:
    with pytest.raises(InvalidCollectorIdError, match="expected one uppercase letter"):
        CollectorId.parse(value)
