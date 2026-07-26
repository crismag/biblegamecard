# Game and Asset Production Workflow

## Purpose

This guide explains how BibleGameCard knowledge becomes prompts, images, cards, game data, print assets, and releases. It distinguishes implemented repository capabilities from external runtimes and future production stages.

## End-to-end production chain

```text
Scripture-grounded canonical knowledge
    -> character and gameplay records
    -> schema and domain validation
    -> deterministic prompt compilation
    -> provider-adapted generation inputs
    -> external image-generation runtime
    -> image candidates and metadata
    -> artwork review
    -> approved artwork
    -> structured card data
    -> card-layout rendering
    -> print, web, mobile, and game-data exports
    -> release packages
```

## Current implementation boundary

Implemented in the repository:

- canonical knowledge validation and deterministic assembly;
- lightweight Legendary prompt-development validation and readiness reporting;
- deterministic prompt compilation;
- OpenAI, FLUX, and SDXL prompt adapters;
- generation manifests, traceability, regeneration metadata, and lifecycle states.

Not yet implemented:

- direct ComfyUI or cloud image-provider submission;
- candidate registration and automated review records;
- approved-master asset management;
- card rendering and game-data export.

The compiled prompt directory is therefore the current executable output boundary.

## Stage 1: Canonical character and card knowledge

The source layer defines what must remain stable across outputs: collector ID, name and title, Scripture references, defining scene, gameplay archetype, signature ability, visual identity, continuity rules, prohibited elements, review state, and version history.

A rendered card or generated image must never become the only location where a source decision exists.

## Stage 2: Prompt-development readiness

A lightweight profile may prepare a character for first-pass generation before a full canonical package exists. It must define identity, life stage, biblical scene, focal action, visual identifiers, environment, composition, prohibited elements, and traceable sources.

`GENERATION_READY_DRAFT` authorises draft prompt compilation and candidate generation only. It does not indicate theological, historical, artwork, print, or release approval.

## Stage 3: Deterministic prompt compilation — implemented

Run `tools/compile_prompts.rb` to create:

```text
generated/prompts/<asset-id>/<prompt-version>/
  canonical_prompt.yaml
  prompt.txt
  negative_prompt.txt
  manifest.yaml
  traceability.yaml
  regeneration.json
```

The compiler records asset and collector IDs, prompt and source versions, source hashes, compiler version, adapter and model settings, seed, resolution, lifecycle state, and output hashes.

The compiler does not generate artwork. Successful compilation remains `NOT_GENERATED`.

## Stage 4: Prompt adapter — implemented

The OpenAI, FLUX, and SDXL adapters translate the provider-neutral canonical prompt into provider-facing prompt text. They may alter syntax or provider terminology but must not invent facts or override canonical art direction.

A prompt adapter is distinct from an image provider. The FLUX adapter does not run FLUX; it prepares input for a FLUX-capable runtime.

## Stage 5: Generation request — next implementation

A controlled generation request should reference an immutable compiled prompt directory and identify exactly what is authorised.

```yaml
request_id: GEN-L010-ART-01-0001
asset_id: L010-JOSHUA-ART-01
collector_id: L010
compiled_prompt_digest: sha256:...
provider: comfyui
workflow_id: legendary_portrait_v1
model_id: local-flux
candidate_count: 3
resolution: 768x1152
seed_policy: recorded
source_commit: ...
status: prepared
```

Preparation should be reviewable and non-generating. Submission should reject missing manifests, invalid lifecycle states, uncontrolled candidate counts, or unknown workflows.

## Stage 6: External image-generation runtime — next feasibility target

ComfyUI is the preferred first local runtime. It should be installed separately from BibleGameCard.

```text
BibleGameCard compiled directory
    -> ComfyUI provider adapter
    -> versioned core-node API workflow
    -> local FLUX or Stable Diffusion model
    -> PNG candidates
```

The repository may commit workflow JSON and binding configuration. It must not commit ComfyUI source, model weights, virtual environments, caches, secrets, or uncontrolled temporary outputs.

The first feasibility target is L010 Joshua. See [Local Image-Generation Integration](LOCAL_IMAGE_GENERATION.md).

## Stage 7: Candidate generation and metadata — planned

Each candidate should have a separate immutable metadata record containing model and version or checksum, provider, workflow version, prompt and negative-prompt hashes, adapter version, seed, dimensions, generation timestamp, source request ID, source commit, output checksum, licence context, and review state.

Candidates begin at `GENERATED`. Generated artwork is not official artwork.

## Stage 8: Artwork review — standard exists, integration planned

Review must cover biblical and theological integrity, historical plausibility, continuity, scene accuracy, signature objects, crop safety, anatomy and defects, collection consistency, card compatibility, licensing, and provenance.

Possible outcomes:

```text
REJECTED
CHANGES_REQUESTED
SHORTLISTED
APPROVED
```

A decision must reference the exact candidate checksum. No LLM or generator may approve its own output.

## Stage 9: Approved artwork master — planned

An approved candidate becomes a controlled, versioned master. Never overwrite a released master. Preserve origin, review evidence, crop restrictions, dimensions, colour information, licence and generation provenance, permitted derivatives, and replacement history.

## Stage 10: Structured card data — planned

Card content must exist independently of rendered images. It should include stable IDs, name, title, type, cost, traits, structured ability data, Scripture references, and approved art asset ID.

Gameplay values and rules require their own schema and review process. Prompt-development profiles must not become the only game-data source.

## Stage 11: Structured game behaviour — planned

Abilities should eventually be machine-readable so the same records can drive rules text, engine behaviour, automated tests, AI reasoning, balance analysis, and documentation.

## Stage 12: Card rendering — planned

A renderer will combine approved artwork, structured card data, approved frame templates, typography and icon rules, and target output profiles.

Expected output classes include print front/back images, web images, mobile assets, thumbnails, and accessible text data.

## Stage 13: Game-data and story export — planned

Applications should consume compiled contracts rather than authoring YAML directly. Future exports may include cards, abilities, characters, localisation, campaign nodes, missions, dialogue context, rewards, and Scripture discovery notes.

Narrative outputs remain derived. New claims must return to canonical review.

## Stage 14: Release package — planned

A release should contain approved, versioned outputs with a manifest, checksums, licences, release notes, exact source commit, and included asset versions.

## Revised vertical-slice sequence

Do not begin with eight generated characters. Prove one fully traceable character first:

1. validate Joshua canonical and prompt-development sources;
2. compile deterministic FLUX inputs;
3. prove ComfyUI with a generic local test;
4. export one stable API workflow;
5. generate several unapproved Joshua candidates;
6. register provenance and checksums;
7. complete human artwork review;
8. define approved-master handling;
9. render one card;
10. export one structured game-data record;
11. then expand to a small multi-card deck and playable proof.

Prompt authoring for additional characters may continue in parallel, but scale should not hide an unproven generation and review path.

## Production principle

Every output must answer:

```text
What authoritative source produced this?
Which source and prompt version produced it?
Which compiler, adapter, workflow, and model produced it?
Which seed and settings were used?
Who reviewed the exact output checksum?
What may consume it?
Has it been approved or released?
```

If those questions cannot be answered, the asset is not production-controlled.