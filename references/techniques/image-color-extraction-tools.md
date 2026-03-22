# Image Color Extraction Tools

Two complementary tools for extracting color palettes from images.

---

## img-colors.com — Clustering-Based Extraction

**URL:** https://img-colors.com/
**Author:** bout
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

## Links

- **img-colors.com:** https://img-colors.com/
- **okpalette.color.pizza:** https://okpalette.color.pizza/
