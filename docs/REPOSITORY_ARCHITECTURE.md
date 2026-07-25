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

Recommended package:

```text
cards/L010_joshua/
  README.md
  character.yaml
  gameplay.yaml
  theology.md
  legacy.md
  artwork.yaml
  symbols.yaml
  scriptures.yaml
  prompt_source.yaml
  checklist.md
  revisions.md
```

### `knowledge/`
Shared design knowledge: theology policy, gameplay philosophy, canonical appearance guidance, art bible, naming standards, and controlled vocabularies.

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
Future compilers, validators, exporters, and migration utilities.

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
2. approved registry and schemas
3. approved card specification
4. shared knowledge guides
5. contexts and prompt sources
6. compiled prompts
7. generated artwork and layouts

## Duplication policy
Prefer references and composition over copied text. Duplicate content only where a generated artifact must be self-contained, and record its source.