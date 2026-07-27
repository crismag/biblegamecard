# Asset Coverage Report

Audit date: **2026-07-27**

## Executive summary

| Area | Observed coverage | Production interpretation |
|---|---:|---|
| Enumerated target cards | 34 | Provisional Core Legendary catalogue; human scope confirmation required. |
| Canonical character packages | 1 | Joshua only, and still draft/pre-generation review. |
| Legendary prompt-development profiles | 18 | Draft profiles; only nine IDs/names align directly with the 34-card catalogue. |
| Target names with a prompt profile | 16/34 | Aaron and Saul profiles are not in the current catalogue. |
| Compiled-prompt subjects | 1 | Two Joshua output layouts/versions are present. |
| Card-package directories | 1 | Joshua contains source and review records, not a complete asset package. |
| Image/PDF/layered artwork files | 0 | No generation, candidate, approved, composed, print, or digital asset is evidenced. |
| Artwork registry entries | 0 | The lifecycle registry contains no assets. |
| Official approved cards | 0/34 | No approval may be inferred from reported prototypes. |

## Sources audited

- `registry/legendary_cards.json` enumerates 34 Core Legendary cards and reports 31 historical prototypes, but explicitly says those reports require an image-file audit.
- `knowledge/characters/legendary/L010_joshua/` is the only canonical knowledge package.
- `knowledge/prompt_development/legendary/` contains 18 YAML profiles (Noah through David in a different collector sequence).
- `generated/prompts/` contains two Joshua compiled-output trees: `L010/v0.1.0/openai/` and `L010-JOSHUA-ART-01/1.0.0/`.
- `cards/L010_joshua/` contains the sole card working package.
- `registry/asset_registry.yaml` defines artwork lifecycle states but has an empty `assets` list.
- Repository-wide extension inspection found no PNG, JPEG, WebP, SVG, PDF, or PSD files outside Git metadata.

## Critical mismatch: collector numbering

Prompt profiles use an 18-card sequence that diverges from the authoritative
34-card registry at `L009`. The profile sequence has Aaron (`L009`), then Joshua,
Caleb, Samson, Gideon, Deborah, Ruth, Samuel, Saul, and David. The catalogue has
Caleb (`L009`), Joshua (`L010`), Deborah (`L011`), and a different subsequent
order. Sixteen target names have profiles, but most post-Joshua files carry a
conflicting ID. Aaron and Saul have profiles but no current target card.

Do not compile or rename these profiles in bulk. A human must decide whether the
profiles are historical inputs to migrate, whether the registry is authoritative
for every name, and how provenance should record any mapping.

## Existing visual foundations

The files under `knowledge/art/` already address visual language, character
style, composition, environments, lighting/colour, symbolism, negative prompts,
and references. `docs/ARTWORK_REVIEW_STANDARD.md` and related production guides
also contain reusable constraints. Phase 2 should consolidate and resolve these
sources rather than inventing a parallel style system.

## Gaps and risks

1. The full product scope is unknown beyond the 34-card Legendary set.
2. Thirty-three target cards lack canonical packages.
3. Eighteen target names lack even a prompt-development profile; existing
   mismatched profiles require deliberate reconciliation.
4. Joshua has compiled prompts but unresolved review and generation settings.
5. No actual candidate or approved artwork is versioned in the repository.
6. No card-front/back template or print/digital export is evidenced.
7. Reported prototype history cannot advance any evidence-backed lifecycle state.
8. Existing status vocabularies differ; the roadmap model must remain distinct
   from the artwork registry lifecycle until production proves a migration need.

## First production wave

Only Joshua is selected now. A pilot wave must not be locked until Joshua proves
the lifecycle. After that retrospective, a human may approve a diverse set such
as Moses, David, Esther, Ruth, Samson, Deborah, and Gideon.

## Audit method

The audit enumerated repository paths and machine-readable registries; it did not
assume that a directory count equals approved scope. It classified generated
text separately from generated imagery and treated claims without files as
unverified history.
