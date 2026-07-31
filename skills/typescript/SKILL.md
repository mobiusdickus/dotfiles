---
name: typescript
description: TypeScript/Node development conventions and tooling. Use when writing, reviewing, or debugging TypeScript code.
---

## Environment
- Node 24+ (LTS), TypeScript 5.x+ (6.0 defaults strict, ESM, ES2025)
- pnpm preferred, npm acceptable
- ESM modules (`"type": "module"` in package.json)
- tsconfig: strict mode enabled, explicit `types` array, explicit `rootDir`

## Type System
- `interface` for object shapes (better compiler perf, cached type relations)
- `type` for unions, intersections, primitives, mapped/utility types
- Discriminated unions over optional properties
- `unknown` over `any` — narrow before use
- `as const satisfies` for type-safe constants
- No enums — use literal unions or const assertion objects
- `import type` for type-only imports
- Explicit return types on public APIs, infer internally
- Narrow types, but avoid excessively large unions (quadratic compile cost)

## Functions
- Single object arg for 2+ parameters
- Pure and stateless where possible
- Single responsibility

## Naming (community conventions)
- camelCase: variables, functions
- PascalCase: types, interfaces, React components
- UPPER_SNAKE: constants
- Booleans prefixed: `is`, `has`, `should`, `can`
- Acronyms as words: `userId` not `userID`, `ApiUrl` not `APIURL`
- Generics: single letter (`T`, `K`) for simple cases, descriptive `T`-prefixed (`TRequest`, `TResponse`) for 3+ params or unclear context
- Named exports preferred (except where frameworks require default exports)

## Style
- ESLint + typescript-eslint (strict-type-checked config)
- Prettier or Biome for formatting
- `@ts-expect-error` with description over `@ts-ignore`
- Comments explain "why", not "what" — prefer expressive naming
- TSDoc (`/** */`) for public APIs, library code, and config types
