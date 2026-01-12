# ADR-0002: Usar @Observable + Environment para inyeccion de dependencias

## Estado
Aceptado

## Contexto
La app necesita una forma simple y nativa de SwiftUI para compartir repositorios y servicios entre pantallas, con overrides limpios para previews y tests. El proyecto apunta a iOS 26+, por lo que el framework Observation esta disponible.

## Decision
Usar un contenedor a nivel de app marcado con `@Observable` (por ejemplo, `AppDependencies`) e inyectarlo en la raiz con `.environment(...)`. Las vistas y view models acceden a dependencias con `@Environment(AppDependencies.self)`.

## Pros
- Nativo de SwiftUI y alineado con las recomendaciones actuales de Apple.
- Facil de reemplazar en previews/tests con otro contenedor.
- Evita frameworks de DI de terceros y boilerplate pesado.
- Encaja con el modelo de Observation para actualizaciones.

## Contras
- Dependencias menos explicitas que con inyeccion por inicializador.
- Si falta el Environment, falla en runtime.
- El exceso de Environment puede ocultar acoplamientos.

## Por que esta eleccion
La app es SwiftUI-first y apunta a iOS 26+, por lo que Observation esta disponible. `@Observable` + Environment mantiene la DI ligera, testeable y consistente con patrones actuales de SwiftUI.

## Consecuencias
- Crear un contenedor `AppDependencies` con repositorios y servicios.
- Inyectarlo una vez en `FranAlonsoIAApp`.
- Usar `@Environment(AppDependencies.self)` en vistas y view models.
- Proveer contenedores de preview/test con fakes o stubs.
