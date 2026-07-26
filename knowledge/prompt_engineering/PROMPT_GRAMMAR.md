# Prompt Grammar

## Purpose
Defines the canonical clause order for compiled visual prompts. Stable ordering improves reviewability, model adaptation, and reproducibility.

## Canonical order
1. Asset type and primary subject.
2. Biblical identity and narrative moment.
3. Life stage, appearance, clothing, and continuity traits.
4. Pose, action, expression, and relationships.
5. Signature objects and approved symbols.
6. Environment, period, geography, and atmosphere.
7. Camera, crop, composition, and overlay-safe zones.
8. Lighting and colour intent.
9. Rendering and material language.
10. Card-readability and print-aware quality requirements.
11. Output format and aspect ratio.
12. Exclusions or negative prompt.

## Clause rules
- Begin with concrete subject identity rather than style adjectives.
- Describe visible evidence; do not rely on abstract labels such as “epic” or “holy” alone.
- Put the most important identity and action details early.
- Use one clear instruction per clause.
- Remove synonyms that repeat the same idea.
- Resolve contradictions before generation.
- Keep theological guardrails explicit when the visual request could imply personal magic or unsupported sacred imagery.

## Subject clause
Should identify the asset and dominant subject:

```text
A vertical full-art collectible illustration of Joshua, mature Israelite leader and successor to Moses.
```

Do not use the card title as a substitute for visible identity.

## Narrative clause
Specify one moment or synthesized identity approved by the character package. Do not combine unrelated life events into one image unless the asset is explicitly symbolic.

## Character clause
Use observable traits:
- life stage;
- facial structure;
- hair and beard;
- build and posture;
- garments and materials;
- continuity colours;
- condition such as travel wear, mourning, imprisonment, or battle fatigue.

## Action clause
Use a single readable verb and define object interaction. Replace “powerful pose” with concrete posture, gaze, hand placement, movement, and emotional intent.

## Symbol clause
Name the symbol, meaning, and physical integration. Avoid unexplained floating symbols.

## Environment clause
State period, region, terrain, architecture, weather, time, and meaningful details. Exclude unsupported landmarks.

## Composition clause
Specify:
- portrait, three-quarter, full figure, group, or environmental view;
- camera height and distance;
- subject placement;
- focal hierarchy;
- background simplification;
- crop and overlay-safe needs.

## Lighting clause
Choose one primary lighting family and describe practical or environmental behaviour. Do not stack incompatible moods.

## Rendering clause
Reference approved style modules and material priorities. Franchise names are prohibited as style shortcuts.

## Quality clause
State anatomy, hands, object grip, face clarity, material separation, thumbnail readability, and clean-art requirements.

## Negative clause
Assemble relevant exclusions from the central library. Keep model-specific syntax in the adapter layer.

## Prompt lint checks
A compiler or reviewer should flag:
- unresolved placeholders;
- more than one narrative moment;
- conflicting age, costume, weather, or time descriptions;
- repeated style adjectives;
- unsupported sacred symbols;
- missing hand/object interaction;
- missing aspect ratio;
- embedded typography requests in illustration-only assets;
- direct franchise imitation;
- vague terms not translated into visible instructions.

## Compactness
Prompt length should be sufficient to preserve intent but not inflated. If two clauses express the same visual requirement, retain the more concrete one.
