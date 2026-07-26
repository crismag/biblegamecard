# BibleGameCard Development Work Package

This directory is the execution workspace for Codex, Claude, and human contributors implementing the next non-image-generation capabilities of BibleGameCard.

## Purpose

The package turns the repository roadmap into bounded, reviewable development work while protecting the pending local image-generation feasibility test.

The current Ruby tools remain the deterministic core for canonical validation, assembly, readiness reporting, and prompt compilation. New application-level capabilities should be implemented primarily in Python and should call the Ruby tools rather than duplicate their behaviour.

## Read order

1. `00_MASTER_CONTEXT.md`
2. `01_ARCHITECTURE_AND_LANGUAGE_STRATEGY.md`
3. `02_WORKSTREAM_ROADMAP.md`
4. `03_AI_AGENT_EXECUTION_RULES.md`
5. `04_TESTING_AND_QUALITY_STRATEGY.md`
6. `05_SHARED_CONTRACTS.md`
7. the selected task prompt under `prompts/`

## Prompt catalogue

| Prompt | Workstream | Image-test impact |
|---|---|---|
| `prompts/01_python_platform_bootstrap.md` | Python packaging and application shell | None |
| `prompts/02_unified_cli_and_service_layer.md` | Unified CLI and subprocess-backed services | None |
| `prompts/03_asset_registry_and_dependency_graph.md` | Asset registry services and dependency analysis | None |
| `prompts/04_semantic_validation.md` | Cross-record and domain validation | None |
| `prompts/05_card_data_compiler_and_rules_engine.md` | Structured cards, abilities, and exports | None |
| `prompts/06_mcp_server.md` | Repository tools for AI clients | None |
| `prompts/07_dashboard_and_docs_site.md` | Static production dashboard and documentation site | None |
| `prompts/08_release_localisation_story_exports.md` | Release builder, localisation, and story exports | None |
| `prompts/09_ci_and_quality_gates.md` | CI orchestration and repository health checks | None |
| `prompts/10_provider_plugin_contracts.md` | Provider interfaces without executing image generation | Low; contracts only |

## Recommended execution order

1. Python platform bootstrap.
2. Unified CLI and service layer.
3. CI and quality gates for the new Python layer.
4. Asset registry and dependency graph.
5. Semantic validation.
6. Card data compiler and rules engine.
7. MCP server.
8. Dashboard and documentation site.
9. Release, localisation, and story exports.
10. Provider plugin contracts.

Do not execute multiple prompts in one pull request unless the prompt explicitly permits it. Each agent should inspect the current repository and any merged predecessor work before editing.

## Protected boundaries

Until the image-generation feasibility test is complete, tasks in this package must not:

- install or vendor ComfyUI;
- download model weights;
- generate or approve artwork;
- modify existing compiled Joshua prompt artifacts merely to support a new application;
- change image lifecycle state from `NOT_GENERATED`;
- introduce untested provider-specific generation behaviour;
- rewrite the existing Ruby compiler or validators.

## Templates

Use `templates/TASK_HANDOFF_TEMPLATE.md` when transferring work between agents and `templates/PR_DESCRIPTION_TEMPLATE.md` when opening a pull request.
