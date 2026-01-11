# Repository Guidelines

## Project Structure & Module Organization
- `FranAlonsoIA/` contains the app source. Major areas are `Core/`, `Domain/`, `Data/`, `UI/`, `Helpers/`, `Support/`, `Resources/`, and `Preview Content/`.
- `FranAlonsoIAApp.swift` is the app entry point.
- Tests live in `FranAlonsoIATests/` (unit) and `FranAlonsoIAUITests/` (UI).
- Xcode metadata is in `FranAlonsoIA.xcodeproj/`, with shared schemes for DEV and PROD.

## Build, Test, and Development Commands
- Open in Xcode: `open FranAlonsoIA.xcodeproj`.
- Build (DEV): `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIA-DEV -destination 'platform=iOS Simulator,name=iPad (A16)' build`.
- Build (PROD): `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIA-PROD -destination 'platform=iOS Simulator,name=iPad (A16)' build`.
- Run tests: `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIATests -destination 'platform=iOS Simulator,name=iPad (A16)' test`.
- Optional test plans: `-testPlan FranAlonsoIA-DEV` or `-testPlan FranAlonsoIA-PROD`.

## Coding Style & Naming Conventions
- Swift 6 with SwiftUI; use 4-space indentation and avoid tabs.
- Naming: `UpperCamelCase` for types, `lowerCamelCase` for values, `test*` for XCTest methods.
- SwiftLint is configured in `.swiftlint.yml`. Run `swiftlint` before committing; the config flags `DispatchQueue.sync` usage and prefers `first(where:)` over `filter().first`.

## Testing Guidelines
- XCTest is the default framework for unit and UI tests.
- Keep test files in the matching test targets and name them `SomethingTests.swift` or `SomethingUITests.swift`.
- Cover new behavior with unit tests; add UI tests for new flows or screens when practical.

## Commit & Pull Request Guidelines
- Use short, descriptive commit messages in English only. Example: `Add client filters`.
- PRs must be written in English and should include a brief description, test notes, and relevant screenshots for UI changes.
- Link related issues when applicable.

## Documentation
- Write new docs in `docs/` (English).
- Mirror each document in `docs/es/` with a Spanish translation.

## Configuration Tips
- Firebase configuration lives at `FranAlonsoIA/Resources/Info/GoogleService-Info.plist`. Use the correct project keys for the target environment.
- The `DEVELOP` build flag selects the Firestore environment in `FranAlonsoIA/Core/FSEnvironment.swift`; prefer the `FranAlonsoIA-DEV` scheme for development.
