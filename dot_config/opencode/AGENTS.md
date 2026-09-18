# Engineering Defaults

These are global defaults for development, infrastructure, and homelab work.
Repository-local `AGENTS.md`, README, build configuration, CI, and existing tests override these defaults.

## Before changing anything

- Inspect the repository and working tree before editing.
- Read the nearest `AGENTS.md` and relevant README, build/test configuration, deployment configuration, CI workflows, and existing tests.
- Identify existing conventions, the affected source files, validation commands, and the deployment/source-of-truth mechanism before proposing changes.
- Do not invent repository behavior, APIs, configuration, environment variables, hostnames, ports, services, secrets locations, or deployment topology.
- Explain assumptions and uncertainty when repository evidence is incomplete.

## Change discipline

- Prefer the smallest complete, reviewable change.
- For multi-file, behavioral, public-API, infrastructure, or security-sensitive changes, summarize scope, approach, risks, and validation before editing.
- Preserve public API, configuration, wire-format, operational, and backwards compatibility unless a breaking change is explicitly requested.
- Reuse established repository patterns before adding dependencies, abstractions, frameworks, layers, or configuration systems.
- Do not perform unrelated refactors, formatting, renames, dependency upgrades, or generated-file changes while addressing a focused request.

## Git and operational safety

- Run `git status --short` and inspect relevant diffs before editing.
- Treat pre-existing uncommitted changes as user-owned.
  Do not overwrite, discard, revert, reset, clean, stash, or reformat them.
- Do not commit, push, tag, release, publish, deploy, apply infrastructure, restart services, or change DNS/firewall rules without explicit user approval.
- Never use force-pushes, destructive Git commands, `sudo`, broad deletion, disk operations, or shutdown/reboot commands.
- Never expose or reproduce secrets, tokens, keys, passwords, certificates, private inventories, production data, or sensitive request/response content.

## Validation and reporting

- Run focused validation first, then broader checks when appropriate and allowed.
- Do not claim a command ran, a test passed, or a deployment succeeded unless the result is known.
- For implementation work, report: what changed, files changed, validation run and results, checks not run, and remaining risks or follow-up work.
- For reviews, report findings by severity with file/location references where possible.
  If no issues are found, state residual runtime or validation risk.

## Research

- For current, version-specific, security, compatibility, product, or operational claims, research official or upstream sources before asserting facts.
- Keep research separate from workspace changes unless the user requests both.
- Prefer skills for task-specific workflows: Python, Go, async clients, containers, infrastructure, networking/security, model gateways, or research.
- For substantial research, use the Scout/Research agent before implementing.

<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow.
  Name a file or symbol in the query to read its current line-numbered source.
  If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->
