# Shared Contracts

## Purpose

Prevent Ruby, Python, MCP, dashboards, and future provider integrations from creating competing interpretations of repository data.

## Contract sources

The primary contracts are:

- JSON Schemas under `schemas/`;
- machine-readable registries under `registry/`;
- canonical knowledge under `knowledge/characters/`;
- prompt-development records under `knowledge/prompt_development/`;
- generated manifests and traceability records;
- explicit review evidence.

Python models are projections of these contracts, not independent authorities.

## Required shared identifiers

Use stable identifiers for:

- collector ID;
- asset ID;
- prompt or compiler output ID;
- generation request and run ID;
- candidate ID;
- card ID;
- ability ID;
- review decision ID;
- release ID.

Do not derive permanent identity solely from display names or filesystem paths.

## Lifecycle rules

The current asset lifecycle is:

```text
NOT_GENERATED -> GENERATED -> UNDER_REVIEW -> APPROVED -> RELEASED
                       \-> REJECTED
```

Implement transitions through one policy service. Do not allow arbitrary assignment. Each transition should define required evidence and audit fields.

Until real image-generation evidence exists, supplementary development must preserve `NOT_GENERATED` for artwork assets.

## Result envelope

Public service operations should return a consistent typed result containing:

- operation name;
- success flag;
- status category;
- human summary;
- structured diagnostics;
- affected paths or IDs;
- invoked tool metadata where applicable;
- deterministic output paths where applicable.

## Status categories

Recommended application categories:

- `SUCCESS`;
- `VALIDATION_FAILED`;
- `DRIFT_DETECTED`;
- `BLOCKED`;
- `NOT_FOUND`;
- `INVALID_INPUT`;
- `UNSUPPORTED`;
- `DEPENDENCY_FAILURE`;
- `INTERNAL_ERROR`.

These application categories must not replace domain lifecycle states.

## Dependency record

A dependency edge should include:

- source node ID and type;
- target node ID and type;
- relationship kind;
- source path or declared evidence;
- whether the dependency requires rebuild, review, or both;
- optional version constraint.

## Asset registry policy

Asset records should preserve:

- stable identity;
- source collector/card relationship;
- current lifecycle state;
- versions and hashes;
- source commit;
- prompt/compiler provenance;
- generation provenance when it exists;
- review evidence;
- release references;
- deprecation or supersession links.

## Card and ability contracts

Card presentation data and executable mechanics should be separate but linked. A structured ability should model trigger, condition, target, effect, modifier, duration, limits, and display-text projection.

Artwork pointers must be optional until approved artwork exists. Card-data compilation must not require generated images.

## Compatibility/versioning

Every externally consumed JSON contract should carry a schema version. Breaking changes require migration notes and fixture updates. Additive fields should have defined defaults or optional semantics.

## Hashing and serialisation

Use SHA-256 unless an existing contract specifies otherwise. Define canonical serialisation before hashing structured data. Never hash a non-deterministically ordered mapping.
