# Character Package Template

Use `cards/L010_joshua/` as the filled human/production reference implementation and `knowledge/characters/legendary/L010_joshua/data/` as the canonical machine-readable reference. Begin new characters from `templates/character_knowledge/`; compatibility YAML in `cards/` should point to canonical data rather than copy facts. A production Legendary package should contain:

- `README.md` — purpose, scope, navigation, dependencies, pipeline, state.
- `identity.md`, `biblical_basis.md`, `timeline.md`, `relationships.md`, `legacy.md` — classified, traceable knowledge.
- `character.yaml` — compatibility pointer to canonical character data.
- `gameplay_identity.md` and `gameplay.yaml` — human review view plus compatibility pointer.
- `symbolism.md`, `art_direction.md`, and `artwork.yaml` — human review views plus canonical-data pointer.
- `context.md` — compact structured compilation context.
- `prompt_source.md` and `prompt_source.yaml` — semantic review view plus canonical prompt-profile pointer.
- `compiled_prompt.md` — pointer to, and status view of, the generated prompt; never the sole source of a decision.
- `production_pipeline.md` — package-specific instantiation of every production stage.
- `prompt_traceability.yaml` — clause-to-source provenance for compiled prompts.
- `continuity.yaml` — compatibility pointer to continuity fields owned by canonical `art.yaml`.
- `artwork_evaluation.yaml` — immutable candidate score and disposition record.
- `asset_versions.yaml` — independent versions, states, hashes, and dependency lock.
- `generation_record.yaml` — exact provider request, raw output, settings, hashes, and transformations.
- `approval_record.yaml` — immutable named gate decision for an exact artifact version/hash.
- `review_checklist.md`, `revision_history.md`, and `metadata.yaml` — gates, decisions, versions, dependencies, and state.

## Creation sequence
1. Reserve the collector ID in the registry.
2. Research passages and label Scripture, tradition, inference, and project interpretation.
3. Complete identity and narrative knowledge before gameplay or art direction.
4. Review machine-readable sources against repository schemas and controlled status terms.
5. Compile prompts into `generated/prompts/<asset-id>/<prompt-version>/` with a manifest.
6. Review prompt and generated output independently; never infer approval from file existence.

Do not copy Joshua-specific conclusions into another character. Copy the structure, classification discipline, traceability, and production gates.
