# Prompt 07 — Production Dashboard and Documentation Site

## Objective

Generate a static, read-only view of repository health, coverage, readiness, and documentation without creating a second source of truth.

## Required work

1. Audit existing reports, registries, trackers, and Markdown documentation.
2. Build a static dashboard generator using application services and generated reports.
3. Include views for:
   - collection and prompt-profile coverage;
   - canonical package coverage;
   - validation and drift status;
   - asset lifecycle counts;
   - blocked items and missing evidence;
   - dependency impact summaries;
   - card-data coverage;
   - release readiness when available.
4. Link every displayed status to its source path or generated report.
5. Add `biblegamecard dashboard build --output ... --check`.
6. Add deterministic JSON data backing the HTML where useful.
7. Add a documentation-site configuration that publishes repository Markdown as the source and links schemas, ADRs, development prompts, and operational guides.
8. Add broken-link checks and deterministic snapshot tests.
9. Prepare optional GitHub Pages deployment, but do not enable public deployment unless repository policy permits it.

## Constraints

- Trackers and dashboards do not override canonical status.
- Do not edit source records through the dashboard.
- Do not embed large generated artwork or model files.
- Keep the first implementation static; do not add a database or web server without need.

## Acceptance criteria

- Dashboard output is reproducible and can be deleted/rebuilt.
- Counts and statuses trace to source data.
- Empty and blocked states render correctly.
- Documentation navigation includes the new `development/` package.
- Existing repository tests remain green.
