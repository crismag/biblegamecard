# Production Status Model

These roadmap statuses describe end-to-end card-package progress. They do not
replace the uppercase artwork lifecycle in `registry/asset_registry.yaml`; an
artwork lifecycle transition still requires its own evidence.

| Status | Entry condition |
|---|---|
| `planned` | Target is accepted, but canonical work is incomplete. |
| `knowledge_ready` | Canonical package and references passed their review. |
| `card_defined` | Card identity and provisional card-facing content are approved. |
| `prompt_ready` | Visual profile and compiled prompt are complete and reviewed. |
| `generation_ready` | Provider, settings, manifest, output paths, and approvals to generate are recorded. |
| `candidates_generated` | Real candidate files and generation record exist. |
| `under_review` | Candidates are undergoing required human review. |
| `revision_required` | Review records a new prompt, generation, or edit requirement. |
| `artwork_approved` | A named primary artwork has human approval evidence. |
| `card_composed` | Approved artwork is placed in an approved card-front composition. |
| `export_ready` | Required print and digital exports exist and await final validation. |
| `complete` | All required assets, provenance, approvals, and validation are complete. |
| `blocked` | A documented dependency prevents progress. |

## Rules

- Store the current status explicitly; never infer approval from a file name.
- Advance only when the entry condition has evidence in the repository.
- Preserve the history of replacements and never silently overwrite approved art.
- Use `blocked` with a written blocker and owner/decision needed.
- Use the catalogue note field for uncertainty until a dedicated per-card record
  is justified by the production workflow.
