# Architecture

## Overview
FranAlonsoIA follows a Clean Architecture approach with clear separation between UI, Domain, and Data. The app is iPad-first, built with Swift 6 and SwiftUI for iOS 26+, and designed to stay fast and maintainable as it grows.

## Layering
- UI: SwiftUI screens, view models, design system, and previews.
- Domain: Core entities and business rules, plus repository protocols and use cases.
- Data: Repository implementations, data sources, DTOs, and mappers.
- Core/Helpers/Support/Resources: shared infrastructure and configuration assets.

## Tech Stack Highlights
- Swift 6 with strict concurrency (`@MainActor`, `async/await`).
- SwiftUI with adaptive layouts for iPad and iPhone (iOS 26+).
- Local persistence with SwiftData.
- Cloud sync with Firestore via decoupled repositories.

## Data Flow (Typical)
1. A SwiftUI view triggers actions in its view model.
2. The view model calls a Domain use case.
3. The use case depends on repository protocols.
4. The Data layer implements those protocols and talks to local/remote sources.
5. Mappers translate between DTOs and Domain models.

## Future-Ready Design
The modular structure keeps UI changes isolated and allows future AI features (suggestions, OCR, analytics) to plug into the Domain/Data layers without rewriting UI flows.
