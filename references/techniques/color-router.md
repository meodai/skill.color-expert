# Color Router — Reactive Color Management for Design Systems

**Source:** [GitHub — meodai/color-router](https://github.com/meodai/color-router)
**Author:** meodai
**npm:** `color-router`

## What It Does

TypeScript color management framework that works like a **smart, interconnected color spreadsheet**. Solves the combinatorial explosion problem in design systems — a 190-color palette (Material Design) has 17,955 two-color combinations. Color Router maintains relationships reactively instead of manually.

## Core Concept

| Spreadsheet      | Color Router                             |
| ---------------- | ---------------------------------------- |
| Sheets           | Palettes (`brand`, `light`, `dark`)      |
| Cells            | Named colors (`brand.primary`)           |
| Formulas         | Functions (`darken`, `bestContrastWith`) |
| Cell references  | `router.ref('brand.primary')`            |
| Auto-recalculate | Changes cascade through all dependents   |

## API

```typescript
import { ColorRouter } from "color-router";
import { ColorRenderer } from "color-router/renderers";

const router = new ColorRouter();

// Define colors
router.createPalette("base");
router.define("base.primary", "#3498db");
router.define("base.text", router.ref("base.primary")); // linked!

// Functions
router.define("base.hover", router.func("darken", "base.primary", 0.1));
router.define(
  "base.contrast",
  router.func("bestContrastWith", "base.primary", "base"),
);

// Palette inheritance
router.createPalette("dark", {
  extends: "light",
  overrides: {
    background: router.ref("base.black"),
    text: router.ref("base.white"),
  },
});

// Change base.primary → everything updates automatically
router.define("base.primary", "#e74c3c");
```

## Built-in Functions

| Function                          | Purpose                                   |
| --------------------------------- | ----------------------------------------- |
| `bestContrastWith(key, palette)`  | Find highest-contrast color from palette  |
| `minContrastWith(key, ratio)`     | Ensure minimum contrast ratio             |
| `colorMix(c1, c2, ratio, space?)` | Mix colors (renders to CSS `color-mix()`) |
| `lighten(key, amount)`            | Lighten a color                           |
| `darken(key, amount)`             | Darken a color                            |
| `relativeTo(key, cssTransform)`   | CSS relative color syntax                 |
| `closestColor(key, palette)`      | Find perceptually nearest color           |
| `furthestFrom(palette)`           | Find most distant color                   |

## Output Formats

**CSS Variables:**

```css
:root {
  --base-primary: #0066cc;
  --light-mixed: color-mix(
    in lab,
    var(--light-primary) 30%,
    var(--base-orange)
  );
}
```

**JSON:** flat `{ "base.primary": "#0066cc" }` for programmatic use

**SVG Renderer** and **Table View Renderer** also available

## Dependency Graph Analysis

```typescript
const graph = router.getDependencyGraph();
graph.dfsTraversal("brand.primary"); // depth-first
graph.findShortestPath("brand.primary", "btn.text"); // path between colors
graph.hasCycles(); // detect circular deps
```

## Why It Matters for Design Systems

- **Single source of truth** — change one color, everything updates
- **Theme inheritance** — dark mode extends light, only overrides what changes
- **Contrast guarantees** — `bestContrastWith` searches entire palettes
- **Native CSS output** — renders `color-mix()`, CSS custom properties
- **Auditable** — dependency graph reveals how colors relate

## Links

- **GitHub:** https://github.com/meodai/color-router
- **npm:** `npm install color-router`
