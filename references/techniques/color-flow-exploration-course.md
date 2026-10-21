# Color Flow — Color Exploration Course & Flow Designer

By **Dustin Brown** (speckofdustin.com). Personal project, captured 2026-10-21.

- Tool / course hub: https://colorflow.speckofdustin.com/
- Sibling tools: [Color Collapse](color-collapse-tone-mapping.md) (tone mapping, the full version of module 6), [Color Weight](color-weight-lightness-hierarchy.md) (lightness-hierarchy palettes, built on module 01)

"Interactive instruments for understanding digital color." Six modules, each stating **one fact** with an instrument to test it ("the controls are the main content"). The order goes from perception to the systems that put numbers on it. A good teaching sequence to borrow: each module pairs the tidy claim with the failure that proves it.

---

## 01 · Value vs. Luminance (perception)

HSV V and HSL L are not brightness. At **V = 100, relative luminance varies about 13×** across hues (yellow ≈ 0.93 vs blue ≈ 0.07).

- Rec.709: `Y = 0.2126 R + 0.7152 G + 0.0722 B` (linear). Green is about ¾, blue about 7%.
- V is just `max(R,G,B)`, with no weighting.
- Secondaries light two subpixels and luminance adds: Y ≈ 93%, C ≈ 79%, M ≈ 28%. Every secondary is brighter than either primary inside it, which is why the hue sweep's luminance curve peaks at Y/C/M.
- Practice: saturated blue text on black has the same picker "brightness" as any hue, but about 7% luminance. Decisions about legibility, hierarchy, or material reflectance need Y or L*, not V.

## 02 · Magenta and non-spectral colors (perception)

No single wavelength makes magenta. On the CIE 1931 diagram it sits on the **line of purples**, the straight bottom edge joining the spectrum's two ends, where no point is a wavelength. It appears when L and S cones fire strongly and M stays quiet.

Teaching point: **every color wheel is a designed object.** Nature gives a line (violet to red). Closing it into a circle splices in the purples without marking the seam. So wheel layout (how much arc green gets, what sits opposite blue) is a design choice, and every angle-based harmony rule (complementary, triadic) inherits it. That's why the same rule gives different colors on different wheels, and why painter's-wheel advice misfires on screens. *(Cross-ref: `youre-wrong-about-color-harmony.md`.)*

## 03 · Saturation across models (systems)

All models agree saturation means distance from gray. They disagree on *which* gray and what else may change:

| Model | What "more saturation" does | Lightness side effect |
| --- | --- | --- |
| HSV | holds max channel, pulls the other two down | **always darkens** (only removes light); desaturated V=100 → white |
| HSL | pins the (max+min)/2 midpoint | **hue-dependent**: yellow at 50% brightens a lot, blue darkens |
| Raster-editor slider | scales channels away from their average | R/G-heavy hues gain luminance, blues lose it |
| CIELab / OKLCH | changes C perpendicular to L | **L holds** (nearly flat lines) |

Footnote the module gets right: even at constant L, saturated colors look slightly brighter (**Helmholtz–Kohlrausch**). Numeric constant L ≈ perceived constant L, not equal.

Practice: a late "make the brand color a bit more saturated" in an HSV/HSL picker silently moves L, **and every contrast ratio that color is part of**. Re-check contrast after chroma edits, or edit in OKLCH. In 3D, saturating an albedo map changes how much light the material reflects, which is a material change.

## 04 · Color Flow Designer (systems)

Pick anchors, shape the transition, export a palette or gradient. From `ramp-engine.js`, the interpolation modes are:

- **sRGB** and **linear RGB** lerps, shown as the failing baselines.
- **Straight OKLab** line.
- **OKLCH arc** with a hue direction (`shorter` / `longer` / `increasing` / `decreasing`, the CSS Color 4 hue-interpolation keywords) plus a **chroma bow**: `C(t) = lerp(C₀,C₁,t) + 4·t·(1−t)·bow`. This parabola peaks at the midpoint, so you can push the middle of a gradient more or less vivid than its ends. A neutral endpoint borrows the other endpoint's hue (it doesn't snap to 0°).
- **Catmull-Rom spline** through several anchors in OKLab (L clamped to 0.001–0.999).
- **Monotonic lightness spine**: keeps each anchor's hue and chroma but re-places its L on a deliberate ascending or descending OKLab-L ramp with a gamma (minimum span 0.2). The source anchors are left untouched, so the constraint can be toggled off. This is the "ramps must be monotone in L" rule built as a switch.
- **Cubehelix** (Green 2011), implemented as in the reference: generated in gamma-encoded RGB and clipped per channel. Phase in degrees (`START = phase/120`), turns, direction, intensity, gamma.
- **Even spacing** by equal arc length along the gamut-mapped OKLab path, before 8-bit rounding.
- Out-of-gamut samples are mapped in OKLCH (chroma reduction), not RGB-clamped. The gamut boundary comes from an 18-step bisection on C at fixed L and h.

## 05 · Why color spaces exist (systems)

The "gradient graveyard": the same two endpoints interpolated in sRGB / HSV / CIELab / OKLab, with a midpoint chip for each. A timeline pairs each space with the failure it was built to fix. Clicking an entry loads endpoints that reproduce it:

| Space | Problem it answers | Demo endpoints |
| --- | --- | --- |
| RGB | hardware-native; blue→yellow midpoint averages to **gray** (cube center) | `#0000ff → #ffff00` |
| CIE XYZ (1931) | device-independent specification; each strip takes a different route between the same measured endpoints | `#ff0000 → #00ff00` |
| CIELab (1976) | numeric distance ≈ perceived distance; blue→yellow keeps steady L | `#0000ff → #ffff00` |
| HSV/HSL (1978, Alvy Ray Smith) | artist-friendly hue/saturation controls, cheap math, but red→cyan swings through bright green | `#ff0000 → #00ffff` |
| OKLab/OKLCH (2020, Ottosson) | fixes CIELab's hue drift: **blue→white goes purple in Lab**, holds in OKLab | `#0000ff → #ffffff` |

Rule of thumb from the module: ask **what needs to be even, the numbers or the appearance**. Anything judged by eye (gradients, ramps) goes in OKLCH. A quick hue rotation can stay in HSV. A tool's "perceptual" blend mode means Lab-family behavior.

## 06 · Color collapse in tone mapping (dynamic range)

Bright saturated colors skew toward the six primaries/secondaries under per-channel tone mapping ("notorious six"). AgX trades that for earlier desaturation to white. Brand colors should use a hue-stable mapper or be composited back in after the tone map. Full write-up: [color-collapse-tone-mapping.md](color-collapse-tone-mapping.md).

---

## Links

- Color Flow / Color Exploration: https://colorflow.speckofdustin.com/
- Color Collapse: https://colorcollapse.speckofdustin.com/
- Color Weight, five-color palette with an intentional reading order (one accent and four supports separated by OKLab lightness gap/range, max range 30 L points, hue path modes, contrast targets 3:1–7:1, luminance-grayscale preview): https://colorweight.speckofdustin.com/
- Experiments index: https://experiments.speckofdustin.com/
- Dave Green, Cubehelix (2011): see `cubehelix-color-scheme.md`
