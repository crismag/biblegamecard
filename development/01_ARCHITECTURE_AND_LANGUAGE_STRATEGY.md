# Architecture and Language Strategy

## Decision

Use a hybrid architecture.

- Ruby remains the existing deterministic build core.
- Python becomes the new application and integration platform.
- Shared repository files remain the language-neutral contract.

## Why not rewrite Ruby now

The Ruby tools already provide tested behaviour for validation, assembly, reporting, and prompt compilation. An immediate rewrite would create parity risk, invalidate existing generated artifacts, consume effort unrelated to the image-generation feasibility test, and produce two implementations that may disagree.

A migration may be considered later only when a concrete operational need exists and parity tests can prove equivalent behaviour.

## Proposed Python layout

```text
python/
  pyproject.toml
  README.md
  src/
    biblegamecard/
      __init__.py
      cli/
      services/
      contracts/
      repositories/
      subprocesses/
      assets/
      dependency_graph/
      validation/
      cards/
      exports/
      mcp/
      dashboard/
      releases/
      providers/
  tests/
    unit/
    integration/
    contract/
```

Do not put Python package code directly in `tools/`. Existing `tools/` remains the home of the current Ruby executables.

## Layer responsibilities

### Contracts

Typed representations of existing JSON/YAML contracts. Prefer generated or schema-backed Pydantic models where practical. Controlled values must come from repository schemas or one shared Python enum whose values are tested against the schema.

### Repositories

Read-only and controlled-write access to repository paths. Repository classes must prevent path traversal, use UTF-8 explicitly, and avoid modifying generated files unless invoked by the owning service.

### Subprocess adapters

Strict wrappers around existing Ruby commands. Capture stdout, stderr, return code, duration, and invoked command. Return typed results. Do not use shell interpolation.

### Services

Application operations such as validate, compile, status, dependency impact, export, and release. Services contain orchestration and policy; CLI, MCP, and future REST adapters call services.

### Interfaces

- CLI is the first public interface.
- MCP is added after service boundaries stabilise.
- REST is optional and should not be introduced until a real consumer requires it.

## Dependency direction

```text
CLI / MCP / future API
        |
        v
Application services
        |
        +--> typed contracts
        +--> repository access
        +--> Ruby subprocess adapters
        +--> pure Python domain functions
```

Domain and service layers must not import CLI or MCP modules.

## Runtime policy

- Support a clearly documented Python version, initially Python 3.12 or later unless repository CI establishes another baseline.
- Use `pyproject.toml` as the package and tool configuration source.
- Lock dependencies with a chosen reproducible mechanism.
- Keep optional integrations in extras, for example `mcp`, `dashboard`, and `image`.
- Do not make heavyweight image or ML libraries core dependencies.

## Suggested libraries

Use only when justified:

- Typer for CLI;
- Pydantic for typed contracts;
- PyYAML or ruamel.yaml for controlled YAML handling;
- NetworkX only if dependency-graph needs exceed a simple internal graph model;
- Jinja2 for generated static pages and release notes;
- pytest for Python tests;
- mypy or pyright for static typing;
- Ruff for formatting and linting.

Avoid framework accumulation. The standard library is sufficient for subprocesses, hashing, JSON, pathlib, dataclasses, and basic graph traversal.

## Determinism policy

Python-generated artifacts must define:

- stable key ordering;
- newline policy;
- timestamp policy;
- source commit handling;
- content hashes;
- deterministic filenames;
- check mode that detects drift without writing.

Never use wall-clock timestamps in deterministic outputs unless the timestamp is explicitly operational rather than reproducible.

## Error model

Every public operation should distinguish:

- invalid user input;
- repository contract violation;
- subprocess failure;
- generated drift;
- blocked lifecycle gate;
- unsupported capability;
- internal error.

CLI exit codes and MCP error responses should be documented and tested.

## Security boundary

- Never execute commands from repository data.
- Never pass untrusted values through `shell=True`.
- Do not expose arbitrary filesystem paths through MCP.
- Keep credentials outside the repository.
- Treat YAML as untrusted input and use safe loading.
- Validate all generated output paths against the repository root.

## Migration rule

A Ruby capability may move to Python only through a dedicated migration proposal containing:

1. reason for migration;
2. behavioural contract;
3. fixture corpus;
4. parity tests;
5. deterministic output comparison;
6. deprecation path;
7. rollback plan.
