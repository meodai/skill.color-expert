# Color Collapse — Tone Mapping Explorer

By **Dustin Brown** (speckofdustin.com, UX Design Director, Microsoft AI Incubation). Personal project, captured 2026-10-21.

- Tool: https://colorcollapse.speckofdustin.com/
- Model sources & attribution: https://colorcollapse.speckofdustin.com/color-collapse-notices.html
- Companion explainer (module 6 of the Color Flow course): https://colorflow.speckofdustin.com/

Follows a family of equally bright, equally colorful colors through one tone mapper while exposure climbs from −6 to +8 EV, and plots where each one goes in OKLCH. The question it answers: **when a saturated color gets brighter than the display can show, which way does its hue go, and how fast does its chroma die?**

---

## The core fact: per-channel clipping skews hue toward six attractors

A saturated color is a *ratio* between its RGB channels. Clip each channel at 1 and, once the brightest one pins while the others keep rising, that ratio changes, so the hue changes. Bright orange: red pins, green keeps climbing, so it slides toward yellow.

Primaries and secondaries have channels that clip together (or not at all), so they **hold** their hue; every hue between them migrates toward the nearest one. Across the wheel, hues bunch into six attractors (R, Y, G, C, B, M): the **"notorious six"**, the look of blown-out highlights in renders and phone photos.

- **Clip, per-channel Reinhard, and the common Narkowicz "ACES fitted" curve** soften the shoulder but skew the same way, because they still act channel by channel.
- **AgX** compresses in a slightly desaturated, log-encoded space, so highlights lose chroma on the way to white instead of one channel slamming the ceiling. Skew is much smaller, but vivid highlights wash out to white sooner. *(The Color Flow text says AgX "preserves" hue. The plots show it reduces drift, not removes it. Check the Unwrapped view rather than assuming zero.)*
- **ACES 2.0** was designed partly to tame the six-hue skew. **Blender** switched its default view transform from Filmic to AgX for the same reason.

**When the skew is wanted vs. a defect** (from the explainer):
- Film / stylized renders: warm highlights rolling to yellow-white is part of what reads as "cinematic". Filmic mappers lean into it.
- Brand / product work: a brand red turning orange in a specular highlight is wrong. Use a hue-preserving mapper, or composite the brand color back in after the tone map.
- 3D pitfall: an emissive or albedo color that looks right at rest shifts hue as soon as it catches a bright light. The material didn't change, the exposure did.

---

## Method worth copying: a "fair" input family

Inputs start at the **same OKLab L and the same OKLCH C** for every hue (12/24/36 samples). The shared chroma is the largest one that fits *every* hue in the chosen gamut (sRGB or Display P3). Exposure multiplies **decoded linear-light RGB** by `2^EV`, never the gamma-encoded values.

Pipeline: `sRGB decode → ×2^EV → mapper → channel clamp → sRGB encode → OKLab/OKLCH`.

That makes any difference between hues the mapper's doing, not the input's. The same trick works for testing any color operation: equalize L and C first, then look at what the operation does to each hue.

Measurement conventions:
- Hue counts as undefined when input **or** output OKLCH C < **0.01** (dashed curve holds its last position).
- "Of input chroma" is a ratio of OKLCH C. It can be over 100% and is **not** a saturation percentage.
- Deltas (ΔL, ΔC, Δh) compare against the original input, not against the mapped 0 EV result. Some mappers already shift hue at 0 EV.

---

## Views

| View        | Axes                                                                                       | Reveals                                                                 |
| ----------- | ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------- |
| Exposure 3D | height = EV, angle = output hue, radius = OKLCH C; dashed input ring at 0 EV                | Chroma collapse toward the axis as exposure rises                        |
| Lightness 3D| height = output OKLab L, inside the sampled sRGB/P3 gamut shell                             | Paths hitting the shell and sliding up it toward white                   |
| Top / slice | rotated/reflected OKLCH (warm upper left, hue clockwise), grading-style, **not** a YCbCr vectorscope | Where each hue lands at a given EV                                   |
| Unwrapped   | x = continuous output hue, y = EV; stroke width = output C / input C                       | Sideways bends = hue shift; convergence on the six attractors           |

Extras: a film LUT loader (3D `.cube`, DaVinci Wide Gamut / Intermediate in, Rec.709 gamma 2.4 out, tetrahedral interpolation, exposure applied in scene-linear before the input conversion), PNG export, and JSON/CSS export with model versions.

---

## The mappers, as implemented

All operate on nonnegative scene-linear Rec.709 (or P3-D65 where noted), D65.

```js
// Clip: per-channel clamp
out = clamp01(x)

// Reinhard, per channel (simple form, no white point or scene key)
out = x / (1 + x)

// Narkowicz 2016 "ACES filmic" fit, per channel (NOT real ACES)
out = (x * (2.51*x + 0.03)) / (x * (2.43*x + 0.59) + 0.14)

// AgX minimal (Benjamin Wrensch, values from Troy Sobotka's AgX), default look
v   = inset · rgb                         // near-identity 3×3 that pulls toward neutral
l   = clamp01((log2(v) + 12.47393) / 16.499999)
p   = 15.5l⁶ − 40.14l⁵ + 31.96l⁴ − 6.868l³ + 0.4298l² + 0.1191l − 0.00232
out = max(0, outset · p) ^ 2.2            // guard the fit's negative toe before the power

// Khronos PBR Neutral (Apache-2.0, KhronosGroup/ToneMapping)
start = 0.76; desat = 0.15
x = min(r,g,b); offset = x < 0.08 ? x − 6.25x² : 0.04
c = rgb − offset; peak = max(c)
if peak < start: return c                 // linear below the shoulder: base colors stay exact
d = 1 − start; newPeak = 1 − d² / (peak + d − start)
c *= newPeak / peak
g = 1 − 1 / (desat * (peak − newPeak) + 1)
return mix(c, newPeak, g)                 // desaturate toward the compressed peak
```

AgX matrices (rows): inset `[[.8425,.0784,.0792],[.0423,.8785,.0792],[.0424,.0784,.8791]]`, outset `[[1.1969,−.0980,−.0990],[−.0529,1.1519,−.0990],[−.0530,−.0980,1.1511]]`. The notices page points out that an earlier version of the tool had two blue-column inset coefficients transcribed wrong. If you port AgX, copy the constants from the source, not from someone's port.

**Khronos Neutral is the one to know for product/e-commerce 3D.** It's an exact identity below about 0.76, so base colors render as authored. It compresses only the peak channel's overshoot and desaturates only in proportion to how much it compressed. It has a different goal from filmic mappers, which reshape the whole range.

**Real ACES and OpenDRT** in the tool: ACES 1 (SDR Video, ACES 1.3 OCIO config) and ACES 2 (SDR 100 nits, ACES 2.0 config) are baked from OpenColorIO 2.5.2 into 65³ LUTs with a log shaper and tetrahedral lookup. OpenDRT v1.1.0 (Jed Smith, GPL-3.0) is a direct port of the Standard look at 100 nits, 10-nit grey, D65 white, bright surround, hue and purity modules included. All of them are labeled approximations, not claims of bit-exact reference rendering.

---

## Takeaways for the skill

1. **"Brighter" is not a hue-safe operation.** Any per-channel curve applied in RGB (clip, Reinhard, Narkowicz fit, also CSS `filter: brightness()` past 1, or additive glow) skews hues toward R/Y/G/C/B/M. This is the HDR/tone-mapping version of "reduce chroma, don't clip RGB" from gamut mapping.
2. **The "ACES curve" in most shader code is Narkowicz's one-line per-channel fit, not ACES.** It inherits the six-hue skew that ACES 2.0 was built to fix.
3. **Pick by intent:** filmic skew for mood, AgX / ACES 2 / OpenDRT for hue stability with highlight desaturation, Khronos PBR Neutral when authored base colors must survive untouched.
4. **Test color operations on an equal-L, equal-C hue family** and plot the result in OKLCH. Uneven inputs hide uneven operations.

## Links

- Color Collapse: https://colorcollapse.speckofdustin.com/
- Model notices / licenses: https://colorcollapse.speckofdustin.com/color-collapse-notices.html
- Color Flow / Color Exploration course (Value vs Luminance, Magenta, Saturation across models, Color Flow Designer, Why color spaces exist, Collapse): https://colorflow.speckofdustin.com/
- Color Weight, five-color palettes built on a lightness hierarchy (one accent and four supports, gap/range in OKLab L, contrast targets): https://colorweight.speckofdustin.com/
- Dustin Brown's experiments index: https://experiments.speckofdustin.com/
- Krzysztof Narkowicz, ACES Filmic Tone Mapping Curve (2016): https://knarkowicz.wordpress.com/2016/01/06/aces-filmic-tone-mapping-curve/
- Benjamin Wrensch, Minimal AgX Implementation: https://iolite-engine.com/blog_posts/minimal_agx_implementation
- Troy Sobotka, AgX: https://github.com/sobotka/AgX
- Khronos PBR Neutral: https://github.com/KhronosGroup/ToneMapping
- OpenDRT (Jed Smith): https://github.com/jedypod/open-display-transform
- OpenColorIO ACES configs: https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES
