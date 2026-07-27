# BibleGameCard Asset Production Realignment Context

## Mission

BibleGameCard is a content-authoring, prompt-engineering, artwork-production,
and asset-packaging repository. Its current objective is:

> Produce a complete, consistent, traceable, and reusable library of biblical
> card assets for every approved target character and card category.

The lifecycle is biblical sources → canonical knowledge → card identity → art
direction → compiled prompt → generated candidates → human review → approved
artwork → card composition → print and digital exports.

## Product boundary

In scope are biblical content, card metadata and provisional text, art
direction, prompt and image-generation records, candidate and approved artwork,
composition, exports, provenance, licensing awareness, validation, and review.

Out of scope unless a later roadmap explicitly authorises them are game clients
and servers, rules or combat engines, accounts, multiplayer, economies,
authentication, generic REST or MCP platforms, dashboards, plugins, distributed
queues, and unrelated cloud infrastructure.

Existing infrastructure is retained, but frozen except where it demonstrably
supports production, validation, traceability, or packaging of card assets.

## Definition of done

A target card is complete only when its canonical knowledge and references,
card identity, visual and prompt profiles, compiled prompt, real generation
record, reviewed and approved primary artwork, composed front, print and digital
exports, provenance, and final validation are complete. Human approval cannot be
inferred from generation or automated validation.

The repository phase is complete when every approved target is explicitly
tracked and complete, all required card backs and exports exist, validation
passes, and no target remains in an unknown state.

## Operating principles

1. Produce assets before expanding infrastructure.
2. Prove the complete Joshua vertical slice before batch scaling.
3. Require human review for biblical appropriateness, stereotypes, anatomy,
   historical details, artifacts, readability, consistency, and audience fit.
4. Automate demonstrated repetition, not hypothetical needs.
5. Trace approved work to card ID, prompt version, provider/model, settings,
   date, seed when available, references, edits, reviewer, and approval record.
6. Keep artistic or theological uncertainty visible as `proposed`,
   `needs_review`, `approved`, or `rejected`.
7. Never claim artwork was generated, reviewed, or approved without real files
   and records.

## Active sequence

1. Confirm the complete target inventory.
2. Define and approve the art bible and card visual specification.
3. Select one practical generation workflow and manifest format.
4. Complete Joshua from knowledge through approved exports.
5. Refine only the repeated friction observed in that slice.
6. Complete a diverse pilot wave, then controlled production waves.
7. Complete supplementary categories, print/digital systems, and final package.

## Pull-request gate

Every proposed change must state which production step it improves, which cards
benefit, what asset or production capability becomes available, what remains
manual, and what is explicitly out of scope. A previous numbered platform
prompt is not sufficient justification.
