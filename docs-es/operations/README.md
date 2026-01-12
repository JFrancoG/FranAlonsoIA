# Operaciones (CI/CD)

## Alcance
Este documento describe las operaciones basicas de CI/CD que deberiamos ejecutar en GitHub Actions para FranAlonsoIA.

## CI (en pull requests y main)
- Checkout del repo.
- Seleccionar version de Xcode (fijar para builds reproducibles).
- Ejecutar SwiftLint con la configuracion del repo: `swiftlint`.
- Build del esquema DEV en simulador:
  - `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIA-DEV -destination 'platform=iOS Simulator,name=iPad (A16)' build`
- Build del esquema PROD en simulador:
  - `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIA-PROD -destination 'platform=iOS Simulator,name=iPad (A16)' build`
- Ejecutar tests unitarios:
  - `xcodebuild -project FranAlonsoIA.xcodeproj -scheme FranAlonsoIATests -destination 'platform=iOS Simulator,name=iPad (A16)' test`

## CD (en tags o ramas de release)
- Build del esquema PROD.
- Archive y export (manual o script cuando la distribucion este definida).
- Subir artifacts si hace falta (IPA, dSYM, logs).

## Cache (opcional)
- Cachear SPM y DerivedData para reducir tiempos de build.
- Restaurar caches por version de Xcode y Package.resolved.

## Secrets y config
- No guardar claves de Firebase en el repo.
- Inyectar configuracion via GitHub Secrets cuando haga falta.
- Mantener separada la configuracion DEV y PROD por esquema.

## Logs y artifacts
- Publicar logs de build si hay fallo.
- Opcionalmente subir reports de tests para depuracion.
