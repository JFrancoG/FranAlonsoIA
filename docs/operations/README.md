# Operations (CI/CD)

## Scope
This document describes the basic CI/CD operations we should run in GitHub Actions for FranAlonsoIA.

## CI (on pull requests and main)
- Checkout repo.
- Select Xcode version (pin for reproducible builds).
- Run SwiftLint with the repo config: `swiftlint`.
- Build DEV scheme on simulator:
  - `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIA-DEV -destination 'platform=iOS Simulator,name=iPad (A16)' build`
- Build PROD scheme on simulator:
  - `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIA-PROD -destination 'platform=iOS Simulator,name=iPad (A16)' build`
- Run unit tests:
  - `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIATests -destination 'platform=iOS Simulator,name=iPad (A16)' test`

## CD (on tags or release branches)
- Build PROD scheme.
- Archive and export (manual or scripted when distribution is defined).
- Upload artifacts if needed (IPA, dSYM, logs).

## Caching (optional)
- Cache SPM and DerivedData to reduce build times.
- Restore cache keys based on Xcode version and Package.resolved.

## Secrets and config
- Do not store Firebase keys in the repo.
- Inject environment config via GitHub Secrets when needed.
- Keep DEV and PROD configuration separated by scheme.

## Logs and artifacts
- Always publish build logs on failure.
- Optionally upload test reports for debugging.
