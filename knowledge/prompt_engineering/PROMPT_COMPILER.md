# Prompt Compiler

## Purpose
Defines how reviewed repository knowledge becomes a reproducible image-generation prompt. The compiler may initially be manual or script-assisted; the contract remains the same.

## Principle
Canonical knowledge and approved art specifications are source material. The compiled prompt is a generated artifact and must not become the only place where a decision is stored.

## Inputs
Required inputs vary by asset type but normally include:
- asset identity and version;
- subject or event specification;
- scriptural basis and theological guardrails;
- character continuity fields;
- environment specification;
- pose, expression, and narrative beat;
- composition module;
- lighting module;
- visual style modules;
- quality modules;
- negative-prompt modules;
- model adapter and output requirements.

## Output package
A compiler run should produce:
- compiled positive prompt;
- compiled exclusions or negative prompt;
- source input hashes or versions;
- compiler version;
- model adapter and model name;
- requested aspect ratio and resolution;
- generation seed or provider job ID when available;
- generation timestamp;
- warnings and unresolved fields.

## Compilation stages
1. Validate required source fields.
2. Resolve asset template.
3. Load approved character and environment context.
4. Resolve style, composition, lighting, quality, and exclusion modules.
5. Remove duplication and contradictions.
6. Order clauses according to `PROMPT_GRAMMAR.md`.
7. Apply model-specific adaptation.
8. Run theological, historical, continuity, and production checks.
9. Emit prompt artifact and provenance record.

## Failure conditions
Compilation must fail or emit a blocking warning when:
- the subject or narrative beat is undefined;
- required scriptural support is missing;
- two modules conflict;
- character continuity fields contradict one another;
- sacred objects or disputed symbols lack review;
- the prompt asks a character to control divine power;
- an output dimension or asset template is missing;
- unresolved placeholders remain.

## Generated artifact path
Recommended pattern:

```text
generated/prompts/<asset-id>/<prompt-version>/
  prompt.txt
  negative_prompt.txt
  manifest.yaml
```

## Manifest example

```yaml
asset_id: L010-JOSHUA-ART-01
prompt_version: 1.0.0
compiler_version: 1.0.0
model_adapter: chatgpt-image
source_versions:
  character: 1.0.0
  artwork: 1.0.0
  visual_language: 1.0.0
modules:
  - STYLE_BIBLICAL_REALISM
  - STYLE_PAINTERLY_PREMIUM
  - COMP_HERO_THREE_QUARTER
  - LIGHT_VICTORY
warnings: []
```

## Manual compilation rule
Until automated tooling exists, a human may compile prompts using the same ordered stages. The manifest must still be created, and manual edits must be reflected in source specifications or recorded as an explicit temporary override.

## Override policy
Overrides require:
- reason;
- approver;
- affected clauses;
- expiration or follow-up action.

Overrides must not bypass theological or rights-related restrictions.

## Review gates
A prompt may be generated only after source review. An image may become official only after separate output review. A well-formed prompt does not guarantee a valid image.
