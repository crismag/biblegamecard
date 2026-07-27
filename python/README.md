# BibleGameCard Python platform

This directory contains the initial, read-only Python application foundation. It requires
Python 3.12 or later and intentionally has no runtime dependencies. The authoritative Ruby
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
```

All repository commands are read-only. `doctor` only checks repository discovery and whether the
Ruby executable is present; it does not invoke Ruby tools.

## Quality checks

```bash
cd python
python -m pytest
ruff check .
ruff format --check .
mypy
```

## Deliberately deferred

Ruby subprocess orchestration, compilation, registry mutation, providers, image generation,
review and release operations, MCP, REST, dashboards, exports, and application frameworks belong
to later workstreams. This milestone neither generates files nor changes canonical knowledge,
compiled prompts, artwork, or lifecycle state.
