# pro-color-harmonies — Perceptually-Tuned Color Palettes

**Source:** [GitHub — meodai/pro-color-harmonies](https://github.com/meodai/pro-color-harmonies)
**Author:** meodai (inspired by @royalfig)
**Demo:** https://meodai.github.io/pro-color-harmonies/
**npm:** `pro-color-harmonies`

## What It Does

Dependency-free TypeScript library generating **perceptually-tuned color palettes** from a single base color. Goes far beyond traditional "rotate hue by X°" harmony — works in OKLCH with adaptive strategies, muddy-zone avoidance, and four post-processing modifiers.

## How It Differs from Standard Harmony Libraries

| Traditional                  | pro-color-harmonies                                            |
| ---------------------------- | -------------------------------------------------------------- |
| Complementary = H + 180°     | Adaptive complement based on base color character              |
| Same formula for all colors  | Analyzes base (dark? light? vibrant?) → context-aware strategy |
| Often produces muddy results | Actively avoids muddy zones (dark yellows/browns)              |
| One interpretation per type  | 4 styles per harmony type (square, triangle, circle, diamond)  |
| Jarring shifts between bases | Smooth interpolation across thresholds                         |

## API

```typescript
import { ColorPaletteGenerator } from "pro-color-harmonies";

// Single harmony
const palette = ColorPaletteGenerator.generate(
  { l: 0.7, c: 0.12, h: 200 }, // base color (OKLCH)
  "triadic", // harmony type
  { style: "triangle", modifiers: { sine: 0.3 } },
);
// → 6 OKLCH colors

// All harmonies at once
const all = ColorPaletteGenerator.generateAll(
  { l: 0.7, c: 0.13, h: 260 },
  { style: "triangle" },
);
// → { analogous, complementary, triadic, tetradic, splitComplementary, tintsShades }
```

## Harmony Types (always returns 6 colors)

| Type                 | Description                                                                               |
| -------------------- | ----------------------------------------------------------------------------------------- |
| `analogous`          | Walk hue within a band; muddy-zone avoidance                                              |
| `complementary`      | Style-dependent complement (not rigid +180°); base/complement + dark/light/muted variants |
| `triadic`            | Three hues (mathematical, optical, adaptive, or warm/cool depending on style)             |
| `tetradic`           | Four-hue schemes (square, rectangle, adaptive, double-complement)                         |
| `splitComplementary` | Base + two splits around opposite; dark/light/muted variants                              |
| `tintsShades`        | 6-step lightness scale with perceptual strategies (Bezold-Brücke shift, chroma curves)    |

## 4 Style Interpretations

| Style                | Character                                                                   |
| -------------------- | --------------------------------------------------------------------------- |
| `square` / `default` | Mathematically strict geometric relationships                               |
| `triangle`           | Perceptually-balanced; bends angles for visual harmony; "Chroma Narratives" |
| `circle`             | Emotionally expressive; hue/lightness bands; "Color Hierarchy"              |
| `diamond`            | Luminosity-aware; lightness+chroma driven; UI-friendly                      |

## 4 Modifier Knobs (0–1 each)

Post-processors that sculpt existing palettes:

| Knob    | Effect                                                                    |
| ------- | ------------------------------------------------------------------------- |
| `sine`  | Smooth sinusoidal hue shift (~45°) + lightness variation; flowing, gentle |
| `wave`  | Logistic/chaotic mapping; irregular but controlled; noisy structure       |
| `zap`   | Spiral path; directional and energetic hue/lightness/chroma modulation    |
| `block` | Triangular wave; stepped contrast blocks in lightness and hue             |

## Exposed Utilities

```typescript
import {
  clampOKLCH,
  normalizeHue,
  avoidMuddyZones, // color utils
  getComplementaryHue,
  getTriadicHues, // hue strategies
  lerp,
  lerpOKLCH, // interpolation
  enhancePalette,
  polishPalette, // post-processing
  createPaletteGenerator, // factory
} from "pro-color-harmonies";
```

## Key Concepts for the Skill

- **Muddy-zone avoidance** — not all color space is equally useful; certain hue+lightness+chroma combinations are universally unappealing
- **Adaptive variation** — dark bases need lighter variations, light bases need richer darker tones; one formula can't serve all
- **Smooth interpolation** — palette generation shouldn't produce jarring shifts when base color crosses a threshold
- **OKLCH is the right space** for harmony calculation — perceptually uniform means "rotate 120°" actually produces visually equidistant hues

## Links

- **GitHub:** https://github.com/meodai/pro-color-harmonies
- **npm:** `npm install pro-color-harmonies`
- **Demo:** https://meodai.github.io/pro-color-harmonies/
