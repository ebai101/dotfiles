---
name: python
description: Use when editing Python source, Python package configuration, public APIs, typing, exception behavior, or Python tests.
---

# Python Engineering

## Inspect first

- Read `pyproject.toml`, relevant package configuration, CI workflows, existing source patterns, formatter/linter configuration, and nearby tests.
- Target only Python versions supported by project metadata or CI.
- Reuse existing dependencies and project abstractions before adding packages.

## Implementation

- Add explicit type annotations for public functions, exported classes, non-obvious module boundaries, and values where the project convention expects them.
- Avoid mutable defaults and hidden global state.
- Preserve public APIs, configuration keys, serialized data, exception behavior, and compatibility unless the task explicitly authorizes a breaking change.
- Raise precise errors.
  Preserve causal context with `raise NewError(...) from exc` where appropriate.
- Follow the repository's import ordering, formatting, linting, and docstring rules.

## Tests

- Add or update focused tests for behavior changes.
- Prefer deterministic tests with injected dependencies, clocks, randomness, I/O, or environment boundaries where practical.
- Run the narrowest relevant test command first, then configured broader checks when appropriate.
