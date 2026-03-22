# Spectral.js — Realistic Pigment Color Mixing

**Source:** [GitHub — rvanwijnen/spectral.js](https://github.com/rvanwijnen/spectral.js)
**Author:** Ronald van Wijnen
**License:** MIT
**Demo:** https://spectraljs.com/

## What It Does

Lightweight JavaScript library for **realistic color mixing based on Kubelka-Munk theory**. Unlike RGB blending (which darkens mid-gradients), it simulates how actual pigments interact with light — producing colors that behave like real paint mixing.

## How It Works (Pipeline)

1. Input RGB → **spectral reflectance curves** (380–750 nm)
2. Calculate **Kubelka-Munk K/S** (absorption/scattering) values
3. Compute **effective concentration** per pigment: `C = f² · T² · L` (factor, tinting strength, luminance)
4. Combine K/S values weighted by concentration
5. Inverse K-M → mixed reflectance
6. Reflectance → **CIE XYZ** (D65 illuminant)
7. XYZ → **sRGB** with smart gamut mapping (OKLCh chroma reduction + ΔE optimization)

## Key Formula

**Kubelka-Munk:** `F(R) = (1 - R)² / 2R = K/S`

- K = absorption coefficient
- S = scattering coefficient
- R = reflectance

## API

```javascript
// Create colors
let blue = new spectral.Color("#002185");
let yellow = new spectral.Color("#FCD200");

// Mix (Kubelka-Munk spectral mixing)
let green = spectral.mix([blue, 0.5], [yellow, 0.5]);
// → #3D933E (vibrant green, not muddy dark like RGB would give)

// Palette generation
let palette = spectral.palette(blue, yellow, 8);

// Gradient sampling
let color = spectral.gradient(0.75, [c1, 0], [c2, 0.5], [c3, 1]);

// Tinting strength
blue.tintingStrength = 0.35; // reduce blue's dominance in mixes
```

## Key Features

- **Kubelka-Munk spectral mixing** — physically-based, not RGB averaging
- **Tinting strength control** — model dominant vs weak pigments
- **GLSL shader support** — GPU-accelerated mixing (2–4 colors)
- **Multiple color spaces:** sRGB, linear RGB, XYZ, OKLab, OKLCh
- **Smart gamut mapping** — OKLCh chroma reduction for out-of-gamut colors
- **deltaE** calculations for perceptual color comparison
- **Lazy memoization** for performance
- **64-bit floating point** precision

## Why It Matters

- **RGB mixing:** blue + yellow = dark gray/brown (additive averaging)
- **Spectral.js:** blue + yellow = vibrant green (like real paint)
- Same insight as Color Nerd's mixing path videos: CMY paths curve outward (retain chroma), RGB paths curve inward (lose chroma)

## Related Projects

- **Mixbox** — commercial spectral mixing library (closed source); Spectral.js is the open-source alternative
- **FocalPaint** — iPad app using similar Kubelka-Munk approach
- **Hello, Mixbox** — interactive K-M visualization in OKLAB

## Technical References

- Kubelka-Munk theory (Kubelka & Munk, 1930s)
- Scott Burns' LHTSS method (spectral data generation)
- Color.js (color space conversions)

## Links

- **GitHub:** https://github.com/rvanwijnen/spectral.js
- **Live demo:** https://spectraljs.com/
- **npm:** `npm install spectral.js`
- **GLSL shader:** included as `spectral.glsl`
- **Ko-fi (support):** https://ko-fi.com/C0C2KEHZW
