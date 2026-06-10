# Bujack — The Geometry of Color in a Non-Riemannian Space

Roxana Bujack (Los Alamos National Laboratory) and colleagues resolve a ~100-year-old gap in
Erwin Schrödinger's 1920s theory of color perception: they define the **neutral (grayscale)
axis** purely from the geometry of the color metric itself, and show that **hue, saturation,
and lightness arise from the intrinsic geometry of color space** — not from external cultural
or perceptual constructs layered on top.

This is the follow-up to Bujack et al.'s 2022 finding that **perceptual color space is *not*
Riemannian** — the standard assumption (going back to Helmholtz, Schrödinger, and used in every
ΔE color-difference metric) that color distances behave like a smooth Riemannian manifold is
wrong, because of **diminishing returns**: the perceived difference of a large color jump is
*less* than the sum of its small steps, which a Riemannian metric cannot represent.

- **Lead:** Roxana Bujack — Los Alamos National Laboratory
- **Co-authors:** Emily N. Stark, Terece L. Turton, Jonah M. Miller, David H. Rogers
- **Paper:** "The Geometry of Color in the Light of a Non-Riemannian Space," *Computer Graphics
  Forum* (Eurographics Conference on Visualization / EuroVis), 2025-05-23.
  DOI: [10.1111/cgf.70136](https://doi.org/10.1111/cgf.70136)
- **2022 precursor:** "The non-Riemannian nature of perceptual color space," *PNAS* (2022).
  DOI: [10.1073/pnas.2119753119](https://doi.org/10.1073/pnas.2119753119)
- **Press:** SciTechDaily / Los Alamos National Laboratory, 2026-05-10 —
  <https://scitechdaily.com/scientists-solve-100-year-old-schrodinger-mystery-about-color-perception/>

## The Core Findings

### 1. Color space is non-Riemannian (2022)

The classical model treats color difference as a Riemannian metric: total distance along a path
= sum of infinitesimal steps. Empirically that **overestimates** large differences. Human vision
shows **diminishing returns** — a big perceptual gap reads as smaller than the accumulated small
steps that span it. A Riemannian geometry can't encode this; you need a more general
(non-Riemannian) structure. Consequence: ΔE-style metrics (CIE76, CIE94, CIEDE2000) are built on
an assumption that doesn't hold for large differences.

### 2. The neutral axis falls out of the geometry (2025)

Schrödinger could describe the geometry of color but couldn't formally pin down *where the
grayscale axis lives* from first principles. Bujack et al. derive the black→white neutral line
**from the color metric alone**, then show hue, saturation, and lightness as intrinsic geometric
properties of that metric:

> "These color qualities don't emerge from additional external constructs … but reflect the
> intrinsic properties of the color metric itself." — Roxana Bujack

### 3. Geodesics explain the Bezold–Brücke effect

Using **shortest-path (geodesic) calculations through perceptual color space** in the
non-Riemannian framework, they account for the **Bezold–Brücke effect** — perceived hue shifts
as light intensity changes (most hues drift toward yellow or blue as they get brighter) — and for
the diminishing-returns behavior of color distinction.

## Why It Matters

- **Foundational, not cosmetic.** This challenges the metric assumption under every perceptual
  color-difference formula. "Use OKLAB / CIEDE2000 for ΔE" is still the right *practical* advice,
  but be aware the underlying geometry is an approximation that breaks down for large jumps.
- **Pairs with the empirical work.** Sits alongside [MacAdam ellipses](macadam-ellipses-jnd.md)
  (CIE 1931 isn't uniform) and [Koenderink's 3D metric field](koenderink-3d-metric-field-rgb.md)
  (dense empirical discrimination across RGB) — three converging lines that perceptual color
  space is lumpier and less well-behaved than the textbook smooth-manifold picture.
- **Derivation over convention.** Lightness/hue/saturation being *derivable* from the metric,
  rather than imposed, is the same spirit as preferring computed/semantic color decisions over
  hand-picked literals — the structure should fall out of the constraints.

## Links

- **Press article:** <https://scitechdaily.com/scientists-solve-100-year-old-schrodinger-mystery-about-color-perception/>
- **2025 CGF paper (DOI):** <https://doi.org/10.1111/cgf.70136>
- **2022 PNAS paper (DOI):** <https://doi.org/10.1073/pnas.2119753119>
