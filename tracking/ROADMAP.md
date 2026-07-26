# BibleGameCard Production Roadmap

## Purpose
This roadmap tracks the transition from repository foundation to repeatable biblical character and card production. Detailed work remains in phase-specific checklists; this file shows the current production position and the next gated milestone.

## Milestones

| Milestone | Status | Exit criteria |
|---|---|---|
| Repository Foundation | Complete | Core governance, schemas, registries, templates, and production boundaries are available. |
| Art and Prompt Foundation | Complete | Visual language, design guides, prompt grammar, templates, versioning, and model guidance are approved. |
| Joshua Reference Package | In review | Joshua package sources and compiled prompt are complete; human reviews, generated artwork, and card layout remain. |
| Validator Hardening | In progress | Real schema validation, safe loading, fixtures, CI, and deterministic drift checks are reviewed and merged. |
| Joshua Artwork Production | Blocked | Required human gates, model adapter, and output settings are approved and recorded. |
| Reference Archetypes | Pending | Leader, queen, king, prophet, and apostle archetypes validate visual cohesion. |
| Core Legendary Production | Pending | All L001-L034 packages and approved assets are complete. |
| Print Production | Pending | Card backs, bleeds, colour checks, proofs, and manufacturing exports are approved. |
| Game Integration | Pending | Card data and assets are consumable by the first playable digital or physical prototype. |

## Current objective
Review the Joshua reference package across biblical/theological, gameplay, art-direction, and prompt gates before generating its official artwork.

## Current batch
- Review the complete `cards/L010_joshua/` knowledge and source package.
- Review compiled prompt `L010-JOSHUA-ART-01` independently from its sources.
- Select and record a model adapter and output resolution.
- Generate and inspect official artwork only after source and prompt approval.
- Validate the reference structure before cloning it for later characters.
- Validate Phase 3B production traceability, continuity, evaluation, corrections, asset versioning, and G1–G7 evidence without generating artwork.
- Validate Phase 3C normalized canonical knowledge, graph references, structured Scripture/events, human projections, and reusable character-data templates.

## Review checklist
- Confirm the visual language reflects the intended premium biblical collectible identity.
- Confirm sacred depiction, miracle, symbolism, and historical boundaries are acceptable.
- Confirm prompt grammar and templates are sufficiently model-neutral.
- Confirm versioning and provenance requirements are practical.
- Confirm Joshua sources, compiled prompt, and package navigation are production-ready before generation.

## Next gated milestone
**Reference Archetypes** begins after Joshua source, prompt, artwork, and card-layout reviews prove the complete pipeline.

## Status vocabulary
- `Pending`: not started.
- `In progress`: active work exists but exit criteria are unmet.
- `In review`: implementation is complete and awaiting approval.
- `Complete`: approved and merged.
- `Blocked`: cannot progress without an explicit decision or dependency.
