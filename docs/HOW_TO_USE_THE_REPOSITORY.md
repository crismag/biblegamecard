# How to Use the BibleGameCard Repository

## 1. Understand what runs where

BibleGameCard currently validates knowledge and compiles deterministic image-generation inputs. It does not generate pixels by itself.

```text
BibleGameCard repository
  -> validates source knowledge
  -> compiles provider-neutral prompts
  -> applies OpenAI, FLUX, or SDXL prompt adapters
  -> writes manifests, traceability, and regeneration metadata

External runtime
  -> ComfyUI/local model or cloud image API
  -> generates image candidates
```

Keep the existing BibleGameCard repository as the product source. Install ComfyUI separately and connect it through a manual feasibility workflow or a future provider adapter.

## 2. Start with the type of work

| Goal | Primary location | Typical output |
|---|---|---|
| Research a biblical character | `knowledge/` | canonical YAML or Markdown |
| Prepare first-pass art direction | `knowledge/prompt_development/` | generation-ready draft profile |
| Validate canonical knowledge | `tools/validate_character_knowledge.rb` | validation result |
| Validate prompt readiness | `tools/validate_legendary_prompt_development.rb` | readiness result |
| Compile prompts | `tools/compile_prompts.rb` | `generated/prompts/` artifacts |
| Generate local artwork | external ComfyUI runtime | unapproved candidates |
| Review artwork | review evidence and card package | decision tied to exact candidate |
| Render cards | future renderer | print/web/mobile assets |
| Export game content | future compiler | game-ready JSON |

Do not edit a rendered card or generated prompt when the decision belongs in canonical knowledge.

## 3. Find the authoritative source

Use the collector ID as the stable identity. For Joshua:

```text
L010 — Joshua

registry/legendary_cards.json
knowledge/characters/legendary/L010_joshua/
knowledge/prompt_development/legendary/L010_joshua.yaml
cards/L010_joshua/
generated/prompts/L010-JOSHUA-ART-01/
```

The same character appears in several layers for different purposes. Confirm which layer owns the decision being changed.

## 4. Choose the authoring path

### Lightweight prompt-development profile

Use `knowledge/prompt_development/legendary/` to make a character ready for draft generation before a full canonical package exists.

```text
AUTHORING_DRAFT
  -> PROMPT_SOURCE_COMPLETE
  -> GENERATION_READY_DRAFT
```

This state does not imply final theology, history, gameplay, artwork, or production approval.

### Full canonical package

Use `knowledge/characters/legendary/<package>/data/` for production-grade knowledge, relationships, timelines, gameplay, art, prompt, review, and version history.

Full packages must pass stricter schema, graph, traceability, deterministic assembly, and review-gate checks.

## 5. Work on a focused branch

```bash
git checkout main
git pull --ff-only
git checkout -b feature/<focused-change>
```

For a ComfyUI experiment, use a branch in this repository rather than another BibleGameCard repository:

```bash
git checkout -b spike/comfyui-joshua-generation
```

ComfyUI itself should live in a separate directory and should not be copied into this repository.

## 6. Validate source layers

Prompt-development profiles:

```bash
bundle exec ruby tools/validate_legendary_prompt_development.rb --all
bundle exec ruby tools/report_legendary_generation_readiness.rb --check
bundle exec ruby -Itest test/legendary_prompt_development_tools_test.rb
```

Canonical packages:

```bash
bundle exec ruby tools/validate_character_knowledge.rb --all
bundle exec ruby tools/assemble_character_knowledge.rb --check --all
bundle exec ruby -Itest test/validate_character_knowledge_test.rb
```

Structural validity and generation readiness are separate. A valid package may still be blocked from artwork generation.

## 7. Compile prompts

Compile Joshua for FLUX/local generation:

```bash
ruby tools/compile_prompts.rb \
  --profile knowledge/prompt_development/legendary/L010_joshua.yaml \
  --adapter flux \
  --model local-flux \
  --seed 0 \
  --resolution 768x1152
```

Compile all available profiles:

```bash
ruby tools/compile_prompts.rb --all --adapter flux
```

Detect stale or edited generated output:

```bash
ruby tools/compile_prompts.rb \
  --profile knowledge/prompt_development/legendary/L010_joshua.yaml \
  --adapter flux \
  --model local-flux \
  --seed 0 \
  --resolution 768x1152 \
  --check
```

The compiled directory contains provider-neutral prompt data, adapted positive and negative prompts, a generation manifest, traceability, and regeneration metadata. Compilation does not call ComfyUI.

## 8. Use ComfyUI manually for the first feasibility test

Until a provider adapter exists:

1. install and run ComfyUI outside this repository;
2. load a core-node text-to-image workflow;
3. use a model that fits the target workstation and licence needs;
4. copy `prompt.txt` and `negative_prompt.txt` from the compiled Joshua directory;
5. use the manifest seed and dimensions, or clearly record any test overrides;
6. save the workflow in API format;
7. record model, workflow, seed, dimensions, source commit, prompt digest, and output checksum;
8. keep the image in an unapproved candidate state.

See [Local Image-Generation Integration](LOCAL_IMAGE_GENERATION.md).

## 9. Regenerate outputs through tools

When source changes:

```text
edit source
  -> validate
  -> regenerate owned outputs
  -> run drift check
  -> inspect diff
```

Never repair generated drift by editing generated files manually.

## 10. Review by authority layer

Before committing, check:

- Were canonical changes intentional?
- Did generated files change only because sources or explicit settings changed?
- Did a tracker claim a stronger state than the evidence supports?
- Did provider-specific language leak into canonical data?
- Are unresolved questions still visible?
- Are human approvals still pending where required?
- Were model weights, secrets, caches, or uncontrolled candidate images accidentally added?

## 11. Working with ChatGPT, Codex, Claude, or local LLMs

AI agents may inspect the repository, compile prompts, prepare generation requests, invoke a narrow provider adapter, and summarise candidate metadata.

They should not receive authority to silently rewrite canonical facts, approve their own artwork, generate unbounded candidates, or commit secrets and model files.

A local or hosted text LLM is optional for conversational operation. An image model remains necessary to create the actual artwork.

## 12. Current practical exercise

The most useful exercise is now a Joshua image-generation vertical slice:

1. validate L010 sources;
2. compile with the FLUX adapter;
3. verify drift checking;
4. generate one generic ComfyUI test image;
5. export the working API workflow;
6. generate several unapproved Joshua candidates;
7. record full provenance;
8. review the exact candidate checksums;
9. document failures and required integration changes;
10. only then implement the permanent ComfyUI provider adapter.

This exercise proves that the repository output is operationally usable without confusing prompt compilation with image generation or approval.