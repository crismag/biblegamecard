# Bible Game Card

A version-controlled design and context repository for a premium biblical collectible strategy card game.

## Current focus

The current milestone is to complete the L010 Joshua production reference, validate the reusable character-package architecture with Esther and Moses, and then expand across the 34-card **Core Legendary Collection** as a consistent Official V2 release set.

## Start here

- [Repository usability and production guide](docs/USABILITY_AND_PRODUCTION_GUIDE.md)
- [How to use the repository](docs/HOW_TO_USE_THE_REPOSITORY.md)
- [Game and asset production workflow](docs/GAME_AND_ASSET_PRODUCTION_WORKFLOW.md)
- [Game development integration guide](docs/GAME_DEVELOPMENT_INTEGRATION_GUIDE.md)
- [Production operations guide](docs/PRODUCTION_OPERATIONS_GUIDE.md)
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
6. Canonical knowledge and review evidence are authoritative; generated outputs and human-facing trackers are reproducible projections.

## Immediate queue

1. Complete L010 Joshua cross-discipline review and approve the exact compiled prompt.
2. Select the Joshua model adapter and output settings, then generate and evaluate official artwork candidates.
3. Begin L026 Esther and L008 Moses as controlled canonical-package architecture tests while Joshua production continues.
4. Complete the print-production specification before final Joshua card approval.
5. Apply the proven package structure and production workflow to the remaining Legendary collection.

## Development workflow

`main` is the canonical integration branch. New work is developed on focused branches and merged through reviewed pull requests after required validation, deterministic-generation, and drift checks pass.

## Canonical validation

Install the locked Ruby dependencies with `bundle install`, then run `bundle exec ruby tools/validate_character_knowledge.rb --all`, `bundle exec ruby -Itest test/validate_character_knowledge_test.rb`, and `bundle exec ruby tools/assemble_character_knowledge.rb --check --all`. Artwork readiness is computed from review evidence and remains blocked independently of structural validation.
