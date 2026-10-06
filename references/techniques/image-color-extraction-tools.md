# Image Color Extraction Tools

Six tools for extracting color palettes from images — plus one that enables searching by palette.

---

## img-colors.com — Clustering-Based Extraction

**URL:** https://img-colors.com/
**Author:** mrmrs / mrmrs.cc
**Architecture:** Edge-computed (Cloudflare Workers), no server/database

### How It Works

1. **Upload** → resized to max 1,500px, converted to JPEG
2. **Sample** → ~5,000 random pixels (keeps payload tiny)
3. **Cluster** → 7 unsupervised algorithms find palette centroids
4. **Visualize** → 3D point cloud of sampled pixels + centroids
5. **Generate** → click any palette → instant mesh-blurred gradient background

### Seven Methods (with RGB / Lab variants)

| Method                 | What it does                                                                 | Trade-off                                                      |
| ---------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------------------- |
| **K-Means**            | Lloyd-style iteration (`ml-kmeans`) to k centroids                           | Fast; favors round, similar-sized clusters in the color space  |
| **PCA + K-Means**      | One PCA axis orders pixels; quantile-spaced seeds, then K-Means              | Often better seeds than random init; still k-means assumptions   |
| **DBSCAN**             | Density-connected regions in RGB/Lab                                         | Arbitrary shapes; noise points can be dropped                  |
| **OPTICS**             | Ordering by reachability; clusters from density (`density-clustering`)       | Handles varying density better than a single DBSCAN ε           |
| **Agglomerative**      | Hierarchical clustering (average linkage / AGNES), cut to k groups           | Flexible tree cut; heavier on large samples                    |
| **Median-Cut**         | Recursively splits the box with the largest R/G/B range at the median pixel  | Classic quantization; very fast; builds eight buckets in code, then respects the global palette-size limit |
| **Random Sampling**    | k **distinct** random pixels from the subsample, equal weight                | Baseline / stress-test; not optimizing a cluster criterion      |

### 3 Color Spaces for Clustering

| Space                 | Pros                                                       | Cons                                                             |
| --------------------- | ---------------------------------------------------------- | ---------------------------------------------------------------- |
| **RGB**               | Raw screen values, easy math                               | Not perceptually uniform (yellow "farther" from white than blue) |
| **CIELab**            | Perceptually uniform — equal step = equal perceived change | Best for human-expectation clustering                            |
| **HSL (cylindrical)** | Separates hue from sat/lightness; good for creative UI     | Wonky distance near poles                                        |

**Tip:** Toggle color space buttons and watch the 3D point cloud morph — same data, different clustering results.

### Mesh Gradient Generation

Click any palette card → instantly generates a blurred mesh gradient background from those colors. Perfect for hero sections or wallpaper experiments.

---

## okpalette.color.pizza — OKLCH-Based Extraction

**URL:** https://okpalette.color.pizza/
**Author:** meodai / Elastiq.ch
**Privacy:** No cookies, no tracking, no uploads

### How It Works

Upload or paste an image → extracts palette in **OKLab/OKLCh** color space with analysis metrics.

### Analysis Metrics

| Metric                     | What it measures             |
| -------------------------- | ---------------------------- |
| **Avg Lightness**          | Overall brightness (%)       |
| **Avg Chroma**             | Color intensity              |
| **Colorfulness**           | Vibrancy quantification      |
| **Light/Dark Ratio**       | Brightness distribution      |
| **Sparse Color Detection** | Whether colors are dispersed |

### Controls

- **Muted ↔ Saturated** slider — bias extraction toward desaturated or vivid colors
- **Dark ↔ Light** slider — bias toward shadows or highlights
- **Auto-Detect Bias** — automatic adjustment

### Visualizations

- HSV Cylinder view
- HSV Cube view
- Debug view (⌘+I)

### Export

- SVG, PNG, statistics data

---

## colorgram-js — Fast Lightweight Palette Extraction

**URL:** https://github.com/darosh/colorgram-js
**npm:** `colorgram`
**Author:** Jan Forst ([@darosh](https://github.com/darosh))
**License:** MIT

### What It Is

A 1 kB (min+gzip) color extraction library for browser and Node. Scans every pixel, buckets by hue/lightness/luminance (top 2 bits each → 64 buckets), returns averaged RGB + proportion. Fixed 1024-byte memory footprint.

### Key Properties

- **Fast:** ~15 ms for 340×340, ~50 ms for 512×512
- **Tiny:** 1 kB min+gzip, no dependencies
- **Fixed memory:** 64 buckets × 4 values × 4 bytes = 1024 bytes
- **Rotation-invariant:** no spatial bias
- **TypeScript:** full types included

### API

```typescript
import { extract, Channels } from 'colorgram';

const palette = extract(
  { data: imageData.data, channels: Channels.RGBAlpha },
  12 // top N colors
);
// Returns: Array of [R, G, B, proportion]
```

Also exports `sample()` (raw buckets), `hsl()` (RGB→HSL), `sortByHsl()`.

### Algorithm

1. Per pixel: compute H, L (HSL) and BT.709 luminance
2. Top 2 bits of each → 6-bit index into 64 buckets
3. Accumulate RGB sums + count per bucket
4. Sort by count, return top N with averaged RGB and proportion

---

## Art Palette — Palette Extraction + Search-by-Color (Google Arts & Culture)

**URL:** https://github.com/googleartsculture/art-palette
**Authors:** Simon Doury ([@voglervoice](https://github.com/voglervoice)), Damien Henry ([@dh7](https://github.com/dh7)) — Google Arts & Culture Lab
**License:** Apache 2.0
**Status:** Archived (read-only since 2025-11)

### What It Is

A two-part system from Google Arts & Culture that extracts palettes from images *and* enables nearest-neighbor palette search across art collections.

### Architecture

| Part | Language | Purpose |
| --- | --- | --- |
| **Frontend** | JavaScript | Palette extractor — processes `ImageData` to compute color palettes from images |
| **Backend** | Python + TensorFlow | Palette embedding model — maps palettes into Euclidean space preserving perceptual color distance |

### How It Works

1. **Extract** → JS frontend processes image data and produces a color palette
2. **Embed** → TensorFlow model encodes palette into a vector where perceptually similar palettes are geometrically close
3. **Search** → Nearest-neighbor lookup finds artworks with matching palettes

### Usage

The JS extractor can be used directly in browser or Node to extract palettes from image data. The Python backend provides a trainable embedding model for building palette-similarity search.

### Why It Matters

- **Perceptual embedding** — palette similarity respects human perception, not just RGB distance
- **Scalable search** — embedding space enables fast nearest-neighbor queries over large art collections
- **Reusable code** — Apache 2.0 licensed JS + Python, ready to integrate into projects

---

## Palette Studio — Meditations in Color (curated painterly extraction)

**URL:** https://meditationsincolor.com/palette-studio
**Author:** Pixel Symphony (pseudonymous algorithmic & plotter artist, California; MA in modern art history and curatorial studies) — https://pixelsymphony.art
**Context:** The extractor behind the Meditations in Color archives (368 painters / 20,564 works; 7,312 directors / 20,100 posters). Uploads are the same routine the archive was built with, so an uploaded sheet and an archive sheet are measured the same way.
**Privacy:** Runs entirely in the browser. The image is never uploaded; the public "Collected Palettes" ledger keeps colour and name only.

### Why the results feel good on artwork

It does *not* return the k-means answer. The source comment says why: on a Klimt, plain k-means "returns four near-identical dusty pinks and never finds the chartreuse or the Payne's grey." Coverage-clustering answers *what area does each colour occupy*; a painter's palette is *which colours make the picture*. Palette Studio runs both and lets the second pick the swatches, then measures the first back onto them for proportions.

### Pipeline (read from the page source, Sept 2026)

1. **Raw clusters** — downscale to ≤160 px long edge, k-means in **OKLab**, k = 12, 14 Lloyd iterations. Seeds are spread evenly along the sorted lightness axis so the first pass spans the sheet instead of collapsing into the darkest region. Output: hex + pixel share.
2. **Accent hunters** — a second pass on a 168 px sample bins pixels to 12-step RGB, drops neutrals (HSL S < 18, L < 12 or > 88), and scores each bin by chroma × midtone-ness × a hue-family boost (red 1.7, green 1.55, orange 1.35, blue/teal 1.24 …) with an extra 2–4× for warm midtones. A dedicated red-accent hunter runs first. Score uses `count^0.36`, so a small but vivid accent can outrank a large dull field.
3. **Achromatic guard** — if the raw clusters are all near-neutral (a B&W poster), the accent pass is withheld, because coarse RGB binning otherwise turns faint casts into "Blush" and "Dark Greyish Blue" on an image with no pink or blue in it.
4. **Prominence ranking** — every candidate gets a display score: √weight, chroma, midtone bonus, warm-figure and cool-accent boosts, neutral penalty (−22), dark penalty; image-sourced candidates get +18 over raw clusters.
5. **Diversify** — greedy pick of 12 with a **minimum mutual RGB distance of 54** (relaxed to 0.68× if the count can't be filled). The display leads with one colour per hue family.
6. **Measure back** — every pixel is assigned to its nearest curated colour in OKLab; pixels farther than 0.14 from all of them are held out and bucketed separately, and any held-out region ≥ 4 % of the image earns its own swatch in its true colour. This gives honest proportions *and* rescues large regions the curation missed.
7. **Metrics + spectrum** — mean luminance, luminance std (contrast), mean HSV saturation, warmth (chroma-weighted cosine from hue 45°), entropy over 64 RGB buckets, mono share, and Hasler–Süsstrunk colorfulness (rg/yb std + mean). A 12-bin hue spectrum weighted by chroma².
8. **Naming** — painter-pigment vocabulary, not web names: HSL boxes mapped to "Oxblood / Burnt Sienna / Terra Rosa / Phthalo Blue / Payne's Grey", a neutral ladder (Lamp Black → Charcoal → Graphite → Pewter → Ash → Silver → Bone → Ivory), plus a list harvested from the curated artist palettes. Lightness decides before saturation, so a near-black with numerically real hue is still "Lamp Black".

### Where it is opinionated

- The accent pass is **hand-tuned toward warm figure colours** (red boost up to 1.85, warm midtones up to 4.25×). That's a painting-archive prior — it finds the flesh tone and the vermilion touch — and it will over-promote a stray red on a cool photograph.
- Distance, family and naming are **RGB / HSL**, only the clustering and coverage are OKLab. The 54-unit RGB floor is a fixed threshold that means different things in different hue regions.
- Fixed 12 stops; no bias sliders. Studio templates (Classic, Field, Triptych, Vanderpoel-measured, pairing by complementary / analogous / warm-cool) re-read the same palette rather than re-extracting.

### Transferable idea

Run coverage clustering **and** an accent-salience pass, select by salience with a mutual-distance floor, then measure coverage back onto the selection with a held-out threshold. The two-question split (area vs. what makes the picture) is why extracted palettes from paintings stop looking like muddy averages.

---

## Irozukume — sample reweighting for accent-aware quantization (technique note)

**URL:** https://github.com/Romly-Romly/irozukume
**Author:** Romly (Japan) — GPL-3.0, Windows-only tray colour picker, alpha (June 2026). Ported from the author's own earlier web version.

The app is a conventional picker (RGB/CMYK/HSV/HSL/HWB/Lab/LCH/OKLCH/YUV planes, harmony disc, WCAG checker, GIMP `.gpl` / Adobe `.act` export) and not itself a reason to install anything. Its image-palette tab is worth a note because of one trick that answers the same complaint Palette Studio does — coverage clustering never finds the small accent — with less machinery:

**Reweight the sample set before quantizing.** Instead of changing the objective, change what the optimiser sees. Each pixel sample gets a draw weight

```
w = (1 + satW · min(1, C*ab / 60)) · (1 + rareW · (1 − density / maxDensity))
```

with `satW`, `rareW` in 0…8, then a fixed-size training set is resampled *with replacement* by those weights. High-chroma and low-density colours are over-represented, so a plain error-minimising quantizer run on that set allocates palette entries to them. Both weights at 0 collapse to uniform subsampling, so the same code gives the honest coverage palette.

The quantizer itself is simulated annealing in CIELAB (CIE76): median-cut seed, Metropolis acceptance on mean cost with the initial temperature calibrated from the average worsening of trial moves, a Lloyd centroid-snap move mixed in with random jitter, and in-loop orphan rescue that relocates a palette entry with zero pixels (or the redundant twin of a near-duplicate pair) to the highest-error sample found by an 8-point tournament. Median cut, k-means++ and octree are offered alongside for comparison. Extracted colours are always shown hue-sorted so the same colour lands in the same place regardless of algorithm.

**Why it matters:** the reweighting is quantizer-agnostic. Drop it in front of k-means, median cut or Spectrimage-style OKLab clustering and you get an accent-sensitivity dial without hand-tuned hue-family boosts.

---

## Pixi — seven-chip palette card, art-directed rather than measured

**URL:** https://xanderstagwood.github.io/pixi/ — source https://github.com/xanderstagwood/pixi (`src/`)
**Author:** Xander Stagwood. Plain-JS ES modules, no dependencies, no build step, with a test suite under `test/`. No LICENSE file in the repo (as of Oct 2026), so read it but don't copy it.
**What it does:** drop in an image (or draw a random Unsplash photo) and get a 7-colour card you can name, reorder and export as CSS vars, JSON, GIMP `.gpl`, `.hex`, JASC `.pal`, paint.net, SVG, Unity, Adobe `.ase` / `.aco` / `.act`.

The code says plainly what Palette Studio only implies: *"the picture's colors are adjusted for a pleasing card, not copied."* Extraction is deliberately simple, and most of the work goes into choosing which colours to keep and then nudging them. Every adjustment runs under the same guard: **a nudged chip is never left closer to another chip than it was before, or than ΔE_OK 0.08 ("tellable")**.

### Pipeline (read from `src/`, Oct 2026)

1. **Over-extract.** k-means in **RGB**, k = 12, farthest-point seeding from one random pixel. That seeding is why a small vivid patch gets its own cluster: it sits far from everything else. The author tried an extraction step that boosted vividness and spread the colours apart, and dropped it in favour of plain k-means. The perceptual work happens afterwards.
2. **Vivid face** (`extract.js`). Each cluster is shown as the **mean of its most colourful 25 % of pixels** (ranked by RGB max−min spread), not as its centroid. The source's example: a red dragonfly on a dark ground averages to brown, but its vivid face is still red. It's a cheap fix for the averaging that turns k-means palettes into mud, and it doesn't touch the clustering.
3. **Exact mode.** Merge clusters closer than ΔE_OK 0.02 (one JND). If 7 or fewer distinct colours remain, the chips are shared out by area and no later step changes them. A flat-colour illustration gets its own colours back.
4. **Scheme detection** (`scheme.js`). Neutral means OKLCH C < 0.04. Hue families are runs of hues with no gap of 25° or more. A family counts as a hue if it holds ≥ 8 % of the image's chromatic area. The detector then names the image's scheme: ≥ 70 % neutral → *neutral-pop*; one hue → *tonal*; two hues ≥ 150° apart → *complementary*, ≤ 60° → *analogous*, between → *dichromatic*; three or four hues → *split-complementary / triadic / square / tetradic* by arc geometry. With more than four families (a rainbow) it keeps a random run of four neighbouring families, so the card isn't a hue salad.
5. **Roles, then recipe** (`chooser.js`). Four chips are fixed first:
   - **dark anchor**: the darkest colour.
   - **light anchor**: the lightest colour.
   - **hero**: the most chromatic colour.
   - **accent**: only if one earns it. It needs C ≥ 0.08 and a hue ≥ 70° from the image's chroma×area-weighted circular-mean hue, and ≥ 85 % of the remaining colour area has to sit within 70° of that mean.

   Pure black (L < 0.09) and pure white (L > 0.99) are excluded unless they cover ≥ 80 % of the image. Each scheme has a **~60/30/10 chip recipe**. For example, triadic gets 3 + 2 + 1 chips from its families plus 1 neutral, and neutral-pop gets 4 neutrals + 3 colour chips. Each group fills its quota **as a ramp**: the next chip is the candidate farthest from the group's existing chips, with lightness distance weighted 1.5× and a +0.5·C bonus so a group doesn't come out all greys. A family takes at most 3 chips while other colours are available.
6. **Harmonize** (`harmony.js`). This step only touches *free* chips. A chip within 30° of one of the scheme's ideal angles (measured from the hero's hue: 180° for complementary, ±120° for triadic, and so on) is turned halfway toward that angle. Otherwise it is turned at most 10° toward the palette's mean hue. Neutrals get 0.015 chroma of the palette's hue, an imperceptible tint that still helps the card hold together.
7. **Intensify** (`intensity.js`). Free chips in the hero's family keep 70 % of their chroma, and no free chip may exceed 1.2× the median free chroma. Nothing is ever *raised*: duller neighbours are what make the hero pop.
8. **Calm the Christmas clash** (`clash.js`). If the palette contains both a vivid red (hue 30° ± 22°, C ≥ 0.1) and a vivid green (135° ± 28°), the hero's side wins (or the more chromatic side if neither is the hero). The other side drops to C 0.05 and moves 0.1 L away from the winner.
9. **One lightness ramp** (`gradient.js`).
   - **Blocks.** Hues are grouped into contiguous blocks so they never alternate down the card. A vivid red and a muted tan become separate blocks even though their hues are close, because their chroma differs by more than 2.2×. Neutrals are slotted in wherever they cost least. A tinted grey (C ≥ 0.015) joins its hue's block as a "shadow" of it.
   - **Block order.** Every permutation of block order is tried and scored by how much lightness would have to move. Warm-to-cool only breaks ties.
   - **Fitting.** Lightness is fitted with **isotonic regression (pool-adjacent-violators) with a minimum step of 0.06 L**, then pulled halfway toward even steps. Moves are capped at 0.18 L for free chips, 0.09 for the hero and accent, and 0 for the anchors.
   - **Flat-card rescue.** If the card's total L range is still under 0.5, the two ends are pushed outward by up to 0.06 (`contrast.js`).
10. **Final candidate pick** (`arrange.js`). Each chip has 5 OKLCH variants: ±0.05 L (darker is also richer, lighter also softer) and ±8° hue. A cost function keeps whichever variant best fits the order's lightness and warmth patterns. Steps against the ramp cost 100×, warmth only settles what the ramp leaves open, and a zig-zag/lurch penalty keeps the run smooth.

### Perception helpers worth lifting (`perceive.js`, `color.js`)

- **Warmth curve on OKLCH hue**, from recent warm/cool judgment studies the source cites (Min 2026; Jov 2025). Orange (~45°) = +1 and cyan-blue (~205°) = −1. Red and green are ambiguous, yellow is weakly warm, magenta leans warm and violet cool. The score is scaled by `1 − exp(−C/0.03)`, so a grey with a hint of blue reads as a cool grey, and lighter colours read slightly warmer (+0.2·(L − 0.55)).
- **Helmholtz–Kohlrausch "shade"**: `L + C·(0.15 + 0.15·cos(h − 265°) + 0.1·max(0, cos(h − 345°)))`. This is a Fairchild–Pirrotta-style chroma term with an added red-magenta peak, used to judge "lighter than" when ordering.
- **Tinted label ink** (`inkOver`). Text over one or more backgrounds takes their mean hue and up to 0.05 chroma, and its lightness is bisected toward the background's mean lightness until WCAG contrast is exactly 5:1 against every background. The result is ink that looks like part of the palette instead of a black-or-white sticker.
- **Highlights lifted in OKLCH** (`brighter`). The L step grows with lightness (`0.01 + 0.03·L`) and comes with a 6 % chroma bump. The step shrinks if gamut mapping would cost more than 4 % chroma, so highlights on vivid colours don't wash toward white.

### Where it is opinionated

- **Not a measurement.** Hues are rotated, chroma is tempered, lightness is refitted, and red/green pairs are defused. Don't use it when you need the image's real colours or proportions. Exact mode is the exception.
- Clustering and the vividness ranking are in **RGB**. Everything after that is OKLab/OKLCH.
- The output is randomised: the seed pixel, the rainbow neighbourhood, the ramp direction and the tie-breaks all vary, so the same image gives a slightly different card each time. A seeded `random` makes it repeatable.
- The scheme names are classic wheel geometry used as *recipes* (how many chips each family gets, and which angles to pull hues toward). They are not a claim that complementary colours look good. The hue pull is capped at 15°.

### Transferable ideas

1. **Vivid face**: show a cluster as the mean of its most chromatic pixels, not its centroid.
2. **Over-extract, then choose**, with explicit roles (two lightness anchors, a hero, an earned accent).
3. **The "never closer than before or than tellable" guard** on every post-process. It lets you stack harmonize/temper/refit steps without them merging chips into twins.
4. **Isotonic regression with a minimum step** to turn any ordered set into a clean value ramp with capped per-chip moves.

---

## When to Use Which

| Scenario                                  | Best tool                     |
| ----------------------------------------- | ----------------------------- |
| Compare clustering algorithms             | img-colors.com (7 algorithms) |
| See 3D point cloud of image colors        | img-colors.com                |
| Get mesh gradient from image              | img-colors.com                |
| OKLCH-native extraction                   | okpalette.color.pizza         |
| Bias toward muted/saturated or dark/light | okpalette.color.pizza         |
| Export palette stats                      | okpalette.color.pizza         |
| Privacy-first (no uploads)                | okpalette.color.pizza         |
| Minimal bundle, fast extraction in code   | colorgram-js (1 kB)           |
| Search artworks by palette similarity     | Art Palette                   |
| Perceptual palette embeddings             | Art Palette                   |
| Painterly palette from artwork (accents, not averages) | Palette Studio (meditationsincolor.com) |
| Pigment-vocabulary colour names            | Palette Studio                |
| Accent dial for any quantizer (sample reweighting) | Irozukume technique note |
| Designed 7-chip card: roles, scheme recipe, one value ramp | Pixi                          |
| Image's real colours when it has ≤ 7 (flat art) | Pixi (exact mode)            |

## Links

- **img-colors.com:** https://img-colors.com/
- **okpalette.color.pizza:** https://okpalette.color.pizza/
- **colorgram-js:** https://github.com/darosh/colorgram-js
- **Art Palette:** https://github.com/googleartsculture/art-palette
- **Palette Studio:** https://meditationsincolor.com/palette-studio
- **Irozukume:** https://github.com/Romly-Romly/irozukume
- **Pixi:** https://xanderstagwood.github.io/pixi/ — source https://github.com/xanderstagwood/pixi
