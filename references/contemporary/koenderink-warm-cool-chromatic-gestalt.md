# Koenderink — Warm/Cool & The Well-Tempered Color Circle

A connected series of papers by Jan Koenderink, Andrea van Doorn, and Doris I. Braun (Giessen) on the phenomenology of warm/cool, chromatic non-uniformity, and the structure of perceived color space.

**Scholar page:** [Jan Koenderink — Google Scholar](https://scholar.google.com/citations?hl=en&user=lxW3wvMAAAAJ)

## The Papers

| Year | Title | Venue |
|------|-------|-------|
| 2022 | The space of colour & the colour of space | Gestalt Theory |
| 2024 | The well-tempered color circle: A chromatic Gestalt | i-Perception 15(4) |
| 2024 | "Warm," "cool," and the colors | Journal of Vision 24(7):5 |
| 2024 | Chromatics: Warm and cool | Art & Perception 13(2), 85–119 |
| 2026 | An empirical three-dimensional metric field for color space | bioRxiv — see [dedicated file](koenderink-3d-metric-field-rgb.md) |

## Core Claims

### 1. The color circle is not "well tempered"

A musically well-tempered scale has equal perceptual steps per equal geometric step. The conventional color circle does **not** — equal hue angles (in HSL/HSV/OKLCH) are not equal perceptual steps. The 2024 i-Perception paper analyzes this phenomenologically; the 2026 empirical paper measures it directly along a circular trajectory through RGB and finds grain size varying substantially with hue, with structured modulation that resembles classical wavelength discrimination curves at the region admitting dominant wavelengths.

**Implication for palette generation:** hue-angle-based harmony (120° triad, 90° tetrad, 180° complement) is a geometric shortcut over a non-uniform perceptual circle. Libraries that compensate (RampenSau's `harveyHue` easing, pro-color-harmonies' muddy-zone avoidance) are doing empirically motivated work, not arbitrary tweaks.

### 2. Warm and cool are not hue rotations

The Journal of Vision and Art & Perception papers (both 2024) argue that warm/cool is a **phenomenological axis** — a joint shift in hue, saturation, and perceived "temperature" quality — not a simple hue-wheel direction. Green and purple sit on the boundary: they can be warmed or cooled, but neither is fundamentally warm or cool. Red–orange and blue–cyan are canonical warm/cool; green–purple is a secondary axis orthogonal to it.

This matches the `color-temperature-spectral-bias.md` and `green-warm-or-cool-spectral.md` entries in this skill — Koenderink provides the formal/experimental backing for the spectral intuition.

### 3. Empirical asymmetry: cool regions are coarser

The 2026 paper measures this directly. Along the three chromatic body diagonals of the RGB cube, grain volume grows faster on the cool side (cyan, blue, green) than on the warm side (red, yellow, purple). **The cool half of color space supports fewer distinct qualitative regions than the warm half.** Not just a cultural or art-theoretical observation — it falls out of volumetric discrimination measurement.

### 4. Color space is a metric field, not a coordinate system

The cumulative argument across these papers: perceived color space is not a flat vector space with a single distance formula. It's a manifold with a **smoothly varying local metric** — anisotropic, non-uniform, structured. Parametric "uniform color spaces" (CIELAB, OKLAB, CAM16-UCS) are global approximations to this underlying field. Useful, but not the ground truth.

## Why This Matters for the Skill

- **Warm/cool questions** should cite both the spectral-reflectance explanation (Color Nerd shorts) **and** the Koenderink phenomenological/empirical framing. Both levels of description.
- **Palette generation and hue spacing** — the non-well-tempered result is direct empirical support for using OKLCH over HSL, and for hue easing over equal-angle harmony.
- **Claims about color space "uniformity"** — Koenderink is the canonical contemporary source for "there is no flat parameterization that is globally perceptually uniform." OKLAB is the best current approximation; it is not the underlying truth.
- **Counting colors** — use the 2026 paper's ~1,000 qualitative regions in RGB, not "millions of discriminable colors," when the question is about meaningful distinction (palette size, naming system capacity, UI tokens).

## Related Entries

- [Koenderink 3D Metric Field](koenderink-3d-metric-field-rgb.md) — the 2026 empirical measurement
- [MacAdam Ellipses — JND](macadam-ellipses-jnd.md) — classical 1942 work this extends
- [Green Warm or Cool? (Spectral)](green-warm-or-cool-spectral.md) — spectral-reflectance explanation
- [Warm/Cool ≠ Hue](warm-cool-color-temperature.md) — warm/cool as joint hue+saturation shift
- [Color Temperature = Spectral Bias](color-temperature-spectral-bias.md)
