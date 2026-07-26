# Master Compilation Context

This human-readable entry point contains no independent character facts. The normalized canonical source is [`knowledge/characters/legendary/L010_joshua/data/manifest.yaml`](../../knowledge/characters/legendary/L010_joshua/data/manifest.yaml).

Prompt compilation loads these named documents through the manifest:

```yaml
canonical_package: knowledge/characters/legendary/L010_joshua/data/manifest.yaml
knowledge_version: 1.0.0
compiler_inputs:
  identity: character
  scripture: references
  chronology: timeline
  graph_relationships: relationships
  symbolism: symbols
  gameplay: gameplay
  visual_profile: art
  semantic_prompt_profile: prompt
review_and_generation_state: review
```

The compiler resolves `prompt.semantic_components.*.field_refs`; it must not scrape prose from this file. Human documents in `cards/L010_joshua/` are review projections declared by `manifest.human_views.projections`. Change canonical data first, validate it, and update affected human projections in the same commit.
