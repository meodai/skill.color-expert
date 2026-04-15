# George Francis — Balanced Generative Color Palettes

**Source:** [George Francis](https://georgefrancis.dev/) (personal blog, generative artist)
**Article URL:** https://georgefrancis.dev/writing/balanced-generative-color-palettes/
**Companion article:** https://georgefrancis.dev/writing/generative-color-modulation/

Two small, composable techniques for generative art:

1. **Weighted color selection** — turn a palette into a probability distribution so the composition follows the 60/30/10 rule (or any ratio you want) without visible chaos.
2. **Per-use color modulation** — each time a color is "placed", nudge its HSL by a small random amount so the piece reads as hand-applied paint rather than flat fills.

Francis explicitly recommends combining them: "Why not try combining weighted color palettes with a touch of color modulation?"

## Why this matters

Random uniform color picking from a palette feels visually unstable — every color fights for attention. Distributing colors by weight produces the same "balanced" feel painters get from a dominant / secondary / accent hierarchy. Modulation on top adds organic variance that computer renders usually flatten away.

This is a pure JS technique — no libraries required, pairs cleanly with any generative pipeline (p5.js, canvas, SVG, WebGL).

---

## Technique 1 — Weighted selection

### The core function

```javascript
function createWeightedSelector(items) {
  const weightedArray = [];

  for (const item of items) {
    for (let i = 0; i < item.weight; i++) {
      weightedArray.push(item.value);
    }
  }

  return function () {
    return weightedArray[Math.floor(Math.random() * weightedArray.length)];
  };
}
```

Takes `[{ value, weight }]` objects. Returns a closure that produces a random `value` on each call, weighted by `weight`. Values can be anything — colors, strings, shapes, numbers.

### Applied to 60/30/10

```javascript
const pickColor = createWeightedSelector([
  { weight: 60, value: 'black' },    // neutral    — 60%
  { weight: 30, value: 'orange' },   // primary    — 30%
  { weight: 10, value: 'tomato' },   // accent     — 10%
]);

// In the render loop:
const color = pickColor();
renderObject(color);
```

Weights are arbitrary — they do not need to sum to 100. `[6, 3, 1]` behaves the same as `[60, 30, 10]`.

### Notes & gotchas

- **Memory cost:** the implementation expands weights into an array. Weights of `60 / 30 / 10` → 100-element array. Fine for palettes; use a cumulative-sum + binary-search version for very large weights.
- **Not just colors:** the same selector works for shape types, stroke widths, motif variants. The 60/30/10 rule applies to any compositional element.
- **Compose with harmony:** choose the three colors with a harmony rule first (complementary, triadic, analogous) — weighting only controls distribution, not harmony.

## Technique 2 — Color modulation

### The function

```javascript
function modulateColorHSL(baseColor, hRange = 8, sRange = 8, lRange = 8) {
  const random = (min, max) => Math.random() * (max - min) + min;
  return {
    h: baseColor.h + random(-hRange, hRange),
    s: baseColor.s + random(-sRange, sRange),
    l: baseColor.l + random(-lRange, lRange),
  };
}
```

### Usage

```javascript
const baseColor = { h: 240, s: 75, l: 75 };

const modulated = modulateColorHSL(baseColor, 12, 12, 12);
const css = `hsl(${modulated.h}, ${modulated.s}%, ${modulated.l}%)`;
```

Each object rendered to the canvas uses a slightly different version of the base. Over many objects the palette reads as "hand-mixed paint" rather than PostScript flat fills.

### Tuning advice

- Keep ranges small — 5–15 for each axis. Larger ranges destroy palette identity.
- **Lightness is the most visually dominant axis** — reduce `lRange` relative to `hRange` / `sRange` if the piece feels noisy.
- Consider clamping `s` and `l` to `[0, 100]` for robustness (the article omits this).
- **Upgrade path:** swap HSL for OKLCH / OKHSL to avoid HSL's uneven lightness across hues. Modulation magnitudes in OKLCH L / C / H are perceptually consistent in a way HSL's are not — a +10° hue jitter at blue does not feel like a +10° jitter at yellow in HSL, but is much closer in OKHSL. See [bjorn-ottosson-oklab-articles.md](../contemporary/bjorn-ottosson-oklab-articles.md) and [hsluv-better-than-hsl.md](hsluv-better-than-hsl.md).

## Combining the two

The article's headline recommendation is the combination:

```javascript
const pickBase = createWeightedSelector([
  { weight: 60, value: { h: 0,   s: 0,  l: 10 } },  // near-black
  { weight: 30, value: { h: 30,  s: 90, l: 55 } },  // orange
  { weight: 10, value: { h: 10,  s: 80, l: 60 } },  // tomato
]);

function drawShape() {
  const base = pickBase();
  const c = modulateColorHSL(base, 6, 10, 6);
  return `hsl(${c.h}, ${c.s}%, ${c.l}%)`;
}
```

Dominant neutral, intentional accent distribution, per-object organic variance — three low-cost tricks that together lift most generative pieces.

## Related techniques in this collection

- **[IQ Cosine Palette Formula](iq-cosine-palette-formula.md)** — parametric ramp, complementary technique for building the base palette.
- **[Tyler Hobbs — Generative Color](tyler-hobbs-generative-color.md)** — also advocates probability-weighted palettes and "gradient the probabilities" (shift the distribution across the canvas, not the colors themselves). Direct intellectual neighbor to this article.
- **[Fontana — Fully Generative Color](fontana-generative-color-approach.md)** — Harvey Rayner's 6-step approach uses the same dominant/secondary/accent thinking ("salt/herbs/spices") with a tonally balanced spectrum.
- **[RampenSau](rampensau-palette-generation.md)** — could generate the base colors fed into `createWeightedSelector`.

## Links

- **Article 1 — Balanced Generative Color Palettes:** https://georgefrancis.dev/writing/balanced-generative-color-palettes/
- **Article 2 — Generative Color Modulation:** https://georgefrancis.dev/writing/generative-color-modulation/
- **CodePen — weighted selector demo:** https://codepen.io/georgedoescode/pen/OJQRxZr
- **CodePen — modulation demo:** https://codepen.io/georgedoescode/pen/XWeBapd
- **60/30/10 color rule video (linked by Francis):** https://www.youtube.com/watch?v=V-SD_zV9S2c
- **Smashing Magazine — HSL Colors in CSS (linked by Francis):** https://www.smashingmagazine.com/2021/07/hsl-colors-css/
- **Author homepage:** https://georgefrancis.dev/
