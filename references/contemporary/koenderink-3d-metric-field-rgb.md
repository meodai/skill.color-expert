# Koenderink et al. — Empirical 3D Metric Field for Color Space (2026)

**Full title:** An empirical three-dimensional metric field for color space
**Authors:** Jan Koenderink, Andrea van Doorn, Doris I. Braun, Karl R. Gegenfurtner
**Affiliation:** Abteilung Allgemeine Psychologie and Center for Mind, Brain & Behavior, Justus-Liebig-Universität Gießen
**Venue:** bioRxiv preprint (posted 2026-03-11), CC-BY 4.0
**DOI:** [10.64898/2026.03.09.710376](https://doi.org/10.64898/2026.03.09.710376)
**Local PDF:** [pdfs/koenderink-2026-empirical-3d-metric-field.pdf](pdfs/koenderink-2026-empirical-3d-metric-field.pdf)

## What It Is

The first **dense, volumetric, empirical mapping of color discrimination across the full RGB cube**. Where MacAdam (1942) gave local ellipses in one isoluminant plane, and CIEDE2000 parametrically corrects CIELAB to match sparse planar data, this paper measures the full 3D structure directly.

8 observers × 35 reference colors (body-centered cubic lattice inside the RGB cube) × 7 orientations × 14 opposite directions × 5 turning points each. Instead of threshold "just noticeable differences," they measured **Notable Qualitative Differences (NQD)** — finite perceptual steps that feel like a clear qualitative change, not detection-limit JNDs.

At each reference color, the fourteen directional extents define a centrally symmetric convex region; the **Löwner–John minimum-volume ellipsoid** is fit to it. Each ellipsoid becomes a 3×3 symmetric positive-definite (SPD) matrix; the SPD matrices across RGB space form a **metric field** that can be compared, averaged, and interpolated using the Frobenius geometry (treating symmetric matrices as a 6-D Euclidean vector space). Interpolation uses Gaussian radial basis functions over nearest BCC neighbors.

## Key Results

- **Observer variability is ~multiplicative, not structural.** Across 8 observers, median ellipsoid diameters vary by ~4×, but Kendall rank correlations of Frobenius norm vs the group median run 0.55–0.72. After normalizing each observer to a common median Frobenius norm, the spatial structure aligns closely. The **criterion** differs between observers; the **geometry** does not.
- **RGB space accommodates only ~1,000 qualitatively distinct regions.** A practical packing of non-overlapping grain ellipsoids at median spacing (0.14 in RGB units) fills the cube with roughly a thousand ellipsoids. Not a strict capacity — a geometric statement about granularity at the scale of finite perceptual steps. *This is a far smaller number than threshold-JND–based "millions of discriminable colors" estimates.*
- **Grain grows along the achromatic axis.** Ellipsoids near black are small; ellipsoids near white are large. The black↔white diagonal shows monotonic growth. Greater lightness tolerance than chromatic tolerance around neutrals.
- **Opponent diagonals are V-shaped and asymmetric.** Along red–cyan, yellow–blue, and purple–green, grain is smallest near the center of the cube and grows toward both ends, with **systematic asymmetry: cyan, blue, and green sides grow faster than red, yellow, and purple sides.** Koenderink interprets this as the "cool vs warm" unbalance familiar to painters (cool regions are "coarser"; warm regions are "finer").
- **Hue is not well-tempered.** A circular path through RGB interior shows grain size varying substantially with hue — equal angular steps are not equal qualitative steps. Confirms the "not well-tempered color circle" claim from Koenderink, van Doorn & Braun (2024, i-Perception).
- **Agreement with CIEDE2000:** strong rank correlation of volumes (Kendall τ = 0.78, p < 10⁻¹⁰), so CIEDE2000 captures large-scale volumetric variation well. But **CIEDE2000 ellipsoids are systematically more prolate/eccentric** than the empirical ones, which are closer to spheroidal with only mild elongation. The separable lightness/chroma/hue parameterization of CIEDE2000 imposes anisotropies that don't exactly match empirical geometry.
- **Gamma vs L\*.** The sRGB gamma (≈2.4) produces a compression of physical intensity very similar to the cube-root of CIELAB L\* over the display-relevant range. Working in raw RGB after gamma already approximates a perceptually meaningful intensity axis — small correction is likely within the noise of the grain measurement itself (see Appendix A1).

## Why RGB (and not Lab / xy)

Two explicit arguments:

1. **It's the generative stimulus space.** Every modern LCD/OLED/LED/HMD produces color from three additive primaries. Measuring in RGB avoids the transformation and assumption stack that CIE-based measurement requires.
2. **Ecological coverage.** The 2D projection of the sRGB triangle onto the CIE xy chromaticity diagram looks small because the projection "dramatically distorts volumetric relations." In 3D, the RGB cube occupies ~2/3 of the color solid, and most natural object reflectances and Munsell chips fall inside or close to it. The "huge gray area outside the triangle on xy" is mostly empty of real object colors. (Same authors: Koenderink, van Doorn & Gegenfurtner, 2021.)

## Conceptual Shift

The paper reframes color geometry:

- Not a **single global distance formula** (ΔE₇₆, ΔE₂₀₀₀) fit to sparse data, but a **metric field** — a smoothly varying SPD tensor at every point. At each color, the local geometry is different; the distance formula must respect that locally.
- Not **infinitesimal thresholds**, but **finite qualitative steps** — a different level of description. Threshold psychophysics probes the edge of detection; NQDs probe the scale at which color space feels segmented into distinct regions. These are different geometries. Threshold data gives smooth continuity; qualitative grain gives discretization around ~1,000 regions.
- Larger color differences can be recovered by **integrating the local metric along geodesics** through the field, giving a principled path from local perceptual geometry to an approximate global formula.

## Why This Matters for the Skill

- **Major update to how "perceptually uniform" should be discussed.** CIELAB / OKLAB / CIEDE2000 are all approximations to an empirical metric field that is structured, anisotropic, and not flatly parameterizable. When asked "is OKLAB uniform?" or "what's the best distance formula?", acknowledge the underlying geometry is a smoothly varying tensor field, not a constant.
- **Strong defense of using RGB directly for display work.** Gamma-encoded sRGB is closer to L\* than usually credited. Avoids the mapping overhead and assumption stack of working in Lab when the stimulus ultimately hits an sRGB display anyway.
- **A concrete number for qualitative color capacity: ~1,000 regions in RGB.** Use this instead of the commonly repeated "10 million discriminable colors" when the question is about **meaningful** color distinctions, palette granularity, color naming, or UI token counts. Threshold discrimination and qualitative grain are different counts at different scales.
- **Warm/cool asymmetry has an empirical geometric basis.** Cool half-space is "coarser-grained" than warm half-space in RGB. Useful when discussing palette balance, warm/cool mood, or why certain hue regions "support more distinct colors."
- **Color circle non-uniformity is empirically measured.** Equal hue degrees ≠ equal perceptual steps — evidence for why OKHSL / OKLCH's hue axis is still non-uniform and why `random-display-p3-color`'s named hue ranges don't have equal angular width.
- **CIEDE2000's known limits are now quantitatively characterized.** It captures volume variation well but over-elongates ellipsoids. Use this as honest nuance when recommending ΔE₂₀₀₀ for industrial tolerance work.

## Practical Use

- When a user asks **"how different is color A from color B?"** — recommend CIEDE2000 or OKLAB-Euclidean for first pass, but note that neither captures local anisotropy correctly and that the ground truth is a locally anisotropic metric field.
- When a user asks **"how many colors can I put in a palette and still have them feel distinct?"** — orders-of-magnitude answer is ~100–1,000 for an entire RGB-displayable set at the level of qualitative distinction. (Not the JND count.)
- When a user asks about **hue spacing in palette generation** — cite the non-well-tempered result: equal angular steps are not equal perceptual steps. Libraries like RampenSau's harveyHue easing and pro-color-harmonies' muddy-zone avoidance are empirically motivated.
- When a user asks **"is xy uniform? is Lab uniform? is OKLAB uniform?"** — none of them are; they're global parameterizations of a locally varying tensor field. OKLAB is a better approximation than xyY or Lab, but still an approximation.

## Related Koenderink Work (same authors, adjacent topics)

- **The well-tempered color circle** (i-Perception 2024, 15(4)) — phenomenological analysis of chromatic non-uniformity.
- **"Warm," "cool," and the colors** (Journal of Vision 2024, 24(7)) — warm/cool as phenomenological axes rather than hue rotation.
- **Chromatics: Warm and cool** (Art & Perception 2024, 13(2), 85–119) — extended treatment of warm/cool.
- **The space of colour & the colour of space** (Gestalt Theory 2022) — foundations.
- **Koenderink, van Doorn & Gegenfurtner (2021)** — RGB cube occupies ~2/3 of the object-color solid (the "small triangle on xy is misleading" argument).

All available on [Jan Koenderink's Google Scholar](https://scholar.google.com/citations?hl=en&user=lxW3wvMAAAAJ).
