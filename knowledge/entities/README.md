# Shared Knowledge Entities

These registries provide stable graph IDs and display labels reused by character packages.

- `biblical_entities.yaml`: people, groups, nations, and explicitly cautious figure IDs.
- `locations.yaml`: reusable places and optional parent-location edges.
- `symbols.yaml`: reusable visual/conceptual symbols with claim classification.

## Rules
- IDs are uppercase snake case and immutable once released.
- A registry entry identifies an entity; character-specific relationships and claims belong in the character package.
- Do not add speculative biographical facts merely to create an ID.
- Parent locations express containment only when the project is confident; use `null` rather than forcing a disputed geography.
- Character packages reference IDs and may add usage constraints, but must not copy or redefine registry labels and meanings.
- Merge duplicate entities instead of inventing character-local variants. If two traditions genuinely require distinction, document and review separate IDs.
