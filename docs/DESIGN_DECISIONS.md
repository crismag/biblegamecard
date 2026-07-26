# Design Decisions

This document records durable design rationale for the BibleGameCard visual and prompt-production system. Operational changes belong in revision logs; this file explains why foundational choices exist.

## DD-001 — Canonical knowledge precedes artwork
Artwork is derived from reviewed character knowledge rather than invented independently. This protects biblical identity, improves consistency, and allows the same character package to support cards, stories, games, devotionals, and future media.

## DD-002 — Semi-realistic painterly biblical realism
The target style is cinematic, semi-realistic, and painterly rather than photographic, cartoon, anime, or exaggerated high fantasy. It supports emotional warmth, premium collectibility, historical atmosphere, and controlled creative interpretation without presenting imagined portraits as documentary fact.

## DD-003 — Premium fantasy presentation without franchise imitation
Cards may use dramatic lighting, layered depth, ornamental framing, and high production value, but must not imitate protected characters, layouts, logos, or signature visual systems from existing card-game franchises.

## DD-004 — Biblical respect outranks spectacle
Drama is allowed only when it clarifies calling, conflict, courage, worship, deliverance, judgment, or legacy. Spectacle must never trivialize Scripture, depict God as a controllable effect, or turn miracles into a character's personal magic.

## DD-005 — Prompts are compiled artifacts
Final generation prompts are assembled from structured character data, approved style modules, composition rules, environment guidance, quality clauses, and exclusions. They are not canonical source files and should not be manually patched without updating their source inputs.

## DD-006 — Character continuity is intentional, not accidental
Approved facial structure, age range, silhouette, clothing language, signature objects, and colour tendencies are tracked per character. Later depictions may vary by life stage or scene but must remain recognizably connected.

## DD-007 — Illustration and card layout are separate layers
Primary art should remain useful without embedded typography, logos, rarity labels, borders, or rules text. Card frames and overlays are assembled later so artwork can be reused across print, web, mobile, story, and promotional outputs.

## DD-008 — Small-format readability governs composition
Trading-card art must communicate at thumbnail size. One dominant subject, strong silhouette, controlled values, limited focal symbols, and protected overlay zones take priority over excessive environmental detail.

## DD-009 — Historical plausibility with documented uncertainty
Clothing, architecture, tools, weapons, materials, and landscapes should fit the broad historical and geographic setting. Where evidence is uncertain, the project chooses a plausible interpretation and records it rather than presenting speculation as certainty.

## DD-010 — Symbols require theological context
Symbols are selected because they connect to a character, event, covenant, virtue, calling, or scriptural theme. Decorative symbolism should not imply unsupported doctrine, merge unrelated traditions, or replace the actual biblical narrative.

## DD-011 — Model adaptation does not change art direction
Different image models may require different syntax, weighting, or prompt length. Model-specific adapters may change wording but must preserve the same approved visual intent and content constraints.

## DD-012 — Human approval remains mandatory
Automated generation and review may accelerate production, but no artwork becomes official without human review for biblical accuracy, visual quality, continuity, anatomy, print suitability, and unintended symbolism.
