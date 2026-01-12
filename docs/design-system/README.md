# Design System

## Scope
This document reflects the current design system implementation in `FranAlonsoIA/UI/DesignSystem` and the preview screens used to validate visual identity and components.

## Typography
- Font family: Inter
- Sizes:
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
- Asset-backed colors:
  - `Color.background` -> `backgroundMain`
  - `Color.backgroundSec` -> `backgroundSecondary`
  - `Color.text` -> `textMain`
  - `Color.textSec` -> `textSecondary`
  - `Color.accentAltColor` -> `accentAlternativeColor`
- `Color.accentColor` is used as the primary accent for actions.

## Spacing
- `Spacing.xs` = 4
- `Spacing.sm` = 8
- `Spacing.md` = 16
- `Spacing.lg` = 24
- `Spacing.xl` = 32

## Corner Radius
- `CornerRadius.small` = 8
- `CornerRadius.medium` = 16
- `CornerRadius.large` = 24
- `CornerRadius.extraLarge` = 32

## Shadows
- `Shadow.light` = black 5% opacity
- `Shadow.medium` = black 10% opacity
- `Shadow.heavy` = black 20% opacity
- `Shadow.radius` = 8

## Stroke Widths
- `StrokeWidth.thin` = 1
- `StrokeWidth.regular` = 2

## Component Heights
- `ComponentHeight.button` = 48
- `ComponentHeight.textField` = 44

## Reference Previews
- `VisualIdentityView` shows typography and color swatches.
- `ComponentPreview` shows button, card, and text field examples.
