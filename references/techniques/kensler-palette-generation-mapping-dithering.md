# Andrew Kensler — Palette Generation, Palette Mapping, and Dithering

Six posts from Andrew Kensler's blog (Pixar rendering engineer; also known for the
business-card ray tracer). Together they form a small, self-consistent toolkit:
**generate** a small general-purpose palette by optimization, **visualize** its
internal structure as a graph, **quantize/dither** images into it correctly, and
**convert bit depths** without bias.

**Sources**

- [Pixel Art Palettes for Free](http://eastfarthing.com/blog/2016-05-06-palette/) — May 6, 2016
- [Mapping Pixel Art Palettes](http://eastfarthing.com/blog/2016-05-27-mapping/) — May 27, 2016
- [A 54-Color Palette](http://eastfarthing.com/blog/2016-09-19-palette/) — Sep 19, 2016
- [Blending for Dithering](http://eastfarthing.com/blog/2017-09-23-dithering/) — Sep 23, 2017
- [More on Palettes](http://eastfarthing.com/blog/2020-08-10-palette/) — Aug 10, 2020
- [Converting Color Depth](http://eastfarthing.com/blog/2015-12-19-color/) — Dec 19, 2015 (bonus, same toolkit)

Blog: <http://eastfarthing.com/blog/> · Topics: <http://eastfarthing.com/blog/topics.html>

---

## 1. Generating a palette by optimization (2016)

Motivation: DawnBringer's DB16/DB32 and Arne Niklas Jansson's 16-color palette are
hand-picked. Kensler's complaint about DB is that they are "a bit desaturated and
lacking in purples — you couldn't do *Monkey Island* with them." So: can a short
program produce a good general-purpose palette from scratch?

**Optimizer:** simulated annealing. The interesting part is not the search, it is the
objective — which is where all the color science lives.

### Two competing objectives

1. **Maximize the minimum CIEDE2000 distance** between the two closest colors in the
   palette (maximin separation).
2. **Minimize the RMS error** between evenly sampled points of the RGB cube and their
   nearest palette entry, again measured in CIEDE2000 (coverage / quantization error).

These pull in opposite directions, and the *reason* is the useful insight:

- Maximin separation drives colors onto the **faces of the RGB cube** — highly
  saturated colors measure as more different from each other.
- Minimizing coverage error drives colors **into the interior** — duller, desaturated
  colors each cover more volume of the cube.

So "spread the colors out" is not one criterion but two, and they disagree about
saturation.

### How he combined them

- **Quality score = ratio** (min-distance ÷ RMS-error). Palettes with the best ratio
  quantized his test suite best.
- **Annealing target = difference** (min-distance − RMS-error). Optimizing the
  *difference* kept the annealer from getting stuck in local maxima, while he tracked
  and kept the best palette seen *by ratio*.

Two objectives, two different combinations, for two different jobs — search behavior
vs. selection. Worth stealing.

**Empirical constant:** the best ratios came out at roughly **2.34–2.37 regardless of
palette size** (16: 2.37, 32: 2.35, 48: reported via ratio, 54: 2.29 with much less
compute). A convenient convergence target — if your own optimizer lands far below
~2.3, you probably have not run it long enough.

A side effect noted in post 2: because of the maximin criterion, **every linked pair
in the resulting palette has nearly the same CIEDE2000 difference** — the palette is
perceptually evenly stepped by construction, not by hand-tuning.

### The palettes (all CC-free to use; author asked only to hear about it)

Color names below are the nearest [xkcd color survey](http://xkcd.com/color/rgb/)
names by CIEDE2000 — Kensler's own labeling.

**aek-16** ([GIMP .gpl](http://eastfarthing.com/blog/2016-05-06-palette/aek-16.gpl), quality 2.37)

```text
#3f32ae sapphire      #e30ec2 hot magenta   #baaaff pale violet   #ffffff white
#ff949d rose pink     #e80200 red           #7a243d wine          #000000 black
#195648 dark blue grn #6a8927 mossy green   #16ed75 minty green   #32c1c3 topaz
#057fc1 cerulean      #6e4e23 mud brown     #c98f4c dull orange   #efe305 piss yellow
```

**aek-32** ([GIMP .gpl](http://eastfarthing.com/blog/2016-05-06-palette/aek-32.gpl), quality 2.35) — note it discovered *both* a warm and a cool gray family on its own

```text
#d6a090 #fe3b1e #a12c32 #fa2f7a #fb9fda #e61cf7 #992f7c #47011f
#051155 #4f02ec #2d69cb #00a6ee #6febff #08a29a #2a666a #063619
#000000 #4a4957 #8e7ba4 #b7c0ff #ffffff #acbe9c #827c70 #5a3b1c
#ae6507 #f7aa30 #f4ea5c #9b9500 #566204 #11963b #51e113 #08fdcc
```

**aek-48** ([GIMP .gpl](http://eastfarthing.com/blog/2020-08-10-palette/aek-48.gpl), 2020, lots of compute)

```text
#000000 #43290f #7d554d #8d226b #4a4053 #0f4078 #1c4c4b #1d4b18
#377f04 #248b6e #666c5e #5f540a #97833f #ab601b #f58e32 #f3bd2d
#e8c4a6 #aaa1a5 #facce1 #f892f6 #fb03b3 #db2753 #a77188 #e48b82
#fd3d0e #b21401 #740321 #290016 #180750 #3c06ce #984bca #9a8afa
#c4d0fc #ffffff #b3ffff #00c0b8 #9ab095 #e2f5b7 #faff04 #a9b835
#2ab64d #77f827 #45f6b7 #04c7f8 #3895ef #418898 #6c7192 #095ffc
```

**aek-54** ([GIMP .gpl](http://eastfarthing.com/blog/2016-09-19-palette/aek-54.gpl), quality 2.29 — matches the NES color count, requested by a reader)

```text
#05fec1 #32af87 #387261 #000000 #1c332a #2a5219 #2d8430 #00b716 #50fe34
#a2d18e #84926c #aabab3 #cdfff1 #05dcdd #499faa #2f6d82 #3894d7 #78cef8
#bbc6ec #8e8cfd #1f64f4 #25477e #72629f #a48db5 #f5b8f4 #df6ff1 #a831ee
#3610e3 #241267 #7f2387 #471a3a #93274e #976877 #e57ea3 #d5309d #dd385a
#f28071 #ee2911 #9e281f #4e211a #5b5058 #5e4d28 #7e751a #a2af22 #e0f53f
#fffbc6 #ffffff #dfb9ba #ab8c76 #eec191 #c19029 #f8cb1a #ea7924 #a15e30
```

He also built a **swatch tester**: hand-drawn 3- and 4-level grayscale swatch
templates, then a program that finds the nearest-matching color triples/quads in the
palette (CIEDE2000) and recolors the template. A cheap way to ask "can this palette
actually shade an object?" rather than only "are these colors distinct?"

---

## 2. Mapping a palette as a DAG (2016)

Pixel artists assess palettes via **color ramps** laid out crossword-style on a grid.
Kensler tried to automate that and hit two walls:

1. **Finding ramps is hard.** He tried interpolating each pair of colors in CIELAB and
   looking for other palette colors near the line. With small palettes this finds few
   long ramps — in practice **real ramps curve and meander** through color space
   rather than running straight.
2. **Laying ramps out on a grid is impossible in general.** A color shared by more
   than two ramps cannot be shown without duplicating it.

### The alternative: a lightness-directed proximity graph

> Draw an arrow from each color to every color that is (a) **lighter** than it and
> (b) within a certain **color distance** of it.

- Lighter = higher **L\*** in CIELAB.
- Close = **CIEDE2000** below a threshold.
- The result is a **directed acyclic graph**; hand it to GraphViz **`dot`**, which
  lays it out well.

**Threshold heuristic (the clever bit):** compute the **minimum spanning tree** over
all palette colors with CIEDE2000 as edge weights, and use the **heaviest edge in that
MST** as the threshold. This is the smallest threshold that still yields a
single-component graph — no isolated colors, no arbitrary constant.

`dot` knows nothing about hue, lightness, or saturation, yet the edge constraints
alone are enough for it to arrange the palette into a legible, plausible structure;
ramps are read by following arrows.

**2020 addition:** edges are **shaded by CIEDE2000 distance** — black for the closest
linked pair, light gray for the farthest linked pair, interpolated between. Caveat he
states himself: a light-gray edge does not mean the two colors are dissimilar in
absolute terms, only that other linked pairs are closer.

**Palettes he mapped:** aek-16/32/48/54, Arne 16 and 32, DawnBringer DB16, DB32 and
Fun16, PICO-8 (and the extended 32-color secret palette), Commodore 64 (Pepto's
calculated version), default EGA, the NES 54, and **Solarized** — where the map
"definitely manages to find the desaturated spine of the palette."

**Documented failure case:** the extended PICO-8 palette. Its light blue is unusually
isolated, so the MST's heaviest edge is large, so the threshold is large, so almost
everything else gets connected to everything else and the map turns to spaghetti.
**The heuristic degrades whenever one palette color is a far outlier** — a real
limitation to check for before trusting the layout.

---

## 3. Blending for dithering: use linear RGB, not CIELAB (2017)

The single most transferable correction in the series.

Kensler's dithering code originally blended in **CIELAB**, on the reasonable-sounding
grounds that CIELAB is perceptually uniform. He got odd color casts and assumed a bug.
It was not a bug — it was the wrong color space.

### The argument

Take a yellow pixel above a blue pixel. Yellow lights the red and green subpixel
elements; blue lights the blue element. **That is exactly the same set of emitters a
single white pixel has, spread over twice the area.** Below the eye's resolving limit
it must therefore look like white at half the brightness — a **50% gray**.

- **Linearized RGB (sRGB primaries)** predicts exactly that.
- **CIELAB** puts the yellow–blue midpoint at a **pale pinkish** color. Wrong.

### The principle

> For dithering, even though it is the human visual system doing the blending, you do
> not want a color space that models the eye — you want one that **models the device**.

The optical mixing happens *before* perception, in linear light emitted by physical
subpixels. Perceptual uniformity is the right tool for measuring *differences* between
colors (which is why CIEDE2000 is used everywhere else in this series) and the wrong
tool for predicting the *result of mixing* light. Kensler notes he found this
counterintuitive; most people do.

He shipped an interactive widget on the post: pick two colors, compare a real
checkerboard dither against its 50% blend in linear RGB (left) and in CIELAB (right).

**Practical rule:** blend/average in **linearized sRGB** for dithering, alpha
compositing, image downsampling, and anything else where light physically adds. Use
OKLab/CIELAB/CIEDE2000 for *choosing* and *comparing* colors. Do not mix the two jobs.

**Dither pattern note (from post 1):** he remapped test images with an **8×8 positional
dither** for the chart, but used a **2×2 positional dither** for artwork because it is
"closer to how a human might dither an image by hand" — simpler color mixes, at the
cost of more banding.

---

## 4. Bonus — Converting color depth without bias (2015)

Same toolkit, earlier post. The near-universal 8-bit ↔ float conversion is

```c
float f32 = u8 / 255.0f;
u8 = (int)( 255.0f * f32 );      // truncating
```

Three complaints:

1. **255 is the wrong divisor** — a byte has 256 steps, not 255. And 1/255 is not
   exactly representable in binary floating point, so every input except 0 and 255
   maps to an inexact value.
2. **It is asymmetric.** Truncation lets you add nearly 1/255 without changing the
   output byte, but the smallest *decrease* drops it a step. Repeated processing
   passes therefore have a **bias toward black** and lose energy over time.
3. **It does not generalize** to other fixed-point depths. `u10 = u8 * 1023 / 255`
   round-trips 0 and 255 but not most values in between.

### The fix: treat a color code as a cell, not a point

Apply Heckbert's discrete↔continuous pixel-coordinate convention (`d = floor(c)`,
`c = d + 0.5`) to color:

```c
f32 = ( u8 + 0.5f ) / 256.0f;
u8  = (int)( 256.0f * f32 );
```

Properties:

- Divisor is 256, so every byte maps to an **exactly representable** float.
- **Symmetric**: you can add anything in (−1/512, +1/512) and land on the same byte.
- The float range mapping cleanly to 0–255 is **exactly 0.0–1.0**.
- Generalizes: 8↔10 bit becomes `u10 = 4*u8 + 2; u8 = u10 / 4;`.

Downside he acknowledges: the darkest low-precision value no longer maps to the
darkest high-precision value. He argues this is *correct* — the original value was
merely quantized into that bucket, and the bucket center is the best guess.

### It composes with dithering

```c
u8 = (int)( 256.0f * f32 + drand48() - 0.5f );   // now needs clamping
```

Breaks up banding where processing changed the image, and — crucially — **returns the
original file byte-for-byte where nothing changed**. Use **one shared dither value
across R, G, and B** to avoid introducing color shifts:

```c
float dither = drand48() - 0.5f;
r_u8 = (int)( 256.0f * r_f32 + dither );
g_u8 = (int)( 256.0f * g_f32 + dither );
b_u8 = (int)( 256.0f * b_f32 + dither );
```

Grays get dithered but stay neutral gray.

---

## What to take from this

- **Palette generation as constrained optimization** — same family as Ström's
  simulated-annealing `category-colors` (see
  [strom-least-wrong-colors-simulated-annealing.md](strom-least-wrong-colors-simulated-annealing.md)),
  but with a *general-purpose drawing palette* objective (separation + RGB-cube
  coverage) rather than a *categorical dataviz* objective (brand similarity + CVD
  separation). The loss function is the design decision in both cases.
- **Maximin separation and coverage error disagree about saturation.** Know which one
  you actually want, or ratio them.
- **MST heaviest edge** is a good parameter-free proximity threshold — and fails
  loudly when one color is an outlier.
- **Blend in linear RGB, compare in a perceptual space.** Model the device for mixing,
  model the eye for difference.
- **`(u8 + 0.5) / 256`** for depth conversion, plus a shared per-pixel dither.

Related: [pixel-art-color-palettes.md](pixel-art-color-palettes.md) (hue-shifted ramps,
the hand-crafted counterpart to this automated approach),
[colorsort-js.md](colorsort-js.md) (the other "impose structure on an unordered
palette" approach — a smoothest path rather than a DAG).

---

## Links

| Link | What it is |
| ---- | ---------- |
| <http://eastfarthing.com/blog/> | Andrew Kensler's blog (Pixar; business-card ray tracer, Perlin noise, Luculent font) |
| <http://eastfarthing.com/blog/2016-05-06-palette/aek-16.gpl> | aek-16 GIMP palette |
| <http://eastfarthing.com/blog/2016-05-06-palette/aek-32.gpl> | aek-32 GIMP palette |
| <http://eastfarthing.com/blog/2020-08-10-palette/aek-48.gpl> | aek-48 GIMP palette |
| <http://eastfarthing.com/blog/2016-09-19-palette/aek-54.gpl> | aek-54 GIMP palette |
| <http://www.ece.rochester.edu/~gsharma/ciede2000/ciede2000noteCRNA.pdf> | Sharma et al. — CIEDE2000 implementation notes + test data. Kensler: essential for debugging an implementation |
| <http://pixeljoint.com/forum/forum_posts.asp?TID=12795> | DawnBringer DB16 |
| <http://pixeljoint.com/forum/forum_posts.asp?TID=16247> | DawnBringer DB32 |
| <http://pixeljoint.com/forum/forum_posts.asp?TID=22582&PID=201753#201753> | DawnBringer Fun16 |
| <http://androidarts.com/palette/16pal.htm> | Arne Niklas Jansson 16- and 32-color palettes |
| <http://www.lexaloffle.com/pico-8.php?page=faq> | PICO-8 palette |
| <https://lospec.com/palette-list/pico-8-secret-palette> | Extended (secret) PICO-8 32-color palette |
| <http://www.pepto.de/projects/colorvic/> | Pepto — calculated Commodore 64 palette (better than the Wikipedia values) |
| <https://ethanschoonover.com/solarized/> | Solarized |
| <http://xkcd.com/color/rgb/> | xkcd color survey names (used for labeling) |
| <http://www.graphviz.org/Documentation/dotguide.pdf> | GraphViz `dot` guide |
| <https://en.wikipedia.org/wiki/File:RGB_24bits_palette_color_test_chart.png> | Standard palette test chart |
| <http://dl.acm.org/citation.cfm?id=90823> | Heckbert — discrete vs. continuous coordinates (`d = floor(c)`, `c = d + 0.5`) |
