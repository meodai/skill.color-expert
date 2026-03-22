---
name: color-expert
description: Use when working with color naming, color theory, color spaces, color definitions, or any task involving color knowledge - palettes, conversions, accessibility, perception, or historical color terminology
---

# Color Expert

A comprehensive knowledge base for color-related work. See `references/INDEX.md` for 100+ detailed reference files; this skill file contains the essential knowledge to answer most questions directly.

## Color Spaces — What to Use When

| Task                            | Use                                    | Why                                                                       |
| ------------------------------- | -------------------------------------- | ------------------------------------------------------------------------- |
| Perceptual color manipulation   | **OKLCH**                              | Best uniformity for lightness, chroma, hue. Fixes CIELAB's blue problem.  |
| CSS gradients & palettes        | **OKLCH** or `color-mix(in oklab)`     | No mid-gradient darkening like RGB/HSL                                    |
| Gamut-aware color picking       | **OKHSL / OKHSV**                      | Ottosson's picker spaces — cylindrical like HSL but perceptually grounded |
| Normalized saturation (0-100%)  | **HSLuv**                              | CIELUV chroma normalized per hue/lightness. HPLuv for pastels.            |
| Print workflows                 | **CIELAB D50**                         | ICC standard illuminant                                                   |
| Screen workflows                | **CIELAB D65** or OKLAB                | D65 = screen standard                                                     |
| HDR                             | **Jzazbz / ICtCp**                     | Designed for extended dynamic range                                       |
| Pigment/paint mixing simulation | **Kubelka-Munk** (Spectral.js, Mixbox) | Spectral reflectance mixing, not RGB averaging                            |
| Color difference (precision)    | **CIEDE2000**                          | Gold standard perceptual distance                                         |
| Color difference (fast)         | **Euclidean in OKLAB**                 | Good enough for most applications                                         |
| Video/image compression         | **YCbCr**                              | Luma+chroma separation enables chroma subsampling                         |

### Understanding HSL's Limitations

HSL isn't "bad" — it's a simple, fast geometric rearrangement of RGB into a cylinder. It's fine for quick color picking and basic UI work. But its three channels don't correspond to human perception:

- **Lightness (L):** fully saturated yellow (`hsl(60,100%,50%)`) and fully saturated blue (`hsl(240,100%,50%)`) have the same L=50% but vastly different perceived brightness. L is a mathematical average, not a perceptual measurement.
- **Hue (H):** non-uniform spacing. A 20° shift near red produces a dramatic change; the same 20° near green is barely visible. The green region is compressed, reds are stretched.
- **Saturation (S):** doesn't correlate with perceived saturation. A color can have S=100% and still look muted (e.g., dark saturated blue).

**When HSL is fine:** simple color pickers, quick CSS tweaks, situations where perceptual accuracy doesn't matter.

**When to use something better:**

- Generating palettes or scales → **OKLCH** (uniform lightness across hues)
- Creating gradients → **OKLAB** or `color-mix(in oklab)` (no mid-gradient darkening)
- Gamut-aware picking with HSL-like UX → **OKHSL** (Ottosson's perceptual HSL)
- Normalized saturation 0–100% → **HSLuv** (CIELUV-based, no out-of-bounds)

### Key Distinctions

- **Chroma** = colorfulness relative to a same-lightness neutral reference
- **Saturation** = perceived colorfulness relative to the color's own brightness
- **Lightness** = perceived reflectance relative to a similarly lit white
- **Brightness** = perceived intensity of light coming from a stimulus
- Same chroma ≠ same saturation. These are different dimensions.

## Accessibility — Key Numbers

Of ~281 trillion hex color pairs (research by @mrmrs\_, computed via a Rust brute-force run):

| Threshold                 | % passing | Odds            |
| ------------------------- | --------- | --------------- |
| WCAG 3:1 (large text)     | 26.49%    | ~1 in 4         |
| WCAG 4.5:1 (AA body text) | 11.98%    | ~1 in 8         |
| WCAG 7:1 (AAA)            | 3.64%     | ~1 in 27        |
| APCA 60                   | 7.33%     | ~1 in 14        |
| APCA 75 (fluent reading)  | 1.57%     | ~1 in 64        |
| APCA 90 (preferred body)  | **0.08%** | **~1 in 1,250** |

APCA is far more restrictive than WCAG at comparable readability. At APCA 90, only 239 billion of 281 trillion pairs work. JPEG compression exploits the same biology: chroma subsampling (4× less color data) is invisible because human vision resolves brightness at higher resolution than color.

## Color Harmony — What Actually Works

### Hue-first harmony is a weak standalone heuristic

Complementary, triadic, tetradic intervals are weak predictors of mood, legibility, or accessibility on their own. Every hue plane has a different shape in perceptual space, so geometric hue intervals do not guarantee perceptual balance.

### Character-first harmony works (Ellen Divers' research)

Organize by character (pale/muted/deep/vivid/dark), not hue. Finding: **hue is usually a weaker predictor of emotional response than chroma and lightness** — a muted palette often reads as calm across many hues. Relaxed vs intense is driven more by chroma + lightness than hue alone.

### Legibility = lightness variation

Grayscale is a quick sanity check for lightness separation, not an accessibility proof. You still need to verify contrast with WCAG/APCA and consider text size, weight, polarity, and CVD. Same character + varied lightness is often more readable. Same lightness regardless of hue is usually illegible.

### The 60-30-10 rule

60% dominant color, 30% secondary, 10% accent. One color dominates to prevent "three equally-sized gorillas fighting."

## Pigment Mixing — Not What You Think

- **Pigment mixing is not well described by the simple subtractive model alone** — "integrated mixing" (Küppers/Briggs) is a better practical description. It behaves like a compromise between subtractive and additive averaging.
- **CMY mixing paths curve outward** (retain chroma = vivid secondaries) — "extroverted octopus"
- **RGB mixing paths curve inward** (lose chroma = dull browns) — "introverted octopus"
- **Mixing is non-linear**: proportion of paint ≠ proportional hue change. You "turn a corner" at certain ratios.
- **Blue→yellow is a LONG road**, red→yellow is SHORT. Traditional wheel massively misrepresents distances.
- **Tinting strength varies**: blues are concentrated/strong, yellows are weak.
- **White doesn't just lighten** — it shifts hue AND kills chroma.
- **For spectral/K-M mixing in code**: use Spectral.js (open source) or Mixbox (commercial).

## Color Temperature

- **Temperature ≠ hue** — it's a systematic shift of BOTH hue AND saturation, dependent on starting hue
- **Spectral bias**: which end of the spectrum a light favors (short λ = cool, long λ = warm)
- **Cool daylight**: blue atmospheric scatter fills shadows; paint neutral highlights, blue shadows
- **Warm incandescent**: favors long wavelengths including infrared (literally felt as heat)
- **Green and purple** do not map cleanly to warm/cool in the same way as red-orange or blue-cyan; perceived temperature depends strongly on context

## Color Naming — Multiple Systems for Different Registers

| System                | Register                   | Example                            |
| --------------------- | -------------------------- | ---------------------------------- |
| ISCC-NBS              | Scientific precision       | "vivid yellowish green"            |
| Munsell               | Systematic notation        | "5GY 7/10"                         |
| XKCD                  | Common perception          | "ugly yellow", "hospital green"    |
| Traditional Japanese  | Cultural/poetic            | "wasurenagusa-iro" (forget-me-not) |
| RAL                   | Industrial reproducibility | RAL 5002                           |
| Ridgway (1912)        | Ornithological             | 1,115 named colors, public domain  |
| CSS Named Colors      | Web standard               | 147 named colors                   |
| color-description lib | Emotional adjectives       | "pale, delicate, glistening"       |

Use `color-name-lists` npm package for 18 naming systems in one import.

## Historical Corrections

- **Moses Harris (1769)** was first to place RYB at equal 120° — Newton, Boutet, Schiffermüller didn't. His own wheel needed a 4th pigment. The origin of bad color theory.
- **Von Bezold (1874)** killed "indigo" as a spectral color — Newton's "blue" ≈ modern cyan, Newton's "indigo" ≈ modern blue.
- **The word "magenta"** wasn't used for the subtractive primary until 1907 (Carl Gustav Zander). Before: "pink" (Benson 1868), "crimson," "purpur."
- **Amy Sawyer (1911)** patented a CMY wheel (primrose/rose/turquoise) decades before it became mainstream.
- **Elizabeth Lewis (1931)** married trichromatic + opponent process on one wheel, anticipating CIE Lab by 30 years.

## Recommended Tools

### Palette Generation (actual algorithms, not pre-made swatches)

Note: coolors.co does not generate palettes — it picks randomly from 7,821 pre-made palettes hardcoded in its JS bundle.

- **RampenSau** — hue cycling + easing, color space agnostic
- **Poline** — anchor points + per-axis position functions (1.2K stars)
- **pro-color-harmonies** — adaptive OKLCH harmony, muddy-zone avoidance, 4 styles × 4 modifiers
- **dittoTones** — extract Tailwind/Radix "perceptual DNA", apply to your hue
- **FarbVelo** — random palettes with dark→light structure
- **IQ Cosine Formula** — `color(t) = a + b*cos(2π(c*t+d))`, 12 floats = infinite palette

### Palette Analysis & Linting

- **Color Buddy** — 38 lint rules (WCAG, CVD, distinctness, fairness, affect)
- **Censor** — Rust CLI, CAM16UCS analysis, 20+ viz widgets
- **Color Palette Shader** — WebGL2 Voronoi, 30+ color models, 11 distance metrics
- **PickyPalette** — interactive sculpting on color space canvas

### Color Libraries (code)

- **Culori** — 30 spaces, 10 distance metrics, gamut mapping, CVD sim
- **@texel/color** — 5–125× faster than Color.js, minimal, for real-time
- **Spectral.js** — open-source K-M pigment mixing (blue+yellow=green)
- **RYBitten** — RGB↔RYB with 26 historical color cubes

### Key Online Tools

- **oklch.com** — OKLCH picker
- **Huetone** — accessible color system builder (LCH/OKLCH)
- **View Color** — real-time analysis, WCAG + APCA, CVD preview
- **APCA Calculator** — myndex.com/APCA

## Deep References

See `references/INDEX.md` for 100+ detailed files organized as:

- **`historical/`** (14 files + 14 PDFs) — Ostwald, Helmholtz, Bezold, Ridgway 1912, ISCC-NBS, Caravaggio's pigments, Moses Harris, Lewis/Ladd-Franklin
- **`contemporary/`** (31 files) — Ottosson's OKLAB articles, Briggs lectures (5), CSA webinars (13), Pixar Color Science, Acerola, Juxtopposed, Computerphile, bird tetrachromacy, OLO, GenColor paper. Full scrapes: huevaluechroma.com (11 chapters + glossary), colorandcontrast.com (8 files)
- **`techniques/`** (40 files) — All tools above documented in detail, plus: Tyler Hobbs generative color, Harvey Rayner Fontana approach, Goethe edge colors as design hack, mattdesl workshop + K-M simplex, CSS-native generation, IQ cosine presets, Erika Mulvenna interview, Color Nerd harmony lecture, Bruce Lindbloom math reference, image extraction tools, Aladdin color analysis
