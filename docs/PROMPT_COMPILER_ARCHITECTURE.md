# Executable Prompt Compilation Architecture

## Authority boundary

The compiler is a projection layer. Canonical character packages under `knowledge/characters/` remain authoritative for character facts, while profiles under `knowledge/prompt_development/` are reviewed authoring inputs. Templates and central art guidance supply reusable production language. Nothing under `generated/` may introduce or override a fact. A correction must be made in its authoritative source and then recompiled.

Generated prompts and metadata are disposable, reviewable build outputs. Approved artwork remains immutable: rejected or superseded artwork is replaced by a newly generated, separately identified output rather than manually retouched.

## Canonical prompt model

`tools/lib/prompt_compilation.rb` normalizes every profile into a model with a stable order:

1. identity;
2. biblical grounding;
3. gameplay influence;
4. visual identity;
5. wardrobe;
6. environment;
7. composition;
8. lighting;
9. rendering language; and
10. prohibited elements.

This intermediate representation is provider-neutral. The source profile's prewritten prompt is not copied as the build result; the compiler derives ordered clauses from structured fields so source changes are visible in drift checks.

## Adapter architecture

Adapters accept the immutable canonical prompt model and return only provider-facing positive and negative prompt strings. OpenAI, Flux, and SDXL adapters implement the same interface. They may translate syntax, weighting, or provider terminology, but must not add biblical, gameplay, continuity, or art-direction facts. Add a future provider by subclassing `Adapter`, registering its stable name in `ADAPTERS`, and adding isolation tests.

The milestone adapters deliberately produce conservative plain-language prompts. Image generation is out of scope; model names, seeds, and resolutions are recorded as future generation inputs only.

## Build and regeneration

Compile Joshua with explicit production settings:

```bash
ruby tools/compile_prompts.rb --profile knowledge/prompt_development/legendary/L010_joshua.yaml --adapter openai --model gpt-image-1 --seed 0 --resolution 1024x1536
```

Compile every registry entry that has a profile:

```bash
ruby tools/compile_prompts.rb --all --adapter openai
```

Detect edits, missing files, or stale output without writing:

```bash
ruby tools/compile_prompts.rb --profile knowledge/prompt_development/legendary/L010_joshua.yaml --adapter openai --model gpt-image-1 --seed 0 --resolution 1024x1536 --check
```

`SOURCE_DATE_EPOCH` and `SOURCE_COMMIT` may be set by CI. Otherwise the build uses the current commit timestamp and hash. Given identical sources, settings, commit metadata, and compiler version, byte-for-byte artifacts repeat. The source hashes in `regeneration.json` provide content-level evidence even if a repository is relocated.

Each output directory contains:

- `canonical_prompt.yaml`: provider-neutral ordered model;
- `prompt.txt` and `negative_prompt.txt`: adapter output;
- `manifest.yaml`: generation inputs and provenance;
- `traceability.yaml`: profile clauses, canonical source paths, and output hashes; and
- `regeneration.json`: deterministic inputs and an executable regeneration command.

`compiled_at` describes the reproducible source snapshot time, not wall-clock execution time. This prevents no-op rebuilds from producing drift.

## Lifecycle and reproducibility

`registry/asset_registry.yaml` defines the allowed lifecycle:

`NOT_GENERATED → GENERATED → UNDER_REVIEW → APPROVED → RELEASED`

Review may instead move an output to `REJECTED`; a new generation attempt returns to `GENERATED`. An approved item can return to review when evidence changes. Compiled manifests begin at `NOT_GENERATED` because compilation does not create artwork. State changes require production evidence and must never be inferred from compiler success.

The generation manifest schema requires the character and prompt versions, compiler, adapter, model, seed, resolution, source commit/profile, deterministic compilation timestamp, lifecycle state, and hashes of every discovered repository source. The traceability report additionally proves that every profile clause has at least one declared source path and identifies canonical files that can be content-hashed.

## Future image-generation boundary

Future generation tooling should consume an immutable compiled directory, validate `schemas/generation_manifest.schema.json`, submit its prompt and settings without rewriting them, and record the provider job/output identifiers in a separate generation record. Artwork review, approval, card rendering, and export remain later independent gates.
