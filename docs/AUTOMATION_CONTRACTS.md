# Automation Contracts

## 1. Schema validator

### Command
`python tools/validate.py [path]`

### Inputs
- repository path or individual YAML/JSON file
- schemas under `schemas/`

### Behaviour
- validates syntax and schema conformance
- checks collector-ID consistency across package files
- reports duplicate registry IDs
- returns non-zero on validation failure

### Output
Human-readable errors plus optional JSON report.

## 2. New-card package generator

### Command
`python tools/new_card.py --collector-id L000 --name "Name" --title "Title"`

### Behaviour
- copies `templates/card_package/`
- creates a normalized package directory
- substitutes collector ID, name, and title
- refuses to overwrite existing packages
- optionally adds a planned registry record

## 3. Prompt compiler

### Command
`python tools/compile_prompt.py cards/L000_name --target image-model`

### Authoritative inputs
- project art direction
- character, theology, gameplay, artwork, Scripture, and prompt-source specifications
- target-model adapter

### Outputs
- compiled prompt
- negative prompt
- compilation metadata
- source-file hashes or commit reference

The compiler must never modify authoritative specification files.

## 4. Generated-artifact manifest

Each generated asset must record:
- artifact ID and type
- collector ID
- output path
- source package version or commit
- source-file list
- generator/model and version
- prompt or compiler version
- dimensions and format
- generation date
- approval state
- parent artifact when derived

## 5. Idempotence and safety
- Generated commands must be repeatable.
- Existing approved outputs require an explicit replacement flag.
- Validation occurs before compilation.
- Generated outputs remain outside authoritative knowledge directories.
