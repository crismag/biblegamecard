# RAG and Provenance Guide

## Purpose
The repository must support reliable retrieval without separating claims from their biblical, historical, gameplay, or design sources.

## Retrieval units
Create one primary RAG package per card. Keep chunks focused and independently understandable.

Recommended chunk types:
- identity and biblical role
- defining events and legacy
- Scripture evidence
- gameplay identity and rationale
- visual identity and symbolism
- prompt-generation context
- review decisions and revisions

## Required metadata
Every indexed chunk must contain:
- `chunk_id`
- `collector_id`
- `character_name`
- `chunk_type`
- `source_files`
- `scripture_references`
- `version`
- `approval_status`
- `last_reviewed`

## Provenance rules
1. Scripture-derived claims must list supporting references.
2. Interpretive claims must be labelled as interpretation, not direct quotation.
3. Historical or cultural claims must identify an external source when introduced.
4. Gameplay and art decisions must point to the decision or specification that authorized them.
5. Generated summaries never replace their authoritative source files.
6. Prototype-image observations must be labelled as visual analysis rather than biblical evidence.

## Chunking rules
- Prefer 250–700 words per narrative chunk.
- Do not combine unrelated characters.
- Repeat collector ID and character name in every chunk.
- Preserve verse references even when the verse text is omitted.
- Keep approved and draft material distinguishable.

## Retrieval priority
1. Approved card specifications
2. Project standards and policies
3. Reviewed theology and Scripture notes
4. Approved decision records
5. Prototype analysis
6. Draft or generated material

## Exclusions
Do not index rejected prompts, superseded generated prompts, unreviewed theological claims, or unrelated sermon material as authoritative card context.
