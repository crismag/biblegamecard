# Prompt 03 — Asset Registry and Dependency Graph

## Objective

Build Python services for querying assets, validating lifecycle transitions, and calculating source-to-output impact without generating images.

## Prerequisites

Prompts 01 and 02 should be merged. Read `registry/asset_registry.yaml`, generation-manifest schemas, current lifecycle documentation, and generated traceability records.

## Required work

1. Create schema-backed Python models for asset registry entries and dependency edges.
2. Implement read/query operations by asset ID, collector ID, state, type, and source path.
3. Implement a lifecycle policy service with explicit evidence requirements.
4. Add dependency graph construction from registries, manifests, traceability, card references, generated outputs, and releases that currently exist.
5. Add commands:
   - `biblegamecard assets list/show/validate`
   - `biblegamecard impact <path-or-id>`
   - `biblegamecard graph check/export`
6. Produce deterministic JSON graph exports and readable impact reports.
7. Detect missing nodes, dangling references, duplicate IDs, illegal transitions, and prohibited cycles.
8. Add fixtures and comprehensive negative tests.

## Protected constraint

No operation may transition artwork from `NOT_GENERATED` without a real generation record satisfying the canonical schema. For this task, implement transition validation but do not perform artwork lifecycle changes.

## Acceptance criteria

- Registry queries are deterministic and typed.
- Impact analysis distinguishes rebuild from human-review impact.
- Graph output is stable across repeated runs.
- Invalid transitions fail closed.
- Existing production files are not rewritten merely by querying them.
