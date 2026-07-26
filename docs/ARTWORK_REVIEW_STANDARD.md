# Artwork Review and Evaluation Standard

## Review disciplines

| Review | Questions | Blocking examples | Evidence |
|---|---|---|---|
| Biblical/theological | Does the scene respect the cited text, divine agency, disputed points, and dignity? | Character performs God's miracle; invented sacred object; harmful conquest spectacle. | Passage-to-visual notes and reviewer decision. |
| Historical | Are geography, material culture, clothing, architecture, weapons, and social roles plausible and honestly classified? | Medieval plate, Roman uniform, modern equipment, geographically impossible landscape. | Art-direction comparison; reference note where needed. |
| Character continuity | Does identity match the approved continuity sheet, allowing explained scene/age variation? | Accidental redesign of face, build, hair, palette, or signature equipment. | Side-by-side reference and variance note. |
| Visual | Is focal hierarchy, lighting, depth, perspective, anatomy, gesture, material separation, and narrative legibility successful? | Extra fingers, floating object, broken weapon, cross-eye, unreadable face, tangent. | Full-size and thumbnail inspection. |
| Technical | Does the file meet size, format, colour, cleanliness, and provenance requirements? | Upscale artifacts, embedded text/watermark, missing hash, wrong aspect ratio. | File inspection and manifest. |
| Card/print | Does the art survive crop, overlay, thumbnail, grayscale/contrast, and physical reproduction? | Key face under frame, unsafe crop, muddy print values, inadequate effective resolution. | Layout mock, preflight, and proof. |
| Collector | Is it distinctive, emotionally coherent, dignified, and legible beside the set without relying on spectacle? | Generic AI hero, duplicated set composition, novelty that breaks canon. | Set-sheet comparison and documented score. |

## Inspection protocol
1. Verify candidate ID and SHA-256 against its generation manifest.
2. Inspect at 100% and 200% for anatomy, texture, edges, artifacts, and object construction.
3. Inspect fit-to-card and at target thumbnail size for face, silhouette, action, and focal hierarchy.
4. Overlay safe zones and frame; inspect crop at all intended aspect/export variants.
5. Compare with art direction, symbolism rules, prompt trace, and continuity sheet.
6. Compare with nearby collection cards for unwanted repetition and palette drift.
7. Record scores and every defect by severity; do not repair before preserving the raw candidate.
8. Decide `reject`, `revise_source`, `candidate_hold`, or `approve`; approval requires all critical checks and threshold scores.

## Scoring rubric
Use integer scores 1–5. Scores support—not replace—reviewer judgment.

| Criterion | Weight | 1 | 3 | 5 |
|---|---:|---|---|---|
| Identity | 15 | Wrong/unrecognizable | Broad role reads | Specifically and consistently recognizable |
| Biblical/theological fidelity | 20 | Contradiction | No contradiction, weak specificity | Text-grounded and guarded |
| Historical plausibility | 10 | Clear anachronism | Broadly plausible | Coherent materials/place with cautious specificity |
| Prompt adherence | 10 | Major clauses missed | Main concept present | All required clauses and exclusions honored |
| Character continuity | 10 | Accidental redesign | Mostly aligned | Aligned; variances explained |
| Composition/focal hierarchy | 10 | Confused | Functional | Immediate, purposeful, card-safe |
| Anatomy/object integrity | 10 | Critical defects | Minor correctable issue | Natural and coherent |
| Technical/print fitness | 10 | Unusable | Meets minimum | Clean, robust across output sizes |
| Thumbnail readability | 3 | Fails | Recognizable | Strong silhouette and face |
| Collector appeal/set fit | 2 | Generic/disruptive | Acceptable | Distinctive and cohesive |

Calculate `weighted_percent = sum(score × weight) / 5`. Minimum candidate-hold threshold is 80%; minimum approval threshold is 90%, with no score below 3 and no critical defect. Theology, identity, anatomy/object integrity, provenance, and rights/safety are hard gates regardless of total.

## Visual checklist
- [ ] Approved identity, life stage, regional appearance, face, hair, beard, build, palette, and equipment.
- [ ] Historically plausible clothing, materials, weapon, architecture, geography, and weather.
- [ ] Correct narrative moment, relationships, symbolism, object ownership, and divine agency.
- [ ] No fantasy armour, modern clothing/equipment, invented sacred marks, caricature, or spectacle of suffering.
- [ ] Face readable; eyes aligned; expression and gaze intentional; skin retains natural texture.
- [ ] Correct limbs, joints, hands, thumbs, finger count, feet, grip, contact, and weight-bearing.
- [ ] No duplicate/missing props, floating objects, broken weapons, fused forms, or impossible carrying poles.
- [ ] Perspective, horizon, architecture, cast shadows, scale, occlusion, and foreground/midground/background depth cohere.
- [ ] Focal point, contrast, lighting direction, edge hierarchy, and colour separation match direction.
- [ ] Silhouette reads at thumbnail size and differs appropriately from neighboring cards.
- [ ] Card frame, title, rules box, collector data, trim, safe zone, and bleed do not cover critical content.
- [ ] Correct aspect ratio, dimensions, effective resolution, format, colour profile, and clean gradients.
- [ ] No text, pseudo-writing, logo, watermark, signature, compression damage, oversharpening, or plastic texture.
- [ ] Candidate, source, settings, transformations, reviewer decisions, versions, and hashes are recorded.

## Failure correction matrix
Correct the earliest authoritative source responsible; do not patch only the compiled prompt when the source is wrong.

| Failure/symptoms | Likely cause | Source or prompt correction | Review recommendation |
|---|---|---|---|
| Too young/old | Life stage vague or model prior | Make life stage observable: hair greying, skin weathering, posture; avoid unsupported numeric age. | Recheck Scripture classification and continuity. |
| Wrong regional appearance or caricature | Generic/biased model prior; vague context | State plausible region and varied natural features; prohibit stereotype language. | Historical + dignity review; reject caricature. |
| Face drift | Continuity traits too broad; no approved reference | Tighten stable face/hair/beard traits; attach approved reference ID/weight when permitted. | Side-by-side continuity review. |
| Fantasy/medieval/Roman armour | “Epic warrior” shorthand or missing period | Replace genre adjectives with materials/construction; repeat explicit exclusions in adapter. | Historical review; reject rather than retouch large costume errors. |
| Modern military equipment | Ambiguous “commander” language | Specify period garments, sword construction, procession; exclude uniforms/firearms. | Full object inventory review. |
| Duplicate sword/prop | Too many object clauses or unclear hand interaction | Name one item, location, grip, scabbard, and state “single.” | Inspect hands, reflections, and background duplicates. |
| Six fingers/missing thumb/malformed hands | Model anatomy failure; small hand area | Simplify gesture; enlarge visible hand; state finger/grip integrity; use approved inpaint only as versioned edit. | 200% inspection; new artwork version after repair. |
| Cross-eyed/asymmetric face | Small face, extreme angle, generation defect | Increase face priority; reduce extreme angle; request aligned gaze. | Reject if identity changes under repair. |
| Plastic skin/over-sharpening | Rendering/adapter bias or aggressive upscale | Request natural skin variation and restrained microcontrast; revise upscale settings. | Inspect at print size and 200%; preserve raw. |
| Low contrast/unreadable face | Background value collision or poor light placement | Specify face/key-light separation and background value control. | Thumbnail, grayscale, and frame-overlay review. |
| Magic effects/halo | Abstract “holy/epic” language or model prior | Describe practical light; explicitly prohibit aura, halo, spellcasting, personified divine light. | Theology review is mandatory. |
| Wrong symbolism/object ownership | Crowded source or weak relationship clause | State object owner/carrier and physical integration; remove nonessential symbols. | Compare symbolism table and passage. |
| Floating/broken objects | Unspecified contact, occlusion, or construction | Define hands, straps, poles, ground contact, scale, and material joins. | Technical visual inspection at 200%. |
| Incorrect perspective/depth | Excess scene complexity; conflicting camera clauses | Use one camera, horizon, focal order, and three depth planes; reduce figures. | Overlay perspective lines and crop. |
| Composition unsafe for card | Prompt optimized as poster | Declare frame overlay zones, subject position, and quiet margins before generation. | Test official frame and every crop. |
| Generic AI hero/low collector appeal | Reused pose/style clichés | Reinforce character-specific action, restraint, symbols, and set-comparison requirement. | Collector review only after hard gates pass. |
| Theological inaccuracy | Missing or untraced interpretation | Correct knowledge/art direction first, invalidate prompt approval, then recompile. | Reject candidate; biblical/theological sign-off required. |
