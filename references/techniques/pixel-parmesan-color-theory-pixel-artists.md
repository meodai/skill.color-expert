# Color Theory for Pixel Artists: It's All Relative

**Author:** Lux
**Source:** Pixel Parmesan
**Date:** 2020-11-09
**URL:** https://pixelparmesan.com/blog/color-theory-for-pixel-artists-its-all-relative

## Core Thesis

Lux's main argument is that pixel art does not need a separate, magical color theory. The same fundamentals still apply:

- color depends on light
- color is relative to surrounding colors
- palette choices should be judged in context, not by isolated rules

The medium changes how color is applied, especially because pixels do not blend smoothly, but it does not change the underlying logic of color.

## Key Ideas

### Color Is Relative

The article emphasizes **chromatic adaptation** and **color constancy**: the same absolute sampled color can read very differently depending on lighting and neighboring colors. That is why symbolic shortcuts like "sky = blue" or "grass = green" are weak guides.

Lux distinguishes between:

- **local color** - the inferred color of the object itself
- **absolute color** - the literal sampled color in the image
- **relative color** - the color as perceived in context

This is a strong practical framing for sprite work, where the same sampled hue can plausibly stand in for different local colors under different lighting setups.

### The Traditional Wheel Is Not Enough

The article argues that the standard RYB wheel is a poor guide for pixel-art palette construction because:

- its spacing does not reflect the real distribution of hues
- its primaries are historically contingent rather than universally correct
- it only describes **relative family relationships**, not which absolute colors to pick

Lux instead recommends a broader **YRMBCG / "yurmby"** wheel and treats gamut selection as more useful than formulaic harmony schemes. The key idea is to choose a constrained range of colors that share common chromatic ingredients rather than chasing abstract complement pairs.

### Greys and Subjective Neutrals Matter

The article points out that neutral-looking colors often work as **relative complements** of surrounding hues. An absolute grey can read blue next to orange or orange next to blue. This explains why greys are useful in ramps as neutralizers and interpolators.

Lux also describes the **subjective neutral** at the center of a chosen gamut: the color that reads most neutral within the palette context, even if it is not objectively grey.

### Hue-Shifting Is an Incomplete Explanation

Lux pushes back against simplistic pixel-art advice about "hue-shifting." Hue changes are real, but they are not a standalone trick. They result from lighting, material response, bounce light, and color relativity.

Important corrections:

- shadow does not always mean lower saturation
- highlights are not always the most saturated areas
- midtones often carry the strongest saturation
- hue, saturation, and perceived value all interact

This lines up with broader color-science ideas in the skill: the appearance of color shifts as part of a larger lighting and perception system, not as a simple warm-lights cool-shadows recipe.

### Pixel Art Compresses Modeling Factors

Because pixel art cannot easily show smooth value gradations, artists often have to compress multiple modeling factors into a few tones. Lux argues that palette choices should therefore be made with imagined lighting in mind, not built as context-free ramps first.

That means the chosen shades need to preserve believable:

- local color
- relative value structure
- lighting mood
- material separation

### Predefined Palettes Are Overrated

Lux is skeptical of building fixed palettes before knowing what the image actually needs. The article favors:

- sampling from related work or references
- building colors as the piece develops
- adjusting ramps in context
- experimenting instead of following formulas

The comparison is good: prebuilding ramps before knowing the piece is like buying ingredients before deciding what recipe you are making.

## Why This Matters for the Skill

- One of the better practical explanations of **color relativity for pixel art**
- Useful corrective to beginner advice that over-focuses on hue-shifting as a trick
- Strong link between studio pragmatism and formal color ideas like local color, luminance, gamut masking, and subjective neutrals
- Supports the repo's broader stance that **good palettes come from constraints, context, and intent**, not from wheel formulas alone

## Practical Takeaways

- Choose colors in context, not in isolation.
- Treat hue-shifting as a consequence of lighting and perception, not as a recipe.
- Use limited gamuts to build cohesion.
- Let greys and near-neutrals do structural work in ramps.
- Build palettes around the needs of the piece instead of worshipping predefined swatch sets.
