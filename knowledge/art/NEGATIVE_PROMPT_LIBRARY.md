# Negative Prompt Library

## Purpose
Centralizes exclusions and failure checks for generated artwork. Negative prompts reduce common model errors but do not replace human review.

## Usage rules
- Select only exclusions relevant to the asset and model.
- Prefer clear visual descriptions over long keyword spam.
- Do not depend on negative prompts to enforce theology or historical truth; positive context and review remain required.
- Model adapters may convert these clauses into platform-specific syntax.

## Global exclusions
`NEG_GLOBAL_CLEAN`
- no watermark, signature, logo, brand mark, UI, border, card frame, caption, rules text, collector number, or pseudo-writing;
- no low resolution, heavy compression, blur, muddy focal area, unfinished sketch, or accidental crop;
- no duplicate subject, mirrored duplicate, collage, split panel, or contact sheet.

## Anatomy exclusions
`NEG_ANATOMY`
- no extra or missing fingers, fused fingers, malformed hands, duplicated limbs, disconnected joints, twisted wrists, broken posture, asymmetrical eyes, melted facial features, duplicated teeth, or impossible object grip;
- no adult proportions on children;
- no weightless stance unless the narrative explicitly requires suspension.

## Historical exclusions
`NEG_ANACHRONISM`
- no modern clothing, zippers, plastic, watches, eyeglasses, electric lights, vehicles, firearms, printed books, modern roads, skyscrapers, or contemporary furniture;
- no medieval-European plate armour, Gothic castles, fantasy taverns, or Renaissance court dress unless explicitly approved for a non-historical adaptation;
- no generic archaeological monument from the wrong era used as scenery.

## Style exclusions
`NEG_STYLE_DRIFT`
- no anime, chibi, children's cartoon, comic-book superhero, glossy 3D toy, plastic game cinematic, photographic cosplay, fashion editorial, pin-up, or horror-gore treatment;
- no direct imitation of an existing entertainment or trading-card franchise;
- no neon cyberpunk effects, glowing runes, or science-fiction technology.

## Theological and symbolic exclusions
`NEG_THEOLOGY`
- no character controlling magical energy;
- no glowing eyes used to indicate holiness;
- no invented divine humanoid figure;
- no unexplained halo, angel wings, cross, dove, crown, or sacred object;
- no decorative Hebrew, Greek, Aramaic, or Latin pseudo-text;
- no miracle presented as the character's independent power.

## Character exclusions
`NEG_CHARACTER`
- no glamour-model uniformity, sexualized pose, exposed costume inconsistent with the setting, bodybuilder exaggeration, oversized fantasy weapon, modern haircut, or identical faces across supporting figures;
- no expression unrelated to the narrative beat;
- no random battle damage added for drama.

## Environment exclusions
`NEG_ENVIRONMENT`
- no empty generic fantasy backdrop when a defined location is required;
- no impossible geography, floating architecture, oversized moon, unrelated ruins, or excessive particle effects;
- no background crowd made of repeated or malformed people;
- no environment detail obscuring the subject or overlay-safe areas.

## Material exclusions
`NEG_MATERIALS`
- no plastic skin, metallic cloth, weightless fabric, rubber armour, polished fantasy chrome, inconsistent firelight, transparent solid objects, or texture repetition;
- no gold applied indiscriminately to imply holiness.

## Card-readability exclusions
`NEG_CARD_READABILITY`
- no tiny central figure, cluttered silhouette, equal contrast everywhere, face hidden in shadow, critical detail at trim edge, busy lower overlay zone, or symbol collage.

## Asset-specific additions
### Character portrait
Use `NEG_GLOBAL_CLEAN + NEG_ANATOMY + NEG_STYLE_DRIFT + NEG_THEOLOGY + NEG_CHARACTER + NEG_CARD_READABILITY`.

### Historical environment
Use `NEG_GLOBAL_CLEAN + NEG_ANACHRONISM + NEG_STYLE_DRIFT + NEG_ENVIRONMENT`.

### Artifact or equipment
Add exclusions for incorrect scale, duplicated object parts, unreadable construction, floating object, modern manufacturing, and decorative pseudo-text.

### Group scene
Add exclusions for repeated faces, merged bodies, ambiguous ownership of limbs, inconsistent scale, and missing interaction.

## Review reminder
A generated image can still fail even when none of these defects are obvious. Review must also confirm biblical basis, emotional accuracy, character continuity, composition, symbolism, and production suitability.
