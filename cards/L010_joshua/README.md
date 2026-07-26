# L010 Joshua — Reference Package

## Purpose
This is the human-readable and production review package for Joshua. Its machine-readable authority is the [canonical knowledge manifest](../../knowledge/characters/legendary/L010_joshua/data/manifest.yaml). Future packages should reuse that normalized data model and this review workflow rather than inventing a new architecture.

## Scope and authority
The Markdown files present reviewable projections of Joshua's scriptural identity, traceable interpretation, gameplay direction, visual specification, and prompt source. Character facts are authored once in normalized canonical data; compatibility YAML files here point to that source. It does **not** claim that generated artwork, draft rules, chronology estimates, or project interpretation are Scripture. Authority follows [Repository Architecture](../../docs/REPOSITORY_ARCHITECTURE.md#authority-order).

## Contents

| File | Responsibility |
|---|---|
| [identity.md](identity.md) | Canonical identity and claim classification |
| [biblical_basis.md](biblical_basis.md) | Passage inventory and event evidence |
| [timeline.md](timeline.md) | Scripture-ordered chronology |
| [relationships.md](relationships.md) | Traceable relationship map |
| [legacy.md](legacy.md) | Biblical legacy and interpretive boundaries |
| [gameplay_identity.md](gameplay_identity.md) | Unbalanced design philosophy |
| [symbolism.md](symbolism.md) | Approved and prohibited motifs |
| [art_direction.md](art_direction.md) | Human review projection of canonical art data |
| [context.md](context.md) | Canonical compilation-input index |
| [character.yaml](character.yaml) | Compatibility pointer to canonical character data |
| [gameplay.yaml](gameplay.yaml) | Compatibility pointer to canonical gameplay data |
| [artwork.yaml](artwork.yaml) | Compatibility pointer to canonical art data |
| [prompt_source.yaml](prompt_source.yaml) | Compatibility pointer to canonical prompt profile |
| [prompt_source.md](prompt_source.md) | Semantic prompt review view |
| [compiled_prompt.md](compiled_prompt.md) | Pointer and review rendering of the generated prompt |
| [review_checklist.md](review_checklist.md) | Approval gates |
| [production_pipeline.md](production_pipeline.md) | Instantiated end-to-end workflow |
| [prompt_traceability.md](prompt_traceability.md) | Sentence-level compiled-prompt provenance |
| [continuity.yaml](continuity.yaml) | Compatibility pointer to canonical art continuity fields |
| [artwork_review.md](artwork_review.md) | Joshua-specific candidate review gates |
| [known_failure_modes.md](known_failure_modes.md) | Symptoms, causes, corrections, and review actions |
| [prompt_evolution.md](prompt_evolution.md) | Version evolution and change rationale |
| [card_production.md](card_production.md) | Approved-art-to-release workflow |
| [quality_gates.md](quality_gates.md) | Mandatory evidence and approval authority |
| [asset_versions.yaml](asset_versions.yaml) | Independently versioned artifact inventory |
| [generation_request.yaml](generation_request.yaml) | Frozen, currently blocked provider request fields |
| [revision_history.md](revision_history.md) | Package decisions and versions |
| [metadata.yaml](metadata.yaml) | Package state and dependencies |

## Dependencies
- [Project Bible](../../PROJECT_BIBLE.md)
- [Theology and Content Guide](../../knowledge/THEOLOGY_AND_CONTENT_GUIDE.md)
- [Art guides](../../knowledge/art/VISUAL_LANGUAGE.md)
- [Prompt Grammar](../../knowledge/prompt_engineering/PROMPT_GRAMMAR.md)
- [Prompt Compiler](../../knowledge/prompt_engineering/PROMPT_COMPILER.md)
- [Canonical character package schema](../../schemas/knowledge/canonical_character_package.schema.json)
- [Production Validation Standard](../../docs/PRODUCTION_VALIDATION_STANDARD.md)
- [Artwork Review Standard](../../docs/ARTWORK_REVIEW_STANDARD.md)

## Generation pipeline
1. Author normalized claims, references, graph entities, and profiles under the canonical data manifest; validate cross-references.
2. Render or update human review projections and review canonical character, gameplay, and art documents.
3. Resolve semantic field references from canonical `prompt.yaml`; `context.md` is only a navigation view.
4. Compile in canonical grammar order; store the regenerable result and manifest under [`generated/prompts/L010-JOSHUA-ART-01/1.0.0/`](../../generated/prompts/L010-JOSHUA-ART-01/1.0.0/).
5. Pass G1–G4, select a concrete adapter/settings record, then generate immutable candidates with provenance.
6. Evaluate each candidate, approve an exact artwork hash, and compose layout only after G5.
7. Pass card, print, and release gates G6–G7; archive dependency locks and checksums.

## Review status
**Package state: spec review.** Research and production specifications are complete for review. Prompt compilation is complete. No artwork or final card is approved or included.
