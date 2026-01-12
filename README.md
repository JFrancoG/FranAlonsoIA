# 💇‍♂️ FranAlonsoIA

**Professional management app for hair salons**, designed for Fran Alonso and his team. Built for daily use on iPad by hairdressers and on iPhone for business management tasks. Focused on speed, simplicity and powerful features – everything Fran needs at his fingertips.

## 🎯 Vision

A modern, fluid and robust app that enables complete management of a salon like Fran Alonso’s: services, products, stock, clients and sales – all tightly integrated, accessible and easy to use. Built with a forward-thinking architecture ready to integrate AI capabilities in the future.

---

## 🧑‍💼 Main Use Cases

- 📌 Provide services to overlapping clients during the workday
- 👩‍🦰 Client file with personal data, consent signature, hair color history or recurring details
- 🧴 Product management for internal use during services or direct sales to clients
- 📦 Real-time stock control linked to product usage and sales
- 💳 Sales registration with option to print invoice or receipt
- 📈 Monthly income/expenses overview, with occasional access to older data
- 🧾 Appointment management is done with another app for now, but integration is planned

---

## 📱 Target Devices

- **iPad (main usage):** for hairdressers during services
- **iPhone (admin usage):** for inventory, pricing, reports, etc.
- All devices are under 2 years old

---

## 🧩 MVP Features (v1.0)

- Full client CRUD with consent form and custom fields
- Product management (usage and sales)
- Stock tracking and adjustments
- Services registration
- Sales with receipt/invoice
- Monthly overview of business metrics

---

## 🔗 Core Entities (tightly connected)

- `Client`
- `Product`
- `Service`
- `StockMovement`
- `Sale`
- `ConsentForm`
- *(Future: `Appointment`)*

---

## 🛠️ Architecture and Tech Stack

- **iPad-first UI design**, with Split View, multitouch, and smooth navigation
- **Swift 6** with strict concurrency (`@MainActor`, `async/await`, value types)
- **SwiftUI (iOS 26+)**, adaptive UI
- **Clean Architecture**: clear separation of `UI / Domain / Data`
- **Local persistence**: SwiftData
- **Cloud sync**: Firestore (Firebase) via decoupled repositories
- **Minimal and intuitive UI**, inspired by Craft, Notion and Things
- **Dark mode and accessibility** from day one

---

## 🧠 Built for Future AI

- Architecture designed to support smart suggestions, OCR, sales analysis, etc.
- Modular foundation to integrate custom ML models or external APIs

---

## 🔧 Development and Collaboration

- 📁 Modular structure (`UI`, `Domain`, `Data`, `Core`, `Resources`, etc.)
- 🧪 CI/CD and test-ready from the start
- 📋 GitHub Issues and Projects for task tracking
- ✅ Clean code and pull request practices
- 🖼️ Design references in Figma/Miro
- 🧾 Living README and technical documentation

---

## 📌 Notes

- Appointments are managed in a separate app for now, but this app is prepared to integrate them later.
- Built as a professional, scalable, and maintainable long-term solution.

---

**FranAlonsoIA** is more than a hair salon app — it’s the definitive digital tool for professionals who want to focus on their clients without losing business control.

---

## 🇪🇸 Versión en Español

# 💇‍♂️ FranAlonsoIA

App de gestión profesional para peluquerías, diseñada para Fran Alonso y su equipo. Pensada para el uso diario en iPad por los peluqueros, y en iPhone para tareas administrativas. La app está centrada en la eficiencia, la simplicidad y la potencia, permitiendo a Fran tener todo lo que necesita al alcance de un toque.

## 🎯 Visión

Una app moderna, fluida y robusta que permite gestionar de forma integral el día a día de una peluquería como la de Fran Alonso: servicios, productos, stock, clientes y ventas, todo conectado, accesible y fácil de usar, con una base tecnológica pensada para crecer e incorporar IA en el futuro.

---

## 🧑‍💼 Casos de uso principales

- 📌 Prestación de servicios a clientes con posibilidad de solape entre citas.
- 👩‍🦰 Ficha de cliente con datos personales, firma de consentimiento, historial de coloración u otros detalles habituales.
- 🧴 Gestión de productos: uso interno en servicios y venta a clientes.
- 📦 Control de stock actualizado al usar productos o registrar ventas.
- 💳 Registro de ventas con opción de ticket o factura.
- 📈 Consulta mensual de ingresos y gastos, y ocasionalmente históricos anteriores.
- 🧾 Preparado para futura gestión de citas directamente en la app.

---

## 📱 Dispositivos objetivo

- **iPad (uso principal):** para el trabajo diario de los peluqueros (servicios, fichas, productos, ventas).
- **iPhone (uso administrativo):** para tareas como consultar inventario, modificar precios, ver históricos, etc.
- Todos los dispositivos tienen menos de 2 años.

---

## 🧩 Funcionalidades MVP (v1.0)

- CRUD de clientes con ficha completa y firma de consentimiento.
- Gestión de productos (uso en servicios y venta directa).
- Gestión de stock.
- Registro de servicios prestados.
- Registro de ventas (producto/servicio, ticket/factura).
- Vista mensual de ingresos/gastos.

---

## 🔗 Entidades principales (fuertemente interconectadas)

- `Client`
- `Product`
- `Service`
- `StockMovement`
- `Sale`
- `ConsentForm`
- (Futuro: `Appointment`)

---

## 🛠️ Arquitectura y stack técnico

- **Diseño first-iPad**, con soporte completo para multitouch, Split View y navegación fluida.
- **Swift 6**, concurrencia estricta (`@MainActor`, `async/await`, tipos seguros).
- **SwiftUI (iOS 26+)**, UI moderna y adaptativa.
- **Clean Architecture** (separación clara de UI / Domain / Data).
- **Persistencia local**: SwiftData.
- **Sincronización Cloud**: Firebase Firestore desacoplado por repositorios.
- **Diseño minimalista e intuitivo**, inspirado en Craft, Notion y Things.
- **Modo oscuro y accesibilidad** incluidos desde el inicio.

---

## 🧠 Preparado para IA

- Arquitectura abierta a IA (recomendaciones, OCR, sugerencias de productos/servicios, análisis de ventas, etc.)
- Módulos desacoplados para integración futura con modelos o APIs inteligentes.

---

## 🔧 Desarrollo y colaboración

- 📁 Modularidad desde el primer día (`UI`, `Domain`, `Data`, `Core`, `Resources`, etc.)
- 🧪 Tests y CI/CD preparados.
- 📋 Issues y Projects en GitHub para organización ágil.
- ✅ Normas de buenas prácticas para PRs y Code Reviews.
- 🖼️ Diseño referenciado en Figma o Miro (por confirmar).
- 🧾 README vivo, actualizado con la evolución del proyecto.

---

## 📌 Notas adicionales

- Las citas de clientes se gestionan actualmente con otra app, pero se dejará preparada la infraestructura para integrarlas en futuras versiones.
- La app se construye como una solución profesional, mantenible y escalable.

---

**FranAlonsoIA** es más que una app de peluquería: es la herramienta definitiva de gestión para profesionales que quieren centrarse en sus clientes, sin perder el control del negocio.
