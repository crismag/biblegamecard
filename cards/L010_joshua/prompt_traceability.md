# Prompt Compilation Traceability

Artifact: `L010-JOSHUA-ART-01`, compiled prompt `1.0.0`. The machine-readable map is [`prompt_traceability.yaml`](../../generated/prompts/L010-JOSHUA-ART-01/1.0.0/prompt_traceability.yaml). Clause IDs follow sentence order in [`prompt.txt`](../../generated/prompts/L010-JOSHUA-ART-01/1.0.0/prompt.txt).

| Clause | Compiled intent | Canonical source fields | Standard/module contribution | Why it is present |
|---|---|---|---|---|
| C01 | Asset, Joshua identity, life stage, succession | `character.names.primary`, `character.leadership`; `art.life_stage`, `art.composition.framing` | Prompt Grammar subject clause | Opens with concrete identity; mature life stage remains labeled project interpretation. |
| C02 | Pre-Jericho synthesis; commissioned courage; no personal supernatural power | `art.scene.mode`, `art.scene.narrative_event_id`; `character.virtues`; `symbols.prohibited_visual_concepts` | Narrative and theological guardrails | Selects one event context and protects divine agency. |
| C03 | Build, face, hair, beard, garments, material defense | `art.body`, `art.face`, `art.hair`, `art.beard`, `art.wardrobe` | Character Design Guide | Resolves only visible canonical art-profile fields. |
| C04 | Pose, expression, signal, and single sword contact | `art.pose`, `art.weapon`; `gameplay.theme` | Action/anatomy rules | Makes coordinated command visible without copying gameplay facts into art. |
| C05 | Priests, closed ark on poles, trumpets | `art.scene.supporting_entity_ids`, `art.scene.required_symbol_ids`; `symbols.symbol_uses` | Symbol/relationship clause | Resolves ownership, carriers, and symbol constraints by ID. |
| C06 | Southern-Levant terrain and intact Jericho | `art.scene.location_id`, `environment`, `weather`, `background` | Environment Guide | Grounds place and pre-fall scene continuity. |
| C07 | Camera, 2:3 framing, hierarchy, safe zones | `art.composition` | Composition Guide | Makes art usable in governed card layout. |
| C08 | Dawn light and palette | `art.lighting`, `art.palette` | Lighting and Color guide | Provides practical light and continuity colours. |
| C09 | Painterly realism and material rendering | `art.rendering.style_module_ids`, `art.rendering.material_priorities` | Style Modules | Applies collection rendering without adding character lore. |
| C10 | Anatomy, construction, clarity, thumbnail/print quality | `art.rendering.quality_targets`, `art.composition.thumbnail_requirements` | Character/quality standards | Turns review criteria into observable requirements. |
| C11 | Clean 2:3 illustration with no typography | `prompt.output`, `art.composition.aspect_ratio` | Prompt Grammar output rule | Separates artwork generation from card typography. |
| C12 | Explicit exclusions and divine-agency guardrail | `prompt.semantic_components.negative`, `art.negative_concept_ids`, `symbols.prohibited_visual_concepts` | Negative Prompt Library | Resolves the reviewed negative component without an unexplained addition. |

## Negative-prompt provenance

| Group | Examples | Canonical origin |
|---|---|---|
| Theology and sacred depiction | magic, aura, halo, divine-light control, opened/weaponized ark | `prompt.semantic_components.negative`; `art.negative_concept_ids`; `symbols.prohibited_visual_concepts` |
| Scene integrity and dignity | collapsing walls, casualties, gore, caricature | `art.scene`, `symbols.prohibited_visual_concepts` |
| Historical/anachronism | fantasy/medieval/Roman armour, modern weapons/flags, invented sigils | `art.wardrobe`, `art.weapon`, `art.negative_concept_ids`; `symbols.symbol_uses` |
| Colour/style | neon/electric magic, orange-teal overgrading | `art.palette.prohibited` |
| Anatomy/object construction | fingers, limbs, hands, sword/scabbard, poles, ark, scale | `art.rendering.quality_targets`, `art.weapon`, `symbols.symbol_uses` |
| Clean deliverable | text, lettering, logo, signature, watermark | `prompt.output` plus the shared Negative Prompt Library |

## Traceability rule
A future wording change must update the structured source first, then the compiled prompt and trace map together. A clause with no source is a compilation failure. Shared standards may supply rendering and technical quality, but may not silently add character facts, symbols, narrative events, or theology.
