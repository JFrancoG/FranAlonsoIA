# ADR-0002: Use @Observable + Environment for Dependency Injection

## Status
Accepted

## Context
The app needs a simple, SwiftUI-native way to share repositories and services across the UI, with clean overrides for previews and tests. The project targets iOS 26+, so the Observation framework is available.

## Decision
Use a single app-level container marked with `@Observable` (for example, `AppDependencies`) and inject it at the root using `.environment(...)`. Views and view models access dependencies with `@Environment(AppDependencies.self)`.

## Pros
- SwiftUI-native and aligned with Apple guidance for modern apps.
- Easy to override in previews/tests by providing a different container.
- Avoids third-party DI frameworks and heavy boilerplate.
- Works well with the Observation model for updates.

## Cons
- Environment dependencies are less explicit than initializer injection.
- Missing environment values fail at runtime if not injected.
- Overuse can hide coupling and make refactors harder.

## Why this choice
The app is SwiftUI-first and targets iOS 26+, so the Observation system is available. Using `@Observable` + Environment keeps DI lightweight, testable, and consistent with current SwiftUI patterns.

## Consequences
- Create an `AppDependencies` container holding repositories and services.
- Inject it once in `FranAlonsoIAApp`.
- Use `@Environment(AppDependencies.self)` in views and view models.
- Provide preview/test containers with fakes or stubs.
