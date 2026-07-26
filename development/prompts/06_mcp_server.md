# Prompt 06 — MCP Server

## Objective

Expose safe, bounded BibleGameCard application services to Codex, Claude Desktop, local LLM clients, and other MCP-capable tools.

## Prerequisites

The Python service layer must be stable. Asset, dependency, and card services should be merged before exposing them.

## Required work

1. Add MCP as an optional Python dependency group.
2. Implement a server adapter that calls application services rather than shelling out independently.
3. Expose a conservative initial tool set:
   - repository health/status;
   - list/show/find characters;
   - validate repository or collector ID;
   - report prompt readiness;
   - compile prompts through the existing service;
   - show asset metadata;
   - calculate dependency impact;
   - validate or export card data.
4. Define strict input/output schemas and stable error responses.
5. Restrict all paths to the repository root and all writes to explicitly authorised service operations.
6. Add configuration for read-only mode, allowed operations, timeouts, and maximum response size.
7. Add tests using an in-process or fake MCP client.
8. Document setup for Claude/Codex-compatible clients without committing credentials or client-specific secrets.

## Forbidden tools

Do not expose:

- arbitrary shell commands;
- arbitrary file read/write;
- Git operations that mutate branches;
- lifecycle approval or release without evidence;
- image generation;
- provider credentials;
- unrestricted prompt execution.

## Acceptance criteria

- MCP calls and CLI calls reach the same services and produce equivalent structured results.
- Read-only mode is the default.
- Path traversal and command-injection tests pass.
- Tool descriptions state lifecycle and authority limitations.
- The server can be started locally with documented commands.
