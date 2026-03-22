# Björn Ottosson — OKLAB, OKHSV, OKHSL & Color Science Articles

**Source:** https://bottosson.github.io/posts/
**Author:** Björn Ottosson
**License:** MIT (all code)

The foundational articles behind OKLAB — the color space recommended throughout this collection.

---

## 1. A Perceptual Color Space for Image Processing (OKLAB)

**URL:** https://bottosson.github.io/posts/oklab/

### What It Is

Perceptual color space: **L** (lightness), **a** (green↔red), **b** (blue↔yellow). Polar form: L, C (chroma), h (hue) = OKLCH.

### Why It Was Created

CIELAB, CIECAM02-UCS, and IPT all have significant limitations. Goal: "simple to use, while doing a good job at predicting perceived lightness, chroma and hue."

### Design Goals

1. Opponent color space (like CIELAB)
2. Predict lightness, chroma, hue with orthogonal coordinates
3. Produce even color transitions when blending
4. D65 whitepoint
5. Numerically stable and differentiable
6. Scale invariant for dynamic range

### Math

XYZ → matrix M₁ → approximate cone responses (LMS) → cubic root → matrix M₂ → Lab. Two matrices + one nonlinearity = extremely efficient.

### Key Result

Outperforms CIELAB on lightness AND chroma AND hue prediction. CIELAB's biggest failure: blue hue prediction. OKLAB fixes this.

---

## 2. How Software Gets Color Wrong

**URL:** https://bottosson.github.io/posts/colorwrong/

### The Problem

Most software blends/processes in sRGB — designed for 1990s CRTs, not color math. Results: colors become "much darker and bluer" when blending saturated opposing hues.

### Why

sRGB's nonlinear transfer function exists because CRTs had nonlinear voltage→brightness. It accidentally correlates with perception but fundamentally misrepresents color for computation.

### Failures

- Blending white+green → shifts hue
- HSL/HSV color pickers exhibit same problems (they just remap sRGB)
- Operations determined by display technology, not color science

### Fix

- **Minimum:** linearize sRGB before processing, reapply gamma after
- **Better:** use perceptual spaces (OKLAB) for human-centered operations
- **Principle:** "Color operations should be done with the use case in mind"

---

## 3. Okhsv and Okhsl — Color Picker Spaces

**URL:** https://bottosson.github.io/posts/colorpicker/

### Problem

HSV/HSL are ubiquitous but perceptually wrong. HSLuv improves lightness but has chroma jumps and hue distortions (Abney effect in blues).

### 8 Desirable Properties for Color Pickers

1. Orthogonal lightness
2. Orthogonal chroma
3. Orthogonal saturation
4. Orthogonal hue
5. Simple cylindrical geometry
6. Max chroma at edge
7. Varies smoothly
8. Varies evenly

These properties CONFLICT — can't have all simultaneously.

### Okhsv Design

- Follows HSV's triangular structure in OKLCH
- Finds gamut cusp (most saturated point) per hue
- Remaps triangle to square with toe compensation
- Result: improved hue perception, max chroma at s=1/v=1

### Okhsl Design (the innovation)

Three-point chroma interpolation instead of HSLuv's single max:

- **C₀(l):** hue-independent baseline → smooth at s=0
- **C_mid(h,l):** optimized intermediate → smoother than C_max
- **C_max(h,l):** absolute maximum chroma for this hue/lightness
- Interpolation: s=0→C₀, s=0.8→C_mid, s=1.0→C_max
- **Result:** gamut unevenness confined to high-saturation edges; smooth interior

### Comparison

| Property             | Okhsv   | Okhsl   | HSV     | HSL     | HSLuv   |
| -------------------- | ------- | ------- | ------- | ------- | ------- |
| Orthogonal Lightness | No      | **Yes** | No      | No      | Yes     |
| Orthogonal Hue       | **Yes** | **Yes** | Partial | Partial | Partial |
| Simple Geometry      | **Yes** | **Yes** | Yes     | Yes     | Yes     |
| Varies Smoothly      | **Yes** | **Yes** | Yes     | Yes     | **No**  |

---

## 4. Gamut Clipping in OKLAB

**URL:** https://bottosson.github.io/posts/gamutclipping/

### Problem

Colors frequently exceed sRGB [0,1]. Simple clamping distorts hues and kills detail.

### Insight

sRGB gamut in OKLAB is always close to a triangle per hue slice, with corners at (L=0,C=0) and (L=1,C=0). The third point (cusp) = most saturated color at that hue.

### 5 Methods Compared

1. **Chroma compression** — keep L constant, reduce C (preserves brightness)
2. **Project to (0.5, 0)** — toward middle grey (hue-independent)
3. **Project to cusp L** — hue-dependent projection target
4. **Adaptive L₀=0.5** — blend chroma compression + projection, α parameter
5. **Adaptive L₀=Lcusp** — same with hue-dependent target

### Recommendation

**Adaptive L₀ with α=0.05** — good default. L₀=0.5 variant slightly more efficient, visually equivalent at low α.

---

## Links

- **OKLAB:** https://bottosson.github.io/posts/oklab/
- **Color Wrong:** https://bottosson.github.io/posts/colorwrong/
- **Color Picker (OKHSV/OKHSL):** https://bottosson.github.io/posts/colorpicker/
- **Gamut Clipping:** https://bottosson.github.io/posts/gamutclipping/
- **Interactive picker demo:** https://ok-color-picker.netlify.app/
