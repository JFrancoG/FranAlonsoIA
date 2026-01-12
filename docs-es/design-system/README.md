# Sistema de diseno

## Alcance
Este documento refleja la implementacion actual del sistema de diseno en `FranAlonsoIA/UI/DesignSystem` y las pantallas de preview usadas para validar la identidad visual y los componentes.

## Tipografia
- Familia tipografica: Inter
- Tamanos:
  - Title: 32
  - Subtitle: 24
  - Body: 17
  - Caption: 13
- Accessors:
  - `Font.interTitle`
  - `Font.interSubtitle`
  - `Font.interBody`
  - `Font.interCaption`

## Color
- Colores desde assets:
  - `Color.background` -> `backgroundMain`
  - `Color.backgroundSec` -> `backgroundSecondary`
  - `Color.text` -> `textMain`
  - `Color.textSec` -> `textSecondary`
  - `Color.accentAltColor` -> `accentAlternativeColor`
- `Color.accentColor` se usa como acento principal para acciones.

## Espaciado
- `Spacing.xs` = 4
- `Spacing.sm` = 8
- `Spacing.md` = 16
- `Spacing.lg` = 24
- `Spacing.xl` = 32

## Radio de esquinas
- `CornerRadius.small` = 8
- `CornerRadius.medium` = 16
- `CornerRadius.large` = 24
- `CornerRadius.extraLarge` = 32

## Sombras
- `Shadow.light` = negro 5% de opacidad
- `Shadow.medium` = negro 10% de opacidad
- `Shadow.heavy` = negro 20% de opacidad
- `Shadow.radius` = 8

## Grosores de linea
- `StrokeWidth.thin` = 1
- `StrokeWidth.regular` = 2

## Altura de componentes
- `ComponentHeight.button` = 48
- `ComponentHeight.textField` = 44

## Previews de referencia
- `VisualIdentityView` muestra tipografia y muestras de color.
- `ComponentPreview` muestra ejemplos de boton, card y campo de texto.
