# Repository Architecture

## Design rule
Knowledge is authored and reviewed. Generated artifacts are compiled or rendered from knowledge.

## Top-level layout

```text
PROJECT_BIBLE.md
README.md
cards/
contexts/
docs/
generated/
knowledge/
prompts/
rag/
registry/
schemas/
templates/
tools/
tracking/
```

## Directory responsibilities

### `cards/`
One package per card. Core Legendary package naming uses `<collector_id>_<slug>`, such as `L010_joshua`.

Recommended production package (the complete reference is [`cards/L010_joshua/`](../cards/L010_joshua/)):

```text
cards/L010_joshua/
  README.md
  identity.md
  biblical_basis.md
  timeline.md
  relationships.md
  legacy.md
  gameplay_identity.md
  symbolism.md
  art_direction.md
  context.md
  character.yaml
  gameplay.yaml
  artwork.yaml
  prompt_source.md
  prompt_source.yaml
  compiled_prompt.md
  prompt_traceability.md
  production_pipeline.md
  continuity.yaml
  artwork_review.md
  known_failure_modes.md
  prompt_evolution.md
  card_production.md
  quality_gates.md
  asset_versions.yaml
  review_checklist.md
  revision_history.md
  metadata.yaml
```

### `knowledge/`
Shared design knowledge plus normalized character knowledge. Global entity, location, and symbol registries live under `knowledge/entities/`. Canonical character data lives under `knowledge/characters/<rarity>/<collector_id>_<slug>/data/` and follows the [Canonical Character Knowledge Model](CANONICAL_CHARACTER_KNOWLEDGE_MODEL.md). Markdown card files are human review projections; canonical YAML is tooling authority.

### `contexts/`
Reusable context modules supplied to AI workflows. Context files should reference authoritative knowledge rather than duplicate it.

### `prompts/`
Prompt source modules and model adapters. Handwritten character facts belong in card specifications, not compiled prompt files.

### `generated/`
Regenerable outputs such as compiled prompts, image renders, layouts, exports, and release bundles. Generated files must declare their source specification version when practical.

### `registry/`
Collector IDs, planned sets, ranges, statuses, and cross-card indexes.

### `schemas/`
Machine-readable validation rules for card packages and registries.

### `templates/`
Starter files used when creating a new card package.

### `rag/`
Chunking policy, indexes, manifests, and generated retrieval documents. Source facts should remain in card and knowledge files.

### `tracking/`
Production status, review gates, release readiness, and reference-asset inventories.

### `tools/`
Compilers, validators, assemblers, exporters, and migration utilities. Canonical character packages must pass `tools/validate_character_knowledge.rb`.

## Naming standards
- Directories and machine-readable filenames: lowercase snake_case, except collector package prefixes.
- Collector packages: `L010_joshua`.
- Markdown titles: human-readable title case.
- IDs: uppercase prefix plus zero-padded number.
- Scripture references: canonical book name and chapter:verse range.
- Do not encode mutable titles into permanent IDs.

## Authority order
When files disagree, use this precedence:
1. `PROJECT_BIBLE.md`
2. approved registries and schemas
3. approved canonical character knowledge package
4. approved production specification and human review projections
5. shared knowledge guides
6. semantic prompt profiles and compiled prompts
7. generated artwork and layouts

## Duplication policy
Author each structured fact once and connect it by stable ID or field reference. Markdown may project canonical data for human review, but is not an independent fact store. Duplicate content only where a generated artifact must be self-contained; record canonical version, field provenance, and hashes.