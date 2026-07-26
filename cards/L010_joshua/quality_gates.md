# Joshua Quality Gates

| Gate | Required Joshua evidence | Current state | Pass authority |
|---|---|---|---|
| G1 Canonical | Identity, basis, timeline, relationships, legacy; classified claims | `review_requested` | Biblical/theological reviewer |
| G2 Gameplay | Gameplay philosophy/source; Moses/Caleb differentiation; divine-agency safeguards | `review_requested` | Gameplay + theology reviewers |
| G3 Art direction | Art source, symbols, continuity, scene choice, historical/dignity review | `review_requested` | Art + historical + theology reviewers |
| G4 Prompt | Source, compiled prompts, trace map, hashes, selected adapter/settings, lint | `review_requested`; blocked on concrete adapter/resolution before generation | Prompt + theology reviewers |
| G5 Artwork | Immutable candidate provenance, ≥90% evaluation, no critical defect, exact approved hash | `blocked` — no candidate | Theology + art + technical reviewers |
| G6 Card | Approved art, rules/copy, frame/layout version, accessibility and content proofs | `blocked` | Content + gameplay + design reviewers |
| G7 Release | Print spec/preflight/proof, dependency lock, checksums, rights/provenance, registry update | `blocked` | Production approver |

A reviewer records name/identity, UTC timestamp, artifact version/hash, decision, and notes. Changes requested return to the authoritative source and produce a new version; no checkbox in this file grants approval.
