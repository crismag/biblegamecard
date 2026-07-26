# Prompt 02 — Unified CLI and Service Layer

## Objective

Create one Python command surface that orchestrates the existing deterministic Ruby tools without reimplementing them.

## Prerequisite

Prompt 01 must be merged. Re-audit the installed package and current Ruby command interfaces.

## Required work

1. Add typed subprocess adapters for canonical validation, canonical assembly drift checking, prompt-development validation, readiness reporting, and prompt compilation.
2. Add application services independent of Typer or other interface code.
3. Implement commands:
   - `biblegamecard status`
   - `biblegamecard validate [--all|--collector-id]`
   - `biblegamecard readiness`
   - `biblegamecard compile <collector-id> [--adapter ... --model ... --seed ... --resolution ... --check]`
4. Resolve collector IDs through repository registries rather than hard-coded paths.
5. Return consistent exit codes and structured JSON output through `--json`.
6. Preserve Ruby stdout/stderr in diagnostics.
7. Add unit, integration, missing-runtime, invalid-ID, non-zero-exit, and timeout tests.
8. Document commands and examples.

## Constraints

- Never use `shell=True`.
- Do not parse human output when a stable generated JSON/YAML result already exists.
- Do not rewrite Ruby logic.
- Do not generate images or update image lifecycle state.

## Acceptance criteria

- Existing Ruby commands still run directly and through Python.
- CLI commands produce stable human and JSON output.
- Errors distinguish validation failure, drift, invalid input, and dependency failure.
- Tests prove exact argument construction and repository working directory.
- Existing Ruby tests remain green.
