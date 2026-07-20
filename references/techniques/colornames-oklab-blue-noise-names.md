# colornames-oklab — Blue-Noise Color Names over Rec2020

**Source:** [GitHub — meodai/colornames-oklab](https://github.com/meodai/colornames-oklab)
**Author:** the maintainer (meodai)
**License:** MIT (names by Claude Fable 5 / color-name-list)
**Viewer:** https://meodai.github.io/colornames-oklab/

## What It Is

**4444 color names, evenly spread over the OKLab color space, covering the full Rec2020 gamut.** The inversion of [color-names](https://github.com/meodai/color-names) (the 30,000+ crowd-sourced list): plotted in perceptual space, crowd-sourced names cluster heavily where humans historically looked — reds, skin tones, popular sRGB pastels — while whole regions of the gamut sit almost empty. Here the *positions* come first: points are spread uniformly through OKLab, so every region of the gamut (including wide-gamut colors most screens are only now learning to show) gets a name, and no two names sit awkwardly close together.

## Data Schema

`colornames-oklab.json` — 4444 entries, 374 kB raw / 90 kB gzipped. Deliberately minimal; everything else is derivable:

```json
{ "name": "Emerald", "tier": "srgb", "hex": "#089156", "oklab": [0.577, -0.1257, 0.0551] }
```

- **`tier`** — smallest gamut containing the color: `srgb`, `p3` (inside Display P3 but outside sRGB), or `rec2020` (outside P3).
- **`hex`** — sRGB fallback produced by **chroma-clamping in OKLCH** (hue and lightness preserved, chroma pulled into gamut — the correct clamp, see SKILL.md *Gamut Mapping in Practice*). Safe everywhere.
- **`oklab`** — the exact sampled `[L, a, b]`. For CSS, spell it as `oklab(${l} ${a} ${b})` — evergreen browsers gamut-map it natively, so no stored `color()` strings needed. OKLCH via `C = Math.hypot(a, b)`, `H = Math.atan2(b, a) * 180 / Math.PI`.

**Descriptions (opt-in):** a separate index-aligned array of 4444 short authored descriptions (`colornames-oklab/descriptions.json`) — adds nothing to the bundle unless imported. E.g. Eigengrau: "The grey the eyes make in total darkness — intrinsic light, everyone's seen it."

## Lookup API

Dependency-free `closest()`, Euclidean distance in OKLab (solid perceptual metric). Takes raw OKLab values — convert with [Culori](culori-color-spaces-api.md) so the package stays zero-dep:

```js
import { closest } from 'colornames-oklab';

closest([0.577, -0.126, 0.055]);
// { name: 'Emerald', tier: 'srgb', hex: '#089156', oklab: [...], distance: 0.001 }

closest([[0.7, 0.1, 0.05], [0.3, -0.1, 0]]);   // many → one match each
closest(palette, { unique: true });             // color.pizza "noduplicates" mode:
// each query (in input order) takes the nearest name not already claimed
```

## Methodology

### Blue-noise sampling

Points generated with **best-candidate (Mitchell) sampling** in OKLab, rejection-constrained to the Rec2020 gamut: each new point is chosen from dozens of random candidates as the one farthest from all existing points. Since Euclidean distance in OKLab approximates perceptual distance, the set is *perceptually* evenly spaced — dense nowhere, sparse nowhere.

Grown in **five deterministic, seeded passes** (1500 → 2100 → 3000 → 4000 → 4444), each sampling against all existing points — so extending the list never moves or renames an entry. **Ids and names are stable forever**, and every future extension stays blue-noise. The dataset does not grow via PRs; only better human-invented names for existing points are accepted.

### Gamut tiers — the natural volume proportions

| tier | count | share | meaning |
| --- | --- | --- | --- |
| `srgb` | 2041 | ~46% | displayable everywhere |
| `p3` | 776 | ~17% | needs a Display P3 screen |
| `rec2020` | 1627 | ~37% | beyond P3 — the outer shell |

These are the *natural* relative volumes of the gamuts in OKLab — a fact worth knowing on its own: **the Rec2020-only shell is enormous (bigger than the P3 increment by 2×), and most of it is hyper-saturated emerald, teal, cyan, and deep blue.**

### Naming — vocabulary tracks the tier

The first 3000 names were written individually by Claude Fable 5, in hue order with each point's OKLCH coordinates and tier in view, drawing on color-names for tone; the last 1444 drew the strongest unused names from the curated *bestOf* subset (via color.pizza), matched by OKLab proximity. The register follows the gamut:

- **sRGB → the everyday canon:** `Moss`, `Denim`, `Terracotta`, `Butter`, `Salmon`, `Charcoal`.
- **P3 → vivid and recognizable:** `Electric Blue`, `Neon Carrot`, `Jazzberry Jam`, `Shocking Pink`.
- **Rec2020 → the exotic shell:** rare pigment/dye names (`Smaragdine`, `Zaffre`, `Eosin`, `Gamboge`, `Fuchsine`), deep-sea and cosmic imagery (`Benthic Teal`, `Event Horizon`, `Singularity`), physical-limit superlatives at the extreme chroma points (`Impossible Green`, `Maximum Fuchsia`, `Beyond Magenta`).

Script-enforced guarantees:

- **Uniqueness** — all 4444 names unique, and every `hex` fallback unique too (colliding wide-gamut clamps deterministically nudged to the nearest free hex).
- **Basics on solid ground** — ~80 "obvious" names (`Red`, `Blue`, `Navy`, `Pink`, `Teal`, `Gold`, …) are audited to exist **and** sit on `srgb`-tier points near their reference colors. Nobody needs a P3 monitor to see "Pink".

## Project Page & Viewer

`docs/index.html` — standalone Three.js viewer with the full dataset embedded: orbit the OKLab solid, hover for names, filter by tier, click to copy. Wide-gamut swatches render via CSS `oklab()`, so a P3 display shows the real thing.

## When to Reach for It

- **Naming generated/arbitrary colors** where you want even coverage — no query lands far from a name, unlike crowd-sourced lists whose density follows historical attention.
- **Wide-gamut (P3/Rec2020) work** — the only naming list with deliberate, proportional coverage beyond sRGB, plus per-color tier metadata to know what a display can actually show.
- **Unique-assignment naming** for palettes (`{ unique: true }`) — each swatch gets its own name.
- **As a perceptually uniform sample set** of the Rec2020 gamut in OKLab — useful beyond naming (e.g. seeding, testing gamut-mapping code, stratified color sampling by tier).

## Connection to Other References

- **[color-name-lists](color-name-lists.md)** — 18 historical/cultural naming systems; colornames-oklab is the geometry-first complement.
- **[Jaffer — Color-Name Dictionaries](jaffer-color-name-dictionaries.md)** — Jaffer's critique of naming datasets (gamut realism, coverage holes) is precisely what blue-noise sampling answers.
- **[Culori](culori-color-spaces-api.md)** — convert inputs to OKLab for `closest()`.
- **[nutelch](nutelch-gamut-relative-chroma.md)** — same chroma-clamp philosophy used for the hex fallbacks.
