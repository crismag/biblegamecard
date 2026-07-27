"""Read-only projections of the authoritative repository registries."""

import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any

from biblegamecard.core.exceptions import CollectorNotFoundError
from biblegamecard.core.ids import CollectorId
from biblegamecard.core.paths import RepositoryPaths


@dataclass(frozen=True, slots=True)
class CollectorRecord:
    """Paths registered for one collector, when those assets exist."""

    collector_id: CollectorId
    name: str
    prompt_profile: Path | None
    canonical_data: Path | None


class CollectorRepository:
    """Resolve collector assets without deriving paths from display names."""

    def __init__(self, paths: RepositoryPaths) -> None:
        self.paths = paths

    def get(self, collector_id: CollectorId) -> CollectorRecord:
        """Load one registered collector and its explicitly declared paths."""
        cards = self._json(self.paths.registry / "legendary_cards.json")["cards"]
        card = next((item for item in cards if item["collector_id"] == str(collector_id)), None)
        if card is None:
            raise CollectorNotFoundError(
                f"Collector ID {collector_id} is not present in registry/legendary_cards.json."
            )
        prompts = self._json(self.paths.registry / "legendary_prompt_development.json")[
            "characters"
        ]
        prompt = next(
            (
                item.get("profile_path")
                for item in prompts
                if item["collector_id"] == str(collector_id)
            ),
            None,
        )
        canonical = self._canonical_data(collector_id)
        return CollectorRecord(
            collector_id, card["name"], self.paths.root / prompt if prompt else None, canonical
        )

    def counts(self) -> dict[str, int]:
        """Return stable registry counts for status reporting."""
        cards = self._json(self.paths.registry / "legendary_cards.json")["cards"]
        prompts = self._json(self.paths.registry / "legendary_prompt_development.json")[
            "characters"
        ]
        return {
            "collectors": len(cards),
            "prompt_profiles": sum("profile_path" in item for item in prompts),
            "canonical_packages": len(
                tuple(self.paths.knowledge.glob("characters/**/data/manifest.yaml"))
            ),
        }

    def _canonical_data(self, collector_id: CollectorId) -> Path | None:
        # Manifest content is authoritative; directory names are not an identity contract.
        for manifest in sorted(self.paths.knowledge.glob("characters/**/data/manifest.yaml")):
            if any(
                line.strip() == f"collector_id: {collector_id}"
                for line in manifest.read_text(encoding="utf-8").splitlines()
            ):
                return manifest.parent
        return None

    @staticmethod
    def _json(path: Path) -> dict[str, Any]:
        with path.open(encoding="utf-8") as stream:
            value: dict[str, Any] = json.load(stream)
        return value
