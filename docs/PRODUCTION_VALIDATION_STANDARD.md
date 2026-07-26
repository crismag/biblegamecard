# Production Validation Standard

Canonical YAML is the authority. Validation safely loads primitive YAML with aliases and Ruby object deserialization disabled, assembles every manifest-declared document, evaluates the declared master JSON Schema, and then evaluates graph, provenance, compatibility-pointer, review-evidence, and generation-readiness rules.

## Local commands

```bash
bundle install
bundle exec ruby -Itest test/validate_character_knowledge_test.rb
bundle exec ruby tools/validate_character_knowledge.rb --all
bundle exec ruby tools/assemble_character_knowledge.rb --check --all
```

Validate or print one package by supplying its `data` directory. Use `--write --all` to deterministically refresh committed `generated/knowledge/<package>/<version>/assembled.json` files. Check mode never writes. Exit codes are 0 for success, 1 for validation or drift, 2 for usage/configuration, and 3 is reserved for unexpected internal failures.

A blocked artwork message is expected while review evidence, adapter selection, or output settings are incomplete; blocking is not a canonical-validation failure. Human Markdown remains reviewed projection, while compatibility YAML is limited to pointers. See [ADR 0001](adr/0001-schema-validator.md) for the supported schema vocabulary.
