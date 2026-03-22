# color-spd — Making Color with Spectral Power Distributions

**Source:** [GitHub — mattdesl/color-spd](https://github.com/mattdesl/color-spd)
**Author:** Matt DesLauriers (mattdesl)
**Demo:** https://mattdesl.github.io/color-spd/

## What It Does

A web tool for creating colors by directly editing **spectral power distributions (SPDs)** — the physical representation of light as energy across wavelengths. Instead of choosing colors by hue/saturation/lightness, you shape the spectral curve and see the resulting perceived color.

## Why This Is Unique

Most color tools work in derivative spaces (RGB, HSL, OKLCH) — abstractions built on top of how we perceive light. color-spd works at the **physics level**: the actual distribution of energy across the visible spectrum (~380–700nm).

This means you can:

- **Create metamers** — different spectral curves that produce the same perceived color
- **Understand why certain colors look the way they do** — see the underlying spectral structure
- **Bridge physics and perception** — watch how changes in spectral energy translate to perceived color changes
- **Explore spectral mixing** — combine spectral curves physically, not just numerically in RGB

## Conceptual Significance

This tool makes tangible the concepts from:

- **Pixar Color Science** (SPDs of daylight vs candle light)
- **FocalPaint** (spectral reflectance editing for impossible pigments)
- **Briggs's "What is a Colour?"** (three levels: spectral → psychophysical → perceptual)

The SPD is the ground truth of color — everything else (XYZ, RGB, OKLCH) is a lossy compression of this information. Two very different SPDs can produce the same RGB value (metamerism), and this tool lets you see and explore that directly.

## Links

- **GitHub:** https://github.com/mattdesl/color-spd
- **Demo:** https://mattdesl.github.io/color-spd/
- **Part of:** [mattdesl's Generative Color Workshop](https://github.com/mattdesl/workshop-generative-color)
