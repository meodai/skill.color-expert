# Why Some Brands Look Expensive (Before You Know What They Sell)

**Source:** [Peter Reitano](https://www.youtube.com/channel/UC6HeAS8je9YiQvU6gfd-3Wg) (YouTube Shorts)
**Date:** 2026-08-18
**URL:** https://www.youtube.com/shorts/BgzB73FUOpU
**Duration:** 2:23

## Overview

Brand-strategy take on color as **positioning signal** rather than decoration: how palette choice communicates price tier before any copy is read. Two opposed strategies — discount brands buy *attention* with saturated primaries; luxury brands buy *perceived value* with restraint. Lands on the 60-30-10 rule as the practical fix for the most common small-brand mistake (too many competing signals).

Marketing-side, not color-science-side. Useful as the vocabulary designers actually bring to a branding brief; see **Cross-Check** below for what the KB supports, weakens, or qualifies.

## The Core Claims

**1. Color is positioning, not decoration.**
> "Before you read a single word, your brain is already making assumptions. Does this feel premium or cheap, or corporate or playful, or luxury or discount?"

**2. Discount/volume categories lean into saturated primaries.**
Fast food, clearance, toy stores, supermarkets — bright reds, yellows, blues. Rationale given: stimulation, urgency, attention; "optimized for speed, accessibility, and volume" (McDonald's, Burger King).

**3. Luxury plays the opposite game — value through restraint.**
Rolex (deep green + gold), Hermès (burnt orange + warm neutrals), Cartier (black, cream, burgundy). Low chroma, warm neutrals, one controlled accent.

**4. The identical-product thought experiment.**
Same product in matte black packaging with soft cream typography vs. bright yellow with red accents → most people assume the black one is more premium. Attributed to category training: "categories train consumers over time."

**5. Too many colors reads as cheap.**
> "Too much contrast, too much stimulation, too many competing signals. Everything fights for attention and, ironically, that often makes a brand feel cheaper."

**6. Luxury branding behaves like architecture, not advertising** — restrained, "confident enough not to scream."

**7. 60-30-10 as the hierarchy fix.**
60% dominant, 30% supporting, 10% accent. > "The point is hierarchy, because when everything is trying to stand out, nothing does."

## Brands Cited

Palettes below are **commonly cited approximations**, not official brand specs — brand books define these in Pantone/CMYK for print and often differ per substrate. Verify against the brand's own guidelines before use.

| Brand           | Described as                | Approx. reference                                  |
| --------------- | --------------------------- | -------------------------------------------------- |
| Rolex           | deep green + gold           | Pantone 355 C green; metallic gold                 |
| Hermès          | burnt orange + warm neutrals| Pantone 1448 C / "Hermès orange"                   |
| Cartier         | black, cream, burgundy      | Cartier red ≈ Pantone 200 C, on black/cream        |
| McDonald's      | aggressive primaries        | red + yellow                                        |
| Burger King     | aggressive primaries        | red, orange, blue                                   |

The pattern the video is pointing at is not hue-specific: luxury examples sit at **low-to-moderate chroma with a large neutral field**, discount examples at **maximum chroma across the whole surface**. Rolex green and a fast-food red are both "a saturated hue" — the difference is *proportion and chroma control*, not which hue was picked.

## Cross-Check Against the KB

**Supported — restraint and proportion.** The video's strongest claim (hierarchy via proportion, few colors, most of the surface calm) is well-corroborated:

- **60-30-10** appears across the KB as a design heuristic: [Drawing Codex color proportion pyramid](drawing-codex-color-proportion.md) (most of an image should be neutral; vivid works *because* it's rare), [Francis balanced generative palettes](francis-balanced-generative-palettes.md) (weighted selection), [Florent Farges](florent-farges-color-harmony-painters.md).
- **Ellen Divers' character-first research**: hue is usually a *weaker* predictor of emotional response than chroma and lightness. This is the strongest scientific backing the video's thesis has — and it reframes it. "Looking expensive" is largely a **low-chroma / controlled-lightness** effect, not a fact about green or burnt orange.

**Weakened — hue→meaning psychology.** "Blue communicates trust and reliability" is the standard marketing claim, and it's the weakest part of the video. Hue-to-emotion mappings are heavily culture- and context-dependent, and the tech-blue convention is better explained by **category convention and imitation** (which the video itself concedes: "categories train consumers over time") than by any intrinsic property of blue. Treat as a description of *learned convention in a market*, not a perceptual law. See [Kim & Heer — color naming across languages](../contemporary/kim-heer-color-naming-across-languages.md) and [GenColor](../contemporary/gencolor-color-concept-association.md) for how concept–color associations are actually measured, and [Fine's critique](../contemporary/color-theory-critical-fine.md) for the general problem with folk color theory.

**Historical precedent.** This is a ~75-year-old research tradition, not a new observation:

- **Louis Cheskin** (1907–1981) founded applied color-marketing research and coined *sensation transference* — the idea that consumers transfer their feelings about packaging onto the product itself. That mechanism *is* the video's identical-product thought experiment. See [Cheskin 1953 color wheel](../historical/cheskin-1953-color-wheel.md).
- **Faber Birren**, *Selling with Color* (1945) — same argument in the wartime commercial-design idiom, and the PDF is in the KB: [birren-selling-with-color-1945.pdf](../historical/pdfs/birren-selling-with-color-1945.pdf). See also [Birren industrial color code](../historical/birren-industrial-color-code-seafoam.md).

**Missing — accessibility.** The video treats contrast purely as a stimulation dial ("too much contrast"). Restraint that flattens lightness separation fails readability: the luxury look (cream on black, gold on green) has to be checked with APCA/WCAG, and gold-on-white in particular routinely fails. Low chroma is compatible with high lightness contrast — that's the combination to aim for. See [Accessibility](../contemporary/colorandcontrast/accessibility.md).

## Practical Translation

To build the "expensive" look as a token system rather than a vibe:

1. **Large neutral field (60%)** — a warm or cool near-neutral surface, chroma roughly `0.01–0.03` in OKLCH. Warm neutrals (cream, bone, taupe) carry most of the "luxury" reading in the cited examples.
2. **Supporting color (30%)** — the brand hue at *reduced* chroma, or a deeper value of the neutral. This is the layer small brands usually skip, jumping straight from surface to accent.
3. **Accent (10%)** — the one high-chroma or metallic element. Reserve it; if it appears everywhere it stops reading as an accent.
4. **Hold lightness contrast even while dropping chroma** — verify text pairs at APCA 75+ for body copy.
5. Encode the split as semantic tokens (`surface` / `surface-secondary` / `accent`), not as three literal hexes — see [Design Book](designbook-reactive-design-token-spec.md).

## Source Books

| Title                                | Author        | Year | Archive.org                                                                                 | Status                              |
| ------------------------------------ | ------------- | ---- | ------------------------------------------------------------------------------------------- | ----------------------------------- |
| _Selling with Color_                 | Faber Birren  | 1945 | [details/sellingwithcolor00birrrich](https://archive.org/details/sellingwithcolor00birrrich) | Already in KB: [PDF](../historical/pdfs/birren-selling-with-color-1945.pdf) |
| _Colors: What They Can Do for You_   | Louis Cheskin | 1947 | [details/colourswhattheyc0000loui](https://archive.org/details/colourswhattheyc0000loui)     | Borrow only (lending-restricted)    |
| _The Cheskin System for Business Success_ | Louis Cheskin | 1973 | [details/cheskinsystemfor0000ches](https://archive.org/details/cheskinsystemfor0000ches) | Borrow only (lending-restricted)    |
| _Color in Business, Science and Industry_ | Deane B. Judd | 1952 | [details/colorinbusinesss00judd](https://archive.org/details/colorinbusinesss00judd)     | Borrow only                         |

## Links

| Resource                | URL                                                        |
| ----------------------- | ---------------------------------------------------------- |
| Video (Shorts)          | https://www.youtube.com/shorts/BgzB73FUOpU                 |
| Video (standard watch)  | https://www.youtube.com/watch?v=BgzB73FUOpU                |
| Peter Reitano — channel | https://www.youtube.com/channel/UC6HeAS8je9YiQvU6gfd-3Wg   |

## Transcript

Have you ever noticed that some brands look expensive before you even know what they sell? That's not an accident, and a huge part of it comes down not [to] the product, not the logo — color. Before you read a single word, your brain is already making assumptions. Does this feel premium or cheap, or corporate or playful, or luxury or discount? That judgment happens almost instantly because color isn't decoration, it's positioning.

Technology brands have historically leaned into blue because blue communicates trust and reliability. Think about discount brands for a second. Fast food, clearance sales, toy stores, supermarkets — they almost all lean heavily into bright reds, yellows, and blues. Why? Because those colors create stimulation, urgency, and attention. There's a reason brands like McDonald's and Burger King live in aggressive primary colors. They're optimized for speed, accessibility, and volume.

Luxury brands play almost the opposite game. Luxury creates value through restraint, through control, through taste. Look at Rolex with deep green and gold, or Hermès with burnt orange and warm neutrals, Cartier with black, cream, and burgundy. Those colors aren't chosen because they look nice, they're chosen because they create a feeling before you ever touch the product.

Imagine someone handed you two identical products. One comes in matte black packaging with soft cream typography, the other comes in bright yellow with red accents. Even if they were exactly the same, most people would instinctively assume the black one is more premium. That's branding psychology. Of course, there are exceptions, but categories train consumers over time.

One of the biggest mistakes smaller brands make is trying to use too many colors all at once — too much contrast, too much stimulation, too many competing signals. Everything fights for attention and, ironically, that often makes a brand feel cheaper. Because for luxury, branding behaves more like architecture than advertising. It's restrained, confident enough not to scream.

One of the simplest frameworks designers use is the 60-30-10 rule. 60% of your visual identity should be your dominant color, 30% should support it, and 10% should be your accent. The point is hierarchy, because when everything is trying to stand out, nothing does.

The real lesson is this: color teaches people how to value your brand before they understand anything else about it — before the craftsmanship, before the product, before the strategy. The best brands understand that design isn't just decoration, it's perception engineering.
