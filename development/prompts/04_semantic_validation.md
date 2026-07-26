# Prompt 04 — Semantic Validation

## Objective

Add cross-record validation rules that schemas cannot express, while avoiding automated theological approval or speculative facts.

## Required work

1. Audit existing validators and list gaps that are genuinely cross-record or semantic.
2. Create a Python semantic-validation framework with stable rule IDs, severity, affected IDs/paths, and remediation messages.
3. Implement an initial conservative rule set covering:
   - collector ID, canonical name, and registry consistency;
   - profile/package path and identity agreement;
   - generated artifacts with missing or stale source references;
   - missing traceability or unresolvable declared sources;
   - lifecycle claims unsupported by evidence;
   - model/provider details leaking into canonical facts;
   - orphan assets and duplicate permanent IDs;
   - invalid card-to-character or ability references;
   - prohibited project combinations only when already encoded in repository policy.
4. Add `biblegamecard semantic-check` with human and JSON output, filtering by rule/severity/collector ID, and a non-zero exit policy.
5. Add rule documentation, fixtures, and positive/negative tests.

## Constraints

- Do not assert that a theological interpretation is correct merely from code.
- Do not invent historical restrictions not present in project standards.
- Rules must cite the repository contract or policy they enforce.
- Do not weaken existing Ruby validation.

## Acceptance criteria

- Every diagnostic has a stable rule ID and evidence path.
- Rules are independently testable and can be enabled or disabled by documented policy.
- The command is deterministic.
- False-positive risk and non-goals are documented.
