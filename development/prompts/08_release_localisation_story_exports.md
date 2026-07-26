# Prompt 08 — Release, Localisation, and Story Exports

## Objective

Add reproducible downstream exports that remain independent of image generation and preserve canonical/derived boundaries.

## Workstream A — Localisation

1. Define stable message IDs for card names, titles, traits, keywords, rules text, and interface strings.
2. Create versioned localisation schemas and English source bundles.
3. Add placeholder or test language bundles only where translation quality can be reviewed.
4. Validate missing, extra, and format-incompatible messages.
5. Do not include copyrighted Bible translation text without an approved licensing and translation policy.

## Workstream B — Story and campaign exports

1. Compile canonical timelines, people, relationships, events, and locations into a derived campaign-context format.
2. Label every field as canonical fact, historical context, project interpretation, or fictional connective material.
3. Add deterministic exports for chapters, map nodes, encounter context, unlock conditions, and Scripture discovery references.
4. Do not generate final dialogue or new canonical claims in this task.

## Workstream C — Release builder

1. Add release schemas and a builder that selects approved/versioned artifacts only.
2. Produce a release directory with manifest, source commit, checksums, licences/provenance references, release notes, game data, localisation, documentation, and available approved assets.
3. Add dry-run, validation, write, and `--check` modes.
4. Refuse missing, unapproved, stale, or checksum-mismatched inputs.
5. Add `biblegamecard release plan/build/check` commands.

## Delivery guidance

These workstreams may be split into separate PRs. Implement localisation contracts before story export localisation, and implement asset services before the release builder.

## Acceptance criteria

- Outputs are deterministic and traceable.
- Canonical and fictional content are unmistakably separated.
- Release construction fails closed on missing approval evidence.
- No image is generated, approved, or altered.
