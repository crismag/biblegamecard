# Prompt 05 — Card Data Compiler and Rules Engine

## Objective

Create artwork-independent structured card and ability data, deterministic exports, and a small rules-engine foundation.

## Required work

1. Audit existing gameplay fields, registry data, and documentation. Do not assume illustrative examples are approved values.
2. Propose and implement versioned schemas for card presentation data and executable abilities.
3. Model abilities using stable IDs and structured trigger, condition, target, effect, modifier, duration, limit, and display-text data.
4. Add authoring templates and a small controlled fixture set. Use only values supported by existing records or explicitly mark placeholders/drafts.
5. Implement deterministic compilation to outputs such as:
   - `generated/game-data/cards.json`
   - `generated/game-data/abilities.json`
   - `generated/game-data/keywords.json`
   - `generated/game-data/manifest.json`
6. Add write and `--check` drift modes.
7. Add `biblegamecard cards validate/compile/show` commands.
8. Implement a minimal pure-domain evaluator for the supported effect subset, with no UI or networking.
9. Generate display rules text from structured mechanics where feasible and test that it remains consistent.

## Constraints

- Artwork references must be optional until approved artwork exists.
- Do not invent final game balance, costs, statistics, or effects.
- Keep unsupported mechanics explicit rather than silently interpreting them.
- Do not embed card text only in images.

## Acceptance criteria

- Schemas, fixtures, compiler, check mode, and tests are included.
- Repeated compilation is byte-stable.
- Invalid references and unsupported effects fail clearly.
- The evaluator is deterministic and tested but intentionally limited.
- Existing image-generation files and lifecycle state remain unchanged.
