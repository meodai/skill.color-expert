# Ardov Color Lab — Techniques & Algorithms

Source code analysis of [ardov/color-lab](https://github.com/ardov/color-lab) (lab.ardov.me) by Alexey Ardov.

Built with: React 18, Vite, TypeScript, Three.js (React Three Fiber), Culori, apca-w3.

---

## Edge Seeker — LUT-Based Gamut Mapping

A novel gamut mapping algorithm that avoids runtime binary search entirely.

### How It Works

1. **LUT generation** — For each of 400 hue slices, finds the "cusp" (point of maximum chroma on the gamut boundary) by converting fully saturated HSL colors to OKLCH. A second pass at L=0.762 provides curvature data.

2. **Curvature fitting** — For each hue slice, fits a **circular arc** to the bright side of the gamut boundary (cusp → white). Key insight: the gamut boundary's bright side is well-approximated by an arc, not a straight line.

3. **Runtime lookup** — Given (L, H) in OKLCH:
   - Interpolates the LUT for cusp position and curvature at that hue
   - **Dark side** (L ≤ cusp L): linear relationship `C = (L / cusp_L) * cusp_C`
   - **Bright side** (L > cusp L): circle-line intersection using the pre-computed arc

4. **Gamut-agnostic** — Works for sRGB and Display P3 by swapping the RGB-to-OKLCH converter.

### Performance

LUT computed once per gamut; runtime lookups use only interpolation + one sqrt. Benchmarked against Culori's `clampChroma` (binary search) and OKHSL-based approaches.

---

## OKLCH Blue Glitch Region

Near pure blue (#0000ff, hue ~264.05°), there's a small region where displayable colors appear non-displayable due to numerical distortion.

### Exact Bounds

- **Lightness:** 0–0.49
- **Hue:** 264.05°–264.21°

### Workaround

The `oklchDisplayable()` function detects this region and uses the slope from pure blue to black/white as an artificial chroma limit, returning clamped RGB instead of `false`.

---

## OKLrCH — OKLCH with Better Toe

A custom color space: OKLCH with Ottosson's "better toe" function applied to lightness. Makes OKLCH lightness more perceptually uniform for SDR gamuts (sRGB, P3).

### The Toe Function

From [Ottosson's color picker post](https://bottosson.github.io/posts/colorpicker/#intermission---a-new-lightness-estimate-for-oklab):

```
k1 = 0.206, k2 = 0.03, k3 = (1 + k1) / (1 + k2)
toe(l) = 0.5 * (k3*l - k1 + sqrt((k3*l - k1)² + 4*k2*k3*l))
```

Both forward (`betterToe`) and inverse (`betterToeInv`) are used throughout the codebase.

### Why It Matters

OKLAB's lightness is designed for HDR. The toe remaps it to behave more like CIELAB lightness for SDR content — better for color pickers and palette tools targeting screen displays.

---

## Perceptual Gradient Subdivision

Converts a gradient defined in any color space into sRGB stops that visually approximate the perceptual interpolation.

### Algorithm

Recursive subdivision: if the midpoint of a segment in the source space differs from the sRGB midpoint by more than a threshold (measured in OKLAB with toe-adjusted lightness), insert intermediate stops.

Solves the problem of CSS gradients only interpolating in sRGB — generate enough sRGB stops to fake perceptual interpolation.

---

## Alpha Color Reverse-Engineering

Given a background color and a target opaque appearance, derives the minimum-alpha RGBA color that, when composited over the background, produces the exact target.

### Use Case

Design system tooling — generating semi-transparent overlay colors that adapt to different backgrounds while maintaining consistent appearance.

---

## Contrast-Targeted Color Search

Binary search on OKLCH lightness to find a foreground color hitting a specific APCA or WCAG contrast target against a given background.

- Automatically determines search direction (lighter or darker) based on which extreme offers more contrast
- Preserves hue and chroma while adjusting only lightness
- Supports both APCA (Lc values) and WCAG (ratio) modes

---

## Dependency-Graph Theme Tokens

Theme colors defined as relationships, not fixed values. 13 named tokens (base, app-bg, subtle-bg, element-bg, hover-bg, active-bg, border-subtle, border, border-hover, solid-bg, solid-hover, text-low, text) with rules:

- **Absolute lightness** in OKLCH
- **Lightness offset** relative to another token
- **APCA contrast** target relative to another token
- **WCAG contrast** target relative to another token

Colors resolved recursively with cycle detection. Output: sRGB HSL + Display P3 `color()` strings.

### Why It Matters

A concrete implementation of the "encode color decisions" principle — theme colors are defined by perceptual relationships rather than frozen hex values.

---

## 16 Color Spaces Visualized in 3D

The 3D viewer supports:

| Family | Spaces |
| --- | --- |
| **RGB** | sRGB, HSL, HSV, Display P3 |
| **OKLAB** | OKLAB, OKLrAB, OKLrCH, OKHSL, OKHSV |
| **CIE** | CIELAB, CIELCH, CIELuv, CIE xyY |
| **Other** | DIN99 Lab, Jab (Jzazbz), YIQ |

---

## Harmony Generator

Semantic harmony in OKLCH. Given an accent hue, generates complementary hues for semantic UI roles:

1. Start at accent hue
2. Try complement (hue+180°), then offsets at ±60°, ±90°, ±30°, ±120° from complement
3. Assign to semantic slot by hue range: 0–30° & 320–360° = error, 30–100° = warning, 100–200° = success, 200–300° = info
4. Render each at 4 lightness levels (90%, 75%, 50%, 30%) with chroma clamped to gamut

---

## Links

- **Color Lab:** https://lab.ardov.me/
- **Source:** https://github.com/ardov/color-lab
- **Huetone:** https://huetone.ardov.me/
- **Hue Plot:** https://hueplot.ardov.me/
- **HDR Web:** https://hdr.ardov.me/
