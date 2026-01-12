# Arquitectura

## Visión general
FranAlonsoIA sigue un enfoque de Clean Architecture con una separación clara entre UI, Domain y Data. La app es iPad-first, está construida con Swift 6 y SwiftUI para iOS 26+, y está pensada para mantenerse rápida y mantenible a medida que crece.

## Capas
- UI: pantallas SwiftUI, view models, design system y previews.
- Domain: entidades centrales y reglas de negocio, además de protocolos de repositorio y casos de uso.
- Data: implementaciones de repositorios, fuentes de datos, DTOs y mappers.
- Core/Helpers/Support/Resources: infraestructura compartida y activos de configuración.

## Puntos clave del stack
- Swift 6 con concurrencia estricta (`@MainActor`, `async/await`).
- SwiftUI con layouts adaptativos para iPad y iPhone (iOS 26+).
- Persistencia local con SwiftData.
- Sincronización en la nube con Firestore mediante repositorios desacoplados.

## Flujo de datos (típico)
1. Una vista SwiftUI dispara acciones en su view model.
2. El view model llama a un caso de uso del Domain.
3. El caso de uso depende de protocolos de repositorio.
4. La capa Data implementa esos protocolos y habla con fuentes locales/remotas.
5. Los mappers traducen entre DTOs y modelos de Domain.

## Diseño preparado para el futuro
La estructura modular mantiene los cambios de UI aislados y permite integrar futuras funciones de IA (sugerencias, OCR, analítica) en las capas Domain/Data sin reescribir los flujos de UI.
