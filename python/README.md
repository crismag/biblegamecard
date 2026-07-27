# BibleGameCard Python platform

This directory contains the unified Python application entry point. It requires Python 3.12 or
later and intentionally has no runtime dependencies. The authoritative Ruby
validators, assemblers, readiness reporter, and prompt compiler remain unchanged; Python does
not reinterpret or replace them.

## Set up and install

Create an isolated environment and install the package with the development tools:

```bash
python3.12 -m venv .venv
source .venv/bin/activate
python -m pip install -e './python[dev]'
```

The project declares bounded development dependencies in `pyproject.toml`. It does not commit a
lock file in this bootstrap because the package has no runtime dependencies; environment locking
for the wider Python platform is deferred until a repository-wide tool is selected.

## Commands

From anywhere inside the checkout, or with `--repository /path/to/biblegamecard`:

```bash
biblegamecard --help
biblegamecard version
biblegamecard doctor
biblegamecard repository root
biblegamecard repository inspect
biblegamecard status
biblegamecard validate --all
biblegamecard validate --collector-id L010
biblegamecard readiness
biblegamecard compile L010 --adapter openai --seed 0 --resolution 1024x1536
biblegamecard compile L010 --check
```

Add global `--json` before the command for a stable result envelope, for example
`biblegamecard --json readiness`. `status` reads the registries and checks the Ruby runtime.
`validate` invokes the existing canonical validator, assembly drift checker, and prompt-development
validator as applicable. `readiness` returns the JSON emitted by the existing reporter. `compile`
resolves the collector's profile through the prompt-development registry and delegates compilation
to Ruby; it writes deterministic prompt artifacts unless `--check` is supplied.

Exit codes are `0` for success, `1` for validation failure, `2` for invalid or unknown input, `3`
for drift, `4` for dependency failures, and `5` for unexpected tool output. Tool stdout and stderr
are retained as structured diagnostics. The subprocess adapter never invokes a shell and runs every
tool from the validated repository root with a bounded timeout.

## Quality checks

```bash
cd python
python -m pytest
ruff check .
ruff format --check .
mypy
```

## Deliberately deferred

Registry mutation, providers, image generation, review and release operations, MCP, REST,
dashboards, exports, and application frameworks belong to later workstreams. This milestone does
not change canonical knowledge, artwork, or lifecycle state.
