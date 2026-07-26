# Supplementary Development Roadmap

## Planning principle

This roadmap covers useful repository development that can proceed without running, changing, or approving image generation. Work is ordered by dependency and risk rather than feature appeal.

## Phase 0 — Baseline audit

Before each implementation wave:

- inspect `main` and all recently merged changes;
- run the existing Ruby validation and compilation tests;
- record current generated-artifact drift status;
- identify contracts owned by schemas and registries;
- confirm the task does not alter image lifecycle state.

Output: a short audit note in the pull request, not a permanent report unless the findings establish a new architectural decision.

## Phase 1 — Python platform bootstrap

Deliver:

- `python/pyproject.toml`;
- `src/biblegamecard` package;
- repository-root discovery;
- typed configuration;
- logging and error foundation;
- test, lint, and type-check setup;
- a minimal `biblegamecard --help` entry point.

Do not implement business operations beyond a health/version command.

Dependencies: none.

## Phase 2 — Unified CLI and service layer

Deliver stable commands:

```text
biblegamecard doctor
biblegamecard status
biblegamecard validate
biblegamecard readiness
biblegamecard compile <collector-id>
```

The first implementation calls existing Ruby tools and normalises their outputs. No Ruby logic is duplicated.

Dependencies: Phase 1.

## Phase 3 — Python CI and quality gates

Add CI jobs for:

- Python unit and integration tests;
- linting;
- type checking;
- package installation;
- CLI smoke tests;
- Ruby/Python contract tests;
- no-drift checks.

Dependencies: Phases 1-2.

## Phase 4 — Asset registry service

Build read and controlled-update services around `registry/asset_registry.yaml` and the generation-manifest schema.

Capabilities:

- list and query assets;
- validate lifecycle transitions;
- compute checksums;
- identify missing provenance;
- refuse unsupported or evidence-free state changes.

This phase must not create image files or move an item from `NOT_GENERATED` without real generation evidence.

Dependencies: Phases 1-3.

## Phase 5 — Dependency graph and impact analysis

Create a graph of source records, generated artifacts, assets, cards, exports, and releases.

Capabilities:

- show direct dependencies;
- show transitive dependants;
- calculate rebuild/review impact;
- emit deterministic JSON and human-readable output;
- detect cycles where cycles are prohibited.

Dependencies: Phase 4.

## Phase 6 — Semantic validation

Add cross-record rules that schemas alone cannot express.

Initial rules should focus on stable repository invariants:

- collector ID and canonical name consistency;
- registry/profile/package agreement;
- prohibited lifecycle claims;
- missing traceability;
- source/generated authority violations;
- unsupported historical or visual category combinations encoded as project rules;
- orphan generated artifacts;
- unresolved references.

Do not attempt automated theological approval.

Dependencies: Phases 1-5.

## Phase 7 — Card data compiler

Define and compile structured card records independently of artwork.

Deliver:

- card and ability schemas;
- deterministic compiler;
- rules-text projection;
- game-ready JSON;
- validation and drift checks;
- fixtures for a small controlled set of cards.

Do not invent final balance values without explicit source records.

Dependencies: Phases 1-3; benefits from Phase 6.

## Phase 8 — Rules engine foundation

Represent triggers, targets, conditions, effects, modifiers, and durations in machine-readable form.

Deliver a small deterministic evaluator and contract tests, not a full game client.

Dependencies: Phase 7.

## Phase 9 — MCP server

Expose approved services as bounded tools:

- repository status;
- list/find characters;
- validate;
- compile prompts;
- dependency impact;
- inspect assets;
- export card data.

MCP must not expose arbitrary command execution, unrestricted file writes, lifecycle approval, or image generation.

Dependencies: Phases 2, 4-7.

## Phase 10 — Static production dashboard

Generate a static dashboard from registries and generated reports.

Views:

- collection coverage;
- validation status;
- prompt readiness;
- lifecycle counts;
- blocked items;
- dependency impact;
- card-data coverage;
- release readiness.

Dependencies: Phases 4-7.

## Phase 11 — Documentation site

Generate a browsable documentation site from repository Markdown and schema references. Keep GitHub Markdown as the source; do not create a parallel documentation truth.

Dependencies: can run after Phase 3; best after Phase 10.

## Phase 12 — Localisation pipeline

Create language-neutral message IDs and localisation bundles for card text, names, keywords, rules, and interface strings.

Do not translate Scripture passages without an approved translation and licensing policy.

Dependencies: Phase 7.

## Phase 13 — Story and campaign exports

Compile timelines, relationships, locations, and events into derived campaign context. Outputs must distinguish canonical facts, project interpretation, and fictional connective content.

Dependencies: canonical data maturity and Phase 7.

## Phase 14 — Release builder

Assemble approved, versioned artifacts into reproducible release directories with checksums, source commit, manifests, licences, and release notes.

Dependencies: Phases 4-13 as applicable.

## Phase 15 — Provider plugin contracts

Define interfaces for future ComfyUI, OpenAI, FLUX-hosted, and SDXL-hosted execution providers.

This phase defines request/result contracts and fake providers only. Actual image execution remains a separate authorised task after the feasibility test.

Dependencies: Phases 1-4.

## Parallelisation guidance

Safe parallel tracks after Phase 3:

- asset registry/dependency graph;
- card data/rules engine;
- documentation site;
- semantic-validation rule design.

Avoid parallel changes to the same schemas, lifecycle values, CLI command tree, or package configuration.

## Suggested pull-request size

Each pull request should generally contain one of:

- one infrastructure layer;
- one service family;
- one schema plus compiler and tests;
- one dashboard/export capability;
- one documentation/ADR decision.

Do not combine MCP, REST, dashboard, provider execution, and schema migration into one pull request.
