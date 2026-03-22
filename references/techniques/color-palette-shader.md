# Color Palette Shader — WebGL2 Palette Visualization

**Source:** [GitHub — meodai/color-palette-shader](https://github.com/meodai/color-palette-shader)
**Author:** meodai
**Demo:** https://meodai.github.io/color-palette-shader/
**npm:** `palette-shader`

## What It Does

Dependency-free WebGL2 shader that maps any color palette across 3D perceptual color spaces. Every pixel is assigned to its nearest palette color (GPU-accelerated Voronoi-like nearest-neighbor matching), revealing palette distribution, distinctness, and balance at a glance.

## Why It Matters

Quick visual assessment of palette quality:

- **Tiny regions** = redundant colors (too similar to neighbors)
- **Uneven regions** = imbalanced hue/saturation/lightness distribution
- **Large, distinct regions** = each color does unique work
- Answers: "Is it worth adding another color?" — if the new region is tiny, no

## Features

- **30+ color models** — OKLab, OKHsl, OKHsv, OKLCH, CIELab (D50/D65), CAM16-UCS, HSV, HSL, HWB, RGB, spectrum, retro bit-depths
- **11 distance metrics** — oklab, deltaE2000, cam16ucs, rgb, lightness-only, spatial blends
- **2D cross-sections** (PaletteViz) and **interactive 3D** (PaletteViz3D) with trackball rotation
- **Gamut clipping** — reveal true color model boundaries
- **Float16 precision** — lossless out-of-gamut sampling
- Zero dependencies, WebGL2 only

## API

```javascript
import { PaletteViz } from "palette-shader";

const viz = new PaletteViz({
  palette: [
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1],
  ], // linear sRGB [0-1]
  container: document.querySelector("#app"),
  colorModel: "okhsvPolar", // visualization space
  distanceMetric: "oklab", // similarity measurement
  position: 0.5, // axis slice position
  axis: "y", // which axis to slice
  gamutClip: false, // show out-of-gamut?
  outlineWidth: 1, // region boundary lines
});

// Live updates — trigger immediate re-render
viz.palette = [
  [1, 0, 0],
  [0, 0.5, 1],
];
viz.colorModel = "oklchPolar";

// Sampling
const [r, g, b] = viz.getColorAtUV(0.5, 0.5);

// Palette manipulation
viz.addColor([0.5, 0.2, 0.8]);
viz.removeColor(2);
```

## Recommended Configurations

| Question              | Color Model       | Distance     |
| --------------------- | ----------------- | ------------ |
| Hue distribution?     | `okhslPolar`      | `oklab`      |
| Most similar colors?  | `okhsl` / `oklab` | `deltaE2000` |
| Worth adding a color? | `okhslPolar`      | `oklab`      |
| Print appearance?     | `cielabD50`       | `cielabD50`  |
| Perceptual closeness? | `oklchPolar`      | `deltaE2000` |

## Color Models Available

**Perceptually Uniform:** okhsv, okhsl, oklab, oklch, oklrab, oklrch (+ polar variants)
**CIE:** cielab, cielch (D50 & D65 + polar variants)
**Appearance:** cam16ucsD65 (+ polar)
**Classic:** hsv, hsl, hwb, rgb (+ polar variants)
**Special:** spectrum (410–665nm + purple line), rgb6/8/12/15/18bit (retro depths)

**Polar vs rectangular:** Polar wraps hue around a circle (designer-intuitive); rectangular shows 3 axes as flat grid (precise values).

## Links

- **GitHub:** https://github.com/meodai/color-palette-shader
- **Live demo:** https://meodai.github.io/color-palette-shader/
- **npm:** `npm install palette-shader`
