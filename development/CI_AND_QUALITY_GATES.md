# CI and quality gates

GitHub Actions runs the repository's hybrid Ruby/Python checks on pull requests, pushes to
`main`, and manual dispatches. CI supports Python 3.12 and Ruby 3.4. Action releases are pinned to
specific versions, workflow permissions are read-only, and dependency caches use only dependency
metadata. Generated repository outputs are never cached or committed by CI.

## Required pull-request checks

Run these commands from the repository root unless a command starts with `cd python`. Each row is a
separate CI job or step so that a failure identifies its owning boundary.

| Gate | Local reproduction command |
| --- | --- |
| Python package installation | `python3.12 -m pip install './python[dev]' && (cd /tmp && biblegamecard version)` |
| Python unit, integration, and contract tests | `cd python && python -m pytest` |
| Ruff formatting | `cd python && ruff format --check .` |
| Ruff linting | `cd python && ruff check .` |
| MyPy type checking | `cd python && mypy` |
| Ruby canonical-validator regressions | `bundle exec ruby -Itest test/validate_character_knowledge_test.rb` |
| Ruby Legendary-tool regressions | `bundle exec ruby -Itest test/legendary_prompt_development_tools_test.rb` |
| Ruby prompt-compiler regressions | `bundle exec ruby -Itest test/prompt_compilation_test.rb` |
| Canonical package validation | `bundle exec ruby tools/validate_character_knowledge.rb --all` |
| Deterministic canonical assembly | `bundle exec ruby tools/assemble_character_knowledge.rb --check --all` |
| Legendary prompt-development validation | `bundle exec ruby tools/validate_legendary_prompt_development.rb --all` |
| Readiness-report drift | `bundle exec ruby tools/report_legendary_generation_readiness.rb --check` |
| Generated-prompt drift | `output="$(mktemp -d)"; bundle exec ruby tools/compile_prompts.rb --all --output "$output"; bundle exec ruby tools/compile_prompts.rb --all --output "$output" --check; rm -rf "$output"` |
| Final tracked-file assertion | `test -z "$(git status --porcelain --untracked-files=no)"` |

Install Ruby dependencies with `bundle install` and Python development dependencies with
`python3.12 -m pip install './python[dev]'` before running the matrix. The final assertion is run
after each deterministic group. Check modes must compare in memory and must not rewrite tracked
files; the assertion catches staged and unstaged tracked-file changes if that contract regresses.

## CI decisions and boundaries

- Python packaging, tests, and static analysis are separate jobs. The test suite retains its
  existing unit, integration, and Ruby-adapter contract coverage rather than introducing new
  architecture solely to label tests.
- Ruby behavior tests are retained unchanged. Canonical validation, assembly drift,
  prompt-development/readiness, and prompt compilation each have narrowly named jobs.
- The prompt-compiler regression test intentionally runs both in the Ruby regression suite and
  beside generated-prompt drift: the former protects the Ruby suite as a whole, while the latter
  gives compiler owners direct diagnostics.
- Current tracked prompt artifacts predate the unified compiler output contract. Until those
  artifacts are deliberately migrated by their owning workstream, CI writes a complete compilation
  to a temporary directory and immediately checks it there. This exercises real all-profile drift
  detection without rewriting or adopting generated repository outputs in this milestone.
- Checkouts are clean and shallow by default. No workflow invokes a generator in write mode, uses
  credentials beyond the read-only token, or uploads generated output as repository truth.
- CI does not install image models, use GPUs, require ComfyUI, execute providers, or alter artwork
  and lifecycle records. The existing deterministic Ruby core remains authoritative; Python
  continues to call it through the existing service/adapter boundary.

## Optional checks and known limitations

Documentation link checking is optional and is not automated yet. The documentation contains
repository-relative links as well as operational references whose availability can depend on the
network; adding a noisy network-dependent gate would not be reliable. Review changed links
manually until a repository-aware, pinned checker and an explicit external-link policy are chosen.

Dependency resolution is constrained by the versions in `Gemfile.lock` and the Python package
metadata, but Python development tools do not yet have a repository lock file. The pip cache is an
installation optimization, not an artifact source, and a clean runner still resolves allowed tool
versions. CI validates the single supported runtime pair rather than a compatibility matrix.
