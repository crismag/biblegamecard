# Legendary Prompt Development

This directory contains lightweight, machine-readable prompt-development source records for the 34-card Core Legendary Collection.

## Purpose

These records support the mobile-first authoring milestone defined as `GENERATION_READY_DRAFT`: enough grounded information exists to compile and run a coherent first-pass artwork prompt without inventing core visual decisions during desktop generation.

This milestone is narrower than production approval. A generation-ready draft is not automatically theologically approved, historically approved, gameplay approved, prompt approved, artwork approved, print ready, or production ready.

## Authority

- Full canonical character packages remain authoritative when they exist.
- These prompt-development records may temporarily contain normalized draft knowledge for characters that do not yet have full canonical packages.
- When a full package is created, duplicated facts must migrate to or reference that package rather than diverge indefinitely.
- Generated prompts and readiness reports are reproducible outputs and are never authoritative sources.

## Record names

Use the permanent collector ID and normalized character name:

```text
L001_noah.yaml
L002_abraham.yaml
...
L034_timothy.yaml
```

## Authoring states

- `AUTHORING_DRAFT` — meaningful required content is still missing.
- `PROMPT_SOURCE_COMPLETE` — required prompt-source fields are populated and traceable.
- `GENERATION_READY_DRAFT` — sufficient for first-pass image generation, with deferred reviews and unresolved assumptions made explicit.

These values must not replace `official_status` in the Legendary registry. Production status and generation readiness are separate dimensions.

## Required discipline

- Ground claims in Scripture or explicitly classify them as historical context, inference, tradition, or project interpretation.
- Record uncertainty instead of inventing unsupported certainty.
- Avoid visible depictions of God the Father as a human figure.
- Do not portray miracles as independent magical power belonging to the character.
- Avoid generic medieval European wardrobe and architecture.
- Keep raw character-art prompts free of card text, logos, borders, and UI.
- Preserve a premium vertical collectible-card composition.
- Keep all unavailable human review states pending.
- Keep image generation state `NOT_STARTED` until an actual generation attempt is recorded.

## Validation

Validate all records with:

```bash
bundle exec ruby tools/validate_legendary_prompt_development.rb --all
```

Validate one record with:

```bash
bundle exec ruby tools/validate_legendary_prompt_development.rb \
  knowledge/prompt_development/legendary/L001_noah.yaml
```

The validator checks the dedicated schema and repository-specific readiness rules. It does not run production approval gates.
