# colordx — CSS Color 4 Manipulation Library (OKLCH-native, 7.6 KB)

**Source:** [GitHub — dkryaklin/colordx](https://github.com/dkryaklin/colordx)
**Package:** `@colordx/core` (v5.5.0 as of Aug 2026)
**Author:** Dmitrii Kriaklin (dkryaklin)
**License:** MIT
**Docs / playground:** https://colordx.dev
**GPU companion:** [dkryaklin/colordx-gpu](https://github.com/dkryaklin/colordx-gpu) (`@colordx/gpu`)
**Blog post on the GPU work:** https://dkryaklin.com/blog/colordx-gpu

## What It Is

A chainable, immutable color manipulation library "built for the CSS Color 4 era" — 7.6 KB gzipped, zero dependencies, TypeScript. Native sRGB / HSL / OKLab / OKLCH; everything else (Lab, LCH, CMYK, HSV, HWB, P3, Rec.2020, A98, ProPhoto, a11y, harmonies, mixing, names, minify) is an opt-in plugin loaded via `extend([...])`.

The ergonomics are the `colord` shape — `colordx('#f00').lighten(0.1).toHex()`, `extend([plugin])`, `.isReadable()`, `.readableScore()`, `.minify()`, `.toNumber()` — but the internals target modern spaces first and are considerably faster. Used by **cssnano** and Evil Martians' **oklch-picker**.

```js
import { colordx } from '@colordx/core';

colordx('#ff0000').toOklch();       // { l: 0.62796, c: 0.25768, h: 29.23389, alpha: 1 }
colordx('oklch(0.5 0.2 240)').toHex();          // '#0069c7'
colordx('#3d7a9f').rotate(30).darken(0.1).toRgbString();
```

## Where It Sits Among the Libraries

| Need | Reach for |
| --- | --- |
| Breadth — 30 spaces, 10 ΔE metrics, interpolation splines, CVD sim, blending | **Culori** |
| Spec authority, exotic spaces (Jzazbz, ICtCp), CAT16 | **Color.js** |
| Chainable CSS-facing manipulation with OKLCH as a first-class citizen, small bundle | **colordx** |
| Bare-metal conversion for real-time / generative art | **@texel/color**, or colordx's `*Channels` / `*Into` functions |

colordx's niche: you want `.lighten().saturate().toHex()` chaining *and* correct CSS Color 4 gamut behavior *and* a small bundle. Culori is the bigger toolbox; colordx is the ergonomic front-end for the everyday CSS cases.

### Benchmarks (author's, Apple M4, Node 22, mitata)

| Benchmark | colordx | @texel/color | colord | culori | chroma-js |
| --- | --- | --- | --- | --- | --- |
| HEX → toHsl | 24M ops/s | — | 10M | 5.5M | 3.5M |
| HEX → lighten → toHex | 12M | — | 5.8M | 4.8M | 1.3M |
| Mix two colors | 6.7M | 5.2M | 1.2M | 1.0M | 1.1M |
| HEX → toOklch | 5.5M | 4.5M | — | 3.3M | 1.0M |
| inGamutP3 | 4.6M | 3.0M | — | 1.0M | — |

Self-reported; treat as directional, not audited.

## The Interesting Part: Gamut Handling

This is the design decision worth stealing. Out-of-gamut `oklch()` / `oklab()` inputs are stored **unclamped**, so the authored color round-trips losslessly; the fold into sRGB happens at output time and you choose *how*:

```js
const input = 'oklch(0.5 0.4 180)';                  // outside sRGB

colordx(input).toOklchString();                       // 'oklch(0.5 0.4 180)'  — preserved
colordx(input).toRgbString();                         // 'rgb(0 152 108)'      — naive clip
colordx(input).mapSrgb().toOklchString();             // 'oklch(0.50907 0.09379 177.84892)'
colordx(input).clampSrgb().toOklchString();           // 'oklch(0.60125 0.1276 164.29892)'
```

- **`.mapSrgb()`** — CSS Color 4 chroma-reduction binary search. Holds L and H, sacrifices C. Use for design tokens, palettes, programmatic harmonies, pickers — anywhere hue drift is a bug.
- **`.clampSrgb()`** — naive clip in *linear* sRGB. Hue and lightness drift (note above: 0.5/180 becomes 0.60/164 — a 15° hue shift and a 10-point lightness jump). This is what browsers actually do when rendering `background: oklch(...)`, which is why it's the default for `.toHex()` / `.toRgbString()`: output matches the screen.
- Static one-shot: `Colordx.toGamutSrgb(input)` ≡ `colordx(input).mapSrgb()`.

Wide gamuts via plugins: `inGamutSrgb / inGamutP3 / inGamutRec2020 / inGamutA98 / inGamutProphoto`, and `Colordx.toGamutP3 / toGamutRec2020 / …`. The README states the containment correctly, including the caveat that usually gets fudged:

> sRGB ⊂ Display-P3 ⊂ Rec.2020 ⊂ ProPhoto. A98 (Adobe RGB 1998) sits between sRGB and Rec.2020 — wider than sRGB, mostly in the greens — but is **not** a strict superset of Display-P3.

Gamut checks accept CIE `lab()` / `lch()` strings and objects too, not just OK-space.

## Plugins

`a11y` (WCAG + APCA) · `lab` (CIE Lab D50, XYZ D50/D65, `mixLab()`, `delta()` = CIEDE2000) · `lch` · `cmyk` (`device-cmyk()`) · `hsv` · `hwb` · `harmonies` · `mix` (`tints/shades/tones/palette`) · `minify` · `names` (140 CSS names) · `p3` · `rec2020` · `a98rgb` · `prophoto`.

**Lab vs OKLab disambiguation:** `{l, a, b}` and `{l, c, h}` are shape-identical between CIE and OK spaces, so CIE objects require a `colorSpace: 'lab' | 'lch'` discriminant. Bare objects parse as OK-space. Same trick for `{x, y, z}`: plain = D50, `colorSpace: 'xyz-d65'` = screen-native D65.

**a11y:** `.isReadable(bg, {level, size})`, `.readableScore(bg)` → `'AAA' | 'AA' | 'AA large' | 'fail'`, `.minReadable(bg)` (auto-adjusts to hit 4.5), `.apcaContrast(bg)` → signed Lc, `.isReadableApca(bg, {size})` using |Lc| ≥ 75 normal / ≥ 60 large. Signed Lc is correct APCA — positive = dark text on light bg. Worth noting the asymmetry the README shows: `#000` on `#fff` = 106.0 but `#fff` on `#000` = −107.9. Polarity matters; WCAG 2.x can't express that.

**harmonies:** pure hue rotation in HSL — complementary [0,180], analogous [−30,0,30], split-complementary [0,150,210], triadic, tetradic (square), rectangle [0,60,180,240], double-split-complementary. Convenient, but it's the naive wheel-geometry model — see `references/techniques/youre-wrong-about-color-harmony.md` and `pro-color-harmonies.md` before shipping these as *the* palette.

## Performance APIs (the reason to pick it for generative work)

Standalone functional converters that skip object allocation entirely:

```js
oklchToRgbChannels(0.5, 0.2, 240);  // [r,g,b] gamma sRGB 0–1 (may exceed range if OOG)
oklchToLinear(0.5, 0.2, 240);       // unclamped linear sRGB — also a free sRGB gamut check
labToRgbChannels / lchToRgbChannels / rgbToLinear / labToLinearSrgb / lchToLinearSrgb
labToLinearAndSrgb(...)             // linear + gamma in one pass
```

Plus P3/Rec.2020 siblings in their plugins (`oklchToP3Channels`, `linearToP3Channels`, …). The **split-step** pattern is the notable one: compute the expensive OKLCH→linear-sRGB step once (3× `Math.cbrt` + the OKLab matrix), then apply the cheap per-space matrix for each output gamut.

**`*Into` variants** — every channel function has a sibling that writes into a caller-supplied `Float64Array(3)` instead of allocating: `oklchToP3ChannelsInto(buf, l, c, h)`. Bit-identical output, ~10× less GC pressure in per-pixel loops. One buffer per loop, not per iteration; `linOut` and `srgbOut` in the `*AndSrgbInto` forms must be distinct buffers. Only reach for these after profiling.

```js
const buf = new Float64Array(3);
for (…each pixel…) {
  oklchToP3ChannelsInto(buf, l, c, h);
  imageData[i++] = Math.floor(buf[0] * 255); …
}
```

## Gotchas

- **`.mix()` interpolates in sRGB**, matching CSS `color-mix(in srgb, …)` and browser compositing — so black→white midpoint is `#808080`, not perceptual. Use `.mixOklab()` (`#636363`) or `.mixLab()` (`#777777`). `tints()`, `shades()`, `tones()` all call `.mix()`, so they inherit sRGB behavior.
- **`.lighten(0.1)` is absolute** (+10 percentage points of L), not proportional. `{ relative: true }` gives the Qix `color`-style proportional behavior. Same flag on `darken/saturate/desaturate`.
- **Precision defaults differ per format:** 2 dp for HSL/HSV/CMYK/Lab/LCH/XYZ, 0 dp for HWB, 4 dp for OKLab/OKLCH/P3/Rec.2020. Alpha is globally fixed at 3 dp. Every `toX()` takes an optional precision argument.
- `.delta()` (lab plugin) returns CIEDE2000 normalized 0–1 (black↔white ≈ 1), not the raw ΔE00 0–100 scale most references use. Defaults to comparing against white if no argument.
- `nearest(color, list)` matches by OKLab distance — fine for coarse "closest swatch," but not a substitute for a proper ΔE00/HyAB match on near-neighbors.
- Not yet implemented (on the roadmap): `color-mix()` parsing, relative color syntax (`oklch(from red l c h)`), `color(srgb …)` / `color(srgb-linear …)` parsing.

## @colordx/gpu — Gamut-Slice Charts on the GPU

**Repo:** https://github.com/dkryaklin/colordx-gpu · **npm:** `@colordx/gpu` · MIT · zero deps
**Story:** https://dkryaklin.com/blog/colordx-gpu

Experimental companion that generates colordx's OKLCH/LCH conversions and gamut tests as **GLSL**, verified against `@colordx/core` by a parity test suite — so the exact same math runs in the shader as on the CPU. The first module built on that foundation is a WebGL2 **gamut-slice chart renderer**: the 2D slice-through-the-color-solid chart at the heart of every OKLCH/LCH picker UI, which is otherwise a per-pixel CPU loop that stutters when you drag a hue slider.

```js
import { createChartRenderer } from '@colordx/gpu';

const renderer = createChartRenderer(canvas, { model: 'oklch' }); // null if no WebGL2
renderer.paint({
  plane: 'cl', value: 264, xMax: 1, yMax: 0.37,
  gamuts: [{ space: 'srgb', border: [1,1,1,1] }, { space: 'p3', fill: true }],
  p3Output: true,
});
```

**Models and planes.** `model: 'oklch' | 'lch' | 'oklab' | 'lab'` (CIE variants are D50) — same math, the axes just change. Polar planes: `'cl'` (x=L, y=C, fixed H), `'ch'` (x=H, y=C, fixed L), `'lh'` (x=H, y=L, fixed C). Cartesian planes: `'ab'` (fixed L), `'la'`, `'lb'`. `xMin`/`yMin` default to 0 — set them negative for `a`/`b` axes. `transpose` swaps which screen axis each component uses without rebinding `xMax`/`yMax`.

### Gamuts are layers, not a nesting

The design decision worth noting, because it's the one most picker UIs get wrong. Each entry in `gamuts` names a `space` (`'srgb' | 'p3' | 'a98' | 'rec2020' | 'prophoto'`) and opts into a fill, a border, or both:

```js
gamuts: [
  { space: 'srgb',    border: WHITE },              // boundary line only
  { space: 'a98',     fill: true, border: WHITE },  // fill + its own edge
  { space: 'rec2020', border: GRAY },
]
```

- **Fill** = the union of every layer with `fill: true`.
- **Border** = each layer's *own* gamut edge (its zero-contour), composited in array order; where two non-nested boundaries cross — a98 vs p3 — the later layer's line wins.
- **No containment is assumed**, so nested and sibling gamuts render identically. This is what makes A98 correct here: it is wider than sRGB but not a superset of P3 (see the gamut section above), and a renderer that hard-codes sRGB ⊂ P3 ⊂ Rec.2020 can't draw it honestly.
- Wide-gamut fills display **clamped** to the output space, but the boundary line still marks the true extent — so you can see that a color exists beyond what your screen can show.

One renderer covers several pickers: an OKLCH picker overlays srgb/p3/rec2020; a wide-gamut picker shows a single working gamut like a98 over an sRGB reference. Legacy `showP3` / `showRec2020` / `borderP3` / `borderRec2020` flags still work, mapped onto equivalent layers, but are deprecated.

### Chroma stretching (`chromaLUT` / `radialLUT`)

By default the chroma axis is **absolute**, so the gamut edge sits wherever it happens to reach and most of the chart is empty. Many OKLCH pickers instead **stretch** each lightness row so the gamut edge fills the axis — i.e. the x-axis becomes "fraction of the way to the gamut shell" rather than an absolute chroma value. That's the same gamut-relative-chroma idea as `nutelch`'s `relC` and the boundary-relative saturation in OkHSL — see `references/techniques/nutelch-gamut-relative-chroma.md`.

```js
const lut = math.maxChromaLUT({ model: 'oklch', hue: 264, gamut: 'p3' });
renderer.paint({ plane: 'cl', value: 264, xMax: 1, yMax: 0.4, gamuts, chromaLUT: lut });
```

A `Float32Array` of max in-gamut chroma sampled along the lightness axis. The builder binary-searches the *same* colordx math the shader runs, so the stretched render is parity-correct by construction rather than approximately aligned. Rebuild when hue/model/gamut changes — ~2k conversions, far cheaper than a per-pixel CPU pass.

`radialLUT` is the Cartesian analogue for the `'ab'` plane: max in-gamut chroma sampled **around the hue circle** at the fixed lightness, so each direction is scaled to map the gamut edge to unit radius. Turns the small off-centre blob of absolute `a`/`b` coordinates into a full disc; read the axes as normalized direction with `xMin`/`yMin` = −1, `xMax`/`yMax` = 1. Built with `math.maxChromaRadialLUT({ model, lightness, gamut })`, rebuilt when lightness changes.

### `math` — the JS twin

The CPU side of the parity suite is exported, useful for testing or for the fallback path:

```js
import { math } from '@colordx/gpu';
math.oklchToLinearSrgb(0.7, 0.1, 150);     // [r,g,b] linear, unclamped
math.oklabToLinearSrgb(0.7, -0.05, 0.12);  // Cartesian twin; also labToLinearSrgb
math.maxChromaLUT({ model: 'oklch', hue: 150, gamut: 'p3' });
```

### Practical notes

- One full-canvas draw per `paint()` — cheap enough to call every frame of a slider drag.
- **One-way door:** a canvas that has handed out a WebGL context can never provide a `'2d'` context again. Decide GPU vs CPU *per canvas* before the first paint.
- `createChartRenderer()` returns `null` instead of throwing when WebGL2 is unavailable — keep a CPU fallback. `paint()` returns `false` while the context is lost and re-initializes automatically on restore. `destroy()` releases the context.
- `p3Output: true` encodes for a Display-P3 drawing buffer (Chrome 104+, Safari 16.4+); silently stays sRGB elsewhere.

Related: `references/techniques/color-palette-shader.md` (same GPU-color-math idea applied to Voronoi palette visualization across 30+ models) and `references/techniques/glsl-lut-color-grading.md`.

## Links

- **GitHub:** https://github.com/dkryaklin/colordx
- **npm:** https://www.npmjs.com/package/@colordx/core
- **Playground / docs:** https://colordx.dev
- **GPU companion:** https://github.com/dkryaklin/colordx-gpu · https://dkryaklin.com/blog/colordx-gpu
- **CSS Color 4 gamut mapping algorithm (the basis of `.mapSrgb()`):** https://www.w3.org/TR/css-color-4/#css-gamut-mapping
- **APCA intro (background for the a11y plugin):** https://git.apcacontrast.com/documentation/APCAeasyIntro
- **Sponsor:** https://ruslo.app
