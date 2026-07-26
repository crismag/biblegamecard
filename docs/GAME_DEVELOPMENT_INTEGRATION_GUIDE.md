# Game Development Integration Guide

## Purpose

This guide explains how BibleGameCard repository data can feed a web game, mobile game, server, campaign system, or other interactive product.

The central rule is:

> Applications consume compiled game-data contracts. They should not independently reinterpret authoring files.

## Integration architecture

```text
canonical repository data
    -> validation
    -> game-data compiler
    -> versioned distribution package
    -> web/mobile/server consumers
```

This separation allows repository schemas and authoring detail to evolve without forcing every consumer to understand internal production files.

## Recommended consumer contract

A future game-data compiler should emit stable application-facing files such as:

```text
dist/game-data/
  manifest.json
  cards.json
  abilities.json
  characters.json
  traits.json
  sets.json
  campaigns.json
  localisation/
    en.json
```

The manifest should include:

- export schema version;
- release version;
- source Git commit;
- build timestamp;
- compiler version;
- content checksums;
- minimum compatible client version.

## Card contract

An application-facing card record may include:

```json
{
  "id": "L010",
  "name_key": "card.L010.name",
  "title_key": "card.L010.title",
  "type": "legendary",
  "set_id": "core_legendary_v2",
  "cost": 6,
  "traits": ["faith", "leadership", "courage"],
  "ability_ids": ["march_around_the_walls"],
  "art": {
    "portrait": "cards/web/L010_joshua.webp",
    "thumbnail": "cards/thumbnails/L010_joshua.webp"
  }
}
```

The final fields must be governed by an approved game-data schema.

## Ability contract

Keep display text separate from executable behaviour.

Example:

```json
{
  "id": "march_around_the_walls",
  "display_name_key": "ability.march_around_the_walls.name",
  "rules_text_key": "ability.march_around_the_walls.rules",
  "trigger": {"type": "on_play"},
  "targets": {
    "side": "opponent",
    "entity_type": "fortress",
    "scope": "all"
  },
  "effects": [
    {
      "type": "modify_stat",
      "stat": "defence",
      "operation": "subtract",
      "value": 3,
      "duration": "until_end_of_turn"
    }
  ]
}
```

The engine should implement a controlled vocabulary of triggers, targets, conditions, effects, and durations.

## Engine design principle

Avoid writing one custom code path for every card.

Prefer:

```text
structured ability definition
    -> generic rules engine
    -> event processing
    -> state transition
```

Custom scripting should be reserved for mechanics that cannot be represented safely in the common contract.

## Suggested gameplay domains

A first game-data model may need:

- players;
- decks;
- hands;
- battlefield zones;
- characters;
- fortresses or objectives;
- resources;
- turns and phases;
- triggers;
- targeting;
- effects;
- statuses;
- durations;
- victory conditions;
- card ownership and unlocks.

The repository should define content. The game engine should define runtime state and enforcement.

## Web application integration

A web client can consume versioned JSON and image assets.

Suggested flow:

```text
release package
    -> static asset host or application bundle
    -> client loads manifest
    -> client verifies compatible schema
    -> client loads cards and localisation
    -> battle engine instantiates runtime objects
```

Do not store the only copy of card text inside raster images. Render accessible text from localisation records.

## Mobile integration

A mobile build may bundle a known content release and optionally download newer compatible releases.

Plan for:

- offline starter content;
- versioned asset packs;
- image-density variants;
- checksums;
- partial downloads;
- backwards-compatible schemas;
- migration of saved decks;
- invalidation of cached assets.

A released collector ID must remain stable so saved decks do not break when art or balance values change.

## Server integration

For authoritative multiplayer, the server should validate actions using the same release data or a server-owned compiled variant.

The server should not trust client-provided card definitions.

Recommended server responsibilities:

- deck legality;
- turn order;
- target validity;
- ability resolution;
- random outcomes;
- state persistence;
- anti-cheat checks;
- match replay events.

## Content versioning and compatibility

Treat these as distinct versions:

- repository source version;
- game-data schema version;
- content release version;
- card balance version;
- artwork version;
- client application version.

Changing artwork should not automatically change game behaviour.

Changing rules behaviour may require replay, saved-game, matchmaking, or deck-compatibility decisions.

## Localisation

Use keys rather than embedding English text in engine records.

Example:

```json
{
  "card.L010.name": "Joshua",
  "card.L010.title": "The Courageous",
  "ability.march_around_the_walls.name": "March Around the Walls",
  "ability.march_around_the_walls.rules": "Reduce opposing fortress defence until end of turn."
}
```

Scripture references may also require translation-specific handling. Separate the canonical passage identity from optional displayed verse text.

## Campaign and RPG integration

Canonical events, locations, and relationships can feed campaign data.

A campaign node may include:

```yaml
id: campaign_joshua_jericho
character_ids:
  - L010
location_id: LOC_JERICHO
source_event_id: EVT_JOSHUA_JERICHO
objectives:
  - complete_seven_day_march
  - preserve_noncombatant_focus
rewards:
  - unlock_card: L010
next_nodes:
  - campaign_joshua_ai
```

Dialogue and scene prose can be generated from approved context, but must not be promoted into canonical historical claims without review.

## AI-assisted gameplay features

Structured exports can support:

- tutorial explanations;
- deck recommendations;
- rule clarification;
- opponent AI evaluation;
- dynamic story narration;
- mission-generation assistance;
- card search and discovery.

The AI should receive release data and explicit rule contracts rather than raw repository access whenever possible.

Do not allow generative AI to change authoritative match state without validation by the game engine.

## Testing strategy

The game-data compiler should generate tests or fixtures for every ability.

Useful test layers:

1. schema validation;
2. semantic validation;
3. ability contract validation;
4. engine unit tests;
5. deterministic scenario tests;
6. card interaction tests;
7. deck legality tests;
8. release compatibility tests.

Example scenario:

```text
Given Joshua is played
And the opponent controls two fortresses
When March Around the Walls resolves
Then both fortresses receive the declared defence modification
And the effect expires at the declared duration
```

## First playable implementation

A minimal web prototype should initially support:

- eight cards;
- two small decks;
- draw and play actions;
- one battlefield or objective zone;
- resource cost;
- simple triggered abilities;
- turn progression;
- victory condition;
- card art loaded from exported assets.

Avoid building the full RPG, economy, marketplace, multiplayer backend, and collection system before the card-data export and rules loop are proven.

## Integration definition of done

A consumer integration is healthy when:

- all card identity comes from exported data;
- all art paths come from the release manifest;
- executable abilities use controlled structures;
- display text uses localisation keys;
- the client verifies schema compatibility;
- collector IDs remain stable;
- releases are reproducible from a repository commit;
- game code does not manually duplicate repository content.