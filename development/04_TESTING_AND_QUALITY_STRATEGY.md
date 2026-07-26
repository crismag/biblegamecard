# Testing and Quality Strategy

## Quality goals

New development must preserve repository truth, deterministic outputs, clear lifecycle gates, and compatibility with existing Ruby tooling.

## Test pyramid

### Unit tests

Cover pure domain rules, typed models, lifecycle transitions, graph traversal, compiler projections, and error mapping.

### Contract tests

Verify Python models against repository JSON Schemas and controlled values. Test that Python does not accept states or fields rejected by the canonical schemas.

### Integration tests

Exercise temporary repositories, subprocess wrappers, YAML/JSON loading, generated output, and command-line behaviour. Use fixtures rather than modifying tracked production records.

### End-to-end smoke tests

Run the installed CLI against a clean checkout and execute safe read-only or deterministic commands. Image generation is excluded.

## Required checks

Recommended Python checks:

```bash
python -m pytest
ruff check python
ruff format --check python
mypy python/src
```

Existing Ruby checks remain required where relevant:

```bash
bundle exec ruby -Itest test/validate_character_knowledge_test.rb
bundle exec ruby -Itest test/legendary_prompt_development_tools_test.rb
bundle exec ruby -Itest test/prompt_compilation_test.rb
bundle exec ruby tools/validate_character_knowledge.rb --all
bundle exec ruby tools/assemble_character_knowledge.rb --check --all
bundle exec ruby tools/validate_legendary_prompt_development.rb --all
bundle exec ruby tools/report_legendary_generation_readiness.rb --check
```

Agents must verify exact supported commands in the current repository.

## Deterministic artifact tests

For each new generator:

1. run write mode in a temporary repository;
2. run check mode and expect success;
3. alter a generated file and expect drift detection;
4. regenerate and expect byte-stable output;
5. change one source field and verify only expected outputs change.

## Golden fixtures

Use small, explicit fixtures. Do not use all production data as the only test corpus. Include positive, malformed, missing-reference, invalid-state, cycle, and path-traversal cases.

## Compatibility tests

The unified Python CLI must verify that wrapped Ruby commands retain their behaviour. At minimum, test argument construction, successful output, non-zero validation results, missing Ruby executable, timeout, and malformed output.

## CI policy

CI should separate:

- existing Ruby deterministic-core checks;
- Python lint/type/unit checks;
- Python integration and contract checks;
- generated-drift checks;
- documentation link checks where practical.

A failure in one area must not be hidden by an aggregate command.

## Coverage policy

Do not optimise for a superficial percentage. Require direct tests for every lifecycle transition, public service operation, error category, and deterministic generator.

## Performance policy

Record baseline runtime for repository-wide commands. Avoid repeated full repository parsing within one invocation; services should share an immutable loaded snapshot where safe.

## Security tests

Include tests for unsafe YAML tags, path traversal, shell metacharacters, arbitrary command injection, unrestricted MCP paths, oversized or malformed input, and unsupported lifecycle transitions.
