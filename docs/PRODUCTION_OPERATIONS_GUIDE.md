# Production Operations Guide

## Purpose

This guide defines the operational discipline for moving BibleGameCard content from draft source records into generated, reviewed, approved, and released assets.

It supplements the repository’s detailed validation and artwork-review standards with a practical production-operations view.

## Production states are separate dimensions

Do not collapse every status into a single label.

A character or card may have independent states for:

- source authoring;
- schema validation;
- theology review;
- historical review;
- gameplay review;
- prompt review;
- generation readiness;
- artwork generation;
- artwork review;
- card-layout review;
- print proof;
- application integration;
- release approval.

For example, a profile may be structurally valid and generation-ready while all human reviews remain pending.

## Source, generated, approved, and released

Use these operational categories consistently.

### Source

Human- or agent-authored canonical records and approved project decisions.

Examples:

```text
knowledge/
registry/
schemas/
templates/
```

### Generated

Reproducible outputs created from source records.

Examples:

```text
generated/knowledge/
generated/prompts/
generated/reports/
generated/images/
dist/
```

### Approved

A specific source version or generated candidate that has passed its required review gate.

Approval must identify the exact file version or checksum.

### Released

An approved artifact included in a versioned distribution package.

Released artifacts should not be overwritten in place.

## Production roles

One person may hold several roles in a small project, but the responsibilities should remain distinct.

### Content author

Creates Scripture-grounded source records and classifies claims.

### Gameplay designer

Defines mechanics, differentiation, balance intent, and executable behaviour contracts.

### Art director

Defines visual identity, composition, continuity, and prohibited concepts.

### Generation operator

Runs approved prompts and records model, adapter, seed, settings, and outputs.

### Reviewer

Evaluates a specific source or candidate against a defined standard.

### Release manager

Confirms versions, checksums, approvals, compatibility, and package completeness.

## Branch and pull-request operations

Use focused branches from `main`.

A production PR should identify:

- source files changed;
- generated files changed;
- tools executed;
- validation results;
- review gates completed;
- review gates still pending;
- compatibility impact;
- rollback or replacement implications.

Avoid combining:

- new character authoring;
- broad schema redesign;
- game-engine implementation;
- artwork generation;
- unrelated documentation cleanup;

unless the changes are inseparable and explained.

## Validation versus approval

Automated validation can confirm:

- schema shape;
- required fields;
- valid IDs;
- graph references;
- controlled values;
- deterministic outputs;
- traceability completeness;
- readiness-rule compliance.

Automated validation cannot independently approve:

- theology;
- historical reconstruction;
- gameplay quality;
- artistic excellence;
- denominational sensitivity;
- print quality;
- commercial release suitability.

Never translate `PASS` into a human approval state unless the relevant standard explicitly defines an automated gate.

## Deterministic generation and drift

A generated artifact is deterministic when the same approved source version and tool version produce the same controlled output.

For deterministic text and data outputs:

1. edit canonical source;
2. run validation;
3. run generator in write mode;
4. run generator in check mode;
5. confirm no uncommitted drift remains;
6. commit source and generated output together when repository policy requires it.

Image generation may not be pixel-deterministic across hosted providers. Reproducibility should still preserve:

- source prompt hash;
- adapter version;
- model and model version;
- seed when supported;
- settings;
- generation request;
- candidate checksum.

## Versioning model

Version these concerns independently.

### Knowledge version

Changes when canonical understanding or structured source data changes.

### Prompt version

Changes when semantic prompt content, clause ordering, or exclusions change.

### Adapter version

Changes when provider-specific transformation or settings change.

### Artwork version

Changes when the approved master image changes.

### Card-data version

Changes when rules, cost, traits, or displayed card content changes.

### Layout version

Changes when frame, typography, icons, or placement rules change.

### Release version

Changes when a distributable package changes.

Do not force all of these to share one version number.

## Review evidence

A review record should include:

- review type;
- reviewer;
- date;
- exact subject ID and version;
- file checksum when applicable;
- decision;
- findings;
- required corrections;
- follow-up reference.

An approval that does not identify the reviewed version is not reliable production evidence.

## Artwork-generation operations

Before generation, confirm:

- prompt source is complete;
- traceability is present;
- generation readiness is computed;
- model adapter is selected;
- output settings are defined;
- prohibited concepts are included;
- generation request is authorised.

After generation:

- preserve every candidate’s metadata;
- do not rename files ambiguously;
- run technical checks;
- record rejection reasons;
- shortlist intentionally;
- approve only a specific checksum;
- create a new artwork version for material revisions.

## Technical image checks

A future image-quality tool may check:

- dimensions;
- aspect ratio;
- file type;
- colour profile;
- alpha channel;
- corruption;
- checksum;
- crop safety;
- duplicate or near-duplicate candidates;
- basic text or watermark detection.

Technical checks do not replace visual review.

## Card-rendering operations

Before rendering, confirm:

- approved artwork master exists;
- card data passes schema validation;
- rules text is final for the target release;
- layout template version is selected;
- font and icon licences permit use;
- output profile is selected.

After rendering, review:

- text overflow;
- contrast and legibility;
- safe zones;
- icon alignment;
- crop placement;
- front/back consistency;
- print bleed;
- web compression;
- mobile memory use.

## Print-production operations

A print candidate should pass:

1. digital layout validation;
2. high-resolution export check;
3. bleed and trim inspection;
4. front/back alignment check;
5. colour proof;
6. physical sample print;
7. handling and readability review;
8. final print approval.

Do not treat a screen preview as a print proof.

## Game-data release operations

Before exporting game data, confirm:

- source card data is approved for the target release;
- ability structures pass semantic validation;
- localisation keys resolve;
- asset paths exist;
- collector IDs are unique and stable;
- client compatibility is declared;
- balance changes are recorded.

A release build should produce checksums and a manifest tied to a source commit.

## CI and automation expectations

Continuous integration should gradually enforce:

- schema tests;
- validator unit tests;
- canonical package validation;
- deterministic assembly checks;
- prompt-development readiness checks;
- generated-report drift checks;
- broken-link checks;
- game-data export tests;
- layout-render smoke tests;
- release-manifest integrity.

CI should fail closed when required production evidence is missing.

## Incident and correction handling

When an error is discovered after generation or release:

1. identify the authoritative source of the error;
2. correct the source rather than only patching output;
3. increment the affected version;
4. regenerate dependent artifacts;
5. repeat required reviews;
6. deprecate or replace the incorrect artifact;
7. document compatibility and release impact.

Examples:

- Wrong Scripture reference: correct canonical knowledge and regenerate all derived text.
- Incorrect weapon: correct art direction or prompt source and generate a new artwork version.
- Broken ability: correct card-data behaviour, update tests, and release a balance/content revision.
- Print crop problem: update layout or crop metadata, not the canonical character facts.

## Release checklist

A production release should confirm:

- source commit is identified;
- release version is assigned;
- all included assets are approved;
- generated outputs are current;
- validators and tests pass;
- unresolved blockers are absent or explicitly excluded;
- licences and provenance are recorded;
- checksums are generated;
- release notes describe changes;
- rollback or replacement path is understood.

## Operational maturity stages

### Stage 1 — Authoring repository

Structured knowledge, schemas, templates, and manual review.

### Stage 2 — Reproducible prompt and artwork pipeline

Prompt compilation, adapters, generation requests, candidate metadata, and artwork review.

### Stage 3 — Card and game-data factory

Structured mechanics, card rendering, application exports, and automated tests.

### Stage 4 — Release platform

Print/mobile/web profiles, CI build artifacts, compatibility controls, and versioned releases.

### Stage 5 — Content ecosystem

Campaign generation, localisation, creator workflows, balance operations, and multiple products consuming the same canonical knowledge.

## Production definition of done

A production item is complete only when:

- its authoritative source is known;
- required validators pass;
- required human reviews are recorded;
- generated artifacts are traceable;
- versions and checksums are recorded;
- consumer compatibility is defined;
- the item is included in a controlled release or intentionally remains unreleased.