# Poline — Esoteric Color Palette Generator

**Source:** [GitHub — meodai/poline](https://github.com/meodai/poline)
**Author:** meodai
**Demo:** https://meodai.github.io/poline/
**npm:** `poline` | **Stars:** ~1.2K
**License:** see repo

## What It Does

"Esoteric" color palette generator that creates visually striking palettes by interpolating between **anchor points** in a 3D polar-to-cartesian coordinate system. Uses position functions (easing curves) to control how colors distribute along paths between anchors. Produces otherworldly palettes from mathematical operations rather than traditional color harmony rules.

## Core Concept

1. Define **anchor points** (HSL colors)
2. Draw paths between anchors in 3D space
3. **Position functions** (sinusoidal, quadratic, exponential, etc.) determine where colors land along each path
4. Each axis (X, Y, Z) can use a different position function
5. Final palette = `numPoints × anchor pairs`

## API

```javascript
import { Poline, positionFunctions } from "poline";

// Basic — random anchors
const poline = new Poline();
poline.colorsCSS; // ["hsl(...)", ...]
poline.colorsCSSoklch; // ["oklch(...)", ...]

// Custom anchors + config
const poline = new Poline({
  anchorColors: [
    [309, 0.72, 0.8], // [hue, saturation, lightness]
    [67, 0.32, 0.08],
  ],
  numPoints: 6,
  positionFunctionX: positionFunctions.sinusoidalPosition,
  positionFunctionY: positionFunctions.quadraticPosition,
  positionFunctionZ: positionFunctions.linearPosition,
  closedLoop: false,
  invertedLightness: false,
});

// Dynamic anchor management
poline.addAnchorPoint({ color: [100, 0.91, 0.8] });
poline.updateAnchorPoint({ pointIndex: 1, color: [120, 0.8, 0.5] });
poline.removeAnchorPoint({ index: 2 });

// Sample any position along the palette
const mid = poline.getColorAt(0.5);
mid.hsl; // [h, s, l]
mid.hslCSS; // "hsl(120, 80%, 60%)"

// Hue shift entire palette
poline.shiftHue(60);

// Closed loop (last color = first)
poline.closedLoop = true;
```

## Position Functions

Control distribution of colors along anchor paths:

| Function                       | Behavior                         |
| ------------------------------ | -------------------------------- |
| `linearPosition`               | Even spacing                     |
| `sinusoidalPosition` (default) | Smooth acceleration/deceleration |
| `exponentialPosition`          | Cluster toward edges             |
| `quadraticPosition`            | Curved falloff                   |
| `cubicPosition`                | Smoother curves                  |
| `quarticPosition`              | Even smoother                    |
| `asinusoidalPosition`          | Inverse sinusoidal               |
| `arcPosition`                  | Arc-like distribution            |
| `smoothStepPosition`           | Smooth step                      |

Each axis (X, Y, Z) can use a different function — creating complex distribution patterns from simple components.

## Output Formats

```javascript
poline.colors; // [[h, s, l], ...]
poline.colorsCSS; // HSL CSS strings
poline.colorsCSSlch; // LCH CSS strings
poline.colorsCSSoklch; // OKLCH CSS strings
```

## Key Features

- **Anchor-based** — define key colors, system fills in between
- **Position functions per axis** — independent easing on each dimension
- **Closed loops** — seamless circular palettes
- **Dynamic sampling** — `getColorAt(t)` for any position 0–1
- **Hue shifting** — rotate entire palette
- **Circle clamping** — constrain coordinates to valid color wheel
- **Inverted lightness** — flip for alternative aesthetics
- **Closest anchor finding** — useful for interactive tools

## How Poline Differs from RampenSau

|                | Poline                             | RampenSau                   |
| -------------- | ---------------------------------- | --------------------------- |
| **Approach**   | Anchor points + path interpolation | Hue cycling + easing        |
| **Input**      | Specific anchor colors             | Start hue + rotation amount |
| **Paths**      | 3D cartesian between anchors       | Cylindrical sweep           |
| **Best for**   | Specific palette refinement        | Generative/random palettes  |
| **Complexity** | Higher (per-axis functions)        | Simpler (global easing)     |

## Links

- **GitHub:** https://github.com/meodai/poline
- **Demo:** https://meodai.github.io/poline/
- **npm:** `npm install poline`
- **CDN:** `https://unpkg.com/poline?module`
