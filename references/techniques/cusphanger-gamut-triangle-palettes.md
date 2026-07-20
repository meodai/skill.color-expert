# CuspHanger — Wijffelaars Palettes in OKLCH

**Source:** [GitHub — meodai/cusphanger](https://github.com/meodai/cusphanger)
**Author:** meodai
**License:** MIT
**Demo:** https://meodai.github.io/cusphanger/

## What It Does

A faithful **OKLCH implementation of Wijffelaars, Vliegen, van Wijk & van der Linden's "Generating Color Palettes using Intuitive Parameters"** (Computer Graphics Forum 28:3, EuroVis 2009 — see [Wijffelaars — Intuitive Color Palettes](wijffelaars-intuitive-color-palettes.md)). The paper was written for CIELUV; CuspHanger re-expresses the exact model in OKLCH, which also lets it target **Display-P3**, not just sRGB. The API is deliberately kept compatible with [RampenSau](rampensau-palette-generation.md) wherever the concepts correspond.

## Core Concept

For a fixed hue, the displayable colors approximate a **triangle in the chroma–lightness plane** with corners at black, white, and the **cusp** — the most saturated color that hue can reach (the paper's *MSC*, Most Saturated Color). A palette is a **quadratic-Bézier path through that triangle, sampled at perceptual lightness steps**. Because the triangle is an inner approximation of the gamut, results are **in-gamut by construction** — no clamping irregularities.

Fidelity details worth knowing:

- The paper's lightness curve is evaluated in its native CIE L\* units and converted to OKLab lightness through luminance Y (for neutrals OKLab L = Y^⅓ exactly), so palettes hit the same physical lightnesses the paper calibrated against the Brewer palettes.
- Diverging palettes sample the *joined* two-arm curve uniformly: odd N lands on the shared neutral exactly once; even N straddles it at half-step spacing, so the step across the join reads like every other step. Swapping `hStart`/`hEnd` mirrors the palette exactly, including with `coolWarm`.
- The paper's bright point `p_b` (the yellow that `coolWarm` pulls toward) is canonically sRGB yellow in every gamut, so sRGB and Display-P3 palettes stay comparable.

## The Knobs (the paper's parameters)

| Param | Meaning | Default |
| ----- | ------- | ------- |
| `saturation` (s) | Curve tension: 0 = gray ramp, 1 = bends through the cusp | 0.6 |
| `brightness` (b) | Shapes the lightness sampling start | 0.75 |
| `contrast` (c) | Shapes the lightness range | min(0.88, 0.34 + 0.06·total) |
| `coolWarm` (w) | Multi-hue shift pulling the light end toward yellow (paper Table 2) | 0 |

**Lightness — two equivalent knobs:** `brightness`/`contrast` are the paper's `b`/`c`; `lRange: [minLight, maxLight]` sets the endpoints directly (RampenSau-style) and wins when given. They're a bijection — same lightness curve, with the paper's perceptual `0.2^x` spacing kept between the endpoints either way.

## API

```ts
import { sequential, ramp, diverging } from 'cusphanger';
import { oklchSrgb, oklchP3, toCss } from 'nutelch';

// single-hue sequential (paper, Table 1)
sequential({ hStart: 260, total: 9, saturation: 0.6, brightness: 0.75, contrast: 0.88, lut: oklchSrgb });

// cool/warm multi-hue (Table 2)
sequential({ hStart: 260, total: 9, coolWarm: 0.15, lut: oklchSrgb });

// diverging — two sequentials joined through a shared neutral
diverging({ hStart: 250, hEnd: 30, total: 9, lut: oklchSrgb });

// Display-P3 target — just pass the P3 LUT
sequential({ hStart: 260, total: 9, lut: oklchP3 });

// lightness by endpoints (RampenSau-style lRange)
sequential({ hStart: 260, total: 9, lRange: [0.25, 0.95], lut: oklchSrgb });

// ramp() — the RampenSau hybrid: a hue trajectory through the paper's model
ramp({ hStart: 260, total: 9, hCycles: 0.3, lut: oklchSrgb });

// saturation as a gamut-relative range across the ramp
ramp({ hStart: 260, total: 9, sRange: [0, 1], lut: oklchSrgb }); // gray dark → vivid light

// explicit hue per color — pairs with RampenSau's uniqueRandomHues / colorHarmonies
ramp({ hStart: 0, total: 9, hueList: [10, 120, 240], lut: oklchSrgb });

// fromColor() — inverse: solve the model so the palette meets a color you already have
fromColor({ mode: 'oklch', l: 0.58, c: 0.09, h: 155 }, { total: 9, lut: oklchSrgb });
```

- **`sequential()` and `diverging()`** are the paper's surface, nothing else.
- **`ramp()`** is the RampenSau-shaped entry point: extends `SequentialOptions` with the hue trajectory (`hCycles`, `hStartCenter`, `hEasing`, `hueList`), ramped tension (`sRange`/`sEasing`) and `triangleMode`. With none of them set it equals `sequential()` exactly. Each color rides the paper's ramp for its own rotated hue.
- Also exported, both taking a nutelch LUT: **`cusp(hue, lut)`** (the MSC apex) and **`maxChromaAt(hue, l, lut)`** (the gamut shell at a lightness).

## fromColor — Meet a Color You Already Have

The inverse problem: you have a color (a brand green, a chart accent) and want the ramp that passes through it. `fromColor(target, { total, lut })` solves the sequential model and returns **options, not colors** — the solve stays inspectable and tweakable:

```ts
const { options, index, color, clamped } = fromColor(target, { total: 9, lut: oklchSrgb });
sequential(options)[index]; // === target (exactly, when reachable)
```

Nothing is fitted — the constraints decouple: hue is taken exactly (`hStart = target.h`, the whole curve lives in the target's hue plane), `saturation` is bisected until the curve's chroma at the target's lightness matches (monotone in `s`, so bisection is exact), and the lightness endpoints shift minimally so sample `index` lands on the target's lightness.

- **`index`** — which entry carries the target. Defaults to `'nearest'` (endpoints move least); pass a number to pin it.
- **`lRange`** — hold the lightness endpoints; only hue + tension are solved, and `index` reports the nearest sample.
- **`clamped`** — reachability is the triangle (∩ shell), not the full gamut. An unreachable target never throws: it's met at the same-lightness boundary point instead, returned as `color` with `clamped: true`.
- **`coolWarm`** is deliberately absent — `w > 0` drifts hue along the curve, breaking the hue decoupling; held at 0.

The target is the same OKLCH object the generators emit — a hex is one Culori call away: `converter('oklch')('#4a8a62')`.

## Output & Rendering

Each color is a nutelch/culori-native OKLCH object `{ mode: 'oklch', l, c, h }`, in-gamut by construction (clamped to the LUT's shell). Render via nutelch's `toCss` — the browser handles `oklch()` natively:

```ts
el.style.background = toCss(palette[0]); // 'oklch(0.44 0.13 260)'
```

For hex strings or gamut flags use [Culori](culori-color-spaces-api.md): `formatHex(color)`, `inGamut('rgb')(color)`.

## Install & Dependencies

```bash
npm install cusphanger nutelch
```

Gamut math is delegated to [nutelch](nutelch-gamut-relative-chroma.md) (LUT-backed, runtime dependency-free); you pass the gamut LUT in — `oklchSrgb` or `oklchP3`.

## RampenSau Interop — What's Shared, What's Left Out

Where concepts correspond, options share RampenSau's names and semantics (`total`, `hStart`/`hEnd`, `hCycles`, `hStartCenter`, `hEasing`, `sRange`/`sEasing`, `lRange`, `hueList`); RampenSau's easing/curve helpers plug straight into `hEasing`/`sEasing`. Only the paper-specific knobs (`saturation`, `brightness`, `contrast`, `coolWarm`) have no RampenSau counterpart. Inside `ramp()` under a shared `triangleMode`, `coolWarm` changes mechanism: with no per-hue triangle to shift, it instead nudges the light colors' hues toward the bright point — same visual intent.

Deliberately omitted:

- **`lEasing`** — the paper's contribution *is* the fixed perceptual lightness sampling (`0.2^x` spacing, calibrated against Brewer). A free-form lightness easing would quietly undo the model; use `lRange` (or `brightness`/`contrast`) instead.
- **`transformFn`** — colors are plain objects; `.map()` the result.
- **Random defaults** — `total` and `hStart` are required. The point of the model is an exact, reproducible specification; nothing is randomized for you.

## When to Reach for It

- **Data-visualization ramps** (sequential/diverging) where perceived ordering, representative distances, and equal importance matter — the Brewer-quality guarantees of the paper, at any N, in a modern color space.
- **P3-targeted palettes** with the same model as sRGB, comparable across gamuts.
- When you want RampenSau's ergonomics but with **in-gamut-by-construction** results and the paper's calibrated lightness sampling instead of free-form easing.

## Connection to Other References

- **[Wijffelaars — Intuitive Color Palettes](wijffelaars-intuitive-color-palettes.md)** — the 2009 paper this implements, model details and user study.
- **[RampenSau](rampensau-palette-generation.md)** — API sibling; free-form hue/saturation/lightness trajectories vs CuspHanger's calibrated model.
- **[nutelch](nutelch-gamut-relative-chroma.md)** — the gamut engine underneath: cusp/shell LUTs, gamut-relative chroma.
- **[Cubehelix](cubehelix-color-scheme.md)** — same monotonic-lightness goal via a helix in RGB.
- **[Culori](culori-color-spaces-api.md)** — for hex interchange and gamut checks on the output.
