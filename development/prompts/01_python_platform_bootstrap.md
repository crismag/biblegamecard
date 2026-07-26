# Prompt 01 — Python Platform Bootstrap

## Objective

Add the first Python application layer without changing existing Ruby behaviour or image-generation state.

## Read first

- `development/00_MASTER_CONTEXT.md`
- `development/01_ARCHITECTURE_AND_LANGUAGE_STRATEGY.md`
- `development/03_AI_AGENT_EXECUTION_RULES.md`
- `development/04_TESTING_AND_QUALITY_STRATEGY.md`

## Required work

1. Audit the current repository and confirm Python does not already have an application package.
2. Add `python/pyproject.toml` and a `src/biblegamecard` package.
3. Add a console command named `biblegamecard`.
4. Implement only foundational commands such as `version`, `doctor`, and `paths`.
5. Add repository-root discovery that works from a checkout and installed editable package.
6. Add typed configuration, base exceptions, logging setup, and result-envelope primitives.
7. Configure pytest, Ruff, and a type checker.
8. Add unit tests and installation/CLI smoke tests.
9. Document local setup and commands in `python/README.md`.

## Constraints

- Do not wrap Ruby tools yet beyond a harmless executable-presence check.
- Do not add FastAPI, MCP, image libraries, or database dependencies.
- Do not modify generated artifacts, lifecycle states, canonical data, or prompt compiler outputs.
- Keep the core dependency set minimal.

## Acceptance criteria

- `pip install -e ./python` succeeds in the supported environment.
- `biblegamecard --help`, `biblegamecard version`, and `biblegamecard doctor` work.
- Tests, lint, format check, and type check pass.
- Repository-root discovery and invalid-root behaviour are tested.
- The PR clearly documents supported Python version and dependency-locking choice.

## Deliverable

Open a focused PR titled similarly to `Bootstrap Python production platform` using the repository PR template guidance.
