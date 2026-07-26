# Game and Asset Production Workflow

## Purpose

This guide explains how BibleGameCard source knowledge is intended to become image, card, print, web, mobile, and release assets.

The workflow is deliberately staged so that generated assets remain reproducible and reviewable.

## End-to-end production chain

```text
Scripture-grounded canonical knowledge
    -> character and gameplay records
    -> schema and domain validation
    -> prompt compilation
    -> image-generation request
    -> image candidates and metadata
    -> artwork review
    -> approved artwork
    -> card-data compilation
    -> card-layout rendering
    -> print, web, and mobile exports
    -> game-data and release packages
```

## Stage 1: Canonical character and card knowledge

The source layer defines what must remain stable across outputs.

Typical information:

- collector ID;
- canonical name and title;
- Scripture references;
- defining scene;
- gameplay archetype and traits;
- signature ability;
- visual identity;
- continuity rules;
- prohibited elements;
- review state;
- version history.

A rendered card must not become the only location where ability text, title, statistics, or Scripture references exist.

## Stage 2: Prompt-development readiness

A lightweight prompt-development profile can prepare a character for first-pass generation before a full canonical package exists.

The profile should answer:

- Who is depicted?
- At what life stage?
- Which biblical scene is shown?
- What is the focal action?
- What identifies the character visually?
- What environment and supporting figures are allowed?
- What composition is required?
- What must not appear?
- Which source supports each major clause?

The target `GENERATION_READY_DRAFT` state authorises draft generation only.

## Stage 3: Prompt compilation

Prompt compilation should convert model-neutral structured data into a reproducible prompt artifact.

Suggested output shape:

```text
generated/prompts/<asset-id>/<prompt-version>/
  prompt.txt
  negative_prompt.txt
  manifest.yaml
  traceability.yaml
```

The manifest should record:

- asset ID;
- collector ID;
- prompt version;
- source package version;
- source file hashes;
- compiler version;
- adapter name and version, when applied;
- output intent;
- aspect ratio;
- generation status.

The traceability record should map prompt clauses back to canonical fields and references.

## Stage 4: Model adapter

Canonical prompts should remain portable.

A model adapter may add provider-specific details such as:

- prompt formatting;
- negative-prompt syntax;
- aspect ratio notation;
- quality settings;
- seed handling;
- safety constraints;
- output resolution;
- reference-image handling.

The adapter must not invent biblical facts or silently override canonical art direction.

Suggested future adapter locations:

```text
adapters/image/<provider>/
templates/production/model_adapter.yaml
```

## Stage 5: Generation request

A generation request should identify exactly what is authorised.

Suggested fields:

```yaml
request_id: GEN-L010-ART-01-0001
asset_id: L010-JOSHUA-ART-01
collector_id: L010
prompt_version: 1.0.0
adapter: provider-name
adapter_version: 1.0.0
candidate_count: 4
aspect_ratio: "2:3"
resolution: "2048x3072"
seed_policy: recorded
source_prompt_sha256: "..."
status: approved_for_draft_generation
```

The generation system should reject requests whose required review gates or adapter fields are missing.

## Stage 6: Candidate generation and metadata

Store candidates in a controlled location rather than scattering files manually.

Suggested structure:

```text
generated/images/L010-JOSHUA-ART-01/1.0.0/
  candidate-001.png
  candidate-001.yaml
  candidate-002.png
  candidate-002.yaml
  generation-run.yaml
```

Each candidate metadata record should include:

- model and model version;
- provider;
- prompt version and hash;
- negative-prompt hash;
- adapter version;
- seed;
- dimensions;
- generation timestamp;
- source request ID;
- safety or moderation result;
- checksum;
- review state.

## Stage 7: Artwork review

Generated candidates are not official assets.

Review should cover:

- biblical and theological integrity;
- historical plausibility;
- character continuity;
- scene accuracy;
- signature-object accuracy;
- composition and crop safety;
- anatomy and image defects;
- collection-wide visual consistency;
- card-layout compatibility;
- licensing and provenance.

Possible outcomes:

```text
rejected
changes_requested
shortlisted
approved_as_master
```

A review decision should reference the exact candidate checksum.

## Stage 8: Approved artwork master

An approved candidate becomes a controlled master asset.

Suggested structure:

```text
assets/artwork/legendary/L010_joshua/
  master-v1.0.0.png
  master-v1.0.0.yaml
```

The metadata should preserve:

- candidate origin;
- approval records;
- crop restrictions;
- colour and resolution information;
- licence or generation provenance;
- permitted derivatives;
- replacement and deprecation history.

Do not overwrite a released master. Create a new version.

## Stage 9: Structured card data

Card content should exist independently from the rendered image.

Illustrative structure:

```yaml
collector_id: L010
name: Joshua
title: The Courageous
card_type: legendary
cost: 6
traits:
  - faith
  - leadership
  - courage
ability:
  id: march_around_the_walls
  display_name: March Around the Walls
  rules_text: Reduce opposing fortress defence until end of turn.
scripture_references:
  - Joshua 6:1-20
art_asset_id: L010-JOSHUA-ART-01
```

Final schema and values must follow repository-approved gameplay standards.

## Stage 10: Structured game behaviour

Ability behaviour should eventually be machine-readable rather than only prose.

Illustrative example:

```yaml
trigger:
  type: on_play
target:
  side: opponent
  entity_type: fortress
  scope: all
effect:
  type: modify_stat
  stat: defence
  operation: subtract
  value: 3
duration:
  type: until_end_of_turn
```

This structure can generate:

- card rules text;
- engine behaviour;
- automated tests;
- AI-readable mechanics;
- balance analysis;
- documentation.

## Stage 11: Card rendering

A renderer combines:

```text
approved artwork
+ structured card data
+ approved frame template
+ typography and icon rules
+ output profile
```

Suggested outputs:

```text
dist/cards/print/L010_joshua_front.png
dist/cards/print/L010_joshua_back.png
dist/cards/web/L010_joshua.webp
dist/cards/mobile/L010_joshua.avif
dist/cards/thumbnails/L010_joshua.webp
```

### Print profile

Should eventually define:

- physical dimensions;
- bleed and safe zones;
- resolution and DPI;
- front/back alignment;
- colour profile;
- trim marks;
- sheet imposition;
- export format;
- printer proof status.

### Web profile

Should define:

- responsive dimensions;
- compression quality;
- thumbnail and full-size variants;
- accessible card text outside the image;
- caching and versioned filenames.

### Mobile profile

Should define:

- device-density variants;
- memory budget;
- texture or atlas rules;
- compressed formats;
- offline packaging;
- fallback assets.

## Stage 12: Game-data export

Applications should consume a compiled contract rather than reading authoring YAML directly.

Suggested output:

```text
dist/game-data/cards.json
dist/game-data/abilities.json
dist/game-data/characters.json
dist/game-data/localisation/en.json
dist/game-data/manifest.json
```

The export manifest should record schema version, build version, checksums, and source commit.

## Stage 13: Story and campaign assets

Character timelines, relationships, locations, and events can feed story development.

Possible generated content:

- campaign chapters;
- map nodes;
- mission objectives;
- encounter definitions;
- dialogue context;
- unlock conditions;
- rewards;
- scene-art prompts;
- Scripture discovery notes.

Story outputs remain derived products. New narrative claims must return to canonical review before becoming source facts.

## Stage 14: Release package

A release should be assembled from approved, versioned outputs.

Illustrative structure:

```text
releases/0.1.0/
  manifest.json
  game-data/
  web-assets/
  mobile-assets/
  print-assets/
  licences/
  release-notes.md
  checksums.txt
```

A release manifest should identify the exact source commit and every included asset version.

## First vertical-slice tutorial

Use the following sequence for the first playable proof:

1. select eight Legendary characters;
2. complete generation-ready prompt-development records;
3. compile prompts with traceability;
4. generate four candidates per character;
5. review and approve one master per character;
6. define simple structured card data and abilities;
7. render one common card frame;
8. export web card images and JSON;
9. build one simple battle loop;
10. produce a printable test sheet;
11. collect gameplay and print feedback;
12. revise canonical sources rather than patching outputs.

## Production principle

Every output should answer:

```text
What source produced this?
Which version produced it?
Which tool produced it?
Who reviewed it?
What may consume it?
Has it been released?
```

If those questions cannot be answered, the asset is not yet production-controlled.