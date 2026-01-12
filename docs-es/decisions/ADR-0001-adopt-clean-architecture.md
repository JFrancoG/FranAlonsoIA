# ADR-0001: Adoptar Clean Architecture (UI/Domain/Data)

## Estado
Aceptado

## Contexto
FranAlonsoIA está pensada para un uso a largo plazo en iPad y iPhone, con funcionalidades en evolución, sincronización en la nube y capacidades futuras de IA. El código debe mantenerse estable y testeable a medida que crece la complejidad.

## Decisión
Adoptar Clean Architecture con capas separadas de UI, Domain y Data. Domain define entidades y protocolos de repositorio; Data implementa esos protocolos y gestiona la persistencia/sincronización; UI se centra en presentación e interacción.

## Pros
- Separación clara de responsabilidades y mantenibilidad a largo plazo.
- Facilita tests unitarios en Domain y view models.
- Las fuentes de datos (SwiftData/CoreData/Firestore) pueden cambiar sin tocar la UI.
- Permite futuras funciones de IA sin reescribir flujos centrales.

## Contras
- Más boilerplate (protocolos, mappers y archivos extra).
- Mayor indirección puede ralentizar trabajo en features pequeñas.
- Requiere disciplina para mantener la dirección de dependencias limpia.

## Por qué esta elección
El proyecto crecerá en alcance y deberá integrar sincronización en la nube y funcionalidades de IA. Clean Architecture aporta la modularidad necesaria para evolucionar con seguridad manteniendo rendimiento y una UI consistente.

## Consecuencias
- Cada feature nueva debe respetar dependencias UI -> Domain -> Data.
- Se requieren mappers entre DTOs de datos y modelos de Domain.
- Los límites arquitectónicos deben cuidarse en las revisiones.
