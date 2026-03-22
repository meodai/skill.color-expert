# RampenSau — Color Palette Generation via Hue Cycling

**Source:** [GitHub — meodai/rampensau](https://github.com/meodai/rampensau)
**Author:** meodai
**License:** MIT
**Demo:** https://meodai.github.io/rampensau/

## What It Does

JavaScript library for generating color ramps/palettes using **hue cycling and easing functions**. Designed for data visualization, design systems, generative art, and creative applications. Outputs HSL-like triplets `[H (0-360), S (0-1), L (0-1)]` that can map to any polar color model (HSL, HSV, LCH, OKLCH).

## Core Concept

Instead of picking individual colors, RampenSau generates palettes by:

1. **Cycling through hues** with configurable rotations and easing
2. **Modulating saturation and lightness** via range + easing curves
3. Optionally applying **curve methods** (lamé, sine, power, linear) for organic variation
4. Supporting **any cylindrical color space** — same generator, different output interpretation

## API

### `generateColorRamp(options)`

```javascript
import { generateColorRamp } from "rampensau";

const colors = generateColorRamp({
  total: 9, // number of colors
  hStart: 220, // starting hue
  hCycles: 0.5, // half rotation (180°)
  hStartCenter: 0.5, // center hue at midpoint
  hEasing: (t) => t, // linear hue easing
  sRange: [0.4, 0.8], // saturation min/max
  lRange: [0.2, 0.9], // lightness min/max
  sEasing: (t) => t, // saturation easing
  lEasing: (t) => t, // lightness easing
});
// Returns: [[h, s, l], [h, s, l], ...]
```

### `generateColorRampWithCurve(options)`

Convenience wrapper with preset curve methods:

- `curveMethod`: `'lamé'` | `'sine'` | `'power'` | `'linear'`
- `curveAccent`: intensity (0–5)

### Hue Utilities

```javascript
import { uniqueRandomHues, colorHarmonies } from "rampensau";

// Random hues with minimum angular separation
const hues = uniqueRandomHues({ total: 5, minHueDiffAngle: 60 });

// Harmonic hue sets
const triadic = colorHarmonies.triadic(120); // base hue 120°
// Also: complementary, splitComplementary, tetradic, analogous,
//        monochromatic, doubleComplementary, compound
```

### Color Output

```javascript
import { colorToCSS } from "rampensau";

colorToCSS([280, 0.6, 0.5], "oklch");
// → 'oklch(L% C H)'

colorToCSS([280, 0.6, 0.5], "hsl");
// → 'hsl(280, 60%, 50%)'
```

**Supported modes:** `hsl`, `hsv`, `lch`, `oklch`

### `harveyHue(h)`

Transforms hue values for a more perceptually even distribution — reduces the over-abundance of green and ultramarine in standard HSL hue wheels.

## Key Design Decisions

- **Color space agnostic** — generates base H/S/L values; interpretation depends on target space
- **Easing functions** control the distribution — not just linear interpolation between endpoints
- **Hue cycling** naturally produces harmonious palettes without needing explicit harmony rules
- **`hStartCenter`** parameter controls where in the ramp the starting hue appears — not always at the beginning
- **Works with OKLCH** — the recommended output space for perceptual uniformity

## Demos & Examples

- **Interactive docs:** https://meodai.github.io/rampensau/
- **Generative syntax highlighting:** https://meodai.github.io/rampensau/highlighter.html
- **1000 generative palettes (CodePen):** https://codepen.io/meodai/pen/ExQWwar?editors=0010
- **p5.js 3D color:** https://editor.p5js.org/meodai/sketches/dzEX_4wTN

## Integration

Works with **Culori** and other color libraries for proper color space conversions. Base values need scaling per color model specs.

## Links

- **GitHub:** https://github.com/meodai/rampensau
- **npm:** `npm install rampensau`
- **CDN:** `https://cdn.jsdelivr.net/npm/rampensau/dist/index.js`
