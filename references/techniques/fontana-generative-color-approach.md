# The Fontana Approach to Fully Generative Color

**Source:** https://medium.com/@harvey.rayner/the-fontana-approach-to-fully-generative-color
**Author:** Harvey Rayner (aka patterndotco)
**Date:** 2022-08-21

## Why This Matters

One of the few deep, honest explorations of **fully generative color** in longform generative art. Most generative art projects use preset palettes — Rayner argues for generating color algorithmically as an authentic extension of the genre, and documents his 6-step approach.

## Why Generative Color Is Rare

> "Compared to the Cambrian explosion in new generative approaches to marks, forms, textures and compositions, projects exploring generative color have been relatively scarce."

Rayner's reasons:

1. **Color feels untamable** — too closely tied to emotions and intangible aesthetics for logic/math
2. **It feels wrong** — some artists resist systematizing something so personal
3. **Temptation to oversimplify** — color looks simple on the surface, so people reach for reductionist color theory
4. **Nobody else is doing it** — artists look at what others do; if generative color is rare, it stays rare
5. **Color and form are inseparable** — false to treat them as separate algorithms

> "I personally don't feel generative color that surprises and has expressive depth is going to come from a simple color theory."

## The 6-Step Algorithm

### Step 1: Tonally Balanced Spectrum

- Modify the standard spectrum so all hues produce the **same mid-grey** when desaturated
- Without this, blue is much darker than yellow → creates "tonal lumps" in hue gradients
- Similar to what `harveyHue()` in RampenSau does

### Step 2: Kill Green and Purple

- Remove fully saturated greens entirely
- Suppress saturated purples/ultramarine
- **Not color theory — artistic decision** for this project's warm, earth-tone, 19th-century aesthetic
- Blues/purples look "sickly and rinsed-out" in the tonally balanced model
- Greens and purples were less color-fast in historical dyes (his guess)

### Step 3: Antique Lights and Darks

- **Lights → shift toward yellow** — mimics aged/yellowed media (vintage feel)
- **Darks → shift toward blue or red** — depends on dominant hue:
  - Warm dominant → blue darks
  - Cool dominant → red darks
- Keeps the color space in complementary balance (light yellows ↔ dark blues)
- "Pinch" the spectrum at purple to represent the actual hue distribution

### Step 4: Background Color-Space Island

- Define a constrained region of the modified color space where backgrounds can live
- Found by elimination: "starting with unlimited and removing what doesn't fit"
- **No theory — just gut + iteration**
- Warm AND cool hues work for backgrounds; foreground is more tightly constrained to warm
- Background color gets ±4% random RGB shift each time it's referenced → subtle variation

### Step 5: Foreground Hue/Tonal Modulation

- **Cannot be separated from composition** — color is inseparable from form
- Fountain elements modulate dark↔light AND progressively shift hue
- Degree of modulation continuously changes
- Transparency calculated by proximity to "source" — near source = more transparent, fringe = more opaque
- Multiple semi-transparent layers create complex color mixing
- In extreme cases hue can shift all the way into blues/purples

### Step 6: Three Types of Accents ("The Seasoning")

- **White accent (Salt):** element → white (then yellowed by light shift)
- **Sub accent (Herbs):** mid-value, full saturation + full opacity — reveals underlying hue when elements modulate near black/white
- **Main accent (Spices):** "Like family recipes, some things need to be kept secret." Not complementary theory — just logic, ranges, and a sprinkle of randomness

## Key Philosophy

> "What I am seeking is not a definitive generative color algorithm that I can apply to multiple projects. I am seeking in every new project to find an approach where **the form grows out of the color and the color grows out of the form**. Not two separate algorithms, but a unified holistic approach."

> "Color and form are not two."

## Practical Takeaways for the Skill

1. **Tonal balance first** — equalize perceived lightness across hues before doing anything else
2. **Subtract what doesn't work** — start with full gamut, remove regions that don't fit the expression
3. **Antique by shifting endpoints** — yellowed lights + complementary darks = instant vintage
4. **Color modulation > color selection** — vary color along compositional structures, don't just pick swatches
5. **Transparency creates color** — layered semi-transparent elements produce colors no single layer could
6. **The algorithm IS the artwork** — color and form must be one process, not two stitched together
7. **Trust gut over theory** — use concepts and logic as tools, but the "intuitive voice has the final say"

## From the Art Blocks Interview

**URL:** https://www.youtube.com/watch?v=mqiGhLF6T9Q (color discussion ~20:00–34:00)

- **First 10 years = black and white only** — "color was this essential element I didn't need." Focused purely on composition and structure.
- **Bottled it on Photon's Dream** — had generative color but chickened out; used preset parameters. "This time I committed."
- **Tonal balance trick explained simply:** take spectrum → monochrome → invert → add together → balanced.
- **Green/purple killing was arbitrary** — wife and daughter's feedback was decisive.
- **The real magic = hue/value twist** — as sprays modulate dark↔light, hue also rotates simultaneously. Contrast decreases while hue warms through the spray.
- **Committed to generative color going forward** — "I will probably do this for every project now."

## Links

- **Article:** https://medium.com/@harvey.rayner/the-fontana-approach-to-fully-generative-color
- **Art Blocks interview:** https://www.youtube.com/watch?v=mqiGhLF6T9Q
- **Fontana on Art Blocks:** https://www.artblocks.io/project/367
- **Harvey Rayner:** https://pattern.co / @patterndotco
