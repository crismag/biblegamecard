# Model Guidelines

## Purpose
Defines how generation models may be adapted without changing approved biblical, visual, continuity, or production intent.

## Model-neutral source
Character packages, art specifications, style modules, and prompt grammar remain model-neutral. Provider-specific syntax belongs in an adapter layer.

## Adapter record
Each adapter should document:
- provider and model name;
- model/version date when known;
- supported inputs: text, image reference, mask, seed, aspect ratio;
- preferred prompt length and structure;
- negative-prompt support;
- reference-image behaviour;
- known anatomy, text, continuity, and crop issues;
- safety or content constraints;
- recommended QA checks;
- adapter version.

## General adaptation rules
- Preserve subject identity, narrative moment, theological boundaries, composition, and exclusions.
- Replace unsupported syntax with plain visible instructions.
- Do not use living-artist or protected-franchise names as style shortcuts.
- Do not assume a model obeys negative prompts consistently.
- Keep illustration and card layout separate unless intentionally generating a mock-up.
- Record every reference image consumed by the model.

## ChatGPT Image adapter guidance
Use natural-language scene direction with explicit visible details, composition, and exclusions. Clearly distinguish image editing from new generation. Provide one coherent scene rather than keyword fragments. Review generated text, hands, object grip, historical elements, and unintended style drift.

## Diffusion-style adapter guidance
Where supported, separate positive and negative prompts. Use weights sparingly and document them. Record sampler, steps, guidance, seed, checkpoint, VAE, control modules, LoRAs, and reference strength when applicable. Local model components require licence review before official use.

## Reference-image guidance
A reference image may guide:
- facial continuity;
- clothing language;
- composition;
- material finish;
- palette;
- environment.

The manifest must specify which qualities are intended. Do not ask a model to copy an entire unrelated image. Confirm rights and project ownership before repository use.

## Model evaluation set
Before adopting a model for production, test at least:
- one male and one female character portrait;
- one older character;
- one action scene;
- one group scene;
- one historical environment;
- one artifact with hands;
- one miracle scene with theological review;
- one card-safe vertical crop.

## Evaluation dimensions
Score or record:
- instruction following;
- character continuity;
- anatomy and hands;
- historical plausibility;
- emotional expression;
- material rendering;
- environment accuracy;
- symbolism control;
- text contamination;
- card-size readability;
- crop reliability;
- consistency across revisions;
- cost, speed, privacy, and licence suitability.

## Change policy
A new model should first produce experimental assets. Existing official artwork is not automatically regenerated. Production adoption requires documented comparison and approval.

## Provider metadata
Do not depend on provider URLs remaining permanent. Store stable job identifiers, prompt manifests, settings, and approved exported assets within repository policy and storage limits.
