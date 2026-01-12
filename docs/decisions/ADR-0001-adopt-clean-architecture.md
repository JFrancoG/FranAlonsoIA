# ADR-0001: Adopt Clean Architecture (UI/Domain/Data)

## Status
Accepted

## Context
FranAlonsoIA targets long-term use on iPad and iPhone, with evolving features, cloud sync, and future AI capabilities. The codebase needs to stay maintainable and testable as complexity grows.

## Decision
Adopt Clean Architecture with separate UI, Domain, and Data layers. Domain defines entities and repository protocols; Data implements those protocols and manages persistence/sync; UI stays focused on presentation and user interaction.

## Pros
- Clear separation of concerns and stronger long-term maintainability.
- Easier unit testing of Domain and view models.
- Data sources (SwiftData/CoreData/Firestore) can change without touching UI.
- Enables future AI features without rewriting core flows.

## Cons
- More boilerplate (protocols, mappers, and extra files).
- Extra indirection can slow down small feature work.
- Requires discipline to keep dependency directions clean.

## Why this choice
The project is intended to grow in scope and integrate cloud sync and AI features. Clean Architecture provides the modularity needed to evolve safely while preserving performance and a consistent UI.

## Consequences
- Each new feature should respect UI -> Domain -> Data dependencies.
- Mappers are required between data DTOs and Domain models.
- Architectural boundaries must be maintained in code reviews.
