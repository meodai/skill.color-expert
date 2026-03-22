# Better Than HSL? — Interview with Alexei Boronine (HSLuv)

**Source:** [Color Nerd](https://www.youtube.com/@ColorNerd1) (YouTube, full-length)
**Date:** 2022-02-19
**URL:** https://www.youtube.com/watch?v=9EJ91dufnxg
**Duration:** 5:52
**Views:** 1,933
**Guest:** Alexei Boronine (creator of HSLuv)

## Description

Interview with Alexei Boronine about HSLuv, a color space he developed in 2012 that normalizes CIELUV chroma to a 0–100% saturation scale, solving HSL's biggest problems while keeping the intuitive hue/saturation/lightness model.

## Key Topics Discussed

### Problems with HSL

- **Lightness is broken for comparison** — works within a single hue/saturation but wildly different across hues; comparing lightness of different colors is meaningless
- **Saturation** has similar issues, though less pronounced
- **Hue is non-uniform** — 20-30° shift between red-orange-yellow is very noticeable, but the same degrees in the green region are barely perceptible
- HSL warps RGB into a cylinder, creating all these distortions

### HSLuv's Innovation

- Based on **CIELUV** (CIE 1976 L*u*v\*) — a perceptually more uniform color space
- **The key innovation:** normalizing CIELUV chroma to a percentage of what's available at each hue/lightness
- Solves the "out of bounds" problem — in raw CIELUV, changing hue at fixed chroma/lightness often produces impossible colors
- **Saturation 100%** = maximum available chroma for that hue at that lightness

### The Funky Gamut Shape

- sRGB gamut in CIELUV is an irregular parallelogram-like shape per lightness level
- **Some colors are impossible:** dark saturated yellow doesn't exist (a dark yellow can't be saturated); dark saturated blue does (the ocean)
- The irregular shape reflects real perceptual constraints

### Hue Angle Differences

- HSLuv hue angles differ slightly from RGB: `#FF0000` is ~12.2° instead of 0°
- Both cycle through the same cone stimulation patterns (L, M, S cones), just pinpointed differently

### HPLuv ("Pastel" mode)

- A secondary circle in the picker that stays within the maximum inscribed circle of the gamut
- Within this circle, you get full hue range at consistent chroma — never out of bounds
- Trade-off: limited to pastel/desaturated colors
- "P" stands for pastel

### Design Use Cases

- More convenient than traditional HSL pickers
- Best use: **automated palette generation** — the uniformity makes algorithmic color schemes more predictable
- Sliding hue at fixed saturation traces a line parallel to the gamut boundary — unique to HSLuv

## Links

- **HSLuv color picker & info:** https://www.hsluv.org
- **HPLuv** (pastel variant): included in the HSLuv project

## Key Concepts for the Skill

- HSL lightness ≠ perceptual lightness (use L\* from CIELUV/CIELAB instead)
- HSL saturation ≠ perceptual saturation (compare chroma at same lightness instead)
- HSLuv is a good middle ground: intuitive H/S/L sliders with perceptual uniformity
- For maximum uniformity without normalization distortion, use OKLCH directly
