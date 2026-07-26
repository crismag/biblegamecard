# Canonical Character Knowledge Model

## Purpose and authority
The normalized YAML package is the authoritative character knowledge source for websites, apps, search, prompt compilation, lore/RAG, AI assistants, gameplay systems, dialogue, story mode, and analytics. Markdown remains a human review projection. Production specifications and generated artifacts reference canonical field paths; they do not become knowledge authority.

A package lives at:

```text
knowledge/characters/<rarity>/<collector_id>_<slug>/data/
  manifest.yaml
  character.yaml
  references.yaml
  timeline.yaml
  relationships.yaml
  symbols.yaml
  gameplay.yaml
  art.yaml
  prompt.yaml
  review.yaml
  version_history.yaml
```

Joshua is the filled reference: [`L010_joshua/data/`](../knowledge/characters/legendary/L010_joshua/data/). The reusable skeleton is [`templates/character_knowledge/`](../templates/character_knowledge/).

## Normalization rules
1. Author a fact once in its owning document. Other documents store its stable ID or field reference.
2. `character.yaml` owns identity, names, titles, roles, leadership, virtues, failures/limits, lifespan, and summary.
3. `references.yaml` owns structured Scripture ranges and their contexts. Claims/events/relationships store `reference_ids`, never copied citation strings.
4. `timeline.yaml` owns events. Art and story systems store `event_id`, not a rewritten event.
5. Global registries own reusable entity, location, and symbol labels. Character packages store IDs.
6. `gameplay.yaml` owns gameplay philosophy; `art.yaml` owns visible continuity and scene direction; `prompt.yaml` owns semantic field references and compiler configuration.
7. `review.yaml` owns review/generation state. `version_history.yaml` owns knowledge-model revisions.
8. Markdown tables and prose are declared projections in `manifest.human_views.projections`. Change canonical YAML first, validate, then update/regenerate affected views in the same commit.
9. Generated prompt, image, layout, and print manifests lock canonical versions and hashes; they never back-write character facts.

## Required and optional fields
The normative structural contract is [`canonical_character_package.schema.json`](../schemas/knowledge/canonical_character_package.schema.json). The validator additionally enforces graph integrity.

| Document | Required concepts | Optional/null concepts |
|---|---|---|
| `manifest` | Package/character/collector IDs, versions, schema, document paths, registries, human projections | Consumer list |
| `character` | Metadata, identity, names, titles, leadership, virtues, failures/limits, lifespan, locations, summary, classification policy | Unknown dates, named successor, numeric appearance age remain `null` rather than guessed |
| `references` | Reference ID, testament, book, one or more chapter/verse segments, context, importance | None for a cited claim |
| `timeline` | Ordered unique event IDs, citations, participants, locations, summary, importance | Absolute dates may be unresolved |
| `relationships` | Relationship ID, target entity, typed edges, direction, importance, influence, citations | No uncited canonical relationship |
| `symbols` | Global symbol ID, package usage, scene constraints, citations; prohibited concepts | Project-only symbol may have an empty citation list when explicitly classified globally |
| `gameplay` | Rarity, archetype, roles, theme, mechanics, strengths/weaknesses, ability rationale, state | Rules text and numeric balance may be `null` before design approval |
| `art` | Classification note, life stage, body/face/hair/beard, wardrobe, weapon, pose, scene, composition, lighting, palette, rendering, continuity | Numeric age and approved image references may be `null`/empty |
| `prompt` | Semantic component field refs, compiler contract, clause order, output contract | Adapter remains `null` until selected |
| `review` | Artifact-specific states, generation state/reasons, review roles | None |
| `version_history` | Version, date, scope, author, reason, changes, state | None |

## Enumerations and naming
- Stable IDs use uppercase snake case: `JOSHUA_SON_OF_NUN`, `JERICHO`, `EVT_JOSHUA_JORDAN`, `REF_JOSHUA_3_1_4_24`, `REL_JOSHUA_MOSES`.
- Collector IDs match `^[A-Z][0-9]{3}$`; slugs use lowercase snake case; versions use `MAJOR.MINOR.PATCH`.
- Scripture `testament`: `old`, `new`; importance: `primary`, `supporting`.
- Event importance: `supporting`, `formative`, `primary`, `defining`.
- Edge direction: `outgoing`, `incoming`, `bidirectional`.
- Review states follow [Production Validation Standard](PRODUCTION_VALIDATION_STANDARD.md#approval-states).
- Controlled role, relationship, period, gameplay, and mechanic tags use uppercase snake case. New tags require clear semantics and should be promoted to a registry when reused.
- Unknown is `null`; not applicable is an explicit state/tag; empty string is not a substitute.

## Scripture range model
A reference contains a canonical book label and one or more same-chapter segments:

```yaml
- id: REF_JOSHUA_3_1_4_24
  testament: old
  book: Joshua
  segments:
    - {chapter: 3, verse_start: 1, verse_end: 17}
    - {chapter: 4, verse_start: 1, verse_end: 24}
  context: Jordan crossing and memorial stones
  importance: primary
```

Discontinuous verses use multiple segments. Cross-chapter ranges are expanded into per-chapter segments. The model does not encode translation-specific quotation text unless a separately licensed quotation registry is introduced.

## Graph rules and queries
- Every participant, relationship target, nation, predecessor, and gameplay comparison resolves to the global entity registry.
- Every event/art/lifespan location resolves to the global location registry; location parents resolve within that registry.
- Every character symbol use resolves to the global symbol registry.
- Every `reference_id`, `event_id`, and semantic prompt field reference resolves within the package.
- IDs are immutable after release; labels may be versioned without breaking graph edges.
- Relationships are directed. Use `bidirectional` only when the modeled relationship itself is reciprocal.

These rules enable queries such as:
- role-tag lookup for judges, kings, prophets, apostles, and leaders;
- `ASSISTANT_TO`/`MENTORED_BY` traversal to find people mentored by Moses;
- event participant plus location traversal to find everyone crossing the Jordan;
- location and symbol reverse indexes for Jericho-associated characters;
- historical-period and event traversal for people appearing during the Exodus.

## Validation
Run:

```bash
ruby tools/validate_character_knowledge.rb knowledge/characters/legendary/L010_joshua/data
```

Validation fails on:
- missing manifest documents, registries, schema, or human projection files;
- invalid ID/version/state formats or duplicate IDs;
- invalid Scripture segments or verse ordering;
- dangling entity, location, symbol, Scripture, event, or prompt field references;
- duplicate/unsorted event order;
- an event omitting the package character from participants;
- inconsistent character IDs across documents;
- unresolved art scene, negative concept, or semantic prompt component;
- an unknown/null value represented by invention rather than the defined nullable field.

The JSON Schema validates the assembled document shape. The Ruby validator performs cross-file referential integrity that JSON Schema cannot express portably. Both are part of the contract.

## Change workflow
1. Reserve stable IDs and add genuinely reusable entities/locations/symbols to global registries.
2. Enter Scripture references before claims, relationships, events, or profiles that cite them.
3. Enter character identity and graph edges; distinguish Scripture, tradition, responsible synthesis, and project interpretation.
4. Enter gameplay and art profiles by reference, not by copying identity/event/location text.
5. Define prompt semantic components only as canonical field references.
6. Validate, review the diff, and update declared Markdown projections.
7. Increment knowledge/package versions according to change impact.
8. Recompile downstream prompts when relevant fields change and update exact version/hash locks.
