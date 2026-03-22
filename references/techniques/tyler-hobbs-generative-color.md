# Working with Color in Generative Art — Tyler Hobbs

**Source:** https://www.tylerxhobbs.com/words/working-with-color-in-generative-art
**Author:** Tyler Hobbs
**Date:** 2016-10-23

## Overview

Practical techniques for color in generative art/creative coding. Not theory — hands-on methods with code examples (Clojure/Processing). Foundation techniques that compose together.

## Key Techniques

### 1. Use HSB, Not RGB

> "RGB is for machines, HSB is for artists."

HSB lets you independently control hue, saturation, and brightness — essential for maintaining consistent mood while varying color.

```clojure
(color-mode :hsb 360 100 100 1.0)
;; Hue [0,360], Sat [0,100], Brightness [0,100], Alpha [0,1]
```

### 2. Randomize Components Selectively

Add organic variation by randomizing individual HSB components:

```clojure
(fill (random 150 155) 40 70)
;; Slight hue variation, consistent saturation + brightness
```

Small random offsets on hue prevent the "too perfect" look of algorithmic color.

### 3. Gradients Mapped to Variables

Map color components to spatial/temporal variables (position, distance, iteration):

```clojure
;; Green-to-blue gradient along y-axis
(let [hue (rescale y 0 1000 130 220)]
  (fill hue 90 90))
```

Add randomness to gradient inputs to avoid harsh linearity:

```clojure
(let [hue (rescale (random y (+ y 100)) 0 1000 130 220)]
  ...)
```

Gradients don't have to be linear — quadratic, logarithmic, eased.

### 4. Probability Distributions for Palettes

Define palettes as weighted random choices:

```clojure
(weighted-choice
  [0 0 100] 0.70      ;; white, 70%
  [220 50 50] 0.20    ;; blue, 20%
  [0 80 80] 0.10)     ;; red, 10%
```

**Key insight:** the RATIOS matter more than the individual colors. 70% white with 20% blue and 10% red creates a completely different feel than equal thirds.

### 5. Combine Gradients with Probability Shifts

The most powerful technique — **gradient the probabilities themselves:**

```clojure
;; Blue probability decreases downward, red increases
(let [blue-odds (rescale y 0 1000 0.30 0.0)
      red-odds (- 0.30 blue-odds)]
  (weighted-choice
    [0 0 100] 0.70
    [220 50 50] blue-odds
    [0 80 80] red-odds))
```

Result: smooth transition from blue-accent to red-accent across the piece without explicit gradient — the color _distribution_ shifts, not the colors themselves.

### 6. Context-Dependent Palette Switching

Different conditions trigger different probability distributions:

```clojure
(if (< radius 50)
  warm-palette   ;; yellow accent
  cool-palette)  ;; blue/green accent
```

## Composability

These techniques stack:

- HSB → selective randomization → gradient mapping → probability distributions → gradient probabilities
- Each layer adds sophistication without complexity

## Why This Matters for the Skill

- **Probability-weighted palettes** is the most underrated technique — almost no design tools support it
- **Gradient the probabilities** rather than the colors = much more naturalistic results
- All of this works in any language/framework, not just Processing
- Connects to RampenSau's approach (hue cycling + easing = parametric palette generation)

## Links

- **This article:** https://www.tylerxhobbs.com/words/working-with-color-in-generative-art
- **Follow-up (2021):** "Color Arrangement in Generative Art" (more comprehensive)
- **Related:** "Probability Distributions for Algorithmic Artists"
