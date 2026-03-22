# Pixel Art Color Palette Techniques

Three complementary resources on building color palettes for pixel art and game art.

---

## 1. Slynyrd — Color Ramps & the Mondo Palette

**Source:** https://www.slynyrd.com/blog/2018/1/10/pixelblog-1-color-palettes
**Author:** Raymond Schlitter

### The Hue-Shifting Principle

The single most important pixel art color technique: **shift hue across a color ramp**, not just brightness. Ramps without hue-shifting look flat and monochromatic.

### Building a Color Ramp (9 swatches)

1. **Middle color** = most vibrant (max combined S+B the artist deems appropriate)
2. **Hue assignment** = +20° shift per swatch (positive = warms toward highlights)
3. **Saturation** = peaks in middle, never 0 or 100; larger steps at ends, smaller in middle
4. **Brightness** = steady increase left→right; smaller steps near 100%
5. Goal: **even contrast between each swatch**

### The Mondo Palette (128 colors)

- 8 ramps × 9 swatches (shifting hue 45° between ramps = full 360° cycle)
- Plus desaturated duplicates (flip middle section, desaturate) for naturals/grays
- "A little color goes a long way with pixel art"

### Key Insight

> "I've tried to come up with mathematically precise formulas but it always seems to come down to trusting the eyeballs to some extent."

---

## 2. OpenGameArt — Xenodrogen Method

**Source:** https://opengameart.org/content/chapter-5-color-palettes

### Core Rule

> "The palette is 50% of the quality of your work."

### Hue-Shifting Rules (Natural Light)

- **Darker** → increase saturation, shift toward **blue** (sky/shadow influence)
- **Lighter** → decrease saturation, shift toward **yellow** (sun/highlight influence)

This mirrors actual outdoor lighting: blue sky fills shadows, yellow sun hits highlights. Same principle as Color Nerd's spectral bias / Fontana's "antique lights and darks."

### The Xenodrogen Method

Hue, saturation, and brightness must each vary in a **single consistent direction** — their rates of change must also be consistent.

- Valid: 1, 5, 5, 12 (accelerating)
- Invalid: 2, 3, 2, 1, 4 ("yoyo" effect)
- More colors = subtler transitions; fewer colors = larger jumps (15–20 units)

### Black & White Rules

- **Pure white (#FFF):** only for bright surfaces (spells, reflective metal/gems)
- **Pure black (#000):** only for outlines/silhouettes, NEVER for shadows or interior details

### Common Beginner Mistakes

1. Over-saturated colors lacking realism
2. Assuming colors (grass=green, water=blue) instead of observing actual variation

---

## 3. Kiwinuptuo — Hue Change Rule (Visual Guide)

**Source:** Kiwinuptuo's Color Palette Tutorial (image guide by Steven Böger)

### The Light Study Rule

- Sun (warm light source) on one side
- Moon/ambient (cool light source) on other side
- Colors shift hue toward the light source they face

### The Hue Change Rule

When building a color gradient:

- **Brighter colors** → shift hue toward sun direction (yellow/warm)
- **Darker colors** → shift hue toward moon direction (purple/blue/cool)
- Good palettes always have **more dark purpleish colors AND more bright yellowish/greenish colors**
- This looks more realistic because it mimics natural light behavior

### Sprite Examples (Wood, Plant)

**Wood ramp:**
| Brightest | Bright | Middle | Dark | Darkest | Outlines |
|-----------|--------|--------|------|---------|----------|
| Hue: +15 | +15 | 30 (start) | +15 | +15 | — |
| Brightness: +14 | +11 | 62 (start) | +15 | +15 | — |

Outline color is always consistent across all sprites. Choose dark blue or dark purple. Can have strong saturation.

### Bad vs Good Palette

- **Bad:** no hue changes, colors not linked to each other
- **Good:** hue shifts create family relationships between all colors; consistent outline color; linked ramps

### Pro Tips for the Right Version

- Linked colors reduce total count needed
- Linked colors "fit well together, the full image will look more harmonizing"
- Consistent outline color = consistent style across all sprites
- Saves time on longer projects

---

## Universal Principles Across All Three

1. **Always hue-shift** — never just adjust brightness alone
2. **Darks → cool (blue/purple), lights → warm (yellow)** — mimics natural light
3. **Saturation peaks in the mid-tones**, drops toward both extremes
4. **Consistent direction** — no yoyo-ing in any parameter
5. **Palette = identity** — consistent palette = consistent visual style
6. **Less is more** — limited palettes force harmony
7. **Trust your eyes** over formulas

## Links

- **Slynyrd Pixelblog:** https://www.slynyrd.com/blog/2018/1/10/pixelblog-1-color-palettes
- **OpenGameArt Ch.5:** https://opengameart.org/content/chapter-5-color-palettes
- **Lospec (palette database):** https://lospec.com/palette-list
