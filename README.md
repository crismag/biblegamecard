# Bible Game Card

A version-controlled, knowledge-first production repository for a premium biblical collectible strategy card game.

## What this repository is

BibleGameCard is the authoritative source and compilation system for biblical character knowledge, gameplay identity, art direction, prompt development, generation metadata, and future card/game exports.

It is not itself an image model or a finished game application. It prepares deterministic, traceable production inputs that can be consumed by an external image-generation runtime such as ComfyUI with a local FLUX or Stable Diffusion model, or by a supported cloud image provider.

```text
canonical knowledge
    -> validated prompt-development profiles
    -> deterministic prompt compilation
    -> provider-adapted generation inputs
    -> external image-generation runtime
    -> reviewed artwork
    -> rendered cards and game exports
```

## Current repository status

Implemented now:

- canonical character-package validation and deterministic assembly;
- lightweight Legendary prompt-development profiles for L001-L018;
- Legendary generation-readiness validation and reporting;
- deterministic prompt compilation;
- provider-neutral canonical prompt output;
- OpenAI, FLUX, and SDXL prompt adapters;
- generation manifest schema, traceability metadata, regeneration commands, and asset lifecycle registry;
- committed compiled Joshua prompt artifacts.

Not implemented yet:

- direct calls to ComfyUI or cloud image APIs;
- image candidate download and registration;
- automated artwork-review records;
- approved artwork storage;
- card-layout rendering;
- game-data export and playable applications.

Compilation therefore ends at `NOT_GENERATED`. Creating pixels still requires an image-generation model and runtime.

## Current milestone

The next milestone is a controlled Joshua vertical slice using the existing L010 profile and prompt compiler:

```text
L010 canonical and prompt-development sources
    -> compiled FLUX/ComfyUI generation inputs
    -> one fixed, versioned ComfyUI workflow
    -> locally generated candidates
    -> recorded provenance and checksums
    -> human artwork review
```

The preferred feasibility path is to install ComfyUI separately from this repository, run it locally, and connect it through a focused provider adapter. The repository remains the product source; ComfyUI remains an external generation runtime.

## Start here

- [Repository usability and production guide](docs/USABILITY_AND_PRODUCTION_GUIDE.md)
- [How to use the repository](docs/HOW_TO_USE_THE_REPOSITORY.md)
- [Executable prompt compiler architecture](docs/PROMPT_COMPILER_ARCHITECTURE.md)
- [Local image-generation integration](docs/LOCAL_IMAGE_GENERATION.md)
- [Game and asset production workflow](docs/GAME_AND_ASSET_PRODUCTION_WORKFLOW.md)
- [Game development integration guide](docs/GAME_DEVELOPMENT_INTEGRATION_GUIDE.md)
- [Production operations guide](docs/PRODUCTION_OPERATIONS_GUIDE.md)
- [Master production tracker](tracking/MASTER_TRACKER.md)
- [Legendary character plan](registry/LEGENDARY_CHARACTER_PLAN.md)
- [Machine-readable Legendary registry](registry/legendary_cards.json)
- [Joshua canonical reference package](cards/L010_joshua/README.md)
- [Production validation standard](docs/PRODUCTION_VALIDATION_STANDARD.md)
- [Artwork review standard](docs/ARTWORK_REVIEW_STANDARD.md)

## Quick start

Install the locked Ruby dependencies:

```bash
bundle install
```

Validate prompt-development profiles and readiness outputs:

```bash
bundle exec ruby tools/validate_legendary_prompt_development.rb --all
bundle exec ruby tools/report_legendary_generation_readiness.rb --check
bundle exec ruby -Itest test/legendary_prompt_development_tools_test.rb
```

Validate canonical packages and deterministic assembly:

```bash
bundle exec ruby tools/validate_character_knowledge.rb --all
bundle exec ruby tools/assemble_character_knowledge.rb --check --all
bundle exec ruby -Itest test/validate_character_knowledge_test.rb
```

Compile Joshua for a local FLUX workflow:

```bash
ruby tools/compile_prompts.rb \
  --profile knowledge/prompt_development/legendary/L010_joshua.yaml \
  --adapter flux \
  --model local-flux \
  --seed 0 \
  --resolution 768x1152
```

Run the same command with `--check` to detect generated-prompt drift. Compilation writes prompt and provenance artifacts but does not invoke ComfyUI or generate an image.

## Working principles

1. Biblical identity drives gameplay and visual identity.
2. Canonical knowledge and review evidence outrank generated outputs and trackers.
3. Generated prompts, images, cards, and exports remain derived and traceable.
4. Generation-ready does not mean reviewed, approved, printable, or released.
5. Collector IDs are permanent; production order and artwork versions are tracked separately.
6. Provider adapters may translate syntax but must not invent biblical or art-direction facts.
7. Image generators are replaceable runtimes; the repository must not be locked to one provider.
8. Human approval remains required for theological, historical, artwork, and release decisions.

## Immediate queue

1. Prove ComfyUI compatibility on the target workstation with one generic workflow.
2. Export and version one core-node API workflow suitable for Legendary portrait artwork.
3. Add a narrow ComfyUI provider adapter that consumes immutable compiled prompt artifacts.
4. Generate one or more unapproved Joshua candidates and record model, workflow, seed, dimensions, hashes, and source commit.
5. Apply the existing artwork-review standard and select or reject candidates.
6. Only after the vertical slice succeeds, implement approved-asset handling and card rendering.
7. Continue collection expansion without treating unfinished image infrastructure as an approval blocker for prompt authoring.

## Development workflow

`main` is the canonical integration branch. Develop focused changes on branches and merge them through reviewed pull requests after relevant validation, deterministic-generation, and drift checks pass. Keep large model files and temporary candidate images outside Git; commit only controlled workflows, metadata, approved assets where policy allows, and reproducible source artifacts.