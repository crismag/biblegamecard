# AI Agent Execution Rules

These rules apply when Codex, Claude, or another AI agent executes a prompt from this package.

## Mandatory first actions

1. Read the root `README.md` and relevant documents under `docs/`.
2. Read all files under `development/` named by the selected prompt.
3. Inspect the current branch and recent merged pull requests.
4. Identify authoritative source files, generated outputs, and review evidence.
5. Run or inspect the existing baseline tests before changing code.
6. State any material mismatch between the prompt and current repository before implementation.

Do not assume this package is newer than the code. The repository at execution time is authoritative.

## Scope discipline

- Implement only the selected workstream.
- Do not opportunistically rewrite existing Ruby tools.
- Do not add unrelated schemas or frameworks.
- Do not update lifecycle states without evidence.
- Do not generate images.
- Do not change canonical character decisions unless the task explicitly requires it.
- Do not edit generated files by hand.
- Do not silently weaken validation to make tests pass.

## Required engineering practices

- Use descriptive names; avoid single-letter variables except conventional local indices.
- Add type hints to Python public functions.
- Use docstrings for public modules, classes, and functions.
- Keep domain logic separate from CLI/MCP adapters.
- Use structured logging where operational context matters.
- Never use `shell=True` for repository commands.
- Validate repository-relative paths.
- Use safe YAML loading.
- Fail clearly and preserve stderr from wrapped commands.
- Make deterministic outputs byte-stable where required.

## Existing-tool boundary

Existing Ruby tools are invoked as external deterministic capabilities. A wrapper must:

- construct an argument list, not a shell string;
- set the working directory explicitly;
- capture stdout, stderr, return code, and duration;
- surface the exact invoked command in diagnostics without leaking secrets;
- distinguish validation failure from process-launch failure;
- be covered by fixture or integration tests.

## Testing requirements

Every implementation prompt must result in:

- unit tests for new domain behaviour;
- integration tests for filesystem or subprocess boundaries;
- negative tests for invalid input and blocked operations;
- deterministic-output or drift tests when files are generated;
- documentation showing how to run the new checks.

Do not claim a command passed unless it was actually run. If the environment prevents a test, record the exact limitation and ensure CI can run it.

## Pull-request requirements

The pull request must include:

- motivation;
- implemented scope;
- explicitly excluded scope;
- architecture decisions;
- authoritative files changed;
- generated files changed;
- commands run and results;
- remaining risks;
- follow-up work;
- confirmation that image lifecycle and generation outputs were not changed.

## Completion rule

A task is complete only when code, tests, documentation, and deterministic/generated artifacts required by the task agree. A large partial implementation should remain a draft PR or be split into a smaller complete change.

## Stop conditions

Stop and report rather than guessing when:

- a required schema or lifecycle value is contradictory;
- the task would require changing canonical facts;
- a requested operation would approve or release an asset without evidence;
- deterministic parity cannot be maintained;
- current repository changes make the planned architecture invalid;
- credentials or model downloads would be required.
