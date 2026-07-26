# How to Use the BibleGameCard Repository

## 1. Start with the type of work

Before editing, identify the work category.

| Goal | Primary location | Typical output |
|---|---|---|
| Research a biblical character | `knowledge/` | canonical YAML or Markdown |
| Define card identity and mechanics | `registry/`, canonical gameplay data | structured gameplay record |
| Prepare artwork direction | canonical art data or prompt-development profile | prompt source |
| Generate prompts | `tools/` plus canonical sources | `generated/prompts/` |
| Generate artwork | generation request plus model adapter | image candidates and metadata |
| Review artwork | `cards/` review package | review decision and approved asset pointer |
| Render cards | approved artwork plus card data | print/web/mobile card assets |
| Build game content | exported structured data | game-ready JSON or engine resources |
| Build campaign content | characters, events, relationships, locations | missions, chapters, dialogue context |

Do not begin by editing a rendered card or generated prompt when the requested change belongs in canonical knowledge.

## 2. Find the authoritative source

Use the collector ID as the stable identity.

Example:

```text
L010 — Joshua
```

Relevant sources may include:

```text
registry/legendary_cards.json
knowledge/characters/legendary/L010_joshua/
knowledge/prompt_development/legendary/L010_joshua.yaml
cards/L010_joshua/
generated/prompts/L010-JOSHUA-ART-01/
```

The same character can appear in several layers for different purposes. Verify which layer owns the decision you are changing.

## 3. Understand the two character-authoring paths

### Lightweight prompt-development profile

Location:

```text
knowledge/prompt_development/legendary/
```

Use this to make a character ready for first-pass artwork generation before a complete canonical production package exists.

Typical lifecycle:

```text
AUTHORING_DRAFT
    -> PROMPT_SOURCE_COMPLETE
    -> GENERATION_READY_DRAFT
```

This path does not imply final theology, history, gameplay, prompt, artwork, or production approval.

### Full canonical character package

Location:

```text
knowledge/characters/legendary/<package>/data/
```

Use this for production-grade character knowledge, including relationships, timelines, gameplay, art, prompt, review, and version history.

A full package must pass stricter schema, graph, traceability, deterministic assembly, and review-gate checks.

## 4. Create work on a focused branch

`main` is the canonical integration branch.

Suggested workflow:

```bash
git checkout main
git pull --ff-only
git checkout -b feature/<focused-change>
```

Examples:

```text
feature/legendary-generation-wave-2
feature/joshua-artwork-review
feature/card-data-export
fix/prompt-traceability
```

Avoid mixing unrelated documentation, schema, character, and tooling changes in one branch.

## 5. Use templates rather than inventing structures

Check `templates/` before creating a record.

Typical examples:

```text
templates/legendary_prompt_development.yaml
templates/card_package/
templates/character_knowledge/
templates/production/model_adapter.yaml
```

Copy the appropriate template, preserve field names and controlled values, then replace placeholders with meaningful content.

Do not remove required fields just because the information is not yet approved. Use the repository’s pending, unresolved, or blocked state instead.

## 6. Author source records carefully

A good source record should:

- separate Scripture from inference, tradition, historical context, and project interpretation;
- use stable IDs;
- preserve collector numbering;
- record the selected life stage and defining scene;
- define gameplay differentiation;
- provide actionable art direction;
- record prohibited elements;
- expose unresolved questions;
- avoid claiming approval that has not occurred.

A source record should not contain a vague phrase when a future generator or developer would need to invent the missing decision.

Weak:

```text
heroic biblical clothing
```

Stronger:

```text
layered natural-fibre travel garments appropriate to an ancient Israelite military leader, practical leather belt, weathered sandals, no royal crown or medieval armour
```

## 7. Validate the appropriate layer

### Prompt-development profiles

Use the dedicated lightweight tooling:

```bash
bundle exec ruby tools/validate_legendary_prompt_development.rb --all
bundle exec ruby tools/report_legendary_generation_readiness.rb
bundle exec ruby tools/report_legendary_generation_readiness.rb --check
bundle exec ruby -Itest test/legendary_prompt_development_tools_test.rb
```

Use the repository-supported invocation if the CLI differs.

### Canonical character packages

Use the production tooling:

```bash
bundle exec ruby tools/validate_character_knowledge.rb --all
bundle exec ruby tools/assemble_character_knowledge.rb --check --all
bundle exec ruby -Itest test/validate_character_knowledge_test.rb
```

Structural validity and generation readiness are different results. A package can be structurally valid while artwork generation remains blocked by review or adapter settings.

## 8. Regenerate outputs through tools

When a source changes, determine which generated outputs depend on it.

Possible outputs include:

```text
generated/knowledge/
generated/prompts/
generated/reports/
dist/
```

Run the owning tool in write mode, then run its check or drift mode.

Never repair generated drift by manually editing the generated output.

The correct sequence is:

```text
edit source
    -> run validator
    -> regenerate output
    -> run drift check
    -> inspect diff
```

## 9. Review the diff by authority layer

Before committing, check:

- Did canonical files change intentionally?
- Did generated files change only because their sources changed?
- Did a tracker accidentally claim a stronger state?
- Were any collector IDs renamed?
- Did a model-specific detail leak into a model-neutral source?
- Did generated text become a source citation?
- Are unresolved questions visible?
- Are human approvals still pending where required?

## 10. Commit and open a pull request

Use descriptive commits, for example:

```text
Author Wave 2 Legendary prompt profiles
Regenerate Legendary readiness report
Add game-data export contract
```

A pull request should state:

- purpose;
- authoritative files changed;
- generated outputs changed;
- validation commands and results;
- review gates still pending;
- known limitations;
- next operational action.

## 11. Mobile-first work

The repository supports useful work before desktop image production.

Good mobile or chat-based activities:

- biblical research and claim classification;
- character identity authoring;
- gameplay differentiation;
- visual direction;
- prompt-source writing;
- traceability;
- issue and PR planning;
- review comments.

Desktop or tool-dependent activities:

- local validation when unavailable in Codex;
- image generation;
- image comparison and colour checking;
- card-layout rendering;
- print preparation;
- release packaging.

## 12. Working with AI agents

Provide an AI agent with:

- repository and branch;
- exact scope;
- authoritative source paths;
- required validation commands;
- forbidden status changes;
- definition of done;
- PR expectations.

Require the agent to inspect the repository before editing.

Do not instruct an agent to make every character “approved.” Instruct it to populate truthful source data and let validators and reviewers determine readiness.

## 13. Common mistakes

Avoid:

- editing generated outputs directly;
- using artwork as canonical evidence;
- confusing generation-ready with production-approved;
- placing all game behaviour only in prose;
- copying card values separately into web and mobile code;
- introducing a second schema for the same concept;
- using one generic prompt for many characters;
- creating a giant PR with unrelated work;
- marking reviews complete because a validator passed.

## 14. Practical first exercise

To learn the repository, complete one character through the lightweight workflow:

1. open its registry record;
2. copy the prompt-development template;
3. add primary Scripture references;
4. select one defining scene;
5. define gameplay identity and differentiation;
6. define visual identity and composition;
7. write positive and negative prompt sources;
8. add traceability;
9. run the lightweight validator;
10. inspect the readiness report;
11. open a focused PR.

This exercise teaches the repository’s source-of-truth, validation, and generated-output model without requiring image generation.