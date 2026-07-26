# BibleGameCard Usability and Production Guide

## Purpose

This document is the entry point for using BibleGameCard as an operational content and asset-production repository.

BibleGameCard is not only a documentation archive. It is intended to become the authoritative source system that feeds artwork generation, card rendering, game-data export, story development, and release packaging.

The repository follows a knowledge-first model:

```text
canonical knowledge
    -> validated structured records
    -> compiled prompts and exports
    -> generated artwork and card assets
    -> reviewed release packages
    -> web, mobile, physical, and story products
```

Generated files are outputs. They do not replace canonical source records.

## Who this guide is for

Use this package when working as a:

- biblical-content author;
- gameplay designer;
- art director;
- prompt author;
- image-generation operator;
- card-layout designer;
- web or mobile game developer;
- story or campaign designer;
- reviewer or release manager;
- AI coding agent operating through Codex or another repository-connected tool.

## Documentation map

1. [Repository Quick Start](HOW_TO_USE_THE_REPOSITORY.md) — practical repository navigation, editing, validation, and contribution workflow.
2. [Game and Asset Production Workflow](GAME_AND_ASSET_PRODUCTION_WORKFLOW.md) — end-to-end path from canonical knowledge to images, rendered cards, and release assets.
3. [Game Development Integration Guide](GAME_DEVELOPMENT_INTEGRATION_GUIDE.md) — how structured card, ability, character, and story records can feed web, mobile, and game-engine applications.
4. [Production Operations Guide](PRODUCTION_OPERATIONS_GUIDE.md) — review gates, versioning, release discipline, generated artifacts, and operational controls.

These guides complement the stricter standards already in the repository:

- [Canonical Character Knowledge Model](CANONICAL_CHARACTER_KNOWLEDGE_MODEL.md)
- [Production Validation Standard](PRODUCTION_VALIDATION_STANDARD.md)
- [Artwork Review Standard](ARTWORK_REVIEW_STANDARD.md)
- [Repository Architecture](REPOSITORY_ARCHITECTURE.md)
- [Production Pipeline](PRODUCTION_PIPELINE.md)

## Operating model

The repository is organised into four conceptual layers.

### 1. Canonical source layer

Typical locations:

```text
knowledge/
registry/
schemas/
templates/
```

This layer stores authoritative facts, approved project interpretations, gameplay identity, art direction, prompt-source data, relationships, timelines, and controlled identifiers.

Edit this layer when making an actual source decision.

### 2. Review and production package layer

Typical locations:

```text
cards/
tracking/
planning/
docs/
```

This layer organises human review, production status, package-level guidance, and operational planning.

It may point to canonical data, but it must not silently override canonical sources.

### 3. Generated layer

Typical locations:

```text
generated/
dist/
```

This layer contains reproducible outputs such as:

- assembled knowledge;
- compiled prompts;
- traceability manifests;
- readiness reports;
- generated image candidates;
- rendered card images;
- game-ready JSON;
- print sheets;
- release packages.

Do not manually edit a generated file when a repository tool owns it.

### 4. Consumer layer

This is normally outside the canonical repository or represented under future application directories.

Consumers may include:

- web game;
- mobile game;
- game server;
- card catalogue;
- deck builder;
- print workflow;
- campaign or RPG engine;
- AI-assisted content tools.

Consumers read exported artifacts. They should not interpret every authoring YAML file independently.

## Core authority rule

When records disagree, use this general precedence:

1. approved canonical knowledge and review evidence;
2. machine-readable registries and schemas;
3. production package projections;
4. generated outputs;
5. human-facing trackers and temporary notes.

Exact package standards may define a more specific rule. Follow the stricter applicable standard.

## Expected production evolution

The repository is being developed incrementally.

Current and near-term capabilities:

- canonical character knowledge;
- Legendary prompt-development profiles;
- schema validation;
- deterministic assembly;
- prompt readiness reporting;
- production and artwork review gates.

Planned production capabilities:

- prompt compilation adapters;
- image-generation request manifests;
- image candidate metadata and review;
- approved artwork registry;
- structured card mechanics and abilities;
- card-layout rendering;
- print, web, and mobile export profiles;
- game-data compiler;
- story and campaign content export;
- release packaging and CI automation.

## Recommended first vertical slice

The first complete proof of repository usability should produce:

```text
8 Legendary character records
8 generation-ready prompt sources
8 reviewed artwork candidates
8 structured playable cards
1 approved card-frame system
1 small exported deck
1 simple playable web battle
1 printable test sheet
```

This vertical slice proves the full path from source knowledge to physical and digital use before scaling to the entire collection.

## Definition of repository usability

The repository is operationally useful when a contributor can:

1. locate the authoritative source for a character or card;
2. make a controlled change;
3. validate it;
4. regenerate affected outputs;
5. review the resulting diff;
6. produce an image, card, game-data, or story artifact without copying facts manually;
7. trace the artifact back to source versions;
8. release it without confusing draft, generated, reviewed, and approved states.

The accompanying guides describe how to perform those activities.