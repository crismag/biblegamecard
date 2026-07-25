# Collector Numbering and Registry Policy

## Permanent identity
A collector ID identifies a released card concept. It is not a production sequence, filename counter, or artwork version.

## Format
One uppercase category prefix followed by a zero-padded three-digit number, such as `L010`.

## Reserved ranges
- `L001-L099`: Legendary characters
- `E001-E199`: Epic cards
- `R001-R299`: Rare cards
- `C001-C499`: Common cards
- `V001-V099`: Verse or Scripture cards
- `D001-D099`: Doctrine, devotion, or discipleship cards

## Rules
- IDs are reserved in the registry before full specification begins.
- Released IDs are never reassigned.
- A changed title does not automatically change the ID.
- A fundamentally different card concept receives a new ID.
- Remasters retain the ID and increment artwork/layout versions.
- Production priority is tracked separately.
- Gaps are allowed and preferable to reassignment.

## Registry fields
Minimum fields: collector ID, slug, name, title, category, set, status, specification version, and notes.

## Change control
Any range change, prefix addition, ID retirement, or reassignment proposal must be recorded in a decision log and reviewed before merge.
