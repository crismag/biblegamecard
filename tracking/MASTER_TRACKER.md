# Bible Game Card — Master Production Tracker

This file is an operational projection of canonical package manifests, review evidence, registry data, and release records. When this tracker conflicts with canonical data, the canonical source wins and this projection must be corrected.

## Status vocabulary

| Status | Meaning |
|---|---|
| `PLANNED` | Accepted into the set; specification not complete. |
| `SPEC_DRAFT` | Character identity, title, traits, and ability are being drafted. |
| `SPEC_READY` | Specification is complete enough for prompt authoring. |
| `PROMPT_READY` | Reusable image-generation prompt package is complete. |
| `PRE_GENERATION_REVIEW` | Canonical, theology, gameplay, art-direction, and compiled-prompt gates are under review before generation. |
| `PROTOTYPE_GENERATED` | Earlier exploratory artwork exists; not an official release asset. |
| `V2_PENDING` | Official standardized artwork must still be generated. |
| `V2_GENERATED` | Official artwork exists but has not passed review. |
| `REVIEW` | Artwork, layout, typography, accessibility, or print checks are underway. |
| `APPROVED` | Approved as the official printable card. |
| `BLOCKED` | Cannot proceed until a documented issue is resolved. |

## Current objective

1. Complete L010 Joshua pre-generation review and resolve its recorded blocking findings.
2. Select the model adapter and output settings, then generate and review Joshua artwork candidates.
3. Begin L026 Esther and L008 Moses as controlled architecture-validation packages without bypassing Joshua's production gates.
4. Complete the print-production specification before final Joshua card approval.
5. Use the proven structure and production workflow for the remaining Legendary packages.
6. Regenerate, approve, and export the consistent Official V2 set.

## Current production queue

| Queue | Track | Collector ID | Character | Working title | Current status | Next action |
|---:|---|---|---|---|---|---|
| 1 | Production reference | L010 | Joshua | The Conqueror | `PRE_GENERATION_REVIEW` | Resolve theology and art-direction findings; record required approvals; select adapter and output settings. |
| 2 | Architecture validation | L026 | Esther | Queen of Courage | `SPEC_DRAFT` | Execute `planning/L026_esther_reference_package_plan.md`; research references, chronology, identity, relationships, symbolism, gameplay constraints, and historical uncertainties before creating the atomic canonical package. |
| 3 | Architecture validation | L008 | Moses | The Deliverer | `PLANNED` | Create a canonical package that tests multiple life stages, large relationship graphs, sacred objects, miracles, and divine-agency guardrails. |
| 4 | Follow-on production | L009 | Caleb | The Mountain Claimer | `SPEC_DRAFT` | Apply the stabilized reference structure after Esther and Moses expose any reusable model changes. |
| 5 | Follow-on production | L014 | Samuel | The Kingmaker | `SPEC_DRAFT` | Finalize characteristics and prompt package after the architecture-validation cycle. |
| 6 | Follow-on production | L030 | James | Son of Thunder | `SPEC_DRAFT` | Finalize characteristics and prompt package after the architecture-validation cycle. |
| 7 | Collection rollout | L001–L034 | Entire Legendary Set | Official V2 Collection | `V2_PENDING` | Expand through the collection after production and package specifications stabilize. |

## Pipeline checklist

### A. Foundation

- [x] Create a protected working branch.
- [x] Establish a permanent collector-number plan.
- [x] Establish production status vocabulary.
- [x] Create the master Legendary character plan.
- [x] Create a machine-readable Legendary registry.
- [x] Create the master card data schema.
- [x] Create the master image-prompt template.
- [x] Create the artwork style guide.
- [x] Create the theological review guide.
- [x] Create the gameplay balancing guide.
- [ ] Create the print-production specification.

### B. Character specification

For every Legendary card:

- [ ] Confirm collector ID and canonical character name.
- [ ] Lock legendary title.
- [ ] Lock gameplay archetype.
- [ ] Lock primary and secondary traits.
- [ ] Define signature ability and gameplay advantage.
- [ ] Select defining biblical scene.
- [ ] Select symbols and visual motifs.
- [ ] Verify Scripture references and theological framing.
- [ ] Define pose, camera angle, expression, palette, and lighting.
- [ ] Write positive prompt and negative prompt.
- [ ] Record prototype references and lessons learned.

### C. Image production

- [ ] Generate official V2 artwork.
- [ ] Save raw generation.
- [ ] Record generation model, date, prompt version, and seed when available.
- [ ] Check character identity and biblical setting.
- [ ] Check duplicate poses and repeated compositions.
- [ ] Check readable typography separately from generated artwork.
- [ ] Produce clean artwork without baked-in unreliable text when necessary.
- [ ] Compose final card using the official layout template.

### D. Review and release

- [ ] Biblical/theological review.
- [ ] Gameplay identity review.
- [ ] Visual consistency review.
- [ ] Typography and accessibility review.
- [ ] Print bleed, safe-zone, and resolution review.
- [ ] Approve final card.
- [ ] Export print and digital variants.
- [ ] Update registry status to `APPROVED`.

## Legendary completion summary

| Measure | Count |
|---|---:|
| Planned Legendary cards | 34 |
| Earlier prototype artwork reported/generated | 31 |
| Missing prototype characters | 3 |
| Official V2 approved cards | 0 |
| Active production reference | Joshua — L010 |
| Next architecture package | Esther — L026 |
| Following architecture package | Moses — L008 |

> Note: Earlier prototype counts are based on the existing conversation history and must be audited when image files are imported into this repository. No earlier prototype should be treated as an approved final asset.

## Change log

| Date | Change |
|---|---|
| 2026-07-25 | Created initial tracker, pipeline, status model, and missing-card queue. |
| 2026-07-26 | Added L010 Joshua reference package and moved it to cross-discipline source/prompt review. |
| 2026-07-26 | Clarified tracker authority, separated Joshua production from architecture-validation work, and aligned the next packages to Esther and Moses. |
| 2026-07-26 | Began the Esther architecture-validation package with a research and atomic-delivery plan; moved L026 to `SPEC_DRAFT`. |
