# Data-Driven Color Manifolds (Nguyen, Ritschel & Seidel, 2015)

**Chuong H. Nguyen, Tobias Ritschel, Hans-Peter Seidel** (MPI Informatik / Saarland University). *ACM Transactions on Graphics* 34(2), Article 20, February 2015, 9 pp.

- DOI: https://doi.org/10.1145/2699645
- Local PDF: [pdfs/nguyen-2015-data-driven-color-manifolds-tog.pdf](pdfs/nguyen-2015-data-driven-color-manifolds-tog.pdf) (gitignored)

Notes made from the full paper text. This is a summary, not a transcript.

---

## The idea

Color pickers make you steer a 3D space with a 1D slider plus a 2D field, in RGB, HSV or Lab. That's general but clumsy for a concrete job. If you want "a slightly different wood color", going redder also needs more saturation, and going less red needs less. Move one axis of a standard picker and you leave the set of plausible wood colors.

Instead, **learn the colors a given kind of object actually takes** (banana, skin, sky, wood, sunset) and embed them as a **1D curve or 2D patch** inside 3D color space. The picker becomes one slider or one small square showing only plausible colors in a sensible order. The embedding is also **density-weighted**: common colors get more slider length, rare ones are compressed. For a chair, brown-beige-red gets room and green/blue shrink.

## Pipeline

1. **Acquire.** Top 100 Google Image results for a class, used as-is: no white-balance correction, mixed styles. Backgrounds are removed by a simple heuristic: bilateral blur, join neighboring pixels whose **CIEDE2000** difference is under a threshold, and drop every connected region that touches the image border. Optionally, textures from 3D model repositories (Google SketchUp) serve as **reflectance** data, since artists' textures are roughly white-balanced and shadow-free. Photos give **radiance**, which includes shading. About 4 M pixels are sampled.
2. **Density.** A 16×16×16 histogram in the source space (RGB or Lab). **Keep only the top α = 15% of bins** to drop outliers and off-class colors. Clamp each bin's density to between 0.1× and 2× the mean so no color is over- or under-weighted. That leaves a few hundred weighted colors.
3. **Reduce dimensions**, compared three ways:
   - **PCA:** density-weighted mean and covariance, keep the top 1–2 eigenvectors, giving a straight line or flat plane. Cheap, but real color clouds are curved, so many colors can't be reached. **Worst in every test.**
   - **MDS (isomap-style):** connect neighboring histogram bins, weight each edge by mean density (dense regions are stretched longer), get all-pairs geodesics with Floyd–Warshall, run classical MDS, normalize, and rotate so the **largest luminance variation lies along axis 1**. Then fill the continuous domain with RBF reconstruction: `f(x) = Σ r(cⱼ,x)·bⱼ / Σ r(cⱼ,x)`, `r = exp(−(sₘ‖x−y‖)²)`. Fails when the color cloud loops into a cycle.
   - **SOM (Kohonen, batch, on GPU)** with **CIEDE2000** as the distance, trained on samples drawn in proportion to density. A minimum neighborhood radius r₀ enforces smoothness. 1D: 128 nodes, r₀ = 15, 4000 steps. 2D: 32×32, r₀ = 10, 2000 steps. **Handles cycles, and wins overall.**

The result is tiny: a smooth manifold stored as a low-res image of a few hundred bytes to a few KB. It builds at interactive rates, so users can add and remove images and watch the manifold update.

## User study

- **Adjustment** (13 subjects): recolor a soft-selected region back to a reference, under a 5 s limit, two clicks, or open-ended. Error was measured as mean CIEDE2000 over pixels.
- **Exploration:** 4 users recolor images until satisfied, using 12 different pickers. Then 10 other people rank the results by quality, and time is compared against plain RGB.
- Pickers tested: RGB, Lab, HSV; "reduced" versions of each with off-class colors grayed out (a control); and 1D/2D manifolds from PCA, MDS and SOM.

Findings:
1. **The choice of standard color space barely matters** for picking performance. This repeats Schwarz et al. (1987) and Douglas & Kirkpatrick (1999): feedback matters more than the space.
2. **Graying out implausible colors doesn't help.** The reduced pickers were no better, so the gain isn't just from hiding wrong colors.
3. **1D and 2D SOM manifolds beat every standard and reduced picker** on accuracy, time and rated quality (Kruskal–Wallis plus Dunn's test, p < 0.05).

The useful lesson: what helps is **re-parameterizing** space along the directions colors actually vary, with density-proportional spacing. Restricting the space alone doesn't.

## Applications

- **1D/2D context sliders** for recoloring (the main use).
- **Palettes:** sample a 1D manifold evenly to get an ordered, well-covering palette. Unlike clustering, the swatches have a meaningful order and can be refined.
- **Recoloring suggestions / stylization:** give each segment a random color from the manifold (e.g. "apples"), so it changes but stays plausible.
- **Parametric families:** one manifold per value of a condition, e.g. sky by time of day, forest by season.
- **Compression:** keep L in Lab, and code chroma as 1–2 manifold coordinates, quantizing less important ones down to 0 bits (2D color becomes 1D). Best for sets of images from one class.
- **White balance with an "on-manifold" assumption** that extends gray world. If some pixels are known to be "skin", choose the illuminant L that minimizes `Σ ‖α_f(aᵢ/L) − aᵢ/L‖²`, where α_f projects onto the manifold. Solved by brute force on a GPU with a 3D lookup table. A pinkish face then gets read as pink skin under white light rather than a pink cast. This follows Olkkonen et al. (2008): humans use familiar-object color to separate illuminant from reflectance. Its limit: it can't tell a tanned face from a brownish light.

## Limitations

- **Needs reliable classification**, both to build the manifold and to use it. "apple" returns fruit and laptops.
- Uncorrected web photos (bad white balance, interreflections, missed backgrounds) blur the manifold. Off-class but related colors can dominate, like the leaf green behind a ladybug.
- **Objects that come in every color** (man-made, textured items like cars or T-shirts) have no low-dimensional manifold. The SOM then zig-zags through all of 3D, so for those, use a normal 3D picker.

---

## Takeaways for the skill

1. **For "pick a plausible X color", a learned 1D/2D path beats any general color space.** The paper shows the general space barely matters, but a content-specific path does.
2. **Space slider stops by how often colors occur.** Frequent colors get more travel. The same idea underlies density-aware palette sampling.
3. **Image-derived palettes have an order.** Fitting a curve (SOM / principal curve) through an image's colors, instead of k-means, gives swatches arranged along a meaningful path. Compare `image-color-extraction-tools.md` and `colorsort-js.md`.
4. **Known object colors constrain white balance**, a computational version of memory color.

## Links

- Paper (ACM DL): https://doi.org/10.1145/2699645
- Related, cited: O'Donovan et al. 2011 (color compatibility from large datasets), Lalonde & Efros 2007 (color compatibility), Shapira et al. 2009 (Gaussian-mixture appearance editing), Olkkonen et al. 2008 (memory color and color constancy), Bell et al. 2013 (OpenSurfaces), Xiao et al. 2010 (SUN database), Kohonen 1990 (SOM), Tenenbaum et al. 2000 (Isomap)
