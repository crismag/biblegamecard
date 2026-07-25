# Production Pipeline

## Stage gates

| Stage | Required output | Exit condition |
|---|---|---|
| 1. Register | Registry entry and collector ID | ID and scope approved |
| 2. Research | Scripture set, notes, uncertainties | Sources traceable |
| 3. Theology | Guardrails and interpretation notes | No unresolved critical concern |
| 4. Gameplay | Role, traits, ability concept | Distinct and biblically grounded |
| 5. Artwork | Appearance, scene, symbols, composition | Visual direction approved |
| 6. Context | Structured generation inputs | Schema-valid package |
| 7. Compile | Model-targeted prompt | Prompt traceable to sources |
| 8. Generate | Candidate artwork | Candidate metadata recorded |
| 9. Review | Content, art, typography, technical QA | Approved candidate selected |
| 10. Layout | Complete card render | Print-safe and readable |
| 11. Release | Versioned export and changelog | Release checklist passed |

## Status vocabulary
`planned`, `researching`, `spec_draft`, `spec_review`, `spec_approved`, `prompt_ready`, `generated`, `asset_review`, `approved`, `released`, `retired`.

## Review gates
A card cannot be official unless all critical checks pass:
- identity and collector ID
- Scripture traceability
- theological integrity
- gameplay clarity
- visual consistency
- typography and card text accuracy
- technical dimensions and export format
- version and provenance metadata

## Prompt compilation
The compiled prompt must be derived from shared style modules, the approved card package, model-specific rendering guidance, and a negative-prompt module. Compiled prompts are outputs and should not become the only place where a creative decision is recorded.

## Revision handling
Minor corrections increment the affected artifact version. Changes to identity, title, central ability, or canonical appearance require card-level review. Released collector IDs remain stable.