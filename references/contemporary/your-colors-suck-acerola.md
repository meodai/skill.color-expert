# Your Colors Suck (It's Not Your Fault)

**Source:** [Acerola](https://www.youtube.com/@Acerola_t) (YouTube)
**Date:** 2023-09-30
**URL:** https://www.youtube.com/watch?v=fv-wlo8yVhk
**Duration:** 37:01
**Views:** 627,648

## Description

Deep technical video essay on digital color theory for game developers and digital artists. Covers the full pipeline from quantization through CIE colorimetry to OKLAB, explaining why default art program color pickers produce bad results.

## Topics Covered

### Posterization & Quantization

- Reducing gradients to fewer tones — foundation of toon shading
- 8 values per channel = 512 colors from 17 million
- **Color banding** — visible transitional artifacts when too few colors fill a gradient
- **Dithering** — adding noise to break up banding (Floyd-Steinberg, ordered/Bayer matrix)
- **Palette swapping** — mapping quantized values to a custom palette; value mapping via ramps

### Radiometry & Photometry

- **Radiance** — physical energy of light (watts)
- **Luminance** — radiance weighted by human eye sensitivity (candela/m²)
- **Luminous efficiency function** — eyes most sensitive at ~555nm (green-yellow); red and blue much less efficient
- This is why green contributes most to perceived brightness in the luminance formula

### How Humans See Color

- **S, M, L cones** — short, medium, long wavelength sensitivity
- **Tri-stimulus response** — perceived color = combination of three cone signals
- A spectral power distribution (SPD) → three numbers describing cone response

### CIE Color Matching (1931)

- Three beams of light matched to single-wavelength test colors by adjusting knobs (-1 to +1)
- **Color matching functions** — convert SPD to three values
- Negative weights exist for some wavelengths → CIE proposed XYZ to make all values positive
- **CIE XYZ** — contains all visible colors; the foundation reference space
- **Chromaticity diagram** — 2D projection of XYZ; spectral locus + purple line

### From XYZ to RGB (sRGB Derivation)

- Choose three primaries on the chromaticity diagram → defines a triangle (gamut)
- sRGB primaries chosen to match common CRT phosphors
- Linear RGB → apply gamma curve (≈2.2) → sRGB
- sRGB covers only a fraction of visible colors

### HSL — Why It's Bad

- Just a geometric rearrangement of RGB into a cylinder
- **Lightness in HSL is a lie** — fully saturated yellow and fully saturated blue have the same "L" value but vastly different perceived brightness
- Saturation in HSL is also non-perceptual
- Moving around the hue wheel shifts perceived brightness unpredictably
- "Your art program's default color picker is lying to you"

### Perceptual Color Spaces

- **CIELAB** — attempt at perceptual uniformity; L* (lightness), a* (green↔red), b\* (blue↔yellow)
- Still not perfectly uniform; hue shifts in blues, discontinuities
- **OKLAB (Björn Ottosson, 2020)** — better perceptual uniformity
  - Pipeline: sRGB → linear RGB → XYZ → LMS (cone response) → cube root → matrix transform → OKLAB
  - L (lightness), a (green↔magenta), b (blue↔yellow)
  - **Gradients are smooth** — no unexpected hue shifts or brightness dips
  - Moving around the hue wheel at constant L keeps perceived brightness consistent

### Practical Advice

- **Drop the HSL color picker** — switch to CIELAB or ideally OKLAB
- "A competent artist can use HSL to get the right color, but OKLAB just makes your life easier"
- In OKLAB, moving around the hue wheel is the only thing you need to do to stay consistent with values
- Most art programs have CIELAB built in — just switch the mode
- Photoshop has an OK Color Picker plugin

## Links

- **OKLAB (Björn Ottosson):** https://bottosson.github.io/posts/oklab/
- **OKLAB critique (Raph Levien):** https://raphlinus.github.io/color/2021/01/18/oklab-critique.html
- **Photoshop OK Color Picker:** https://exchange.adobe.com/apps/cc/66314516/ok-color-picker
- **Bruce Lindbloom (XYZ↔RGB):** http://www.brucelindbloom.com/index.html?Eqn_XYZ_to_RGB.html
- **Ocean Optics Book (XYZ to RGB):** https://www.oceanopticsbook.info/view/photometry-and-visibility/from-xyz-to-rgb
- **AcerolaFX shaders (free):** https://github.com/GarrettGunnell/AcerolaFX

## Key Takeaways for the Skill

- sRGB gamut = triangle on chromaticity diagram defined by CRT phosphor primaries + gamma ≈ 2.2
- HSL lightness is meaningless for comparing colors across hues
- OKLAB is the recommended space for: gradients, palette generation, color manipulation, and color picking
- CIE color matching functions → XYZ → gamut definition → RGB is the fundamental pipeline
- Luminous efficiency peaks at ~555nm — green dominates perceived brightness
