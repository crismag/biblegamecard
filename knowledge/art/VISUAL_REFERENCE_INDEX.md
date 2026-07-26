# Visual Reference Index

## Purpose
Catalogues approved internal visual references that help maintain character, environment, material, lighting, and composition consistency. This index records what should be learned from a reference without treating the whole image as universally authoritative.

## Policy
- Prefer project-owned or properly licensed references.
- Do not copy protected franchise layouts, characters, logos, or signature compositions.
- A reference may be approved for one quality and rejected for others.
- Reference images are evidence for continuity, not canonical biblical sources.
- Broken, superseded, or rejected references remain traceable through status and notes.

## Status values
- `candidate`
- `reviewed`
- `approved`
- `superseded`
- `rejected`
- `missing_asset`

## Reference record
Each entry should include:

```yaml
reference_id: REF-0001
status: candidate
asset_path: assets/references/example.png
subject: Joshua
asset_version: v1
approved_for:
  - facial_structure
  - expression
not_approved_for:
  - armour
  - background
notes: >-
  Strong determined expression and readable silhouette. Armour is too medieval
  and must not be reused.
source_type: project_generated
rights_status: project_owned
reviewed_by: null
reviewed_on: null
supersedes: null
```

## Review dimensions
A reference may be evaluated for:
- facial continuity;
- age and life stage;
- hair and beard design;
- silhouette;
- clothing or armour;
- signature objects;
- environment;
- architecture;
- material rendering;
- lighting;
- colour palette;
- composition;
- emotional tone;
- card-size readability;
- frame or layout integration.

## Initial index
No image is considered approved merely because it exists in ChatGPT, local storage, or a repository folder. Existing prototypes should be added only after asset transfer, rights confirmation, and dimension-specific review.

| Reference ID | Subject | Asset | Status | Approved qualities | Notes |
|---|---|---|---|---|---|
| — | — | — | — | — | Awaiting first reviewed project reference. |

## Character continuity use
When compiling a recurring character prompt, the character package should list approved reference IDs and the exact traits to preserve. Prompt wording should describe those traits explicitly when the generation model cannot consume reference images.

## Supersession
A stronger reference may supersede an earlier one. Do not delete the old record; mark it `superseded`, link the replacement ID, and explain what changed.
