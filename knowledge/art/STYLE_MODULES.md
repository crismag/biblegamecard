# Style Modules

## Purpose
Defines reusable visual clauses that prompt compilation may reference. Modules describe intent; model adapters may rewrite syntax without changing meaning.

## Module contract
Each module should have:
- stable identifier;
- version;
- purpose;
- compatible asset types;
- positive visual instructions;
- exclusions or cautions;
- dependencies;
- change history.

## Core modules

### `STYLE_BIBLICAL_REALISM`
Cinematic semi-realistic biblical illustration; believable anatomy; natural faces and skin; historically plausible materials; grounded human emotion; respectful narrative interpretation; no modern or franchise-specific design language.

### `STYLE_PAINTERLY_PREMIUM`
Refined painterly finish; controlled brush texture; detailed focal area; simplified peripheral detail; rich cloth, leather, bronze, wood, stone, dust, water, and atmosphere; premium collectible quality without plastic photorealism.

### `STYLE_CINEMATIC_DEPTH`
Clear foreground, subject plane, and softened background; intentional atmospheric perspective; directional visual flow; strong but natural silhouette separation; restrained depth of field.

### `STYLE_CARD_READABILITY`
One dominant focal subject; strong value hierarchy; readable face and hands; uncluttered silhouette; protected overlay zones; background detail reduced at thumbnail scale; crop flexibility beyond trim.

### `STYLE_HISTORICAL_PLAUSIBILITY`
Period- and region-aware clothing, architecture, tools, weapons, vegetation, and materials; documented uncertainty; exclusion of modern, medieval-fantasy, and unrelated archaeological elements.

### `STYLE_REVERENT_DRAMA`
Emotionally powerful but respectful; drama arises from calling, conflict, worship, courage, deliverance, judgment, or restoration; miracles remain acts of God; no personal magical aura.

### `STYLE_LEGENDARY_PRESENTATION`
Iconic silhouette, intentional centrality or commanding visual flow, refined material detail, strong focal contrast, restrained symbolic accent, and visual weight appropriate to a legendary collectible. This module does not add a card frame or typography.

### `STYLE_PRINT_AWARE`
Preserved shadow detail, controlled highlights, natural skin separation, moderate saturation, clear small-format values, and no dependence on fluorescent effects that fail in print.

## Lighting modules

### `LIGHT_CALLING`
Focused directional light entering a grounded environment; anticipatory mood; controlled contrast; no unexplained magical beam attached to the character.

### `LIGHT_VICTORY`
Crisp silhouette separation, lifted midtones, warm accents, open atmosphere, and visual release after conflict.

### `LIGHT_TRIAL`
Constrained source, lower-key environment, reduced saturation, pressure from weather or enclosure, readable vulnerability.

### `LIGHT_WORSHIP`
Ordered warm practical light or soft dawn/dusk illumination, calm atmosphere, dignified faces, restrained luminous emphasis.

### `LIGHT_PROPHECY`
Directional interruption, stark value pattern, unsettled atmosphere, restrained colour contrast, no glowing eyes or default lightning.

### `LIGHT_MIRACLE`
Environmental response, scale, reflected illumination, movement, and human reaction; source remains beyond human control.

### `LIGHT_PEACE`
Balanced open values, natural colour, breathable atmosphere, stable composition, soft but dimensional form.

## Composition modules

### `COMP_PORTRAIT_ICONIC`
Head-and-upper-torso emphasis, clear facial identity, simple background, controlled asymmetry, room for title and icons.

### `COMP_HERO_THREE_QUARTER`
Three-quarter figure, narratively motivated stance, signature object, strong silhouette, environmental context, crop-safe edges.

### `COMP_ENVIRONMENTAL_STORY`
Subject integrated into a location or event; setting carries narrative meaning; clear scale and directional flow; figure remains identifiable.

### `COMP_RELATIONAL`
Two or more figures connected through gaze, gesture, touch, spacing, and hierarchy; no repeated faces or ambiguous limbs.

### `COMP_ACTION_CLARITY`
Single readable action beat; believable body mechanics; controlled debris and motion; face or signature silhouette preserved.

## Quality modules

### `QUALITY_ANATOMY`
Correct human anatomy, natural hands, coherent limbs, believable gaze, accurate object grip, no duplication or fusion.

### `QUALITY_MATERIALS`
Distinct material response for skin, hair, linen, wool, leather, metal, wood, stone, water, smoke, and fire.

### `QUALITY_CLEAN_ART`
No text, watermark, logo, signature, frame, border, pseudo-writing, UI element, compression artifact, or unintended crop.

## Combination rules
Default character artwork uses:
`STYLE_BIBLICAL_REALISM + STYLE_PAINTERLY_PREMIUM + STYLE_CINEMATIC_DEPTH + STYLE_CARD_READABILITY + STYLE_REVERENT_DRAMA + QUALITY_ANATOMY + QUALITY_MATERIALS + QUALITY_CLEAN_ART`

Add only one primary lighting module and one primary composition module unless the template explicitly permits more.

## Prohibited combinations
- Do not combine mutually conflicting moods such as `LIGHT_TRIAL` and `LIGHT_VICTORY` without a transition scene specification.
- Do not apply `STYLE_LEGENDARY_PRESENTATION` to every minor object or token.
- Do not use module repetition to inflate prompt length.
- Do not let model adapters add franchise names as style shortcuts.
