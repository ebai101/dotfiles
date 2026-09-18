---
name: python-async-api
description: Use when editing asyncio code, async HTTP/API clients, aiohttp, httpx, retries, task groups, queues, cancellation, background tasks, or async database/network I/O.
---

# Python Async and API Clients

## Correctness

- Never block the event loop with synchronous I/O, blocking sleeps, CPU-heavy work, or synchronous subprocess calls in request paths.
- Respect cancellation.
  Never catch, suppress, wrap, log-and-continue, or retry cancellation as an ordinary failure.
- Define ownership, cancellation, completion, and error propagation for every background task, queue, task group, worker, stream, or concurrency primitive.
- Use context managers and reliable cleanup for sessions, responses, files, locks, database connections, and temporary resources.

## Timeouts and retries

- Use deliberate, bounded timeouts for network and external I/O.
- Retry only clearly transient failures; explicitly bound attempts and backoff.
- Account for idempotency before retrying writes.
- Preserve the final exception and causal context.
  Do not turn persistent failures into silent success or unbounded background work.

## Testability and privacy

- Keep clock, randomness, I/O, environment, and transport boundaries injectable or mockable when that materially improves tests.
- Test cancellation, timeout, retry exhaustion, connection cleanup, and concurrency behavior when the change affects them.
- Do not log credentials, authorization headers, private prompts, request bodies, or sensitive response bodies.
