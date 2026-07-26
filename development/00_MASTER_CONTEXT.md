# Master Development Context

## Repository mission

BibleGameCard is a knowledge-first, version-controlled production system for a premium biblical collectible strategy card game and related digital, physical, and story products.

The repository is not merely a collection of prompts or images. It is intended to preserve authoritative biblical and project knowledge, compile reproducible production inputs, track review evidence, and export controlled assets for games, cards, print, web, mobile, and narrative experiences.

## Current implemented capabilities

The repository currently includes:

- canonical character knowledge architecture;
- one full canonical character package for L010 Joshua;
- lightweight prompt-development profiles for L001-L018;
- schemas, registries, templates, trackers, and review standards;
- deterministic canonical assembly;
- canonical and prompt-development validators;
- deterministic readiness reporting;
- deterministic prompt compilation;
- provider-facing prompt adapters for OpenAI, FLUX, and SDXL;
- generated prompt manifests, traceability, and regeneration metadata;
- GitHub Actions for canonical-package validation.

Prompt compilation does not generate pixels. Image generation requires an external runtime such as ComfyUI plus a compatible image model, or a cloud image API.

## Current strategic decision

Preserve the existing Ruby implementation as the proven deterministic core. Build new application-level systems primarily in Python.

The Python layer should initially orchestrate Ruby commands through a strict subprocess boundary. It must not independently reinterpret canonical data or duplicate the prompt compiler.

## Product architecture

```text
Canonical knowledge, schemas, registries, and review evidence
                         |
                         v
Existing deterministic Ruby tools
  - validate
  - assemble
  - report readiness
  - compile prompts
                         |
                         v
New Python production platform
  - unified CLI
  - application services
  - asset registry access
  - dependency graph
  - semantic validation
  - card/game-data compilation
  - MCP tools
  - dashboard
  - release operations
  - provider orchestration
                         |
                         v
External runtimes and consumers
  - ComfyUI or cloud image APIs
  - web/mobile games
  - print pipeline
  - story/campaign applications
```

## Authority hierarchy

When data disagrees, follow the repository standards and generally prefer:

1. approved canonical knowledge and explicit review evidence;
2. machine-readable schemas and registries;
3. production package projections;
4. generated outputs;
5. human-facing trackers and temporary notes.

Generated files must never introduce new facts.

## Non-negotiable invariants

- Collector IDs are stable.
- Canonical source corrections happen at the source, then outputs are regenerated.
- `GENERATION_READY_DRAFT` is not production approval.
- Successful validation is not human approval.
- Prompt compilation is not image generation.
- Existing generated artifacts must be reproducible.
- Provider adapters must not invent biblical or gameplay facts.
- Approved or released assets are immutable and versioned.
- Python and Ruby must share schemas and controlled values rather than create competing models.
- New capabilities must include tests, documentation, and clear failure behaviour.

## Immediate development objective

Create a Python-based production platform around the existing deterministic core without affecting the pending ComfyUI/FLUX feasibility test.

The first usable platform milestone should allow a contributor or AI agent to run one stable command surface for repository status, validation, readiness reporting, prompt compilation, and machine-readable diagnostics.

## Definition of success

The supplementary development programme succeeds when:

- users no longer need to know which internal language implements each operation;
- AI clients can invoke bounded repository tools through MCP;
- assets and dependencies can be queried without editing source files;
- semantic inconsistencies are detected before production;
- structured card data can be exported independently of artwork;
- repository progress is visible in a generated dashboard;
- releases can be assembled from approved, versioned outputs;
- every output remains traceable to source commit, tool version, and input hashes.

## Explicitly deferred

The following are not part of the supplementary programme until separately authorised:

- production ComfyUI installation automation;
- image model selection and benchmarking;
- actual image generation;
- AI image scoring or artwork approval;
- card-frame visual design;
- final print colour management;
- gameplay balance finalisation;
- rewriting existing Ruby tools in Python.
