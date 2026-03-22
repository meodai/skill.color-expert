# Bruce Lindbloom — Color Science Math & Calculators

**Source:** http://www.brucelindbloom.com/
**Author:** Bruce Lindbloom

## What It Is

The definitive reference site for **color space conversion mathematics**. Every equation you need for converting between color representations, with online calculators and downloadable spreadsheets. Referenced by Acerola, Culori source code, and countless color libraries.

## Key Pages

### Equations (http://www.brucelindbloom.com/Math.html)

All the math for converting between color spaces:

| Conversion           | URL                                                   |
| -------------------- | ----------------------------------------------------- |
| RGB → XYZ            | http://www.brucelindbloom.com/Eqn_RGB_to_XYZ.html     |
| XYZ → RGB            | http://www.brucelindbloom.com/Eqn_XYZ_to_RGB.html     |
| RGB/XYZ Matrices     | http://www.brucelindbloom.com/Eqn_RGB_XYZ_Matrix.html |
| XYZ → Lab            | http://www.brucelindbloom.com/Eqn_XYZ_to_Lab.html     |
| Lab → XYZ            | http://www.brucelindbloom.com/Eqn_Lab_to_XYZ.html     |
| Lab → LCH            | http://www.brucelindbloom.com/Eqn_Lab_to_LCH.html     |
| Chromatic Adaptation | http://www.brucelindbloom.com/Eqn_ChromAdapt.html     |
| Spectral → XYZ       | http://www.brucelindbloom.com/Eqn_Spect_to_XYZ.html   |
| ΔE calculations      | various                                               |

### Calculators (http://www.brucelindbloom.com/Calc.html)

| Calculator                | Purpose                                                     |
| ------------------------- | ----------------------------------------------------------- |
| CIE Color Calculator      | Convert between XYZ, Lab, LCH, Luv, RGB with any illuminant |
| Chromatic Adaptation      | Adapt between illuminants (Bradford, Von Kries, etc.)       |
| ColorChecker Calculator   | Compute XYZ values spectrally for ColorChecker patches      |
| Lab Gamut Display         | Visualize the gamut of a color space in Lab                 |
| RGB/XYZ Matrix Calculator | Compute matrices from custom primaries + white point        |

### Key Technical Details

- **sRGB = D65**, ICC profiles = D50 → chromatic adaptation needed between them
- **Bradford method** — considered best chromatic adaptation; used in Adobe Photoshop
- **Linear RGB required** — all matrix math requires linearized (gamma-decoded) RGB, not sRGB
- **CIE L\* continuity study** — analysis of the L\* function's mathematical properties

## Lab Gamut Display — How It Works

The Lab gamut = ALL physically possible surface colors (non-fluorescing materials, D50 illuminant). Not just sRGB — every color any material could ever produce.

**Construction:** For every possible spectral reflectance (0–1 at each wavelength) → integrate with CIE 2° observer → XYZ → Lab → plot. The boundary of all points = the gamut.

**Square pulse method** for finding surface colors: sweep binary pulses of increasing width through the spectrum (1,480 samples at 0.25nm), with wrap-around. Join resulting Lab points into triangle mesh.

**Key insight — integer Lab encoding wastes ~2/3 of space:** TIFF/ICC/Photoshop use a*,b* range [-128,127]. Some real colors are excluded (lobes bulge outside), while most encodable values can never physically occur.

**What the shape reveals:** yellow extends FAR further in chroma than blue; gamut is wildly asymmetric; maximum chroma varies dramatically with lightness+hue. This is why gamut mapping is necessary.

## Why This Matters for the Skill

- **The math reference** when implementing color conversions from scratch
- **Chromatic adaptation** is critical when converting between D50 (print) and D65 (screen) workflows
- **RGB/XYZ matrices** are the foundation — every color library uses these
- The Lab gamut visualization shows why gamut mapping is necessary (not all perceptually valid colors are displayable)

## Links

- **Home:** http://www.brucelindbloom.com/
- **Equations:** http://www.brucelindbloom.com/Math.html
- **Calculators:** http://www.brucelindbloom.com/Calc.html
- **Lab Gamut Display:** http://www.brucelindbloom.com/index.html?LabGamutDisplayHelp.html
