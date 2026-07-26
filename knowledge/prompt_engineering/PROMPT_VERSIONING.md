# Prompt Versioning

## Purpose
Tracks prompt evolution independently from character knowledge, artwork, layout, and release versions.

## Semantic versioning
Use `MAJOR.MINOR.PATCH`.

- **MAJOR**: changes approved visual intent, narrative moment, composition family, character continuity, or theological interpretation.
- **MINOR**: adds or materially revises modules, environment detail, lighting, camera, or model adaptation while preserving the same approved concept.
- **PATCH**: wording cleanup, duplication removal, typo correction, or model syntax adjustment that does not change intent.

## Independent versions
Track separately:
- canonical character content version;
- artwork specification version;
- prompt source version;
- compiler version;
- model-adapter version;
- compiled prompt version;
- generated image version;
- card-layout version.

## Prompt identifier
Recommended pattern:

```text
<asset-id>-P<major>.<minor>.<patch>
```

Example:

```text
L010-JOSHUA-ART-01-P1.2.0
```

## Change record
Each revision must record:
- version;
- date;
- author or agent;
- reason;
- changed source fields or modules;
- expected visual effect;
- prior generated assets affected;
- review status.

## Regeneration policy
A prompt change does not automatically invalidate an approved image. Mark regeneration as:
- `required` when the old image contradicts corrected theology, continuity, identity, rights, or production requirements;
- `recommended` when the new prompt materially improves the intended concept;
- `optional` for minor wording or adapter changes.

## Model changes
Changing the generation model or major model version requires a new adapter record and normally a prompt minor version, even when the visual intent is unchanged. Record the model explicitly in the manifest.

## Reproducibility
Store provider seed, job ID, image-reference IDs, aspect ratio, resolution, and generation settings when available. Some providers are nondeterministic; reproducibility then means traceable inputs rather than pixel-identical output.

## Manual edits
A manually edited compiled prompt must either:
1. update the structured source and recompile; or
2. record a temporary override with reason and approver.

Untracked manual prompt edits are prohibited for official assets.

## Approval states
`draft -> in_review -> approved -> generated -> superseded`

Compiled prompts are generated artifacts but still require review before official production use.
