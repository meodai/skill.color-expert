# A Perceptual Color Space in Minecraft (OKLAB)

**Source:** [Gneiss Name](https://www.youtube.com/@GneissName) (YouTube)
**Date:** 2024-01-23
**URL:** https://www.youtube.com/watch?v=nJlZT5AE9zY
**Duration:** 15:38
**Views:** 200,766

## Description

A geologist/Minecraft builder explains perceptual uniformity through practical demonstrations — why RGB gradients darken in the middle, why HSV brightness varies with hue, and how OKLAB solves both. Includes side-by-side Minecraft block palette comparisons in RGB vs OKLAB space.

## Key Topics

### RGB Problems Demonstrated

- **Gradients darken in the middle:** blue→red, red→green, green→magenta all dip in brightness mid-transition
- In RGB color space, midpoint colors arc away from the diagonal → non-linear perceptual distance
- **Gamma correction:** our eyes are more sensitive to dark colors; perceive 50% brightness at only 25% intensity; sRGB applies gamma to compensate
- Linear RGB (gamma removed) straightens gradients somewhat but doesn't fix everything

### HSV/HSB Problems

- Still just rearranged RGB, not a different space
- **Perceived brightness varies with hue** at constant saturation/brightness — blue is never as bright as yellow
- To maintain constant perceived brightness across hues, must vary saturation dramatically ("discarded rubber band" shape in RGB space)
- HSB color picker: changing shade from yellow to blue introduces purple tint — doesn't maintain hue

### What "Perceptually Uniform" Means

- **Just Noticeable Difference (JND):** the smallest color change your eyes can detect
- In a uniform space, the JND distance is the same regardless of starting color
- Demo: green needs ~10 units of change to notice; black needs only ~1 unit — in RGB these plot as vastly different distances; in a uniform space they'd be equal

### OKLAB Conversion Pipeline

1. sRGB → remove gamma → **Linear RGB**
2. Linear RGB → **CIE XYZ** (1930s, contains all visible colors)
3. XYZ → **LMS** (approximate human cone response: Long, Medium, Short)
4. LMS → reapply perceptual gamma → **straighten and tweak** → **OKLAB**

- **L** = lightness (black → white)
- **a** = magenta ↔ green axis
- **b** = blue ↔ yellow axis

### OKLAB in Practice (Minecraft)

- All Minecraft blocks plotted in OKLAB space → fit in a nice shape around their average colors
- **RGB gradient vs OKLAB gradient (same endpoints):**
  - Red→Green: RGB path curves, darkens in middle; OKLAB path is nearly straight
  - Blue→Sandstone: RGB arcs through darker colors; OKLAB is more direct
- "I'm genuinely shocked... this actually really changed my opinion. It's probably going to be my go-to space."
- OKLAB could also identify **missing colors in Minecraft** scientifically — gaps in the block palette

### Texture Noise

- A block's average color may be right for a gradient, but high-contrast texture noise (like melon) makes it unusable in practice — a separate consideration from color space

## Links

- **OKLAB (Björn Ottosson):** https://bottosson.github.io/posts/oklab/
- **Moulberry CIELAB in Minecraft (Axian mod):** https://youtu.be/o-JL0AEL0rc
- **World download:** linked in description

## Key Takeaways for the Skill

- Best practical explanation of **why RGB gradients fail** (darkening, hue shifts)
- Clear **OKLAB conversion pipeline:** sRGB → linear → XYZ → LMS → OKLAB
- "There is no perfect color space — only those better for the specific task"
- OKLAB axes: L (lightness), a (magenta↔green), b (blue↔yellow) — opponent process encoding
- Even with limited palettes (216 Minecraft blocks), OKLAB produces visibly better gradients than RGB
