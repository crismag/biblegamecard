"""Artwork lifecycle values projected from the canonical asset registry."""

from enum import StrEnum

from biblegamecard.core.exceptions import InvalidLifecycleError


class AssetLifecycle(StrEnum):
    """Controlled artwork states from ``registry/asset_registry.yaml``."""

    NOT_GENERATED = "NOT_GENERATED"
    GENERATED = "GENERATED"
    UNDER_REVIEW = "UNDER_REVIEW"
    APPROVED = "APPROVED"
    REJECTED = "REJECTED"
    RELEASED = "RELEASED"

    @classmethod
    def parse(cls, value: str) -> "AssetLifecycle":
        """Parse an exact lifecycle value and return a clear domain error."""
        try:
            return cls(value)
        except ValueError as error:
            allowed = ", ".join(item.value for item in cls)
            raise InvalidLifecycleError(
                f"Invalid asset lifecycle {value!r}; expected one of: {allowed}."
            ) from error
