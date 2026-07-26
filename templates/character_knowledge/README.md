# Canonical Character Knowledge Template

Copy `data/` to `knowledge/characters/<rarity>/<collector_id>_<slug>/data/`, replace placeholders, register shared entities/locations/symbols globally, and run the validator. The files intentionally fail validation until required IDs, references, events, and profiles are supplied.

Do not add a fact to multiple YAML documents. Use `reference_ids`, `entity_id`, `location_id`, `symbol_id`, `event_id`, or semantic `field_refs`. See [Canonical Character Knowledge Model](../../docs/CANONICAL_CHARACTER_KNOWLEDGE_MODEL.md).
