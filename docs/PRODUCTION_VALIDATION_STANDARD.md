# Production Validation Standard

## Purpose
This standard turns an approved character specification into reviewable production artifacts without collapsing knowledge, generation, approval, and release into one status. The filled implementation is [L010 Joshua](../cards/L010_joshua/production_pipeline.md).

## Artifact boundaries

| Layer | Authority | Examples | Rule |
|---|---|---|---|
| Knowledge | Authored, cited, reviewed claims | identity, biblical basis, timeline | Generated output never modifies it implicitly. |
| Production source | Approved creative and technical intent | gameplay, art direction, continuity, prompt source | Every choice points to knowledge or is labeled project interpretation. |
| Generation | Regenerable compiler/provider output | compiled prompt, candidates, generation manifest | Existence is not approval. |
| Review | Findings, scores, defects, decisions | evaluation record, reviewer sign-offs | Review records are immutable; corrections create a new record. |
| Approval | Named gate decisions | prompt approval, artwork approval | Approval applies to exact versions/hashes only. |
| Release | Layout and distribution artifacts | card render, print PDF, metadata bundle | Release cannot promote an unapproved upstream version. |

## End-to-end stages
Every package instantiates this table in `production_pipeline.md`. “Owner” may be a qualified person or assigned agent, but approval requires the project’s designated reviewer.

| Stage | Purpose | Required inputs/dependencies | Outputs and artifacts | Review/exit requirement | Blocking failure conditions |
|---:|---|---|---|---|---|
| 1. Canonical knowledge | Establish traceable identity and narrative facts. | Scripture; theology guide; registry ID. | Identity, biblical basis, timeline, relationships, legacy. | Claims classified; passages checked; disputed points recorded. | Invented claim, missing primary basis, unresolved theological contradiction. |
| 2. Gameplay identity | Translate identity into strategic philosophy. | Approved knowledge; gameplay guide. | Gameplay source and rationale. | Distinct role, divine-agency guardrails, counterplay accepted. | Generic identity, personal magic, unsupported or harmful mechanic. |
| 3. Art direction | Define visible interpretation and continuity. | Knowledge, symbolism, gameplay emphasis, art standards. | Artwork source, continuity sheet, scene decision. | Historical, biblical, visual, and dignity review. | Multiple narrative moments, anachronism, unsupported sacred symbol, undefined continuity. |
| 4. Prompt source | Express model-neutral semantic intent. | Approved art direction and continuity; prompt template. | Versioned prompt source. | No unexplained creative choice or unresolved placeholder. | Source conflict, missing guardrail, model trick in semantic source. |
| 5. Prompt compilation | Assemble deterministic clause order and exclusions. | Prompt source; grammar; standards modules; adapter. | Positive/negative prompt, trace map, compilation manifest. | Every clause traced; lint clean; model settings declared; prompt approved. | Untraced clause, contradictory modules, missing dimensions/adapter, theological breach. |
| 6. Image generation | Produce candidates without changing source intent. | Exact approved prompt hash; adapter/model; dimensions; generation settings. | Immutable raw candidates and generation records. | IDs, hashes, model, time, seed/job ID, settings recorded. | Unapproved prompt, missing provenance, silent manual prompt edit. |
| 7. Image review | Evaluate candidates against source and technical criteria. | Raw candidates; art direction; continuity; evaluation template. | Per-candidate scorecard, defects, disposition. | All critical checks pass and selected candidate identified. | Identity/theology defect, anatomical defect, below-threshold score, unknown provenance. |
| 8. Artwork approval | Freeze an accepted artwork master. | Selected candidate; review record; permitted corrections. | Approved artwork master, hash, approval record. | Theology and art approvers sign exact version/hash. | Untracked edit, unresolved critical defect, approval/version mismatch. |
| 9. Card layout | Combine approved art with governed card data. | Approved art; frame; typography; rules copy; collector metadata. | Editable layout, digital proof, layout manifest. | Content, hierarchy, accessibility, safe-zone review. | Wrong art/hash, overflow, unreadable type, incorrect collector data. |
| 10. Print QA | Validate manufacturing output. | Approved layout; print specification; printer profile. | Bleed export, proof, preflight report, print manifest. | Dimensions, bleed, crop, colour, resolution, fonts, proof accepted. | Missing bleed, low effective DPI, wrong colour/export profile, clipped content. |
| 11. Official release | Publish a reproducible approved bundle. | Passed gates 1–10; release notes; registry. | Versioned release bundle, checksums, registry/tracker update. | Production approver confirms dependency lock and archive. | Any open critical issue, missing checksum/license/provenance, stale dependency. |

## Approval states
States describe artifacts, not vague package progress. Record reviewer, timestamp, version, hash, and decision note for every approval transition.

| State | Meaning | Permitted transition |
|---|---|---|
| `draft` | Authored but incomplete. | `review_requested`, `deprecated` |
| `prototype` | Exploratory and never official. | `draft`, `deprecated` |
| `review_requested` | Frozen version submitted for a named review. | discipline approval, `changes_requested` |
| `changes_requested` | Review found required corrections. | new `draft` version |
| `theology_approved` | Biblical/theological review passed exact version. | further discipline approval; invalidated by relevant change |
| `gameplay_approved` | Gameplay philosophy passed exact version. | art/prompt gates |
| `art_direction_approved` | Visual source and continuity passed. | prompt compilation |
| `prompt_approved` | Compiled prompt, trace map, and settings passed. | generation |
| `art_approved` | Selected artwork master passed all image reviews. | card layout |
| `card_approved` | Layout/content/accessibility passed. | print QA |
| `production_approved` | Print and release bundle passed. | `released` |
| `released` | Official immutable release is published. | new version or `deprecated` |
| `deprecated` | Retained for history; prohibited for new production. | none; replace with new version |

A package can aggregate states, but must never imply all contained artifacts share one approval. “Review” without discipline and artifact is insufficient in new records.

## Independent asset versioning

| Artifact | Identifier/version | Increment rule |
|---|---|---|
| Canonical package/content | semantic `MAJOR.MINOR.PATCH` | Major for changed identity/theological interpretation; minor for substantive knowledge; patch for non-semantic correction. |
| Prompt source/compiled prompt | semantic `MAJOR.MINOR.PATCH` | Follow [Prompt Versioning](../knowledge/prompt_engineering/PROMPT_VERSIONING.md). |
| Artwork specification | semantic `MAJOR.MINOR.PATCH` | Major for scene/continuity; minor for visible direction; patch for clarification. |
| Generated artwork | immutable integer candidate/revision plus checksum | Never overwrite; any pixel change creates a new version. |
| Card layout | independent integer or semantic version | Increment for frame, typography, copy, placement, or art substitution. |
| Print assets | release revision | Increment for bleed, profile, imposition, printer, or exported bytes. |
| Metadata | semantic version and checksum | Increment whenever manifest meaning changes; regenerated checksums require a new record. |

Example dependency lock: `L010 package 1.0.0 / prompt 1.0.0 / artwork candidate 4 / layout 2 / print 1 / metadata 1.1.0`. A downstream manifest records exact upstream versions and SHA-256 hashes. Versions never substitute for hashes.

## Reproducibility contract
“Identical assets” means byte-identical source, compiled prompts, settings, input references, and downstream layout/export inputs. A provider may still be nondeterministic; in that case the workflow reproduces the request and audit trail, not guaranteed identical pixels.

Before generation record:
- source and compiled-prompt versions and SHA-256 hashes;
- compiler and adapter versions;
- provider, model, model revision when exposed, account/project context where permitted;
- positive and negative prompt hashes;
- reference-image hashes and weights;
- seed, job ID, sampler, steps, guidance, size, aspect ratio, format, and safety settings when exposed;
- UTC timestamp and operator;
- acknowledged provider limitations.

Raw provider output is immutable. Store subsequent crop, colour, retouch, upscale, and format conversion as ordered transformations with tool/version, parameters, input hash, and output hash.

## Mandatory quality gates

| Gate | Evidence | Approver | Exit condition |
|---|---|---|---|
| G1 Canonical | Knowledge files and claim review | Biblical/theological reviewer | No blocking claim issue. |
| G2 Gameplay | Gameplay philosophy and rationale | Gameplay reviewer | Distinct, grounded identity accepted. |
| G3 Art direction | Artwork source, symbols, continuity | Theology + art reviewers | Scene and visible choices accepted. |
| G4 Prompt | Compiled prompt, exclusions, trace map, lint | Prompt + theology reviewers | Exact prompt hash approved. |
| G5 Artwork | Candidate manifest and evaluation | Theology + art + technical reviewers | Exact image hash approved. |
| G6 Card | Layout manifest and proofs | Content + design reviewers | Exact layout approved. |
| G7 Release | Print preflight, dependency lock, checksums | Production approver | Archive complete and registry update authorized. |

No gate may be self-certified by file existence. Failed gates return to the owning upstream stage, produce a revision entry, and invalidate only approvals affected by the change.

## Card production sequence
1. Import the approved artwork by asset ID and verify its hash.
2. Place it in the official overlay-safe art window without destructive stretching.
3. Apply the versioned card frame and rarity treatment.
4. Apply governed typography styles; never use generated-image text.
5. Populate name, title, traits, ability box, and reviewed rules copy from structured data.
6. Add approved flavor text with a direct source or explicit project-copy label.
7. Add collector number, set code, version/legal marks, and accessibility metadata.
8. Add QR only when its destination, longevity, privacy, contrast, and quiet zone are approved; otherwise omit it.
9. Build trim, safe area, and bleed according to the print specification.
10. Export digital and print variants from the same approved layout source.
11. Run content, visual, accessibility, preflight, and physical-proof reviews.
12. Create layout/print manifests and checksums; release only after G6 and G7.

## Change impact
- Knowledge or theological correction: reassess every downstream artifact; regeneration is required if any approved asset contradicts it.
- Gameplay copy change: reassess card layout and print; art only if visual rationale changes.
- Continuity/art-direction change: new prompt major/minor version and new candidates normally required.
- Adapter/model change: new compilation/generation record even if prompt words are unchanged.
- Retouch: new artwork version and technical/art review; never replace raw output.
- Layout-only correction: new layout and print versions; retain approved artwork version.
