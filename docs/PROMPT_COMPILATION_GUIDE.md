# Prompt Compilation Guide

## Principle
Prompts are compiled artifacts. Character facts, theology, gameplay identity, canonical appearance, and art decisions belong in reviewed source files.

## Inputs
A compiled image prompt should combine:
1. shared legendary style
2. shared card-layout constraints
3. rendering-quality guidance
4. approved character specification
5. approved artwork specification
6. model-specific adapter
7. negative-prompt module

## Output requirements
Each compiled prompt should record collector ID, source versions, compiler version, target model, dimensions or aspect ratio, generation settings when available, and compilation timestamp.

## Precedence
Character-specific approved constraints override generic style guidance. The Project Bible and theology policy override all prompt modules.

## Prohibitions
- Do not introduce unsupported facts during compilation.
- Do not place final typography into generated art unless specifically approved.
- Do not silently modify canonical appearance.
- Do not treat a model's previous output as authoritative source material.

## Model adapters
Adapters may translate the same source context into model-appropriate wording, but may not alter the underlying meaning. Model-specific limitations should be documented.

## Reproducibility
Exact pixel recreation is not guaranteed. Reproducibility means preserving source context, prompt text, model and version, settings, reference assets, and review notes well enough to regenerate a consistent result.
