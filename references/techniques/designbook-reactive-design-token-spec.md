# DesignBook — Reactive Design Token Architecture Spec

**Author:** @meodai
**Source:** Original specification / local note
**Type:** Architecture spec for reactive design tokens

## What It Is

DesignBook is a TypeScript specification for a reactive design-token system with:

- nested scopes
- reference tokens
- function tokens
- dependency tracking
- multiple render targets

It treats a design system as a graph of relationships instead of a flat list of final values. Colors are not just stored; they can be derived, inherited, re-rendered, and recomputed when upstream tokens change.

## Core Idea

Separate token concerns into layers:

- **Reference tokens** for concrete named values
- **Semantic tokens** for role and meaning
- **Function tokens** for derived decisions like contrast, mixing, or spacing scales
- **Scopes** for theme, brand, surface, or component-level inheritance

This makes a token system auditable and themeable. Instead of hardcoding `buttonText = #fff`, you can encode the decision as `bestContrastWith(buttonBg, palette)` and let the system recompute when the palette changes.

## Color-Relevant Features

### 1. Reactive dependency graph

Every token can depend on other tokens. When a source token changes, dependents update automatically.

This is useful for color systems where one brand color change should propagate through:

- semantic roles
- hover/active states
- on-color text
- light/dark theme variants

### 2. Semantic layer over raw values

The spec cleanly separates raw color definitions from their roles in UI.

- raw/reference: `brand.primary`
- semantic: `ui.button-bg`
- derived: `ui.button-text = bestContrastWith(ui.button-bg, brand)`

That matches a strong design-token pattern: reference values define what exists; semantic values define what it means.

### 3. Derived decisions as first-class tokens

The most important idea for color work is that decisions can be encoded, not just their outputs.

Examples from the spec:

- `bestContrastWith(...)`
- `colorMix(...)`
- `closestColor(...)`
- `furthestFrom(...)`

This matters because color systems often fail when hover states, accessible text colors, and theme variants are chosen manually and then drift out of sync.

### 4. Multiple output formats

The same token graph can render to:

- CSS variables
- JSON
- W3 design tokens
- SVG visualizations

That is useful when the same color logic needs to survive across code, documentation, design tools, and build outputs.

### 5. Scope inheritance

Theme extension is built into the model. A dark theme can extend a light theme, override a few tokens, and inherit the rest.

For color systems this is a more robust model than copying large token sets and editing them by hand.

## Why It Matters

This spec is valuable because it shifts color systems from:

- static swatch lists
- duplicated per-platform values
- manually chosen contrast pairs
- brittle light/dark overrides

to:

- dependency-aware token graphs
- semantic mapping layers
- computable color decisions
- renderer-specific export from one source of truth

It is especially relevant for agents and tooling because the system preserves intent, not just final hex strings.

## Relation to Other References

- **Color Router** is a concrete reactive color-management library with a similar spreadsheet/graph mindset.
- **CSS-Native Color Generation** focuses on palette generation and browser-native interpolation.
- **Culori** provides the color-space machinery that a system like this can build on.

DesignBook sits one level above those: it is a token-architecture model for organizing color decisions across a design system.

## Practical Takeaways

- Prefer **reference + semantic + derived** token layers over one flat token map.
- Treat contrast selection, state colors, and nearest-palette matching as **functions**, not one-off literals.
- Use **scope inheritance** for light/dark/brand variations.
- Keep a **dependency graph** so you can audit what changes when a color changes.
- Render the same color logic into different targets instead of maintaining parallel hand-edited outputs.

## Caveat

This is an architecture specification, not a peer-reviewed color-science source. Its value is structural: how to build systems that preserve color intent and relationships in code.
