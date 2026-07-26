# Bible Game Card

A version-controlled design and context repository for a premium biblical collectible strategy card game.

## Current focus

The current milestone is to define and complete the 34-card **Core Legendary Collection**, then regenerate every card as a consistent Official V2 release set.

## Start here

- [Master production tracker](tracking/MASTER_TRACKER.md)
- [Legendary character plan](registry/LEGENDARY_CHARACTER_PLAN.md)
- [Machine-readable Legendary registry](registry/legendary_cards.json)
- [Joshua canonical reference package](cards/L010_joshua/README.md)
- [Character package template](templates/card_package/README.md)
- [Production validation standard](docs/PRODUCTION_VALIDATION_STANDARD.md)
- [Artwork review standard](docs/ARTWORK_REVIEW_STANDARD.md)
- [Canonical character knowledge model](docs/CANONICAL_CHARACTER_KNOWLEDGE_MODEL.md)
- [Joshua machine-readable knowledge](knowledge/characters/legendary/L010_joshua/README.md)

## Working principles

1. Biblical identity drives gameplay identity.
2. Legendary titles emphasize each person’s defining contribution in Scripture.
3. Traits should feel desirable in a fighting or strategy card game while remaining biblically grounded.
4. Earlier images are prototypes and references, not official release assets.
5. Collector IDs are permanent; production order and artwork versions are tracked separately.
6. The repository is the source of truth for character data, prompts, RAG context, revision history, and final assets.

## Immediate queue

1. Review L010 Joshua reference sources and compiled prompt.
2. Generate and review Joshua official artwork after prompt approval.
3. Validate the final card layout and package workflow.
4. Apply the proven package structure to the remaining Legendary collection.

## Branch

Foundation work is currently maintained on `setup/card-context-foundation` until reviewed and merged into `main`.
