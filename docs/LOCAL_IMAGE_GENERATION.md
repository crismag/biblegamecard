# Local Image-Generation Integration

## Purpose

This guide defines how BibleGameCard should use a local image-generation runtime without turning the repository into a model-distribution or ComfyUI source repository.

BibleGameCard owns canonical knowledge, prompt compilation, generation intent, provenance, lifecycle, and review evidence. ComfyUI or another runtime owns execution of an image model.

## Repository boundary

Keep the applications separate:

```text
~/projects/biblegamecard/   # product knowledge, compiler, workflows, metadata
~/applications/ComfyUI/    # external image-generation runtime
~/models/                  # optional shared model storage
```

Do not create a second BibleGameCard repository for the experiment. Use a focused branch in the existing repository. Do not commit model weights, Python environments, caches, or uncontrolled candidate images.

## Current usable path

The repository already supports:

1. validated prompt-development profiles;
2. deterministic canonical prompt compilation;
3. FLUX, SDXL, and OpenAI adapter output;
4. generation manifests and traceability;
5. lifecycle state beginning at `NOT_GENERATED`.

The repository does not yet submit jobs to an image runtime. Until a provider adapter is added, the compiled prompt may be copied manually into ComfyUI for feasibility testing.

## Recommended first experiment

Use L010 Joshua as the first vertical slice.

```text
L010 profile
  -> compile with the FLUX adapter
  -> load one core-node ComfyUI workflow
  -> insert positive prompt, negative prompt, seed, width, and height
  -> generate candidate images
  -> record workflow, model, seed, dimensions, source commit, and checksums
  -> keep every candidate unapproved until human review
```

The first experiment should prove:

- ComfyUI detects the target GPU;
- the selected model fits available memory;
- one image can be generated manually;
- the workflow can be exported in API format;
- the same workflow can be submitted programmatically;
- the compiled Joshua prompt can be used without rewriting canonical facts;
- generation metadata can be traced back to the compiled directory.

## Suggested repository additions

A permanent integration may add:

```text
workflows/comfyui/
  legendary_portrait_v1.api.json

providers/comfyui/
  client.rb or client.py
  workflow_binding.yaml

generated/generation_requests/
generated/image_metadata/
```

The workflow binding should identify node IDs or stable selectors for:

- positive prompt;
- negative prompt;
- seed;
- width and height;
- batch or candidate count;
- output filename prefix.

The provider adapter must validate the generation manifest before submission and must not rewrite the compiled prompt.

## Controlled command target

The future CLI may expose commands similar to:

```bash
bin/biblegamecard prepare L010 --provider comfyui --workflow legendary_portrait_v1
bin/biblegamecard generate <request-id>
bin/biblegamecard inspect <request-id>
```

`prepare` should be non-generating and reviewable. `generate` should submit only a validated request. Neither command should approve artwork.

## Model and licence policy

The repository must record the exact model identifier, version or checksum, licence context, and permitted use. A model suitable for experimentation may not be suitable for commercial release.

Model adapters and workflow names must not imply that generated images are owned, approved, historically accurate, or commercially releasable.

## LLM role

ChatGPT, Codex, Claude, or a local LLM may operate the runner or help review metadata, but an image-generation model is still required to create pixels. The LLM should receive narrow tools rather than unrestricted shell access.

Allowed examples:

- list generation-ready characters;
- compile a prompt;
- prepare a generation request;
- submit a validated ComfyUI workflow;
- list generated candidates;
- record review notes.

Restricted examples:

- arbitrary canonical edits;
- silent prompt rewriting;
- automatic theological or artwork approval;
- unbounded candidate generation;
- committing model files or secrets.

## Success criterion

The integration is proven when one Joshua candidate can be reproduced from a known source commit, compiled prompt digest, workflow version, model identifier, seed, and output settings, and can then enter the existing human artwork-review process.