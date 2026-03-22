# FarbVelo — Random Color Palette Generator

**Source:** [GitHub — meodai/farbvelo](https://github.com/meodai/farbvelo)
**Author:** meodai
**Demo:** https://farbvelo.elastiq.ch/
**License:** CC-BY-SA-4.0 | **Stars:** 87

## What It Does

Web-based color palette generator that creates harmonious random palettes. Name is Swiss-German for "color bicycle" — the tool cycles through color harmonies algorithmically. Designed for design inspiration, passive enjoyment, and palette exploration.

## Generation Algorithm

### 1. Hue Selection

- Generates random hue stops using **HSLuv** color space
- Minimum angle threshold (default 60°) ensures hue diversity
- Evenly-spaced candidates around the wheel

### 2. Palette Construction

- **Dark anchor:** low saturation (5–40%), low lightness (0–20%)
- **Mid tones:** randomized saturation (50–70%), progressive lightness increases
- **Bright highlight:** desaturated, high lightness
- Hues distributed randomly across these tonal positions

### 3. Interpolation

- **chroma.js** interpolates between color stops in **CIE L\*a\*b\*** space
- 0.175 padding for smooth gradients
- Perceptually even transitions

### 4. Color Naming

- Integrates with [color-names API](https://github.com/meodai/color-names) to assign real names to generated colors
- Beyond raw hex — gives context and character to each swatch

## Key Design Decisions

- **HSLuv for hue selection** — perceptually uniform hue distribution (no green/ultramarine over-representation)
- **CIE L\*a\*b\* for interpolation** — perceptually smooth gradients between stops
- **Dark-to-light structure** — every palette has a usable tonal range (not just a random scatter of saturated hues)
- **Minimum hue angle** — user-controllable diversity vs. analogous-ness

## Technical Stack

- Vue.js frontend
- chroma.js (color math)
- HSLuv (hue selection) + CIE L\*a\*b\* (interpolation)
- Integrates with colorsort-js for ML-trained sorting

## How It Relates to Other Tools

| Tool                    | Approach                                     | Best For                               |
| ----------------------- | -------------------------------------------- | -------------------------------------- |
| **FarbVelo**            | Structured random with dark→light range      | Quick inspiration, full tonal palettes |
| **RampenSau**           | Hue cycling + easing functions               | Algorithmic ramps, generative art      |
| **Poline**              | Anchor interpolation with position functions | Refining between specific colors       |
| **pro-color-harmonies** | Adaptive harmony from single base            | Design system harmonies                |
| **dittoTones**          | Reference system DNA transfer                | Matching Tailwind/Radix quality        |

## Links

- **Live demo:** https://farbvelo.elastiq.ch/
- **GitHub:** https://github.com/meodai/farbvelo
- **Original CodePen:** https://codepen.io/meodai/pen/RerqjG
- **Color Names API:** https://github.com/meodai/color-names
