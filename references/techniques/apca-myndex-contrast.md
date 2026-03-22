# APCA & Myndex — Advanced Perceptual Contrast

**Source:** [GitHub — Myndex/SAPC-APCA](https://github.com/Myndex/SAPC-APCA)
**Author:** Andrew Somers (Myndex)
**npm:** `apca-w3`
**Calculator:** https://www.myndex.com/APCA/

## What APCA Is

**Accessible Perceptual Contrast Algorithm** — the replacement for WCAG 2.x contrast ratios, designed for WCAG 3. Based on decades of peer-reviewed vision science rather than simple luminance ratios.

## How APCA Differs from WCAG 2.x

|               | WCAG 2.x                                                                                             | APCA                                                                                |
| ------------- | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Metric**    | Simple luminance ratio (4.5:1, 3:1, 7:1)                                                             | Perceptually uniform contrast value (Lc 0–108)                                      |
| **Polarity**  | Symmetric (text-on-bg = bg-on-text)                                                                  | **Polarity-sensitive** (light-on-dark ≠ dark-on-light)                              |
| **Font size** | Binary (normal vs large text)                                                                        | **Spatial frequency aware** — contrast needs vary by font size, weight, and spacing |
| **Science**   | 1990s luminance math                                                                                 | Modern vision science with standard observer model                                  |
| **Problem**   | "Please Stop Using Grey Text" — WCAG 2 passes colors that are unreadable, fails colors that are fine | Predicts actual readability                                                         |

## Key Concepts

### Polarity Sensitivity

Light text on dark backgrounds needs MORE contrast than dark text on light backgrounds at the same sizes. WCAG 2.x treats them identically — APCA doesn't.

### Spatial Frequency

Small, thin, or complex letterforms need more contrast than large bold text. APCA provides **font size/weight lookup tables** rather than a single threshold.

### Levels

- **Bronze Simple Mode** — most basic, for WCAG 2 migration
- **Silver / Gold** — enhanced accessibility tiers

## Myndex Tools & Libraries

### Code

| Package           | Purpose                                             |
| ----------------- | --------------------------------------------------- |
| **apca-w3**       | Official APCA for web content (`npm i apca-w3`)     |
| **Bridge-PCA**    | WCAG 2 backwards-compatible version using APCA tech |
| **DeltaPhiStar**  | Simplified general-purpose contrast using L\*       |
| **Color Parsley** | Fast color string parsing                           |
| **SeeStars**      | Micro-library for L\* calculations                  |
| **Max Contrast**  | Simple APCA-compatible text color flipper           |

### Web Tools

- **APCA Demonstrator** — interactive demo with design guidance
- **Bridge-PCA Calculator** — WCAG 2 compatible tool
- **CVD Simulator** — clinically accurate color vision deficiency models

### Key Articles

- **"The Realities And Myths Of Contrast And Color"** (Smashing Magazine)
- **"Please Stop Using Grey Text"** — contrast myth debunking
- **"A Contrast of Errors"** — historical review of WCAG 2 problems
- **"Better reading on the web"** (UX Collective)

## APCA Contrast Thresholds (Bronze Level)

| Lc Value  | Meaning                     | Use Case                                       |
| --------- | --------------------------- | ---------------------------------------------- |
| **Lc 15** | Invisibility threshold      | Some users can't perceive contrast below this  |
| **Lc 30** | Minimum for non-fluent text | Sub-fluent, spot reading, icons                |
| **Lc 45** | Large text minimum          | Fluent text >36px                              |
| **Lc 60** | Medium text minimum         | Fluent text >24px                              |
| **Lc 75** | Body text minimum           | Text >18px, the standard readability threshold |
| **Lc 90** | Preferred body text         | Best readability for sustained reading         |

Output range: **-108 to +106** (negative = light text on dark bg, positive = dark text on light bg). Absolute value is the contrast magnitude.

## Algorithm Steps (simplified)

1. **Linearize RGB** — gamma decode with exponent 2.4 (not sRGB's piecewise function)
2. **Compute luminance** — weighted sum: `Y = 0.2126729·R + 0.7151522·G + 0.0721750·B`
3. **Soft black clamp** — values below 0.022 get clamped (prevents math issues near black)
4. **Polarity-dependent exponents** — light-on-dark uses different exponents (0.56/0.57) than dark-on-light (0.65/0.62)
5. **Apply multiplier + offset** — ×1.14, then subtract 0.027
6. **Dead zone** — values with absolute < 0.1 clamp to 0 (below perception threshold)
7. **Scale to Lc** — multiply by 100

## WCAG 2 Backwards Compatibility (Bridge-PCA)

| Bridge-PCA Lc | Equivalent WCAG 2       |
| ------------- | ----------------------- |
| Lc 58         | ~3:1 (large text AA)    |
| Lc 72         | ~4.5:1 (normal text AA) |
| Lc 85         | ~7:1 (AAA)              |

Send lightest color as "background" input for backwards compatibility. Critical for dark mode — "WCAG 2 contrast fails most with dark colors."

## The Numbers (from our research)

Of ~281T hex pairs:

- WCAG 4.5:1 → 11.98% pass
- APCA 60 → 7.33% pass (more restrictive)
- APCA 90 → **0.08%** pass (150× more constrained than WCAG AA)

APCA is stricter because it's more accurate — it rejects pairs WCAG passes that are actually unreadable, and the spatial frequency awareness means body text needs higher contrast than headings.

## Links

- **APCA Calculator:** https://www.myndex.com/APCA/
- **GitHub (SAPC-APCA):** https://github.com/Myndex/SAPC-APCA
- **npm:** `npm i apca-w3`
- **Bridge-PCA:** https://github.com/Myndex/bridge-pca
- **apcach (contrast-first colors):** https://github.com/antiflasher/apcach
- **APCA Readability Criterion (draft):** linked from repo
- **APCA Introduction:** https://github.com/Myndex/apca-introduction
