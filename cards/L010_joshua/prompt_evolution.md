# Prompt Evolution

Prompt versions evolve independently from package, artwork, layout, print, and metadata versions. Apply the shared [Prompt Versioning policy](../../knowledge/prompt_engineering/PROMPT_VERSIONING.md).

## History and planned flow

| Version | State | Why | Change | Expected effect | Regeneration impact |
|---|---|---|---|---|---|
| 1.0.0 | `review_requested` | First canonical compilation for the reference scene | Established identity, pre-Jericho narrative, continuity, composition, dawn light, rendering, quality, and exclusions. | Traceable baseline suitable for adapter review. | No official artwork exists. |
| 1.1.0 | Not created; example only | A selected adapter may require clearer weighting or syntax while preserving concept. | Adapter-specific expression and declared dimensions/settings; semantic source unchanged. | More reliable adherence for that model. | Required first generation uses this only if reviewers approve it. |
| 1.2.0 | Not created; example only | Candidate review might show low face contrast. | Source lighting revised to strengthen practical face separation, then recompiled. | Better face/thumbnail readability without magic light. | Recommended/required according to defect severity. |
| 2.0.0 | Not created; example only | A future approved scene or continuity family changes. | New narrative moment, composition family, or canonical continuity intent. | Materially different approved artwork concept. | New candidates required; 1.x retained, never overwritten. |

Examples are not scheduled versions and must not be pre-created. Every real revision adds date, author, changed source fields/modules, reason, expected visual effect, affected candidates, approval state, and regeneration decision to `revision_history.md`. “Better” is not an adequate reason: name the observed defect or requirement.

## Revision procedure
1. Record the candidate/review evidence that motivates change.
2. Correct the earliest authoritative source; do not hand-edit only generated text.
3. Classify major/minor/patch and document approval invalidation.
4. Recompile positive prompt, negative prompt, trace map, hashes, and manifest together.
5. Diff by clause and verify every new sentence/exclusion has provenance.
6. Request G4 approval for the exact version/hash before generation.
