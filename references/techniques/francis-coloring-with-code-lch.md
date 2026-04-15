# George Francis — Coloring With Code (LCH palette generation)

**Source:** [Codrops](https://tympanus.net/codrops/) tutorial by George Francis
**URL:** https://tympanus.net/codrops/2021/12/07/coloring-with-code-a-programmatic-approach-to-design/
**Published:** 2021-12-07
**Author site:** https://georgefrancis.dev/

Three small, composable palette-generation functions built in **LCH** (perceptually uniform) using [Culori](https://culorijs.org/). Each function solves a different problem — classic harmonies, nearest-match discovery, and pixel-art hue shifting — and all three can be combined in real projects.

Why this article matters:

- Picks LCH over HSL for the right reason: equal hue steps produce equal-feeling shifts, and equal lightness values feel equally bright. HSL fails both tests.
- Explicitly demonstrates the **"nearest match from a pool"** pattern — a simple but under-taught trick for extracting harmonies from an image palette or brand swatches rather than generating sterile computed colors.
- Introduces **hue-shifting** (shifting hue together with lightness) to a developer audience — a pixel-art staple that keeps tints/shades vivid instead of drifting to gray.

---

## 1. Scientific — classic harmonies via hue rotation

Rotate around the color wheel by canonical intervals, keeping L and C constant.

```javascript
function adjustHue(val) {
  if (val < 0) val += Math.ceil(-val / 360) * 360;
  return val % 360;
}

function createScientificPalettes(baseColor) {
  const targetHueSteps = {
    analogous:          [0, 30, 60],
    triadic:            [0, 120, 240],
    tetradic:           [0, 90, 180, 270],
    complementary:      [0, 180],
    splitComplementary: [0, 150, 210],
  };

  const palettes = {};
  for (const type of Object.keys(targetHueSteps)) {
    palettes[type] = targetHueSteps[type].map((step) => ({
      l: baseColor.l,
      c: baseColor.c,
      h: adjustHue(baseColor.h + step),
      mode: "lch",
    }));
  }
  return palettes;
}
```

Usage:

```javascript
import { formatHex } from "https://cdn.skypack.dev/culori@2.0.0";

const baseColor = { l: 50, c: 100, h: 0, mode: "lch" };
const palettes = createScientificPalettes(baseColor);
const triadicHex = palettes.triadic.map(formatHex);
// → ["#ff007c", "#1f8a00", "#0091ff"]
```

**Gotcha:** Culori requires an explicit `mode` property on color objects.

**Challenge from the article:** extend with a monochromatic mode (vary L or C instead of H).

**Caveats worth adding:**

- Fixed `c` at 100 will frequently land **out of sRGB gamut**. Either clamp via `clampChroma(color, 'lch')` from Culori, or cap at `c ≤ 60` for reliable in-gamut colors.
- This is the same hue-rotation logic as classic HSL harmony generators — the LCH win is that the _perceived_ hue steps are actually what the numbers promise.

## 2. Discovery — nearest-match palette from a pool

Given any array of colors (extracted from a photo, brand palette, etc.) and the ideal harmony from Function #1, find the closest real-world color for each slot using Euclidean distance in LCH. Return the best palette of each type plus a variance score.

```javascript
import {
  nearest,
  differenceEuclidean,
} from "https://cdn.skypack.dev/culori@2.0.0";

function isColorEqual(c1, c2) {
  return c1.h === c2.h && c1.l === c2.l && c1.c === c2.c;
}

function discoverPalettes(colors) {
  const palettes = {};

  for (const color of colors) {
    const targetPalettes = createScientificPalettes(color);

    for (const paletteType of Object.keys(targetPalettes)) {
      const palette = [];
      let variance = 0;

      for (const targetColor of targetPalettes[paletteType]) {
        // don't re-use colors already chosen for this palette
        const availableColors = colors.filter(
          (c1) => !palette.some((c2) => isColorEqual(c1, c2))
        );
        const match = nearest(availableColors, differenceEuclidean("lch"))(targetColor)[0];
        variance += differenceEuclidean("lch")(targetColor, match);
        palette.push(match);
      }

      if (!palettes[paletteType] || variance < palettes[paletteType].variance) {
        palettes[paletteType] = { colors: palette, variance };
      }
    }
  }
  return palettes;
}
```

Usage:

```javascript
import { converter } from "https://cdn.skypack.dev/culori@2.0.0";
const toLCH = converter("lch");

const baseColors = [
  "#FFB97A","#FF957C","#FF727F","#FF5083","#F02F87",
  "#C70084","#9A007F","#6A0076","#33006B"
].map(toLCH);

const palettes = discoverPalettes(baseColors);
```

**Requires at least 4 colors** in the pool to cover tetradic.

**Why it matters:** this is the "find me the best triadic inside my photo" pattern. Compared to pure hue rotation, the results feel natural — the palette is always made of colors that genuinely coexisted in the source, so harmonies are never sterile or out-of-gamut.

**Challenge from the article:** bias the selection (e.g., prefer brighter colors) by adding weights inside the distance function.

**Extension ideas:**

- Swap `differenceEuclidean("lch")` for `differenceCiede2000()` or `differenceHyab()` for better perceptual distance — Euclidean in LCH is decent but not great near the poles.
- The `isColorEqual` check on raw LCH fields is brittle for imported colors; prefer comparing by a stable key.

## 3. Hue Shift — lightness modulates hue

Pixel-art technique ([source video](https://www.youtube.com/watch?v=PNtMAxYaGyg)): as a color gets lighter, shift hue one way; as it darkens, shift the other. Keeps tints/shades vivid instead of drifting toward white/black/gray. Builds a 9-step ramp around a base color.

```javascript
function adjustHue(val) {
  if (val < 0) val += Math.ceil(-val / 360) * 360;
  return val % 360;
}

function map(n, start1, end1, start2, end2) {
  return ((n - start1) / (end1 - start1)) * (end2 - start2) + start2;
}

function createHueShiftPalette(opts) {
  const { base, minLightness, maxLightness, hueStep } = opts;
  const palette = [base];

  for (let i = 1; i < 5; i++) {
    const hueDark       = adjustHue(base.h - hueStep * i);
    const hueLight      = adjustHue(base.h + hueStep * i);
    const lightnessDark  = map(i, 0, 4, base.l, minLightness);
    const lightnessLight = map(i, 0, 4, base.l, maxLightness);
    const chroma = base.c;

    palette.push(   { l: lightnessDark,  c: chroma, h: hueDark,  mode: "lch" });
    palette.unshift({ l: lightnessLight, c: chroma, h: hueLight, mode: "lch" });
  }
  return palette;
}
```

Usage:

```javascript
const hueShiftPalette = createHueShiftPalette({
  base: { l: 55, c: 75, h: 0, mode: "lch" },
  minLightness: 10,
  maxLightness: 90,
  hueStep: 12,
});
// → ["#ffb97a","#ff957c","#ff727f","#ff5083","#f02f87","#c70084","#9a007f","#6a0076","#33006b"]
```

**Why the hue shift keeps things vivid:** in LCH (or OKLCH), pure lightness ramps of a fixed hue still feel reasonable, but small hue shifts toward warm-for-tints and cool-for-shades match how light and shadow actually look in the world — skin tones, sunset, ocean, autumn leaves all do this. A 12° step is a good starting default; larger steps (20–30°) produce the "stylized game art" look.

**Challenge from the article:** replace `map` (linear) with an easing function so the ramp bunches toward the ends or middle non-linearly.

**Extension ideas:**

- Run in **OKLCH** instead of LCH — OKLCH hue is even more perceptually uniform, especially around blue (`bjorn-ottosson-oklab-articles.md`). One-line change.
- Vary **chroma** with the step too — often tints look best at lower chroma and midtones at highest chroma (roughly the Munsell irregular solid shape).

## How the three functions compose

- **Scientific → Hue Shift:** pick a base with Scientific (e.g. one of a tetradic set), then build a 9-step ramp for each with Hue Shift. You get a full design-system ramp for a harmonious palette in two calls.
- **Discovery → Hue Shift:** find the best triadic from an image with Discovery, then expand each anchor into a vivid ramp with Hue Shift. Image-driven palette + full ramps.
- **Discovery + Scientific:** the article does this internally — Discovery uses Scientific as its "ideal target" generator.

## Related techniques in this collection

- **[Francis — Balanced Generative Palettes](francis-balanced-generative-palettes.md)** — Francis's later article. `createWeightedSelector` (60/30/10 distribution) + `modulateColorHSL` (per-object variance). Good downstream of these three: Scientific/Discovery/Hue-Shift generates the palette; weighted selection + modulation applies it.
- **[Culori — Color Spaces & API](culori-color-spaces-api.md)** — the library used throughout. `nearest`, `differenceEuclidean`, `converter`, `formatHex`, `clampChroma`.
- **[Björn Ottosson — OKLAB Articles](../contemporary/bjorn-ottosson-oklab-articles.md)** — OKLCH as a drop-in improvement over LCH for these exact functions.
- **[IQ Cosine Palette Formula](iq-cosine-palette-formula.md)** — parametric alternative to Hue Shift for building ramps; smoother by construction.
- **[RampenSau](rampensau-palette-generation.md)** — meodai's ramp generator; implements hue cycling with easing, a generalization of Hue Shift.
- **[Tyler Hobbs — Generative Color](tyler-hobbs-generative-color.md)** — kindred practical treatment of generative color.

## Links

- **Article:** https://tympanus.net/codrops/2021/12/07/coloring-with-code-a-programmatic-approach-to-design/
- **Author (George Francis) site:** https://georgefrancis.dev/
- **Codrops:** https://tympanus.net/codrops/
- **Culori library:** https://culorijs.org/
- **Culori — `nearest`:** https://culorijs.org/api/#nearest
- **Culori — `differenceEuclidean`:** https://culorijs.org/api/#differenceEuclidean
- **Skypack CDN (used for imports):** https://www.skypack.dev/
- **Lea Verou — LCH Colors in CSS:** https://lea.verou.me/2020/04/lch-colors-in-css-what-why-and-how/
- **Can I Use — CSS LCH:** https://caniuse.com/css-lch-lab
- **Pixel-art Hue Shifting tutorial (inspiration for Function #3):** https://www.youtube.com/watch?v=PNtMAxYaGyg
- **Monochromatic Color (Wikipedia — Challenge #1):** https://en.wikipedia.org/wiki/Monochromatic_color
