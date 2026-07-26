# L010 Joshua Canonical Knowledge

This directory is the machine-readable authority for Joshua. Start with [`data/manifest.yaml`](data/manifest.yaml); it declares every normalized document, shared registry, human projection, schema, and intended consumer.

## Data ownership
- [`character.yaml`](data/character.yaml): identity, names, titles, leadership, virtues, failures/limits, lifespan, and summary.
- [`references.yaml`](data/references.yaml): structured Scripture citations.
- [`timeline.yaml`](data/timeline.yaml): graph-ready events.
- [`relationships.yaml`](data/relationships.yaml): typed entity edges.
- [`symbols.yaml`](data/symbols.yaml): character-to-symbol usage and visual constraints.
- [`gameplay.yaml`](data/gameplay.yaml): gameplay philosophy.
- [`art.yaml`](data/art.yaml): visual and continuity profile.
- [`prompt.yaml`](data/prompt.yaml): semantic compiler field references.
- [`review.yaml`](data/review.yaml): review and generation state.
- [`version_history.yaml`](data/version_history.yaml): canonical-data revisions.

Human-readable review projections and production records remain in [`cards/L010_joshua/`](../../../../cards/L010_joshua/). They do not outrank canonical data.

## Validation

```bash
ruby tools/validate_character_knowledge.rb knowledge/characters/legendary/L010_joshua/data
```

See the [Canonical Character Knowledge Model](../../../../docs/CANONICAL_CHARACTER_KNOWLEDGE_MODEL.md) for field rules, graph semantics, normalization, and change workflow.

## Phase 4 production readiness

The package passes structural and graph validation, but artwork generation remains blocked. Reviewers must add identity, role, date, decision, comments, unresolved concerns, and evidence to the canonical gate records; tooling does not infer approval from empty records. A production model adapter and output settings must also be selected outside canonical prompt semantics.
