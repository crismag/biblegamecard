# Executable Prompt Compilation Architecture

## Status

The deterministic prompt compiler is implemented. It converts reviewed prompt-development profiles and canonical repository sources into reproducible, provider-adapted generation inputs.

It does not generate images. Compiled manifests begin at `NOT_GENERATED` and must be consumed by a separate image-generation runtime.

## Authority boundary

The compiler is a projection layer. Canonical character packages under `knowledge/characters/` remain authoritative for character facts, while profiles under `knowledge/prompt_development/` are reviewed authoring inputs. Templates and central art guidance supply reusable production language. Nothing under `generated/` may introduce or override a fact.

Generated prompts and metadata are disposable, reviewable build outputs. Corrections belong in authoritative source files and must then be recompiled.

## Canonical prompt model

`tools/lib/prompt_compilation.rb` normalises every profile into a stable provider-neutral order:

1. identity;
2. biblical grounding;
3. gameplay influence;
4. visual identity;
5. wardrobe;
6. environment;
7. composition;
8. lighting;
9. rendering language;
10. prohibited elements.

The source profile's prewritten prompt is not copied as the final build result. The compiler derives ordered clauses from structured fields so source changes remain visible in drift checks.

## Adapter architecture

OpenAI, FLUX, and SDXL adapters implement the same interface. They accept the immutable canonical prompt model and return provider-facing positive and negative prompt strings.

Adapters may translate syntax, weighting, or provider terminology. They must not add biblical, gameplay, continuity, or art-direction facts.

A prompt adapter is not a generation provider. The FLUX adapter prepares text suitable for a FLUX-oriented workflow; it does not start ComfyUI or load a FLUX model.

## Build and regeneration

Compile Joshua for a local FLUX workflow:

```bash
ruby tools/compile_prompts.rb \
  --profile knowledge/prompt_development/legendary/L010_joshua.yaml \
  --adapter flux \
  --model local-flux \
  --seed 0 \
  --resolution 768x1152
```

Compile all profiles registered with source files:

```bash
ruby tools/compile_prompts.rb --all --adapter flux
```

Detect edits, missing files, or stale outputs without writing:

```bash
ruby tools/compile_prompts.rb \
  --profile knowledge/prompt_development/legendary/L010_joshua.yaml \
  --adapter flux \
  --model local-flux \
  --seed 0 \
  --resolution 768x1152 \
  --check
```

`SOURCE_DATE_EPOCH` and `SOURCE_COMMIT` may be set by CI. Otherwise the build uses repository metadata. Given identical sources, settings, commit metadata, and compiler version, the artifacts repeat byte for byte.

## Compiled output contract

Each output directory contains:

- `canonical_prompt.yaml` — provider-neutral ordered model;
- `prompt.txt` and `negative_prompt.txt` — adapter output;
- `manifest.yaml` — intended generation settings and provenance;
- `traceability.yaml` — source paths, clauses, and output hashes;
- `regeneration.json` — deterministic inputs and executable regeneration command.

`compiled_at` describes the reproducible source snapshot time rather than wall-clock execution time.

## Lifecycle and reproducibility

`registry/asset_registry.yaml` defines the lifecycle:

```text
NOT_GENERATED -> GENERATED -> UNDER_REVIEW -> APPROVED -> RELEASED
                      \-> REJECTED
```

Compiler success never advances an asset beyond `NOT_GENERATED`. State changes require production evidence and must not be inferred from prompt readiness or structural validation.

## Image-generation provider boundary

The next implementation layer should consume an immutable compiled directory and validate `schemas/generation_manifest.schema.json` before submission.

A provider integration should:

1. read rather than rewrite compiled prompt files;
2. load a versioned workflow or provider request template;
3. bind only approved fields such as prompts, seed, dimensions, candidate count, and output prefix;
4. submit to ComfyUI or another image runtime;
5. record request, provider job, model, workflow, seed, dimensions, timestamps, and checksums in a separate generation record;
6. create candidates at `GENERATED`, never `APPROVED`;
7. preserve the source commit and prompt digest.

For local generation, ComfyUI should be installed separately from this repository. The repository may version API workflow JSON and bindings, but it should not vendor ComfyUI source, Python environments, model weights, caches, or secrets.

See [Local Image-Generation Integration](LOCAL_IMAGE_GENERATION.md).

## Near-term target

The first production proof is L010 Joshua:

```text
validated source
  -> deterministic FLUX compilation
  -> versioned ComfyUI API workflow
  -> recorded local model
  -> generated candidate images
  -> provenance and checksums
  -> human artwork review
```

Artwork approval, approved-master handling, card rendering, game-data export, and release packaging remain independent later gates.