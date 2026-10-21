# Color Weight — Palettes Built on a Lightness Hierarchy

By **Dustin Brown** (speckofdustin.com). Personal project, captured 2026-10-21.

- Tool: https://colorweight.speckofdustin.com/
- Siblings: [Color Flow](color-flow-exploration-course.md) (module 01 "Value vs. Luminance" is the premise), [Color Collapse](color-collapse-tone-mapping.md)

"Color with a purpose." It builds a **five-color palette with an intentional reading order**: one accent and four supporting colors, **separated by lightness** while hue and chroma are free to vary. The palette is previewed live on an illustration and three UI mockups, plus a color-only strip. The idea: hierarchy comes from lightness distance, not from hue. Pick the accent first, then let the supports step away from it in L.

---

## The model

**Accent.** Set in OKLCH: L 0–100, C 0–0.4, any hue. The tool remembers hue and chroma even while a very dark, very light, or neutral setting hides them, so dragging L back doesn't lose the color.

**Four supporting roles**, ordered from quietest to closest to the accent: `field` (background), `surface`, `structure`, `detail`. They sit on **one side** of the accent in OKLab L:

```
direction = side === "light" ? +1 : −1
detail    = L_accent + dir · gap
structure = L_accent + dir · (gap + range/3)
surface   = L_accent + dir · (gap + 2·range/3)
field     = L_accent + dir · (gap + range)
```

- **Gap** (0–0.4) is the nearest lightness distance between the accent and any support. This is the main "how much does the accent pop" control.
- **Range** (0–0.3) spreads the four supports. It is **capped at 30 L points on purpose**, so the supports stay a related family instead of turning into a second full tonal scale.
- **Side:** Lighter, Darker, or Automatic. Automatic picks whichever side has more usable room. Ties go lighter.
- **Protect supporting tones** keeps supports in an L corridor of **0.12–0.94**, avoiding pure black, pure white and squashed tones. If the requested gap and range don't fit, the readout says what was reduced, or that it flipped to the other side.

**Support hue paths** relative to the accent (offsets per role, field → detail):

| Path | Hues |
| --- | --- |
| single | all at accent hue + offset |
| neighboring | −30°, −10°, +10°, +30° (analogous) |
| opposite | 150°, 170°, 190°, 210° (complementary fan) |
| split | 150°, 210°, 150°, 210° (split-complementary) |
| arc | rotates from accent hue + offset (field) back to the accent hue (detail), in OKLCH |
| sweep | the long way round (offset − 360°) |
| blend | straight line in OKLab a/b between the two hues, so the middle dips in chroma |

Support chroma is one shared request, `0.18 × intensity`.

**Gamut mapping:** for any color that can't be displayed, it bisects C down at fixed L and h. Every measurement uses the final mapped RGB.

---

## Checking the hierarchy

- **Set priority:** click preview elements from most to least important. The first gets the accent, the next four get progressively quieter roles. Selecting any text assigns *all* text as one group. This records *intended* hierarchy and does **not** predict eye movement.
- **Color-only strip:** equal-size swatches ordered from low to high intended prominence. It removes size, placement and composition so you judge the palette alone.
- **Luminance grayscale:** each color is replaced by the gray with the **same relative luminance (Y)**, not the same OKLab L, to show tonal hierarchy. Exports stay in full color.
- **Contrast markers:** WCAG ratios between neighboring swatches (accent vs field, surface vs field, structure vs surface, detail vs structure). Targets: off, 3:1, 4:1, 4.5:1, 7:1. The readout flags strong competing edges, with the caveat that size, position, surroundings and adaptation also pull attention.

## Measurement honesty (from the help text)

- L = OKLab L (0–100). Hue = OKLCH h. The chroma sliders are positions within instrument ranges (0–0.4 accent, 0–0.18 supports), **not** saturation percentages.
- HSV V = largest encoded channel. Y = weighted linear-light RGB. Both differ from OKLab L **and** from perceived brightness.
- **Helmholtz–Kohlrausch is not simulated**: at equal L, the saturated accent will look a bit brighter than the numbers say. In this tool that works *for* the accent.
- "This focal-point rule is an **authored heuristic, not a validated attention model**." References are given as context only: Ottosson's OKLab and Corney et al., *The Brightness of Colour* (PLOS ONE, 2009). Neither validates the rule.

## Also in the code: target-metric ramps

`weight-engine.js` includes a ramp builder that drives a hue/saturation sweep to a **target value in a chosen metric** (OKLab L, relative luminance Y, or HSV V) through a lightness profile of knots. It bisects OKLab L to hit Y, and lowers chroma only when the target doesn't fit, reporting **chroma retention**. It's a compact way to show that "equal V" produces wildly unequal ramps while "equal L" or "equal Y" holds.

---

## Takeaways for the skill

1. **Build UI hierarchy from lightness distance, not hue.** One accent, supports at a minimum L gap on one side, with a narrow spread (≤ 30 L points) so they read as a family.
2. **Assign roles in priority order** (accent → detail → structure → surface → field) instead of handing out five swatches at random.
3. **Check in grayscale by luminance.** If the hierarchy disappears in gray, hue was doing work it can't sustain (CVD, small sizes, glare).
4. **Label heuristics as heuristics.** The tool is explicit that it doesn't predict attention. That's a good habit to copy when giving palette advice.

## Links

- Color Weight: https://colorweight.speckofdustin.com/
- Björn Ottosson, OKLab: https://bottosson.github.io/posts/oklab/
- Corney, Haynes, Rees & Lotto, The Brightness of Colour (PLOS ONE, 2009): https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0005091
- Experiments index: https://experiments.speckofdustin.com/
