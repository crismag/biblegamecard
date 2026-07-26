# ADR 0001: Supported schema-validation wrapper

**Status:** Accepted — 2026-07-26

## Decision

Canonical packages declare JSON Schema Draft 2020-12 schemas. The validator evaluates the actual assembled package with the repository-owned Ruby wrapper in `tools/lib/canonical_support.rb`. It supports the vocabulary currently used by the canonical schema: local `$ref`/`$defs`, types, object and array constraints, enums/constants, string and numeric constraints, and the `allOf`, `anyOf`, and `oneOf` applicators. It collects violations rather than stopping at the first.

This is intentionally **not** presented as a complete Draft 2020-12 implementation. Unknown `$` keywords cause configuration failure instead of being silently ignored. This avoids an external runtime validator while retaining an explicit upgrade path to a maintained full validator when dependency availability and vocabulary needs justify it. Psych safe loading permits only primitive YAML values and disables aliases.

## Consequences

Schema failures report an assembled document path, rule, safe truncated value, and expected constraint. Cross-document graph, provenance, review, and repository-layout rules remain separate because JSON Schema cannot resolve repository registries or files.
