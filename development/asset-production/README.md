# Asset Production Roadmap

This directory is the authoritative development entry point for the current
BibleGameCard phase. The product is a complete, consistent, traceable, and
reusable biblical card-asset library—not a game platform.

## Read order

1. [Realignment context](ASSET_PRODUCTION_REALIGNMENT_CONTEXT.md)
2. [Target card catalogue](TARGET_CARD_CATALOGUE.md)
3. [Coverage report](ASSET_COVERAGE_REPORT.md)
4. [Production status model](PRODUCTION_STATUS_MODEL.md)
5. [Next steps](NEXT_STEPS.md)

## Current milestone

The 34-card Core Legendary Collection is the only currently enumerated target
set. Joshua (`L010`) is the first vertical slice. The inventory is provisional
until a human confirms whether other character and supplementary-card families
belong in the target catalogue.

No repository image files currently prove generation or approval. Reported
prototype history is not asset evidence. Large-scale generation must wait until
the catalogue and visual system are approved.

## Infrastructure freeze

Existing Ruby, Python, CLI, service, and CI foundations remain supported but
stable. Modify infrastructure only when it removes a demonstrated card-
production blocker, prevents an active production error, validates or packages
assets, materially reduces repeated production work, or preserves consistency
and traceability.

Do not automatically implement old prompts for registries, dependency graphs,
rules engines, MCP, REST, dashboards, plugins, or distributed workers.
