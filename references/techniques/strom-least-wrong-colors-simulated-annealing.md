# How to Pick the Least Wrong Colors — Simulated Annealing for Categorical Palettes

**Author:** Matt Ström-Awn (published as Matthew Ström), design lead at Stripe
**Published:** May 31, 2022 · ~26 min read
**Source:** [mattstromawn.com](https://mattstromawn.com/writing/how-to-pick-the-least-wrong-colors/)
**Code:** [github.com/ilikescience/category-colors](https://github.com/ilikescience/category-colors) (MIT)
**Discussion:** [Hacker News](https://news.ycombinator.com/item?id=31639009)

## What It Is

A **stochastic optimization** approach to categorical data-visualization palettes: instead of constructing a palette from a color-space model (Wijffelaars/CuspHanger) or picking by hand (ColorBrewer, Adobe Spectrum, IBM Carbon), define a **loss function** over the criteria you care about and let **simulated annealing** search the space for the least-bad answer.

The framing is the useful part: *"In most optimization problems, there's no such thing as the one right answer. There are only lots of wrong answers. Our goal is to find the least wrong one."*

## The Problem

Categorical data viz at Stripe. Three competing criteria:

1. **Nice-looking** — should read as on-brand (Stripe-y).
2. **Broadly applicable** — enough distinct colors for many categories.
3. **Accessible** — WCAG 2.2 wants ≥3:1 contrast for non-text elements against adjacent colors; plus CVD safety.

Search-space size: a 24-bit display shows 16,777,216 colors, so a **3-color palette has ~4.7 sextillion possibilities**. At 1 evaluation per nanosecond, brute force takes >10,000 years.

## Why Simulated Annealing

The algorithm is a good fit when a problem has (a) an enormous solution space, (b) multiple competing success criteria, and (c) room for error ("I'm not designing a space suit").

Mechanics, by analogy to metallurgical annealing:

1. Start from an unoptimized state (a random palette).
2. Mutate randomly. Score old vs. new. While "hot," the choice between them is near a coin toss — the state is *allowed to get worse*.
3. "Cool" each iteration: progressively more likely to keep the better-scoring mutation.
4. Halt when random changes almost always score worse.

The point of accepting worse states early is escaping **local maxima**. Pure hill-climbing (always keep the better score) gets trapped in a state whose immediate neighbors are all worse, even when a far better solution exists elsewhere.

Provenance: the author got the idea from Brian Haidet's YouTube video [Algorithmic Redistricting: Elections made-to-order](https://www.youtube.com/watch?v=Lq-Y7crQo44) — same algorithm, applied to gerrymandering maps that had to be simultaneously unfair *and* normal-looking.

## Scoring Each Criterion

### Nice-looking — the honest cop-out

Rather than trying to objectively measure beauty against centuries of color theory, the score is **distance to a reference palette that a human already declared nice**. Minimize ΔE\* between the generated colors and the hand-picked target set.

This is what makes the algorithm **art-directable**: swap the reference palette (Stripe brand → an [Adobe Color](https://color.adobe.com/trends) trend palette) and you get a differently-flavored but still-optimized result.

### Color distance — CIEDE2000

Uses the CIE ΔE\*₀₀ formula, 0 (identical) to 100 (maximally different):

```
ΔE*₀₀ = √( (ΔL'/kL·SL)² + (ΔC'/kC·SC)² + (ΔH'/kH·SH)² + RT·(ΔC'/kC·SC)(ΔH'/kH·SH) )
```

The essay explains *why* naive RGB arithmetic fails: summing/subtracting channel values doesn't track perception — e.g. darker colors are easier to tell apart than lighter ones at the same numeric RGB delta.

### Broadly applicable — two ΔE\* statistics

- **Very different from one another** → maximize the *average* pairwise ΔE\*. More spread = usable across more categories.
- **Equally different from one another** → minimize the *range* of pairwise ΔE\*. Uneven spacing makes viewers see relationships in the data that aren't there (two near-identical greens imply the categories are related).

### Accessible — CVD simulation + the border trick

**The practical insight worth stealing:** finding three colors that all hold 3:1 against *each other* is extremely challenging; beyond three it's essentially impossible. Don't try. **Put a border around chart elements** and require 3:1 between each fill and the border color instead. One constraint per color instead of N².

For color blindness, colors are first transformed via the **Brettel–Viénot–Mollon (1997)** LMS matrix simulation, then the same average-ΔE\* separation is measured in the simulated space:

```
(L_Q, M_Q, S_Q)ᵀ = [[L_R L_G L_B],[M_R M_G M_B],[S_R S_G S_B]] · (R_Q, G_Q, B_Q)ᵀ
```

Separate scores for protanopia, deuteranopia, tritanopia, each with its own weight — so the tradeoff can be tuned to how common each type is.

Caveat the author states outright: WCAG contrast measures only relative brightness, one of several ways colors differ, and no simulation accurately represents how a person with CVD actually sees. CVD is not strictly categorical; degrees vary. Testing with real users is not replaceable.

## The Loss Function

All criteria collapse into one number, each with a tunable multiplier:

```
loss = a·nice
     + b·applicable
     + c·protanopia
     + d·deuteranopia
     + e·tritanopia
```

Lower is better. Raising `a` biases toward on-brand palettes even at some accessibility/versatility cost — the weights *are* the design decision, made explicit and auditable.

(Footnote worth keeping: the field says "loss"/"cost" rather than "gain"/"value" not out of pessimism but because minimizing gives a floor to work toward at zero; maximizing has no boundary.)

## Results

~16,000 palettes generated and evaluated in **about 3 seconds** on a 2016 MacBook.

| | Colors | Loss |
| --- | --- | --- |
| Random start | `#3ec240` `#65c590` `#ac2444` `#b9a263` `#ab088d` | 217.8 |
| Annealed | `#004ebd` `#00825d` `#7c0000` `#fe91fe` `#ff821f` | 136.3 |

~38% improvement. The random start clustered three colors in green ("which green bar?"); the optimized set spreads across hue *and* lightness. Under protanopia simulation the optimized palette mostly holds up, but orange and green converge — the algorithm is not perfect.

The loss-over-time chart shows the signature annealing shape: wild fluctuation while hot, converging to a stable plateau as it cools.

### Stress test vs. hand-made palettes

Scored with **just-noticeable difference (JND)** as implemented in [Viz Palette](https://projects.susielu.com/viz-palette) (Elijah Meeks & Susie Lu), which accounts for the fact that large areas of color are easier to distinguish than thin lines or small dots. Twelve-color palettes, count of JND issues (lower is better):

| Color vision | Adobe Spectrum | IBM Carbon | d3.category20 | Optimizer |
| --- | ---: | ---: | ---: | ---: |
| Normal | 2 | 1 | 4 | **0** |
| Protanopia | 6 | 9 | 13 | **3** |
| Deuteranopia | 6 | 11 | 12 | **4** |
| **Total** | 14 | 21 | 29 | **7** |

Caveat from the author's own footnote: for the 12-color runs he **dialed down the "nice-looking" weight**, trading aesthetics for function. It's the same tradeoff dial, not a free win.

## The Implementation

[github.com/ilikescience/category-colors](https://github.com/ilikescience/category-colors) — Node.js, MIT, two dependencies: **Culori** and **munkres-algorithm**. Notes below reflect commit `6208fdf` (2026-07-22); the code has grown well past what the 2022 essay describes.

```bash
npx categorycolors run                    # generate, --config/--state/--format/--output/--quiet
npx categorycolors report '#1f77b4' '#ff7f0e' '#2ca02c' --threshold 25 --cvd deuteranomaly:1
```

Verified run: 8 colors, default config → 14,405 iterations in ~4.7 s, cost 1.45 → 0.32.

### Default config

```js
evalFunctions: [
  { energy,     weight: 0.15 },
  { range,      weight: 0.15 },
  { jnd,        weight: 0.15 },
  { jnd,        weight: 0.15, cvd: { type: 'protanomaly',   severity: 0.5 } },
  { jnd,        weight: 0.5,  cvd: { type: 'deuteranomaly', severity: 0.5 } },
  { similarity, weight: 1 },
]
colorSpace: { mode: 'okhsl', ranges: [[0,360], [0.2,0.8], [0.3,0.9]] }
colorDistance: { method: 'ciede2000' }   // analysis space lab65
jnd: 20, colorCount: 8, coolingRate: 0.999, cutoff: 0.0001, maxIterations: 100000
similarityTarget: ['#F1781E','#D83F41','#8F4CB3','#215BEF','#009919']
```

Weights are normalized by their sum in `cost()`, so they are *relative*, not absolute — similarity at 1 is ~45% of the total; deuteranomaly gets 3× the weight of protanomaly (it's the more common deficiency); tritan is not scored by default. Mutation happens in **okhsl** while distance is measured in **lab65** — a deliberate split: perceptual-ish channel ranges to sample from, CIEDE2000 to judge with.

### The evaluators (`src/evaluators/`)

All share the signature `(state, config, descriptor) => cost`, take their parameters from the descriptor rather than global config, and normalize by pair/color count so weights stay comparable. That pattern is the reusable part — you can drop in your own scorer without touching the loop.

| Evaluator | What it costs | Shape |
| --- | --- | --- |
| `energy` | Colors too close together | Σ (1 − ΔE/ΔEmax)³ over ordered pairs — a repulsion potential, not the essay's "average ΔE" |
| `range` | Uneven spacing | σ/range of all pairwise ΔE (the essay's "equally different" criterion) |
| `jnd` | Any pair below the JND | Σ (jnd/ΔE)⁴; 1000 for identical colors. Wrap in `cvd:` to score it under simulated deficiency |
| `similarity` | Distance from the reference palette | **Munkres/Hungarian min-weight assignment** between palette and target, so pairing is optimal rather than index-order; unmatched colors cost 1 |
| `avoid` | Intruding on colors you want to steer clear of | Linear ramp 1→0 inside `radius` (default 0.15 × ΔEmax) around the nearest avoid color |
| `contrast` | WCAG shortfall against a background | (ratio/contrast)⁴ below target, (ratio/contrast)^0.5 above (a gentle pull to keep climbing); `checkAdjacent` adds a softer ² penalty between neighbors |
| `saliency` | Mean perceptual "attention-grabbingness" | Lookup into a bundled 8,325-entry table (lab65 quantized to steps of 5, saliency 0.009–0.917). Undocumented in the repo — no source cited. Note the sign: as a *cost* it drives the palette toward **less** salient colors |

`ΔEmax` is computed empirically per distance metric by measuring the largest pairwise distance among the 8 RGB primaries/secondaries — so normalization adapts when you switch to CMC, CIE76, etc.

### Core loop (`src/core/`)

- **`findInitialTemperature`** — samples 100 random mutations, then sets `T₀ = −avgΔ⁺ / ln(acceptanceRate)` for a target 95% acceptance of cost-increasing moves. Removes the main hand-tuned magic number; worth stealing for any annealer.
- **`getNeighbor`** — mutates *one* randomly chosen non-fixed color; step size is annealed too: `distance = min + (max − min)·T` (0.005→0.15 of each channel's span), so it explores coarsely while hot and refines while cold. Locked channels are excluded from the random vector rather than zeroed, so locking hue doesn't shrink the effective step.
- **`simulateCvd`** — Culori's `filterDeficiency{Prot,Deuter,Trit}`, i.e. **Machado, Oliveira & Fernandes (2009)** with continuous severity. This is a *change from the essay*, which described Brettel–Viénot–Mollon (1997). Machado models anomalous trichromacy (severity 0–1), not just dichromacy.
- **`optimizeColorOrder`** — a post-annealing pass the essay never mentions. Reorders the finished palette to minimize the **coefficient of variation of adjacent-pair ΔE** — i.e. even-sized perceptual steps along the sequence, *not* the shortest path. Exhaustive DFS up to 10 colors, pairwise-swap local search beyond; `fixedOrder` pins a color to its slot. Different objective from [colorsort-js](colorsort-js.md), which minimizes total path length.

### Pinning and locking

Colors can be given as `{ color: '#e74c3c', lockedChannels: [0], fixedColor, fixedOrder }`:

- `lockedChannels` — freeze channels by index in the working mode (okhsl: `0`=hue, `1`=saturation, `2`=lightness). Keep the brand hue, let saturation and lightness move to hit contrast.
- `fixedColor` — never mutated, and never coerced into the working space.
- `fixedOrder` — position is pinned during order optimization.

`colorCount` larger than the seed palette fills the remainder with random in-range colors, so partial seeding works.

### Reporting

`reports.reportJndIssues(palette, { distanceMethod, distanceSpace, jndThreshold, cvdSimulations })` lists every pair below threshold, per simulated deficiency — the same audit exposed as `categorycolors report`. Bundled comparison palettes in `src/data/palettes.js`: `observable10`, `d3category10`, `carbon`, `tableau10`, `tableau20`.

### Where the code has moved past the essay

The essay's loss function was similarity + applicability + three CVD terms scored on Brettel 1997. The shipped code replaces "applicable" with the `energy`/`range`/`jnd` trio, swaps in Machado 2009 for CVD, adds `contrast` / `avoid` / `saliency`, adds optimal-assignment similarity matching, channel locking, and a separate ordering pass. Read the essay for the reasoning, the repo for what to actually run.

## Why It Matters

- **Generate-and-score is a distinct third path** next to model-based construction and hand-curation. It handles criteria that have no closed-form solution and that conflict with each other — exactly the situation in categorical viz palettes.
- **The weights externalize the design judgment.** Instead of an unexplainable hand-picked palette, you get a set of numbers that says how much brand fidelity was traded for CVD separation.
- **Art direction survives automation.** Anchoring "nice" to a human-chosen reference set keeps taste in the loop without pretending to model it.
- **The border trick** is a genuinely reusable accessibility technique for charts, independent of the algorithm.

Honest limits the author flags: he's not a computer scientist, the annealing parameters likely aren't tuned well, and better optimizers surely exist. The result is deliberately "good enough," which is the thesis.

## Cited Sources

- Sharma, Wu & Dalal (2005). "The CIEDE2000 Color-Difference Formula: Implementation Notes, Supplementary Test Data, and Mathematical Observations." *Color Research & Application* 30(1): 21–30. [PDF](pdfs/sharma-2005-ciede2000-implementation-notes.pdf) (gitignored) · [source](https://hajim.rochester.edu/ece/sites/gsharma/ciede2000/)
- Brettel, Viénot & Mollon (1997). "Computerized simulation of color appearance for dichromats." *JOSA A* 14(10): 2647–2655. [PDF](pdfs/brettel-vienot-mollon-1997-dichromat-simulation.pdf) (gitignored) · [source](http://vision.psychol.cam.ac.uk/jdmollon/papers/Dichromatsimulation.pdf) — the essay's CVD model
- Machado, Oliveira & Fernandes (2009). "A Physiologically-based Model for Simulation of Color Vision Deficiency." *IEEE TVCG* 15(6): 1291–1298. [PDF](pdfs/machado-oliveira-fernandes-2009-cvd-simulation.pdf) (gitignored) · [source](https://www.inf.ufrgs.br/~oliveira/pubs_files/CVD_Simulation/CVD_Simulation.html) — what the code actually uses, via Culori's `filterDeficiency*`; models anomalous trichromacy with continuous severity, not just dichromacy
- Stone, Szafir & Setlur (2014). "An engineering model for color difference as a function of size." *Color and Imaging Conference*: 253–258. [PDF](pdfs/stone-szafir-setlur-2014-color-difference-size.pdf) (gitignored) · [source](https://research.tableau.com/sites/default/files/2014CIC_48_Stone_v3.pdf) — the basis for JND-at-size
- [jsColorblindSimulator](http://mapeper.github.io/jsColorblindSimulator/) — Brettel et al. in JS
- Prior art surveyed: [Viridis](http://bids.github.io/colormap/), [ColorBrewer](https://colorbrewer2.org/), [Colorgorical](http://vrl.cs.brown.edu/color), [Adobe Spectrum](https://spectrum.adobe.com/page/color-for-data-visualization), [IBM Carbon](https://carbondesignsystem.com/data-visualization/color-palettes/)

## Connection to Other References

- **[Wijffelaars — Intuitive Color Palettes](wijffelaars-intuitive-color-palettes.md)** — the opposite strategy for the same problem: construct palettes from a geometric model of the gamut rather than search for them. Wijffelaars guarantees ordering and in-gamut results by construction; annealing guarantees nothing but optimizes criteria a model can't express (brand similarity, CVD separation, avoidance).
- **[CuspHanger](cusphanger-gamut-triangle-palettes.md)** — Wijffelaars in OKLCH; `fromColor()` solves the "match a brand color" problem analytically where this essay solves it by search.
- **[Color Buddy](color-buddy-palette-lint.md)** — same criteria (WCAG, CVD, distinctness at size, ordering) expressed as *lint rules* over an existing palette rather than a loss function driving generation. Natural companion: anneal, then lint.
- **[Culori](culori-color-spaces-api.md)** — the library the implementation runs on.
- **[APCA / Myndex](apca-myndex-contrast.md)** — an alternative contrast metric to plug into the loss function; WCAG 2.x contrast is the weakest link in this scoring scheme.
- **[Choosing Colors with Confidence](choosing-colors-with-confidence.md)** — human-side counterpart to "equally different" spacing: the exercise there is *no equal chroma, no equal hue spacing*.
- **[colorsort-js](colorsort-js.md)** — ordering an optimized set is a separate problem, and the two tools optimize different things: `optimizeColorOrder` minimizes the *variation* in adjacent ΔE (even-sized steps), colorsort minimizes total path length (smoothest walk).
