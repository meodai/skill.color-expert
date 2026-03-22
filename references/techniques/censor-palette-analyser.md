# Censor — Perceptual Palette Analyser

**Source:** [GitHub — Quickmarble/censor](https://github.com/Quickmarble/censor)
**Author:** Quickmarble
**License:** MIT
**Install:** `cargo install censor-analyser`

## What It Does

Rust command-line tool for **analyzing and visualizing color palettes** (2–256 colors). Generates comprehensive PNG analysis sheets with 20+ visualization widgets, all using **CAM16UCS** for perceptual accuracy. Also supports dithering for palette reduction.

Inspired by DawnBringer's GrafX2 Palette Analyser.

## Key Feature: CAM16UCS Throughout

All widgets use **CAM16UCS** (Color Appearance Model 16, Uniform Color Space) — the most advanced perceptual color model available. More accurate than OKLAB for color distance, especially for dark colors and colors under different illuminants.

Configurable illuminant: D50, D55, D65, or custom color temperature (default 5500K). Preserves ICC profiles from PNG/JPEG inputs.

## Commands

```bash
# Analyze a palette from image
censor analyse -i input.png

# Analyze hex colors
censor analyse -c 2e3037,ebe5ce,7a5c3e

# Load from Lospec.com
censor analyse -l aurora -o aurora-analysis.png

# Dither image to restricted palette
censor dither mona_lisa.jpg -l warmlight --bluenoise 18x18 -o result.png

# CSV metrics
censor compute -l aurora --all

# Daemon mode for batch processing
censor daemon -p 8008
```

## 20+ Visualization Widgets

### Hue/Lightness

- Rectangular hue-lightness (fixed chroma)
- Polar hue-chroma plot
- Polar hue-lightness at fixed chroma levels
- Hue-lightness scatter

### Spectral

- CIExy spectral distribution with non-spectral line
- Spectral box (parabolic parametrization through black/white)
- "Temperature" distribution (normalized -log(CCT))

### Palette Analysis

- Indexed palette grid
- **Close color clustering** (with lightness weighting) — finds redundant colors
- **Internal similarity metric:** `(mean_d / min_d) / n^(2/3)` — single number for palette quality
- Complementary color pairs
- **Useful color mixes** — points maximizing distance from existing palette
- Acyclic check

### Perceptual

- **CAM16UCS 3D cubes** (multiple angles) — see palette in perceptual space
- Lightness-sorted with neutralizers
- Lightness-chroma bars
- Greyscale simulation (variable weights)
- 12-bit RGB approximation
- Close color detection with lightness weights

## Dithering Algorithms

| Method             | Description                                  |
| ------------------ | -------------------------------------------- |
| `--nodither`       | Nearest-neighbor quantization                |
| `--bayer N`        | Ordered dithering with 2^N Bayer matrix      |
| `--whitenoise WxH` | White noise ordered dithering                |
| `--bluenoise WxH`  | Blue noise ordered dithering (default 14×14) |

## Why It Matters

- **CAM16UCS** is more perceptually accurate than OKLAB or CIELAB — especially for palette analysis where you need to compare colors under realistic viewing conditions
- **Internal similarity metric** gives a single quality score for palette balance
- **Close color detection** reveals redundancy — same insight as palette-shader's Voronoi but via a different approach
- **Useful color mixes** suggests which colors to ADD to a palette
- **Dithering** with perceptual distance ensures best possible palette reduction

## Links

- **GitHub:** https://github.com/Quickmarble/censor
- **crates.io:** https://crates.io/crates/censor-analyser
- **Lospec integration:** load any Lospec.com palette by name
