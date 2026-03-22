# RYBitten — RYB Color Space Conversion

**Source:** [GitHub — meodai/RYBitten](https://github.com/meodai/RYBitten)
**Author:** meodai
**License:** MIT
**npm:** `rybitten`

## What It Does

Lightweight JS/TS library for converting between RGB and RYB (Red-Yellow-Blue) color spaces using **trilinear interpolation** through customizable color cubes. Enables working with traditional artist's color relationships (red+yellow=orange, not the red+yellow≈red of RGB) in digital environments.

## Why RYB?

Despite being scientifically "wrong" as primaries (see the Color Nerd RYB vs CMY video), the RYB model remains deeply intuitive for:

- **Generative art** — produces color harmonies that feel painterly
- **Procedural palette generation** — complementary/triadic relationships match artist expectations
- **Education** — maps to how art is traditionally taught
- The library acknowledges this is a pragmatic tool, not a scientific claim about primaries

## How It Works

**Trilinear interpolation** through an 8-corner color cube:

- Cube corners define: white, red, yellow, blue, orange, green, violet, black
- Input RYB coordinates [0-1, 0-1, 0-1] interpolate through this cube to produce RGB
- Different cubes = different historical color systems

## 26 Historical Color Gamuts

The killer feature — preset cubes from major color theorists:

| Key       | Author/System                      | Year |
| --------- | ---------------------------------- | ---- |
| `itten`   | Johannes Itten: Chromatic Circle   | 1961 |
| `munsell` | Munsell Color System               | 1905 |
| `albers`  | Josef Albers: Interaction of Color | 1942 |
| `goethe`  | Goethe: Farbenkreis                | 1809 |
| `harris`  | Moses Harris: Natural System       | 1766 |
| `bezold`  | Wilhelm von Bezold: Farbentafel    | 1874 |
| `runge`   | Philipp Otto Runge: Farbenkugel    | 1810 |
| ...       | +19 more historical systems        |      |

Each includes metadata: title, author, year, reference image.

## API

```javascript
import { ryb2rgb, rybHsl2rgb } from "rybitten";
import { cubes } from "rybitten/cubes";

// Basic RYB → RGB
const rgb = ryb2rgb([1, 0, 0.5]); // full red, no yellow, half blue

// HSL through RYB space (most useful for palettes)
const rgb = rybHsl2rgb([120, 1, 0.5]); // hue 120° in RYB = different from HSL 120°

// Use Munsell's color system instead of Itten's
const munsellCube = cubes.get("munsell").cube;
const rgb = rybHsl2rgb([0, 1, 0.5], { cube: munsellCube });
```

### p5.js Integration

```javascript
colorMode(RYB); // native RYB mode!
background(255, 0, 0); // red in RYB
fill(0, 255, 0); // yellow in RYB (not green!)
```

## Default Itten Cube Corners

| Corner | RGB Value                      |
| ------ | ------------------------------ |
| White  | `[253, 246, 237]` (warm white) |
| Red    | `[227, 36, 33]`                |
| Yellow | `[243, 230, 0]`                |
| Blue   | `[22, 153, 218]`               |
| Orange | `[240, 142, 28]`               |
| Green  | `[0, 142, 91]`                 |
| Violet | `[120, 34, 170]`               |
| Black  | `[29, 28, 28]`                 |

## Connection to the Knowledge Base

- Relates to [RYB vs CMY Color Wheels](../historical/ryb-vs-cmy-color-wheels.md) — this library lets you work WITH the RYB model despite its scientific limitations
- The historical cubes connect to [Ostwald](../historical/ostwald-color-wheel.md), [Bezold](../historical/what-happened-to-indigo.md), [Amy Sawyer](../historical/amy-sawyer-forgotten-color-theorist.md)
- Itten's system critiqued in [CSA — Itten's Seven Contrasts](../historical/itten-seven-contrasts-critical-review.md)

## Links

- **GitHub:** https://github.com/meodai/RYBitten
- **npm:** `npm install rybitten`
- **CDN:** `https://unpkg.com/rybitten`
