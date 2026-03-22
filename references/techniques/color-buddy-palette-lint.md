# Color Buddy — Palette Linting & Analysis

**Source:** [GitHub — mcnuttandrew/color-buddy](https://github.com/mcnuttandrew/color-buddy)
**Author:** Andrew McNutt
**Demo:** https://color-buddy.netlify.app/
**Docs:** https://color-buddy-docs.netlify.app/
**Paper:** "Mixing Linters with GUIs: A Color Palette Design Probe" (arXiv:2407.21285)
**License:** BSD-3-Clause

## What It Does

Interactive tool for developing and **linting** color palettes. Like ESLint for code, but for color palettes — applies automated checks against accessibility, perceptual quality, affect, and design rules. Includes LLM integration (Gemini/OpenAI/Claude) for auto-fixes.

## The Palette Lint Language

A domain-specific language for expressing color palette checks. Supports:

- **Quantifiers:** for-all, there-exists
- **Comparisons:** contrast ratios, deltaE, distances
- **Color functions:** `cvdSim` (CVD simulation), `toSpace`, `inGamut`
- **Aggregates:** mean, std dev, min, max across palette

## 38 Built-in Lint Rules

### Contrast & Accessibility (5)

| Rule                       | Check                                    |
| -------------------------- | ---------------------------------------- |
| Graphical Objects Contrast | ≥3:1 contrast with background (WCAG 2.1) |
| AA Text Contrast (tagged)  | ≥4.5:1 for text-tagged colors            |
| AAA Text Contrast (tagged) | ≥7:1 for text-tagged colors              |
| AA Text Contrast (all)     | ≥4.5:1 for all palette colors            |
| AAA Text Contrast (all)    | ≥7:1 for all palette colors              |

### Color Vision Deficiency (4)

| Rule                  | Check                                          |
| --------------------- | ---------------------------------------------- |
| Deuteranopia-friendly | Colors distinguishable under deutan simulation |
| Protanopia-friendly   | Colors distinguishable under protan simulation |
| Tritanopia-friendly   | Colors distinguishable under tritan simulation |
| Grayscale compatible  | Colors distinguishable in grayscale            |

### Affective Properties (6)

| Rule               | Check                                           |
| ------------------ | ----------------------------------------------- |
| Serious affect     | No highly saturated light colors (L>70, S<70)   |
| Trustworthy affect | Same constraint as serious                      |
| Calm affect        | Same constraint as serious                      |
| Playful affect     | Requires light blue, beige, or gray present     |
| Positive affect    | Excludes dark reds and browns                   |
| Negative affect    | Excludes light greens and high-lightness colors |

### Distribution & Fairness (4)

| Rule                        | Check                                        |
| --------------------------- | -------------------------------------------- |
| Even hue distribution       | Sorted hue std dev <10° (categorical)        |
| Even lightness distribution | Sorted lightness std dev <5                  |
| Fair (categorical)          | Luminance range <50, chroma range <80 in LCH |
| Fair (sequential/diverging) | Luminance range <50 in LCH                   |

### Distinctness & Discriminability (7)

| Rule                            | Check                                     |
| ------------------------------- | ----------------------------------------- |
| Mutually distinct               | All pairs >15 Lab distance                |
| Colors distinguishable in order | Adjacent colors >10 ΔE2000                |
| Color name discriminability     | Each color gets a unique name             |
| Thin object distinctness        | Lab thresholds: L:12.58, a:20.74, b:34.05 |
| Medium object distinctness      | Lab thresholds: L:6.58, a:8.42, b:11.09   |
| Wide object distinctness        | Lab thresholds: L:5.83, a:6.88, b:8.22    |
| Avoid excessive contrast        | WCAG contrast ≤10:1 on bright backgrounds |

### Palette Structure (5)

| Rule                | Check                                             |
| ------------------- | ------------------------------------------------- |
| Sequential order    | Colors ordered by increasing/decreasing lightness |
| Diverging order     | Middle color must be lightest or darkest          |
| Require complements | At least one 180° hue pair (±5° tolerance)        |
| Max colors          | Palette ≤10 colors                                |
| In gamut            | All colors valid sRGB                             |

### Color Quality (4)

| Rule                      | Check                                  |
| ------------------------- | -------------------------------------- |
| Avoid extreme colors      | No pure black/white/red/green/blue     |
| Avoid ugly colors         | >10 ΔE2000 from known undesirable hues |
| Avoid tetradic palettes   | No 90-180-270° hue relationships       |
| Prefer yellow/blue greens | Green hues <90° or >150°               |

### Design-Specific (3)

| Rule                    | Check                                        |
| ----------------------- | -------------------------------------------- |
| Axes low contrast       | Axis colors <20 L\* contrast with background |
| Background desaturation | Backgrounds adequately desaturated           |
| Blue term recognition   | Blue-tagged colors must match blue naming    |

## Why This Matters

**No other tool does this.** Most palette tools help you _create_ colors but don't validate the result against formal criteria. Color Buddy applies the same rigor software engineering uses (linting) to color design:

- **Accessibility:** catch WCAG failures before shipping
- **CVD safety:** verify all three types automatically
- **Perceptual quality:** ensure distinctness at different rendering sizes (thin/medium/wide objects)
- **Fairness:** categorical palettes shouldn't privilege some data categories with brighter/more vivid colors
- **Affect:** match the emotional register of the palette to the application's tone
- **"Ugly color" avoidance** — same principle as pro-color-harmonies' muddy-zone avoidance

## Architecture

| Package                    | Purpose                        |
| -------------------------- | ------------------------------ |
| `color-buddy-palette-lint` | Core linting engine (reusable) |
| `color-buddy-palette`      | Palette manipulation           |
| `color-buddy-color-namer`  | Color naming                   |
| `apps/color-buddy`         | Interactive Svelte app         |

## Links

- **GitHub:** https://github.com/mcnuttandrew/color-buddy
- **Live app:** https://color-buddy.netlify.app/
- **Docs:** https://color-buddy-docs.netlify.app/
- **Lint language docs:** https://color-buddy-docs.netlify.app/lang-docs
- **Paper:** arXiv:2407.21285
