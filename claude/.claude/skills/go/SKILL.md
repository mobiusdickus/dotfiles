---
name: go
description: Go development conventions and tooling. Use when writing, reviewing, or debugging Go code.
---

## Sources
- Google Go Style Guide (google.github.io/styleguide/go)
- Uber Go Style Guide (github.com/uber-go/guide)
- Effective Go (go.dev/doc/effective_go)

## Tooling
- Write code that passes golangci-lint (errcheck, govet, staticcheck, gosimple, unused)
- Code must be race-safe (`go test -race` clean)
- Format with goimports

## Naming
- Short, intention-revealing names; longer in wider scopes
- No stuttering: `user.New()` not `user.NewUser()`; `config.Parse()` not `config.ParseConfig()`
- No `Get` prefix for getters: `func (c *Config) JobName()` not `GetJobName()`
- Packages: short, lowercase, singular, no underscores — never `util`, `common`, `helper`
- Exported error vars: `Err` prefix (`ErrNotFound`); custom error types: `Error` suffix (`NotFoundError`)
- Receiver names: 1–2 letter abbreviation of type, consistent across methods

## Error Handling
- Always handle errors — never `_ = doSomething()` without justification
- Wrap with context: `fmt.Errorf("load config %s: %w", path, err)` — place `%w` at end
- Use `%w` when callers need `errors.Is`/`errors.As`; use `%v` at system boundaries to hide internals
- Never match errors on string content — use sentinel values or custom types
- Handle errors once: either wrap and return, or log and degrade — never both
- Prefer concise context over verbose prefixes: `"new store: %w"` over `"failed to create new store: %w"`

## Interfaces
- Keep small (1–3 methods); compose larger interfaces from smaller ones
- Define at the consumer, not the provider (consumer owns the contract)
- Accept interfaces, return concrete types
- Verify compliance at compile time where useful: `var _ http.Handler = (*Handler)(nil)`
- Don't create interfaces before a real need exists — start with concrete types

## Concurrency
- Prefer `errgroup` over bare `sync.WaitGroup` when collecting errors or needing cancellation
- Context as first parameter, never stored in structs
- Every goroutine must have a known stop condition — no fire-and-forget
- Specify channel direction in function signatures (`<-chan`, `chan<-`)
- No goroutines in `init()`; expose a type with explicit lifecycle (Start/Stop)
- Don't call `t.Fatal` from goroutines other than the test goroutine

## Package Design
- Avoid package-level mutable state — inject dependencies via constructors
- Avoid `init()` — move setup into explicit constructors or `main()`
- Use `internal/` to enforce encapsulation boundaries
- `cmd/` for binaries, `internal/` for private, `pkg/` (optional) for public libraries

## Struct Design
- Make the zero value useful — no required initialization when possible
- Functional options for 3+ optional parameters: `func WithTimeout(d time.Duration) Option`
- Use field names in struct literals; omit zero-value fields
- Use field tags for marshaled structs (`json:"name"`)
- Don't embed types in public structs if it leaks unwanted methods to the API

## Performance (hot path only)
- Pre-allocate slices when size is known: `make([]T, 0, n)`
- `strings.Builder` or `strings.Join` over `+` in loops
- Copy slices/maps at API boundaries to prevent mutation by caller

## Testing
- Table-driven tests as default; use subtests (`t.Run`) for isolation
- Test helpers call `t.Helper()`; use `t.Fatal` for setup failures
- Keep table tests simple — split into separate functions when branching logic appears
- Scope setup to specific tests; avoid package-level `init()` for test data
- Match existing project test style (stdlib assertions, testify, etc.)

## Program Structure
- `os.Exit`/`log.Fatal` only in `main()` — all other functions return errors
- Prefer single `run() error` pattern in main for testability
- Don't panic for control flow — return errors; panic only on unrecoverable invariant violations
