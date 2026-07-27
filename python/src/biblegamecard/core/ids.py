"""Stable identifier value objects backed by repository naming contracts."""

import re
from dataclasses import dataclass

from biblegamecard.core.exceptions import InvalidCollectorIdError

_COLLECTOR_ID_PATTERN = re.compile(r"^[A-Z][0-9]{3}$")


@dataclass(frozen=True, slots=True)
class CollectorId:
    """An uppercase category prefix followed by a three-digit number."""

    value: str

    def __post_init__(self) -> None:
        if not _COLLECTOR_ID_PATTERN.fullmatch(self.value):
            raise InvalidCollectorIdError(
                f"Invalid collector ID {self.value!r}; expected one uppercase letter and "
                "three digits (for example, L010)."
            )

    @classmethod
    def parse(cls, value: str) -> "CollectorId":
        """Parse and validate a collector ID without normalizing malformed input."""
        return cls(value)

    def __str__(self) -> str:
        return self.value
