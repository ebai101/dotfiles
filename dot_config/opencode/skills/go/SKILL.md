---
name: go
description: Use when editing Go production code, Go packages, exported APIs, error handling, contexts, goroutines, synchronization, dependencies, or Go build configuration.
---

# Go Engineering

## Inspect first

- Read `go.mod`, `go.sum`, `go.work` when present, package documentation, existing tests, `.golangci.*`, and CI workflows.
- Follow the repository's established package boundaries and dependency choices.

## Implementation

- Run `gofmt` on changed Go files.
- Prefer simple control flow, focused interfaces, standard-library facilities, and safe zero values where practical.
- Return errors for expected runtime failures; do not panic.
- Wrap operational errors with context using `%w` when callers need the cause.
- Use `errors.Is` and `errors.As` for semantic handling of wrapped errors.
- Check meaningful I/O, cleanup, close, encoder, write, and security-sensitive errors.
- Pass `context.Context` first to request-scoped, I/O, network, database, or long-running functions.
  Do not store it in structs or pass `nil`.
- Honor cancellation and deadlines.
  Define ownership, completion, error propagation, and synchronization for every goroutine or shared mutable resource.
- Preserve public API and wire compatibility unless explicitly approved.
- Do not run `go mod tidy` or make dependency changes unless required by the task.
