# Prompt 10 — Provider Plugin Contracts

## Objective

Define stable execution-provider interfaces for future ComfyUI and cloud image integrations without executing image generation.

## Required work

1. Audit existing OpenAI, FLUX, and SDXL prompt adapters and generation-manifest contracts.
2. Define Python provider-neutral request/result models for:
   - compiled prompt directory reference;
   - model and workflow identity;
   - seed and dimensions;
   - candidate count;
   - optional reference assets;
   - provider job ID;
   - output metadata and checksums;
   - failure diagnostics.
3. Define a provider interface with capability discovery, request validation, submission, status retrieval, cancellation when supported, and result collection.
4. Implement a fake/in-memory provider for tests.
5. Implement a dry-run provider that validates and prints the exact request without network, GPU, or filesystem image output.
6. Add a plugin registry and configuration model.
7. Add contract tests proving providers cannot mutate compiled prompt artifacts or canonical source.
8. Document the future ComfyUI boundary and where workflow JSON should live.

## Constraints

- Do not install ComfyUI.
- Do not download models.
- Do not call OpenAI or any image API.
- Do not generate images.
- Do not implement automatic approval.
- Provider request creation must not change lifecycle state.

## Acceptance criteria

- Fake and dry-run providers satisfy the same tested interface.
- Requests are validated against repository contracts.
- Compiled prompt directories are treated as immutable inputs.
- Result models support future provenance and checksum recording.
- The design can support ComfyUI without making it a core package dependency.
