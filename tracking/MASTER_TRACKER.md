# Bible Game Card — Master Production Tracker

This file is the operational source of truth for what is planned, completed, next, blocked, or awaiting review.

## Status vocabulary

| Status | Meaning |
|---|---|
| `PLANNED` | Accepted into the set; specification not complete. |
| `SPEC_DRAFT` | Character identity, title, traits, and ability are being drafted. |
| `SPEC_READY` | Specification is complete enough for prompt authoring. |
| `PROMPT_READY` | Reusable image-generation prompt package is complete. |
| `PROTOTYPE_GENERATED` | Earlier exploratory artwork exists; not an official release asset. |
| `V2_PENDING` | Official standardized artwork must still be generated. |
| `V2_GENERATED` | Official artwork exists but has not passed review. |
| `REVIEW` | Theology, gameplay, artwork, typography, and print checks are underway. |
| `APPROVED` | Approved as the official printable card. |
| `BLOCKED` | Cannot proceed until a documented issue is resolved. |

## Current objective

1. Complete the missing Legendary prototype cards.
2. Lock the 34-card Legendary registry.
3. Finish structured character specifications and image prompts.
4. Regenerate all Legendary cards as a consistent Official V2 set.
5. Review, approve, and export printable assets.

## Current production queue

| Queue | Collector ID | Character | Working title | Current status | Next action |
|---:|---|---|---|---|---|
| 1 | L009 | Caleb | The Mountain Claimer | `SPEC_DRAFT` | Finalize characteristics and prompt package. |
| 2 | L014 | Samuel | The Kingmaker | `SPEC_DRAFT` | Finalize characteristics and prompt package. |
| 3 | L030 | James | Son of Thunder | `SPEC_DRAFT` | Finalize characteristics and prompt package. |
| 4 | L001–L034 | Entire Legendary Set | Official V2 Collection | `V2_PENDING` | Regenerate in collector-number order after all prompts are locked. |

## Pipeline checklist

### A. Foundation

- [x] Create a protected working branch.
- [x] Establish a permanent collector-number plan.
- [x] Establish production status vocabulary.
- [x] Create the master Legendary character plan.
- [x] Create a machine-readable Legendary registry.
- [ ] Create the master card data schema.
- [ ] Create the master image-prompt template.
- [ ] Create the artwork style guide.
- [ ] Create the theological review guide.
- [ ] Create the gameplay balancing guide.
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
| Next character | Caleb — L009 |

> Note: Earlier prototype counts are based on the existing conversation history and must be audited when image files are imported into this repository. No earlier prototype should be treated as an approved final asset.

## Change log

| Date | Change |
|---|---|
| 2026-07-25 | Created initial tracker, pipeline, status model, and missing-card queue. |
