# BibleGameCard Usability and Production Guide

## Purpose

BibleGameCard is an operational, knowledge-first production repository for biblical card-game content. It is more than a documentation archive, but it is not a self-contained image model or finished game application.

Its responsibility is to preserve authoritative knowledge and turn it into deterministic, traceable production inputs:

```text
canonical knowledge
    -> validated structured records
    -> deterministic prompt compilation
    -> provider-adapted generation inputs
    -> external image-generation runtime
    -> reviewed artwork and card assets
    -> web, mobile, print, and story products
```

Generated files remain outputs. They do not replace canonical source records.

## Who this guide is for

Use this package when working as a biblical-content author, gameplay designer, art director, prompt author, image-generation operator, card-layout designer, game developer, reviewer, release manager, or repository-connected AI agent.

## Documentation map

1. [Repository Quick Start](HOW_TO_USE_THE_REPOSITORY.md) — navigation, editing, validation, compilation, and contribution workflow.
2. [Executable Prompt Compiler Architecture](PROMPT_COMPILER_ARCHITECTURE.md) — implemented compiler, adapters, outputs, drift checking, and lifecycle.
3. [Local Image-Generation Integration](LOCAL_IMAGE_GENERATION.md) — ComfyUI boundary, feasibility experiment, provider-adapter plan, and local workflow.
4. [Game and Asset Production Workflow](GAME_AND_ASSET_PRODUCTION_WORKFLOW.md) — end-to-end source-to-release stages.
5. [Game Development Integration Guide](GAME_DEVELOPMENT_INTEGRATION_GUIDE.md) — future compiled game-data consumers.
6. [Production Operations Guide](PRODUCTION_OPERATIONS_GUIDE.md) — review gates, versioning, releases, and operational controls.

These guides complement the stricter canonical, validation, and artwork-review standards elsewhere under `docs/`.

## Operating model

### 1. Canonical source layer

Typical locations:

```text
knowledge/
registry/
schemas/
templates/
```

This layer stores authoritative facts, project interpretations, gameplay identity, art direction, prompt-source data, relationships, timelines, and controlled identifiers. Edit this layer when making an actual source decision.

### 2. Review and production package layer

Typical locations:

```text
cards/
tracking/
planning/
docs/
```

This layer organises human review, package-level guidance, production status, and planning. It may project canonical data but must not silently override it.

### 3. Generated layer

Typical locations:

```text
generated/
dist/
```

Current reproducible outputs include assembled knowledge, compiled prompts, manifests, traceability, regeneration metadata, and readiness reports. Future outputs include image metadata, rendered cards, game-ready JSON, print sheets, and release packages.

Do not manually edit a generated file when a repository tool owns it.

### 4. External runtime and consumer layer

Image runtimes and product consumers are separate from the canonical repository.

Examples:

- ComfyUI with FLUX, Stable Diffusion, or another local model;
- a cloud image-generation API;
- web or mobile game;
- game server or deck builder;
- print workflow;
- campaign or RPG engine;
- AI-assisted operator interface.

The repository may version runtime workflows and adapter configuration, but it should not vendor model weights or treat an external runtime as canonical source.

## Core authority rule

When records disagree, use this precedence unless a stricter package standard applies:

1. approved canonical knowledge and review evidence;
2. machine-readable registries and schemas;
3. production package projections;
4. generated outputs;
5. human-facing trackers and temporary notes.

## Current capabilities

Implemented:

- canonical character knowledge model;
- production-grade package validation and deterministic assembly;
- Legendary prompt-development profiles for L001-L018;
- prompt-development validation and readiness reporting;
- deterministic provider-neutral prompt compilation;
- OpenAI, FLUX, and SDXL prompt adapters;
- generation manifests, traceability, regeneration commands, and lifecycle registry;
- committed Joshua compilation artifacts.

Compilation produces generation inputs and remains at `NOT_GENERATED`. It does not call an image provider.

## Near-term production plan

The next operational work is not another broad architecture layer. It is a controlled image-generation vertical slice:

1. prove ComfyUI and one suitable local model on the target workstation;
2. export one stable, core-node API workflow;
3. compile L010 Joshua with the FLUX adapter;
4. connect immutable compiled artifacts to the workflow;
5. record request, workflow, model, seed, dimensions, source commit, and output checksums;
6. generate unapproved candidates;
7. apply human artwork review;
8. use the result to design approved-asset handling and card rendering.

Collection authoring may continue in parallel, but generation infrastructure must not falsely advance review or approval states.

## Later capabilities

Planned after the vertical slice:

- controlled ComfyUI and cloud-provider adapters;
- image candidate registry and review evidence;
- approved artwork masters;
- structured card mechanics and abilities;
- card-layout rendering;
- print, web, and mobile export profiles;
- game-data compiler;
- story and campaign export;
- release packaging and CI automation;
- optional CLI, local web UI, MCP, or LLM-operated production console.

## Recommended proof before scaling

The first proof should be deliberately small:

```text
1 canonical character: Joshua
1 deterministic compiled prompt set
1 versioned ComfyUI API workflow
1 recorded local image model
1 reproducible generation request
several unapproved image candidates
1 completed human review decision
```

After that works, expand to one rendered card, one game-data record, and then a small multi-card vertical slice.

## Definition of repository usability

The repository is operationally useful when a contributor can locate an authoritative source, make a controlled change, validate it, regenerate affected outputs, review the diff, invoke an external production runtime without copying facts manually, trace the result back to source versions, and distinguish draft, generated, reviewed, approved, and released states.