# Piter Pasma — Tweaked Rainbow Palette Formula

**Source:** @piterpasma (Twitter/X, Jan 19 2024)
**Shadertoy:** https://shadertoy.com/view/lcf3Rr
**Used in:** Blokkendoos (generative art project)

## What It Does

A single GLSL function that generates a perceptually tweaked rainbow palette. Starts from a standard HSV-like sinewave rainbow and modifies it to reduce greens and improve overall tonal consistency — similar philosophy to Harvey Rayner's Fontana approach but in a compact shader formula.

## The Formula

```glsl
vec3 colrf(float v) {
  v *= TAU;
  vec3 C = .75 + .45 * sin(v + .5 * sin(v + 5.3) + vec3(-1, 0, 1.2));
  C = smoothstep(0., 1., C - .4 * min3(C) - .2 * C.gbr) * .9 + .02;
  return C;
}
```

## How It Works (step by step)

### Step 1: Warped Sine Rainbow

```glsl
vec3 C = .75 + .45 * sin(v + .5 * sin(v + 5.3) + vec3(-1, 0, 1.2));
```

- Base: three sine waves offset by `vec3(-1, 0, 1.2)` — creates R, G, B phase-shifted oscillations (like IQ's cosine formula)
- **The inner `sin(v + 5.3)`** warps the input — creates non-uniform hue spacing. This is what reduces the green band and compresses certain hue regions
- `.75 + .45 *` centers the output and controls amplitude

### Step 2: Tonal Balancing

```glsl
C = smoothstep(0., 1., C - .4 * min3(C) - .2 * C.gbr) * .9 + .02;
```

- `min3(C)` = minimum of R, G, B — subtracting `.4 * min3(C)` removes the "whiteness" (shared component across channels), increasing saturation
- `- .2 * C.gbr` — subtracts a rotated version of the color from itself. This cross-channel suppression further reduces muddiness and increases contrast between channels
- `smoothstep(0., 1., ...)` — soft clamps, preventing harsh clip artifacts
- `* .9 + .02` — keeps values away from pure black and pure white (0.02 floor, 0.92 ceiling)

## Connection to Fontana / Harvey Rayner

Pasma: "I used a very similar method as Harvey's for the colour palette for Blokkendoos. I started with a standard HSV-like (sinewave based) rainbow and tweaked the formula until it had less greens and more overall consistency."

Both approaches:

1. Start with a full spectrum
2. Kill/reduce greens (and often purples)
3. Aim for tonal consistency
4. Arrive at warm, earthy, vintage-feeling palettes

Difference: Rayner's is a multi-step pipeline with separate concerns; Pasma's is a single compact formula.

## Comparison with IQ Cosine Formula

|                       | IQ Cosine                              | Pasma Tweaked Rainbow                   |
| --------------------- | -------------------------------------- | --------------------------------------- |
| **Function**          | `a + b * cos(2π(ct + d))`              | Warped sine + cross-channel suppression |
| **Parameters**        | 4 × vec3 (12 floats)                   | Constants baked into formula            |
| **Hue distribution**  | Uniform (unless c differs per channel) | Non-uniform (inner sine warps spacing)  |
| **Tonal balance**     | Not addressed                          | Built-in via min3 subtraction           |
| **Green suppression** | Manual via parameter tuning            | Built-in via warp + cross-suppression   |
| **Flexibility**       | Highly parameterizable                 | Fixed character, single formula         |

## Key Techniques Worth Extracting

1. **Inner sine warp** `sin(v + .5*sin(v + offset))` — non-uniform hue spacing without lookup tables
2. **`min3(C)` subtraction** — removes shared whiteness = instant saturation boost
3. **Cross-channel subtraction** `C.gbr` — rotating and subtracting channels from each other increases color purity
4. **Floor/ceiling** via `* .9 + .02` — avoids pure black/white without clamping

## Links

- **Shadertoy:** https://shadertoy.com/view/lcf3Rr
- **Blokkendoos:** Piter Pasma's generative art project
- **Related:** [Fontana approach](fontana-generative-color-approach.md), [IQ Cosine Formula](iq-cosine-palette-formula.md)
