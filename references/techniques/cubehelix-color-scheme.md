# Cubehelix — Helical Color Scheme

**Source:** https://people.phy.cam.ac.uk/dag9/CUBEHELIX/
**Author:** Dave Green (Cambridge)
**Paper:** Green, D.A., 2011, Bull. Astr. Soc. India, 39, 289

## What It Is

A color scheme that spirals through the RGB cube along a **helical path** from black to white, ensuring a **monotonic increase in perceived intensity** throughout. Prints as proper grayscale on B&W devices. Created for astronomical imaging but widely adopted.

## The Key Insight

A straight diagonal through the color cube (black→white) is just grayscale. A **helix** around that diagonal adds hue variation while maintaining the brightness ramp. The helix accounts for human vision's different sensitivity to R, G, B — so perceived brightness increases smoothly even as hue changes.

This is the same principle as Goethe's "edge colors" — hue, lightness, and chroma shifting together along a spiral path.

## 4 Parameters

| Parameter          | Controls                                             | Default |
| ------------------ | ---------------------------------------------------- | ------- |
| **Start**          | Starting hue direction (1=red, 2=green, 3=blue)      | 0.5     |
| **Rotations**      | How many R→G→B cycles black→white                    | -1.5    |
| **Hue/Saturation** | Color intensity (0=grayscale, >1=vivid but may clip) | 1.0     |
| **Gamma**          | Emphasize low or high intensity values               | 1.0     |

## Why It Matters

- **Monotonic brightness** — no false brightness peaks (unlike rainbow colormaps where yellow looks brighter than red)
- **Grayscale-safe** — prints correctly on B&W
- **Full intensity range** — uses 0→1 unlike viridis/parula which use ~70%
- **4 parameters** = infinite family of perceptually valid colormaps
- **The foundation** for matplotlib's viridis, magma, inferno, plasma (they all use helical paths)
- Built into: matplotlib, D3.js, Culori, gnuplot, MATLAB, R, and most astronomy software

## Connection to Other Techniques

- **Goethe Edge Colors** — Color Nerd's lecture shows edge color sequences are natural helices; Cubehelix formalizes this mathematically
- **IQ Cosine Formula** — also generates smooth palettes via oscillation, but doesn't guarantee monotonic brightness
- **Fontana/Pasma** — both kill greens and balance tones; Cubehelix achieves this via the helix geometry itself

## Links

- **Interactive generator:** https://people.phy.cam.ac.uk/dag9/CUBEHELIX/cubetry.html
- **Paper:** https://people.phy.cam.ac.uk/dag9/CUBEHELIX/cubetry.html
- **In Culori:** available as `cubehelix` color space
