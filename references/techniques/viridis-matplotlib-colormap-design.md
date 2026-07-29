# Viridis — Designing Matplotlib's Default Colormap

**Authors:** Nathaniel J. Smith & Stéfan van der Walt
**Talk:** "A Better Default Colormap for Matplotlib," SciPy 2015 — [YouTube](https://www.youtube.com/watch?v=xAoljeRJ3lU) (~18 min)
**Page:** [bids.github.io/colormap](https://bids.github.io/colormap/)
**Colormap data:** [colormaps.py](https://github.com/BIDS/colormap/blob/master/colormaps.py) — **CC0**, no rights reserved
**Tools:** [viscm](https://github.com/matplotlib/viscm) (`pip install viscm`) · [colorspacious](https://colorspacious.readthedocs.io/)

Shipped in matplotlib 1.5; **viridis became the default in matplotlib 2.0**, replacing `jet`. Ported to [R](https://cran.r-project.org/web/packages/viridis/), [MATLAB](http://www.met.reading.ac.uk/~ed/viridis.m), and [D3/JS](https://github.com/politiken-journalism/scale-color-perceptual).

## Why Jet Had to Go

The argument that matters isn't aesthetic. A user study of clinicians diagnosing heart disease from cell imaging — using the tool they use daily, whose default was jet — found that against better colormaps they took **twice as long and made more diagnostic errors**. Smith's line: *"it's a joke but like… it may have killed people. Defaults matter."*

Jet's failure is that it is not **perceptually uniform**: equal steps in the data do not produce equal perceptual steps. It has bright bands (cyan, yellow) that read as features in the data that aren't there, and dark bands that hide real structure.

## What "Perceptually Uniform" Means Operationally

Take the derivative of the colormap in perceptual space with respect to the data. **A perceptually uniform colormap is one where that plot is a flat horizontal line.** If your data goes 0.1 → 0.2, that should feel like the same amount of change as 0.8 → 0.9.

Two of these are needed, and viridis satisfies both analytically:

1. Flat perceptual derivative in **color**.
2. Flat perceptual derivative in **grayscale** (people still print things).

## The Key Technical Choice: CAM02-UCS, Not CIELAB

MATLAB's parula — the other post-jet default — was designed to be uniform in **CIELAB**. The talk shows why that isn't enough:

> "Lab space is pretty good for distant colors, about equally good to what we're using, but for **nearby** colors it's really terrible. And that's the crucial thing for uniformity — getting those nearby color estimates right."

The visible consequence is a **band near the bottom of parula** that, once seen, cannot be unseen (stronger on a monitor than in projection). So viridis was built in **CAM02-UCS** — CIECAM02 re-transformed so that Euclidean distance approximates perceptual difference. CIELAB is a 1976 model ("very fancy in 1976 — I assume people were doing this on their desk calculators"); CAM02 is four pages of equations and another 30 years of science.

Note the two-part split: CIELAB was *designed* to estimate similarity by distance, while CIECAM02 was not but is excellent at appearance correlates (e.g. a constant-hue line actually looks like one constant hue, which is not true in Lab). CAM02-UCS grafts the distance property onto the better appearance model.

**Bug note:** early versions of colorspacious had a CAM02-UCS scaling bug. It had negligible effect on the colorspace's key properties but rescaled it, so the control-point paths used to author the original colormaps don't make sense in the corrected space. To edit the originals as authored, pass `--uniform-space buggy-CAM02-UCS`. New colormaps: use current versions and ignore it.

## How the Constraints Determined the Answer

The design space collapses almost entirely once you take the criteria seriously:

| Criterion | Consequence |
| --- | --- |
| Colorblind-friendly | Vary along **blue↔yellow**, not red↔green — red-green is exactly the axis that collapses under the common deficiencies |
| Grayscale-friendly | Must run monotonically **dark → light** |
| Both together | Therefore **dark blue → light yellow**. The reverse (dark yellow → light blue) *doesn't exist* — the gamut blob has no dark saturated yellow |
| Sequential default | No assumed structure in the data: not diverging, not cyclic |

What remained was one genuine choice: looking down on the color solid from the top, you can travel from dark blue to light yellow going **one way round or the other**. Parula went one way; viridis goes the other (through green), where there is more room to work.

The four released options are all the same bluish → reddish → yellowish family:

| Option | Name | Route |
| --- | --- | --- |
| A | **magma** | via purple/red |
| B | **inferno** | via purple/red, hotter |
| C | **plasma** | via magenta/orange |
| D | **viridis** | via green — from a design by **Eric Firing**, with more yellow added at the top |

## The Color Science Primer (worth keeping)

The talk contains a compact, correct derivation of why color spaces look the way they do:

- Light is **not** a wavelength — it's a high-dimensional vector of photon counts per wavelength. Only a laser is monochromatic.
- The retina has three cone types (L/M/S). The eye's response is a **linear projection** from that high-dimensional spectral space to 3D. Linear algebra follows: there's a huge null space, so many different spectra map to the same signal (**metamers**) — and you never have to track them, only the equivalence class.
- **CIE XYZ is just a choice of basis for that 3D space.** Each point is an equivalence class of spectra.
- Physical spectra can't have negative photon counts → the reachable set is a **cone** in XYZ. Slice it at x+y+z=1 and you get the familiar horseshoe chromaticity diagram. That's where that picture comes from.
- Because the projection is linear, mixing two lights lands on the **line between** their projected points (green laser + red laser = yellow). So the whole gamut is the **convex hull of the monochromatic (spectral locus) points** — that's why the horseshoe is shaped as it is.
- A monitor is three fixed points in XYZ plus a nonlinear transfer curve per channel ("nonlinear because that's how cathode ray tubes work, and we now emulate cathode ray tubes in software").
- Perception adds **white-point normalization** — the reason The Dress works. The infinite XYZ cone gets clipped and rescaled into a finite 3D blob: black↔white, blue↔yellow, red↔green.
- **CVD:** the M cone is a recent evolutionary duplicate of the L cone — that's why they're so spectrally similar and why they get mixed up during replication. The red-green signal is the difference between them, so anomalies squish the space along that axis. Moderate deuteranomaly, the most common form, affects roughly 5% of men of European descent.

## viscm — Designing Your Own

```sh
pip install viscm
python -m viscm view jet                       # inspect a built-in
python -m viscm view path/to/colormap_script.py
python -m viscm view CMAP --save OUT.png --quit
python -m viscm edit path/to/colormap_script.py  # the editor they used
```

The diagnostic view: colormap, grayscale version, perceptual deltas, perceptual lightness deltas, four CVD simulations, a 3D spline through CAM02-UCS with equally-data-spaced dots (uniform = evenly spaced dots), and sample images with CVD versions.

The editor: pick start/end lightness at the bottom — since that fully determines the lightness axis, you only manipulate a **2D top-down view** of the remaining plane, dragging Bézier control points. Drag to move, shift-click to add, ctrl-click to delete; click the side colormap to choose which hue/saturation slice the left pane shows (the game is keeping the yellow dot inside the slice). *"It takes like two minutes to design a new color map."*

You can also go the other direction — specify the perceptual path and get a colormap out. Constant lightness + a circle in the other plane, converted via colorspacious, gives a **cyclic colormap** suitable for wind direction or phase.

## The Governance Lesson

Two minutes per colormap is a problem, not a feature: *"if everyone can design a new color map in two minutes, you will never end up with a single color map… here we are literally trying to decide what color to make the bike shed."*

Their strategy: ship exactly **three** options — enough that people feel heard, few enough to decide. A mailing-list survey followed (*"we learned that democracy is useless"*), Eric Firing asked why there was no green one, and the fourth option won. The retrospective criterion: *"we had left out the most important criterion — it has to have green in it."*

The name: viridis is Latin for green; named after a snake (Python), or a bird if you prefer MATLAB compatibility.

## Limits Worth Stating

- **Sequential only.** Viridis encodes an ordered scalar. It is wrong for categorical data (use a categorical palette) and wrong for diverging data with a meaningful midpoint (use a diverging ramp).
- **Uniformity is a target, not a universal good.** A flat perceptual derivative means no region of the data range gets exaggerated — which also means no region gets *enhanced*. Jet's undeserved persistence comes from its high local contrast making faint features pop; the honest answer is that this is fabricated contrast at unpredictable data values, but tasks that are purely about detecting *that* something is there, rather than reading *how much*, are the case where uniform ramps feel flat.
- **CVD-friendly ≠ CVD-equivalent.** The simulations are approximations of a continuum, not categories.

## Connection to Other References

- **[Cubehelix](cubehelix-color-scheme.md)** — Dave Green's earlier solution to the same problem: a helix through the RGB cube giving monotonic brightness plus hue variation, grayscale-safe. Same principle, simpler machinery; viridis replaces the analytic helix with hand-authored Bézier control points in a far better perceptual space, and uses ~70% of the intensity range where cubehelix uses 0→1.
- **[Wijffelaars — Intuitive Color Palettes](wijffelaars-intuitive-color-palettes.md)** — the parametric-model counterpart (CIELUV Bézier paths, intuitive knobs, any N). Wijffelaars generates from parameters; viscm is a manual editor with live perceptual diagnostics. Both reject "sample a straight line through color space."
- **[CuspHanger](cusphanger-gamut-triangle-palettes.md)** — Wijffelaars in OKLCH; the modern in-gamut-by-construction way to get a viridis-class sequential ramp for a hue you choose.
- **[Ström — Least Wrong Colors](strom-least-wrong-colors-simulated-annealing.md)** — cites viridis as prior art, then solves the *categorical* problem viridis explicitly doesn't address.
- **[Goethe Edge Colors as Design Hack](goethe-edge-colors-design-hack.md)** — arrives at the same helical dark→light+hue-shift structure from prism edge colors; explicitly names viridis/magma/cubehelix as the same principle.
- **[Ottosson — OKLAB](../contemporary/bjorn-ottosson-oklab-articles.md)** — the newer perceptual space you'd reach for today instead of CAM02-UCS for most design work; OKLAB was fitted partly against the same CAM16/CAM02-UCS lineage of datasets, and is far cheaper to compute.
- **[Color Buddy](color-buddy-palette-lint.md)** — lints existing palettes against sequential/diverging ordering rules, i.e. checks after the fact what viscm shows during authoring.
