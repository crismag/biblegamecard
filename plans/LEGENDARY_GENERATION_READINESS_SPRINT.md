# Legendary Generation-Readiness Sprint

## Goal

Make every character in the 34-card Core Legendary Collection ready for first-pass artwork generation before desktop production begins.

This milestone is intentionally narrower than production approval. It covers the research, design, structured prompt authoring, and traceability work that can be completed through ChatGPT, Codex, and GitHub without generating images or performing unavailable human review.

## Milestone definition

A character may enter `GENERATION_READY_DRAFT` when the repository contains enough grounded, structured information to compile a coherent first-pass artwork prompt without inventing missing decisions during generation.

This state does **not** imply:

- theological approval;
- historical approval;
- gameplay approval;
- prompt-model validation;
- artwork approval;
- print readiness;
- final production readiness.

## Scope

Apply this sprint to `L001` through `L034` in `registry/legendary_cards.json`.

Joshua remains the production reference implementation. Esther and Moses remain architecture-validation characters, but their unfinished approval state must not block draft prompt authoring for the rest of the collection.

## Required generation-readiness content

Each Legendary character must have a normalized prompt-development profile containing at least:

1. **Identity**
   - collector ID;
   - canonical name;
   - Legendary title;
   - life stage depicted;
   - primary biblical era and culture.

2. **Biblical grounding**
   - primary passages;
   - secondary passages;
   - defining event or scene;
   - classification of statements as Scripture, historical context, inference, tradition, or project interpretation.

3. **Gameplay identity**
   - archetype;
   - traits;
   - signature ability;
   - strategic identity;
   - distinction from closely related characters.

4. **Visual identity**
   - physical presentation without unsupported certainty;
   - wardrobe and materials;
   - culturally appropriate accessories;
   - signature objects;
   - environment;
   - supporting figures where appropriate;
   - visual continuity constraints.

5. **Composition**
   - focal action;
   - camera distance and angle;
   - pose;
   - foreground, middle ground, and background;
   - card-frame-safe negative space;
   - vertical collectible-card composition.

6. **Art direction**
   - mood;
   - lighting;
   - palette;
   - material and environmental texture;
   - premium biblical collectible-card rendering language;
   - prohibited fantasy, anachronistic, denominationally loaded, or culturally inaccurate elements.

7. **Prompt source**
   - semantic positive prompt source;
   - negative constraints;
   - optional variation notes;
   - unresolved assumptions explicitly marked;
   - source-to-prompt traceability.

8. **Readiness state**
   - content completeness;
   - unresolved questions;
   - deferred automated validation;
   - deferred human review;
   - image generation state.

## Proposed canonical location

Use a lightweight, normalized authoring layer rather than prematurely cloning Joshua's full production package for every character:

```text
knowledge/prompt_development/legendary/
  README.md
  L001_noah.yaml
  L002_abraham.yaml
  ...
  L034_timothy.yaml
```

These files are prompt-development source records, not substitutes for full canonical character packages. When a character receives a full package, its canonical knowledge should become authoritative and the prompt-development record should reference or migrate into that package rather than duplicate facts indefinitely.

## Proposed schema

Create:

```text
schemas/legendary_prompt_development.schema.json
```

Minimum conceptual shape:

```yaml
schema_version: 0.1.0
collector_id: L001
character_name: Noah
status: AUTHORING_DRAFT
identity:
  legendary_title: Guardian of Creation
  depicted_life_stage: mature patriarch
  era: antediluvian world
biblical_basis:
  primary_passages: []
  secondary_passages: []
  defining_scene: Noah before the ark under an approaching storm
  claims: []
gameplay_identity:
  archetype: Fortress Guardian
  traits: [Obedience, Protection, Endurance]
  signature_ability: Ark of Salvation
  strategic_identity: catastrophe defence and team shelter
  differentiation: []
visual_identity:
  presentation: []
  wardrobe: []
  materials: []
  signature_objects: []
  environment: []
  continuity_constraints: []
composition:
  focal_action: ""
  pose: ""
  camera: ""
  foreground: []
  middle_ground: []
  background: []
  card_frame_safe_space: ""
art_direction:
  mood: []
  lighting: []
  palette: []
  rendering_language: []
  prohibited_elements: []
prompt_source:
  positive_prompt: ""
  negative_prompt: ""
  variations: []
traceability:
  prompt_clauses: []
readiness:
  content_state: AUTHORING_DRAFT
  automated_schema_validation: PENDING_TOOL_EXECUTION
  theological_review: PENDING_HUMAN_REVIEW
  historical_review: PENDING_HUMAN_REVIEW
  gameplay_review: PENDING_HUMAN_REVIEW
  artwork_generation: NOT_STARTED
  unresolved_questions: []
```

The implemented schema should use repository-controlled enums and conventions wherever those already exist. Do not create conflicting status vocabularies when a suitable controlled term already exists.

## Status model

Use these conceptual stages, mapped to existing repository terminology where possible:

- `AUTHORING_DRAFT` — profile exists but contains meaningful omissions.
- `PROMPT_SOURCE_COMPLETE` — all required prompt-development fields are populated and traceable.
- `GENERATION_READY_DRAFT` — sufficient for first-pass image generation; deferred reviews are explicit.
- `GENERATION_TESTED` — at least one generation attempt has been recorded and evaluated.
- `PROMPT_APPROVED` — exact prompt version approved through the production gate.

Only the first three stages are in scope for the mobile sprint.

## Implementation sequence

### Step 1 — Establish authoring infrastructure

1. Add the prompt-development schema.
2. Add the directory README explaining authority, migration, and readiness semantics.
3. Add one reusable template.
4. Add validation coverage using the existing Ruby validation conventions.
5. Ensure draft records are discoverable without being mistaken for approved canonical packages.

### Step 2 — Bootstrap all 34 records

Generate one record per registry character using existing values from:

- `registry/legendary_cards.json`;
- `registry/LEGENDARY_CHARACTER_PLAN.md`;
- existing canonical packages when present.

Do not invent unsupported biblical or historical details merely to fill fields. Mark open questions explicitly.

### Step 3 — Develop in waves

Recommended authoring waves:

1. `L001-L008` — primeval history, patriarchs, Job, and Moses.
2. `L009-L018` — conquest, judges, monarchy, Elijah, and Elisha.
3. `L019-L027` — major prophets, exile, restoration, Esther, and Ruth.
4. `L028-L034` — John the Baptist and apostolic-era figures.

Each wave should result in reviewable records rather than one enormous unreviewable commit.

### Step 4 — Compute readiness

Add a tool or deterministic report that summarizes:

- required-field completeness;
- unresolved-question count;
- missing citations;
- missing positive prompt;
- missing negative prompt;
- readiness state;
- deferred review states.

Suggested output:

```text
generated/reports/legendary_generation_readiness.json
```

The report is generated and non-authoritative.

### Step 5 — Update tracking

Update the machine-readable registry or a dedicated tracker with a prompt-development status that does not overwrite production approval status.

Do not misuse `official_status` to represent authoring completeness. Production status and generation-readiness status are separate dimensions.

## Authoring rules

- Preserve biblical integrity over visual spectacle.
- Avoid depicting God the Father as a visible human figure.
- Do not imply that miracles originate from a character's independent magical power.
- Avoid generic medieval European clothing and architecture.
- Avoid unsupported certainty about facial features, skin tone precision, height, or body type.
- Distinguish divinely supplied imagery from fantasy embellishment.
- Preserve character age and life-stage continuity.
- Keep prompts suitable for premium vertical collectible-card artwork.
- Keep card text, logos, borders, and UI out of raw character artwork prompts unless an asset explicitly requires them.
- Record ambiguity instead of silently resolving it.

## Codex execution contract

Codex should:

1. inspect repository schemas, validators, templates, controlled vocabularies, and Joshua's implementation before editing;
2. reuse existing conventions rather than creating parallel architecture;
3. implement infrastructure and records in focused commits or PRs;
4. run all available repository tests and deterministic checks;
5. report tests that cannot run rather than claiming success;
6. never mark human review or artwork approval complete;
7. never regenerate or edit generated artifacts manually when a repository generator owns them;
8. preserve clean authority boundaries between canonical knowledge, prompt-development records, compiled prompts, and generated reports.

## Acceptance criteria for the mobile sprint

The sprint is complete when:

- all 34 Legendary characters have prompt-development records;
- every record has biblical references, a defining scene, gameplay identity, visual identity, composition, art direction, positive prompt source, negative constraints, and explicit readiness metadata;
- all profiles pass structural validation available in the repository;
- all unresolved decisions are visible rather than hidden;
- a deterministic report identifies which characters are `GENERATION_READY_DRAFT`;
- no character is falsely marked reviewed, approved, generated, or production-ready;
- a desktop user can select any `GENERATION_READY_DRAFT` character and begin first-pass image generation without inventing core visual decisions.

## Out of scope

- image generation;
- selecting a final image model or adapter;
- candidate artwork scoring;
- final theological, historical, gameplay, or art review;
- layout and typography;
- print production;
- final prompt approval;
- final production asset approval.
