# Image Color Extraction Tools

Three tools for extracting color palettes from images — plus one that enables searching by palette.

---

## img-colors.com — Clustering-Based Extraction

**URL:** https://img-colors.com/
**Author:** murmurs
**Architecture:** Edge-computed (Cloudflare Workers), no server/database

### How It Works

1. **Upload** → resized to max 1,500px, converted to JPEG
2. **Sample** → ~5,000 random pixels (keeps payload tiny)
3. **Cluster** → 7 unsupervised algorithms find palette centroids
4. **Visualize** → 3D point cloud of sampled pixels + centroids
5. **Generate** → click any palette → instant mesh-blurred gradient background

### 7 Clustering Algorithms

| Algorithm              | Approach                           | Trade-off                                              |
| ---------------------- | ---------------------------------- | ------------------------------------------------------ |
| **K-Means**            | Iterative centroid optimization    | Fast; best for spherical clusters                      |
| **Mini-Batch K-Means** | Random mini-batches                | Even faster on large datasets                          |
| **DBSCAN**             | Density-based                      | Finds arbitrary shapes; marks outliers as noise        |
| **Mean-Shift**         | Window slides toward density peaks | No need to pre-set k; slower                           |
| **Agglomerative**      | Hierarchical dendrogram            | Cut at any depth; O(n²) cost                           |
| **OPTICS**             | Density thresholds range           | Reveals nested cluster structure                       |
| **Median-Cut**         | Recursively splits color cube      | Classic palettization; splits on largest channel range |

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

## Links

- **img-colors.com:** https://img-colors.com/
- **okpalette.color.pizza:** https://okpalette.color.pizza/
- **colorgram-js:** https://github.com/darosh/colorgram-js
- **Art Palette:** https://github.com/googleartsculture/art-palette
