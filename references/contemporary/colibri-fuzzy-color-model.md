# COLIBRI — A Fuzzy Colour Model Built From a 2,496-Person Survey

**Source:** arXiv preprint 2507.11488 (July 2025)
**Authors:** Pakizar Shamoi (corresponding), Nuray Toganas, Muragul Muratbekova, Elnara Kadyrgali, Adilet Yerkin, Ayan Igali, Malika Ziyada, Ayana Adilova, Aron Karatayev, Yerdauit Torekhan (Kazakh-British Technical University, Almaty)
**Title:** *COLIBRI Fuzzy Model: Color Linguistic-Based Representation and Interpretation*
**URL:** https://arxiv.org/abs/2507.11488
**Local PDF:** [pdfs/shamoi-2025-colibri-fuzzy-color-model-arxiv-2507.11488.pdf](pdfs/shamoi-2025-colibri-fuzzy-color-model-arxiv-2507.11488.pdf)
**Found via:** cited in Muratbekova et al. 2025 and Igali & Shamoi 2026, both in Umma Gohil's *Colour in Computer Vision* ([colour-in-computer-vision-vlm.md](colour-in-computer-vision-vlm.md))

## Why this matters

Most colour-naming resources in this knowledge base are **nearest-name lookups**: a colour has one name, the boundary between names is a hard line. Human naming does not work that way, and COLIBRI is the largest attempt to measure how it actually works. Instead of "this is teal," it says "0.6 cyan, 0.4 light blue, medium saturation, medium intensity." Every colour has **graded membership in overlapping categories**, and the membership functions are fitted to human votes, not drawn by hand.

The authors call this a new family, **Soft Color Models**, and are careful to distinguish it from perceptual uniformity: CIELAB tries to make equal distances look equally different; COLIBRI tries to make category boundaries as blurry as people's are. Different goal, complementary.

Relevant to: the Color Naming section of `SKILL.md`, [kim-heer-color-naming-across-languages.md](kim-heer-color-naming-across-languages.md), [color-names-in-vlms-gomez-villa.md](color-names-in-vlms-gomez-villa.md), and any future naming tool that wants to say "between X and Y" honestly.

## The model

Built on **HSI** (hue, saturation, intensity), chosen because those are the three attributes people actually use in language. Each axis is partitioned into fuzzy sets with triangular or trapezoidal membership functions:

| Axis | Categories |
| --- | --- |
| Hue (9) | Red, Orange, Yellow, Green, Cyan, **Light Blue**, Blue, Violet, Magenta |
| Saturation (4) | Very low, Low, Medium, High |
| Intensity (5) | Black, Dark gray, Gray, Light gray, White |

At very low saturation a colour is named by its grey level regardless of hue, and at extreme intensity by black or white, which yields five achromatic categories. Igali & Shamoi 2026 count the chromatic combinations as 9 hues × 3 saturation × 3 intensity + 5 achromatic = **86 categories**, and use the 86-dimensional membership vector as a "fuzzy fingerprint" of a colour.

**Light Blue as its own hue** is the notable design decision. The authors are in Kazakhstan; Russian and Kazakh both have obligatory basic terms for light blue (*goluboy*) versus dark blue (*siniy*), as do several other languages. Their expert panel drew the boundary, and the main survey confirmed it, although the cyan / light blue / blue region is also where participants disagreed most (see below).

Membership functions are fitted by grid search over candidate cut points, minimising root-mean-square error between the fuzzy model and the empirical membership (fraction of participants who chose that label for that stimulus), under the constraint that memberships across hue categories sum to one. An adaptive layer (neural network) can refine partitions from new feedback.

## The experiments

Three phases, run in a controlled lab with identical monitors and seating, instructions in English, Kazakh and Russian, Ishihara screening before the hue tasks. Sample sizes with gender split:

| Phase | Task | n |
| --- | --- | --- |
| 1a | Seven colour experts mark hue boundaries and name segments on a continuous spectrum | 7 |
| 1b | Same experts count distinct saturation levels (desaturated → saturated red) and intensity levels (black → white) | 7 |
| 2 | 360° hue circle at 3° steps = 120 stimuli; participants report how many distinct colours they see inside each of the nine categories → reduced to **45 hue stimuli** | 27 |
| 3 main | Each of 45 stimuli, choose between two hue labels | **1,071** (40 % F) |
| 3 alt | Pick every block that looks like a given colour (multi-select) | 505 |
| 3 sat | Classify saturation of colour stimuli | 427 |
| 3 int | Classify intensity of achromatic stimuli | 441 |

Total 2,496 responses, mostly university students. The two hue formats were run partly to validate each other.

## Findings

- **Strong consensus on most hues, honest ambiguity on some.** Most stimuli got a clear majority. A subset split up to a third of votes with a second label. Two stimuli split almost exactly (51.6 / 48.4 and 50.6 / 49.4) — genuine boundary colours. The fuzzy model records that as ~0.5 membership in each rather than forcing a winner.
- **The cyan – light blue – blue region is the hard part.** Two stimuli were assigned to three different hues across the two survey formats. The authors name this their "primary challenge." Compare Kim & Heer's finding that the blue region is where languages disagree most, and Ryan Moulton's point that sRGB cyans are the colours screens most struggle to show.
- **Agreement is highest for hue, lowest for intensity.** Fleiss' kappa: hue 0.76 (substantial), saturation 0.56 (moderate), intensity 0.49 (moderate). People agree on what hue a thing is more readily than on how light or saturated it is, which fits the Gomez-Villa finding that hue carries most of the naming information.
- **Main and alternative hue surveys agree.** Jensen-Shannon divergence 0.119, cosine similarity 0.935, Pearson 0.925. Single-choice and multi-select formats produce the same category structure, so the two-option format of the main survey did not distort results. In the multi-select format, stimuli mostly landed in two categories, not more.
- **Colour vision deficiency.** Of 1,071 main-survey participants, 33 gave at least one wrong Ishihara answer, 76.4 percent of them male; the alternative survey showed the same pattern (72.2 percent male). The authors estimate 1 in 19 (5.14 percent) colour-deficient, in line with published population rates. These participants were removed as outliers before fitting.
- **Gender.** No significant gender difference in how stimuli were distributed across hue categories (mean stimuli selected per category 5.21 F vs 4.68 M). The discussion cites prior work on female sensitivity to red-green and yellow-blue variation, but the authors' own data do not show a categorisation difference.
- **Applications shown.** Dominant colour extraction that returns linguistic labels with proportions, and content-based image retrieval on the VISUELLE fashion dataset (5,577 products, dresses subset) labelled by dominant fuzzy colour. The paper's running example is the Kazakhstan flag, officially "sky blue," reproduced anywhere from cyan to turquoise to light blue.

## Caveats

- **Participants are one population.** Almaty university students, trilingual context where light blue is a basic term. The nine-hue partition may not transfer unchanged to English-only speakers, where light blue is usually a modifier.
- **The hue partition was seeded by seven experts.** The 1,071-person survey validated and shaped the boundaries but did not choose the number of categories.
- **HSI, not a perceptual space.** Membership is defined over an HSI transform of sRGB, so the model inherits sRGB's gamut and HSI's non-uniformity. The authors say this is deliberate (people speak in hue/saturation/lightness terms), but it means the fuzzy sets are device-relative.
- **Intensity and saturation agreement is only moderate.** The four saturation and five intensity levels are the least certain part of the model.
- The related review by the same group (Muratbekova et al. 2025) claims the HS\* family is "most aligned with human perception" from a seven-expert picker test. That is a much weaker claim than this paper's survey supports; keep the two separate.

## Takeaways for the skill

1. When asked to name a colour that sits between categories, say so with proportions rather than picking a winner. This is what humans do, measured.
2. Expect the most disagreement in the cyan / light blue / blue band. If a name in that region matters, ask or show alternatives.
3. Hue names are trustworthy; saturation and lightness words ("pale," "muted," "dark") are the fuzzy part. Give numbers alongside them.
4. Light blue is a basic colour term for a large share of humanity. Naming tools built on English lists under-represent it.

## Links

- Paper: https://arxiv.org/abs/2507.11488
- Group review that introduced COLIBRI to a wider audience: Muratbekova et al. 2025, *Color Models in Image Processing*, https://arxiv.org/abs/2510.00584 (local: `pdfs/muratbekova-2025-color-models-review-arxiv-2510.00584.pdf`)
- COLIBRI used as a human reference for vision encoders: [beyond-color-geometry-igali.md](beyond-color-geometry-igali.md)
- Earlier parametric fuzzy naming (the model COLIBRI is closest to in spirit): Benavente, Vanrell & Baldrich 2008, *JOSA A* 25(10), 2582–2593
- VISUELLE dataset: https://github.com/HumaticsLAB/GTM-Transformer
