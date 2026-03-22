# Workshop: Generative Color — mattdesl

**Source:** [GitHub — mattdesl/workshop-generative-color](https://github.com/mattdesl/workshop-generative-color)
**Author:** Matt DesLauriers (mattdesl)
**Live:** https://generative-color.glitch.me
**Stars:** 99

## What It Is

Hands-on workshop on color science for generative art and creative coding. Includes editable sketches, custom tools, and curated resource links.

## Tools Built for This Workshop

| Tool             | URL                                     | Purpose                                          |
| ---------------- | --------------------------------------- | ------------------------------------------------ |
| **Color Grab**   | https://mattdesl.github.io/colorgrab/   | Extract colors from images                       |
| **Color Swatch** | https://mattdesl.github.io/colorswatch/ | Multi-space color picker                         |
| **Color SPD**    | https://mattdesl.github.io/color-spd/   | Spectral power distribution-based color creation |

## Libraries Used

| Library                                                  | Purpose                           |
| -------------------------------------------------------- | --------------------------------- |
| [Color.js](https://colorjs.io)                           | Color manipulation and conversion |
| [Spectral.js](https://github.com/rvanwijnen/spectral.js) | Spectral/Kubelka-Munk mixing      |
| [Mixbox](https://github.com/scrtwpns/mixbox)             | Pigment-like color mixing         |

## Curated Resource Links

### Color Pickers

- **OKLCH:** https://oklch.com/
- **OKHSV/OKHSL:** https://ok-color-picker.netlify.app/ + [theory](https://bottosson.github.io/posts/colorpicker/)
- **HSLuv:** https://www.hsluv.org

### Color Education

- **147 Named CSS Colors:** https://147colors.com
- **Hue Color Models:** https://colorsupplyyy.com/app/
- **Sorted CSS Colors:** https://enes.in/sorted-colors/
- **Color Systems history:** https://www.colorsystem.com/?lang=en
- **"It's Time to Learn OKLCH"** (Keith J. Grant): https://keithjgrant.com/posts/2023/04/its-time-to-learn-oklch-color/
- **OKLAB theory** (Björn Ottosson): https://bottosson.github.io/posts/oklab/

### Palette Libraries (npm packages)

| Package                                                                                            | Content                                   |
| -------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| [nice-color-palettes](https://github.com/Jam3/nice-color-palettes)                                 | 1000 palettes from ColourLovers           |
| [chromotome](https://www.npmjs.com/package/chromotome)                                             | Curated art/design palettes               |
| [paper-colors](https://www.npmjs.com/package/paper-colors)                                         | Paper stock colors                        |
| [riso-colors](https://www.npmjs.com/package/riso-colors)                                           | Risograph ink colors                      |
| [dictionary-of-colour-combinations](https://github.com/mattdesl/dictionary-of-colour-combinations) | Sanzo Wada's classic dictionary digitized |
| [color-names](https://github.com/meodai/color-names)                                               | 30K+ named colors                         |

### The Wada Sanzō Connection

mattdesl digitized [Sanzo Wada's "Dictionary of Colour Combinations"](https://github.com/mattdesl/dictionary-of-colour-combinations) — the classic 1933 Japanese color reference. This appears in the color-name-lists package as well.

## Technical Contents

- `lib/oklab.js` — OKLAB conversion math (MIT, Björn Ottosson)
- `lib/spectra/` — CIE 1931 2° Standard Observer functions, ColorChecker spectral data
- `sketches/` — editable exercise files for the workshop

## Why This Matters

This workshop is one of the best curated collections of **practical generative color resources**. The three custom tools (Color Grab, Color Swatch, Color SPD) are unique — especially Color SPD which works directly with spectral power distributions, bridging the gap between physics and creative coding.

## Links

- **GitHub:** https://github.com/mattdesl/workshop-generative-color
- **Live (Glitch):** https://generative-color.glitch.me
- **Edit (Glitch):** https://glitch.com/edit/#!/generative-color

---

## mattdesl: K-M Pigment Simplex Palette Generation

**Source:** @mattdesl (social media post)

### Technique

Generate vibrant palettes using **Kubelka-Munk pigment mixing** with 5 primaries: blue, yellow, red, white, black.

**Algorithm:**

1. Define 5 virtual pigments (K-M spectral profiles for blue, yellow, red, white, black)
2. Select 2 pigments randomly
3. Mix at a random concentration ratio
4. Repeat for desired palette size

### Extending to N Dimensions

The approach generalizes: instead of mixing 2 pigments, **sample the N-dimensional pigment simplex** — a point in the space where all N pigment concentrations sum to 1. This means:

- 2 pigments = random point on a line segment
- 3 pigments = random point on a triangle
- 4 pigments = random point on a tetrahedron
- 5 pigments = random point on a 4-simplex

### Why 5 Primaries?

Blue, yellow, red = chromatic gamut (subtractive primaries in painter's terms). White + black = value control. This matches a traditional artist's limited palette (e.g., Zorn palette + blue).

### Why K-M Instead of RGB Mixing?

- RGB: blue + yellow = gray (additive averaging, loses chroma)
- K-M: blue + yellow = vibrant green (spectral pigment mixing, retains chroma)
- Same insight as Spectral.js, FocalPaint, Color Nerd's "extroverted octopus" mixing paths

### Connection to Other Tools

- **Spectral.js** — provides the K-M mixing math in JS/GLSL
- **Mixbox** — commercial alternative for K-M mixing
- **FocalPaint** — iPad app with K-M mixing + editable spectral profiles
- This technique could be implemented using any of these libraries
