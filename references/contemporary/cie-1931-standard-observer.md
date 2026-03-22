# CIE 1931 — Standard Observer, XYZ, and Color Matching Functions

**Primary Standard Data:** CIE 1931 colour-matching functions, 2 degree observer
**DOI:** https://doi.org/10.25039/CIE.DS.xvudnb9b
**Background Overview:** https://en.wikipedia.org/wiki/CIE_1931_color_space

## What It Is

The foundational colorimetric system behind **XYZ**, **xyY**, the **standard observer**, and nearly every later device-independent color space.

## Key Points

- **Human color matching is trichromatic.** Spectra are projected into three tristimulus values.
- **XYZ is device-independent, not perceptually uniform.** It is a measurement/reference space, not a design space.
- **Y tracks luminance.** This is one reason XYZ remains so central.
- **The standard observer is an abstraction.** It is a model of average human color matching, not a perfect representation of any one human visual system.
- **Metamerism is built in.** Different spectra can map to the same tristimulus values and therefore match visually under specified conditions.

## Why This Matters for the Skill

- Necessary foundation for explaining **spectral data**, **standard illuminants**, **ICC PCS**, **Lab**, **CAMs**, and RGB conversion matrices.
- Best starting point when a user asks where **XYZ** or the **chromaticity diagram** comes from.
- Helps keep spectral workflows honest: color spaces collapse rich spectra into observer-dependent tristimulus values.

## Practical Use

- Use when converting **spectral reflectance or SPD data into XYZ**.
- Use when explaining **standard observer assumptions**.
- Use when a user needs the conceptual base layer under modern color libraries.
