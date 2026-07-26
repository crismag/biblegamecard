# Prompt 09 — CI and Quality Gates

## Objective

Create clear CI coverage for the hybrid Ruby/Python architecture and deterministic repository outputs.

## Required work

1. Audit existing GitHub Actions and avoid duplicating working jobs.
2. Add or refactor workflows so failures are separated into:
   - Ruby tests and canonical validation;
   - prompt-development validation and readiness drift;
   - prompt-compiler tests and generated-prompt drift;
   - Python package installation;
   - Python unit, integration, and contract tests;
   - lint, formatting, and type checks;
   - deterministic generated-output checks;
   - documentation link checks where reliable.
3. Cache dependencies safely without caching generated repository outputs as truth.
4. Pin action versions and document supported Ruby/Python versions.
5. Add a local aggregate command or documented command matrix matching CI.
6. Ensure check modes do not modify the working tree.
7. Add a final clean-tree assertion after deterministic checks.
8. Document required versus optional checks for pull requests.

## Constraints

- Do not add image model downloads or GPU jobs.
- Do not require ComfyUI for CI.
- Do not hide individual failures behind one opaque script.
- Do not automatically commit regenerated files from CI.

## Acceptance criteria

- CI runs on a clean checkout.
- Each job has a narrow name and useful diagnostics.
- Generated drift is detected without writing.
- Python and Ruby contract compatibility is tested.
- Workflow permissions follow least privilege.
- Documentation lists exact local reproduction commands.
