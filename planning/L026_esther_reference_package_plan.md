# L026 Esther Reference Package Plan

## Purpose

Esther is the first architecture-validation package after Joshua. This plan begins the package without creating incomplete canonical data under package discovery paths. The package must validate reuse of the canonical character model across a royal-court narrative, a female lead, indirect providence, advocacy, political risk, and non-battlefield courage.

## Package identity

- Collector ID: `L026`
- Canonical character: Esther
- Registry title: `Queen of Courage`
- Registry archetype: `Royal Protector`
- Initial traits: `Courage`, `Influence`, `Wisdom`
- Initial ability concept: `For Such a Time`
- Package role: architecture validation
- Initial status: `SPEC_DRAFT`

Registry values are starting constraints, not approved canonical conclusions. The package must preserve Scripture, responsible synthesis, historical reconstruction, and project interpretation as distinct classifications.

## Architecture questions

The Esther package must test whether the reusable model can represent:

1. A female character with stable visual continuity that does not inherit Joshua-specific masculine, military, wardrobe, or pose assumptions.
2. A royal Persian court environment with historically reviewed clothing, architecture, protocol, banquets, seals, decrees, and throne-room staging.
3. Divine providence without inventing direct divine speech, visible divine intervention, or magical control attributed to Esther.
4. Courage expressed through timing, advocacy, fasting, preparation, persuasion, disclosure, and personal risk rather than physical combat.
5. Multiple names and identities, including Hadassah and Esther, with careful treatment of ethnicity, concealment, disclosure, and covenant identity.
6. A relationship graph involving Mordecai, Ahasuerus/Xerxes, Haman, Vashti, attendants, Jewish communities, and imperial authorities.
7. Event chronology across selection, concealment, the assassination plot, Haman’s decree, fasting, the uninvited approach, banquets, exposure, counter-decree, conflict, and Purim.
8. Gameplay mechanics based on influence and political sequencing while avoiding coercive stereotypes or the implication that beauty itself is supernatural power.
9. Art direction for dignity, agency, cultural plausibility, and premium collectible-card readability.
10. Prompt compilation that can represent restrained tension, court hierarchy, and indirect providence without fantasy spectacle.

## Canonical research scope

Primary Scripture scope:

- Esther 1–10

Cross-reference scope should remain limited and explicitly classified. Candidate supporting areas may include:

- Ezra and Nehemiah for Persian-period context
- Daniel for court-exile comparison, without collapsing distinct settings or dates
- later biblical references only when directly relevant and clearly classified

The repository must not settle disputed chronology, identification of Ahasuerus, or extra-biblical traditions merely to make artwork more specific. Historical reconstruction must record uncertainty.

## Required canonical documents

When research is sufficiently complete, create the full discoverable package atomically from `templates/character_knowledge/`:

- `manifest.yaml`
- `character.yaml`
- `references.yaml`
- `timeline.yaml`
- `relationships.yaml`
- `symbols.yaml`
- `gameplay.yaml`
- `art.yaml`
- `prompt.yaml`
- `review.yaml`
- `version_history.yaml`

Do not merge a partial manifest-declared package. All declared documents must validate together, and the deterministic assembled artifact must be generated in the same PR.

## Initial knowledge decisions to research

### Identity

- canonical naming structure for Hadassah and Esther
- family relationship and guardianship under Mordecai
- Jewish identity, concealment, and later disclosure
- royal position and limits of authority
- explicit virtues, actions, fears, risks, and constraints

### Timeline

The event graph should at minimum distinguish:

- Vashti removed from royal position
- Esther gathered and selected
- Mordecai uncovers the assassination plot
- Haman elevated and offended by Mordecai
- decree against the Jews
- Mordecai’s appeal and Esther’s initial hesitation
- communal fast
- Esther approaches the king uninvited
- first banquet
- second banquet and disclosure
- Haman’s fall
- counter-decree
- deliverance and conflict
- institution of Purim
- Mordecai’s advancement

### Relationships

Each relationship must declare direction, type, relevant event IDs, reference IDs, and uncertainty where applicable.

### Symbolism

Candidate motifs requiring review include:

- royal robes
- sceptre
- banquet table
- signet ring and sealed decree
- fasting garments or restrained visual reference to fasting
- palace gates
- scrolls and couriers
- Purim remembrance

The sceptre and signet ring must remain symbols of royal authority, not magical objects.

## Gameplay design questions

The gameplay package should explore a support/control archetype based on sequencing and political leverage. Candidate mechanic families include:

- `TIMED_ADVOCACY` — benefits unlocked after preparation or delayed disclosure
- `ROYAL_FAVOUR` — limited access or protection granted through reviewed conditions
- `COUNTER_DECREE` — answer a harmful global effect without pretending the original decree never existed
- `COMMUNAL_FAST` — temporary sacrifice or reduced tempo that enables later protection
- `HIDDEN_IDENTITY` — information timing, not deception rewarded without cost
- `BANQUET_SETUP` — staged interaction that changes the next political action
- `FOR_SUCH_A_TIME` — high-impact response when an allied community faces severe danger

Prohibited directions should include:

- beauty as supernatural domination
- seduction mechanics
- magical sceptre or crown
- Esther directly controlling providence
- ethnic targeting as a reward loop
- trivializing attempted genocide into a light comic effect

## Art-direction tests

The art profile should support multiple reviewed depiction contexts while maintaining stable character continuity:

- royal court portrait
- threshold approach before the king
- banquet disclosure
- fasting/preparation context

A single card illustration must choose one coherent temporal moment. It must not combine the fast, throne approach, banquet, Haman’s fall, and Purim into a collage.

Historical review is required for:

- Achaemenid Persian court garments and jewellery
- throne-room architecture and columns
- crown and headdress terminology
- sceptre form
- banquet furnishings and vessels
- skin, hair, and regional diversity without modern beauty stereotypes

## Review gates

The Esther package must instantiate the same reusable gates as Joshua:

- G1 canonical and technical integrity
- G2 biblical, theological, and historical review
- G3 gameplay identity review
- G4 art-direction review
- G5 compiled-prompt review

Artwork generation remains blocked until all required gates, model adapter selection, and output settings are recorded.

## Delivery sequence

1. Confirm registry constraints and create the research ledger.
2. Build Scripture references and event chronology.
3. Build identity and relationship graph.
4. Define classified symbolism and historical uncertainties.
5. Draft gameplay philosophy and prohibited mechanics.
6. Draft art direction and continuity fields.
7. Draft semantic prompt sources.
8. Create the complete canonical package atomically.
9. Generate the deterministic assembled artifact.
10. Validate schemas, graph integrity, provenance, and drift.
11. Create human review projections under `cards/L026_esther/`.
12. Request cross-discipline review; do not generate artwork.

## Exit criteria for bootstrap

This bootstrap is complete when:

- the plan is merged;
- Esther is marked `SPEC_DRAFT` in the operational tracker;
- no incomplete canonical package is introduced;
- the next implementation PR has a clear atomic package contract;
- Joshua production gates remain independent and unchanged.
