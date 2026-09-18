# Color Names in Vision-Language Models

**Source:** arXiv preprint 2509.22524 (September 2025, under review)
**Authors:** Alexandra Gomez-Villa, Pablo Hernández-Cámara, Muhammad Atif Butt, Valero Laparra, Jesús Malo, Javier Vazquez-Corral (Computer Vision Center Barcelona / Universitat de València)
**URL:** https://arxiv.org/abs/2509.22524
**Local PDF:** [pdfs/gomez-villa-2025-color-names-in-vlms-arxiv-2509.22524.pdf](pdfs/gomez-villa-2025-color-names-in-vlms-arxiv-2509.22524.pdf)
**Found via:** Umma Gohil's *Colour in Computer Vision* ([colour-in-computer-vision-vlm.md](colour-in-computer-vision-vlm.md))

## Why this matters

The first systematic replication of classic human colour-naming experiments on vision-language models. It answers a question this skill gets asked implicitly every time an image is shown to an agent: **how good is a VLM at naming a colour it is looking at?** Answer: excellent on the eleven focal colours, noticeably worse everywhere else, and the "everywhere else" is most of colour space. Pairs with [kim-heer-color-naming-across-languages.md](kim-heer-color-naming-across-languages.md) (the same question asked of humans) and with `techniques/colornames-oklab-blue-noise-names.md` (the tool to reach for instead).

## Method

Two stages, both on flat uniform colour chips to remove object and lighting confounds.

1. **Berlin & Kay replication.** The 330 Munsell chips of the World Color Survey, scored against three human references: Sturges & Whitfield focal data (111 highly saturated prototypical chips only), and two computational colour-naming models fitted to full human data, NICE (Parraga & Akbarinia 2016) and Benavente et al. 2008 (parametric fuzzy sets), on all 330 chips.
2. **Expanded set.** The 957 colour samples from Lindner et al. 2012, derived from the XKCD colour survey and validated cross-linguistically. Each chip prompted 100 times per model, open-ended naming. Majority vote assigns the name; consistency is the mean pairwise HSV distance among chips sharing a name.

Models, all 7–9B parameters: InternVL3 8B, Qwen2.5-VL 7B, JanusPro 7B, Molmo 7B, GLM4.1V 9B, MiniCPM-V 4.5 8B. Ablations: InternVL at 1B, 2B, 8B, 14B with the vision encoder held constant; 3D rendered objects in the 957 colours to test colour–object binding; nine further languages.

## Findings

### Focal colours are easy, the rest are not

| Model | Sturges-Whitfield (111 focal chips) | NICE (330 chips) | Benavente (330 chips) |
| --- | --- | --- | --- |
| GLM4.1V 9B | 1.00 | 0.775 | 0.762 |
| Molmo 7B | 0.981 | 0.816 | 0.831 |
| JanusPro 7B | 0.981 | 0.809 | 0.812 |
| InternVL2.5 8B | 0.942 | 0.738 | 0.700 |
| MiniCPM-V 4.5 | 0.875 | 0.637 | 0.656 |
| Qwen2.5 7B | 0.827 | 0.647 | 0.647 |

The high column is exactly the region where humans agree most. On the full chip set accuracy drops to 64–83 percent. The authors' framing: "Berlin and Kay's focal approach cannot reveal whether VLMs develop coherent color vocabularies across the complete range of perceivable colors."

### A shared 21-word vocabulary

All models converge on the same 21 terms, which together account for **67.7 percent of all responses**:

> black, white, gray, red, orange, yellow, green, blue, purple, pink, brown, magenta, lavender, turquoise, maroon, peach, teal, olive, tan, coral, beige

That is Berlin & Kay's eleven plus ten "second tier" English terms. Two strategies beyond the core:

- **Constrained** models (GLM4.1V, MiniCPM) put over 88 percent of answers into the 21 terms.
- **Expansive** models (Qwen2.5, JanusPro, InternVL3, Molmo) reach outside the core, but almost entirely with **lightness modifiers** on core hues: dark teal, pale yellow, light olive, bright pink, deep purple. Distinct lexical alternatives such as crimson, chartreuse, indigo, navy, salmon, rust appear only in individual models.

### Hue drives naming, then loses ground

Mutual information between HSV components and the assigned name:

| Colour set | Hue | Saturation | Value |
| --- | --- | --- | --- |
| Common 21 terms | 58–74 % | 11–14 % | 14–31 % |
| Modified terms | 51–53 % | 15–27 % | 19–33 % |
| Non-common terms | 36–60 % | 14–36 % | 19–28 % |

Hue dominates for basic terms and its share falls as vocabulary gets finer, where saturation and value carry the distinction. Qwen2.5 leans on Value far more than the others (30.5 percent even for common terms).

### Consistency versus vocabulary

- **Green** has the widest within-name hue spread in every model. It is also the most-used name. **Yellow and orange** have the tightest boundaries.
- Vocabulary breadth costs precision. Qwen2.5 has the richest vocabulary and the loosest categories: mean hue distance 31.2° among chips it calls the same name at the 0.5 stability threshold, and its number of stable foci collapses from 14 to 2 as the stability threshold rises to 1.0. GLM4.1V and MiniCPM keep 24–30 foci at the strictest threshold.
- Most models keep within-name hue spread at 15–20° regardless of threshold.

### Language

Prompted in nine further languages, the terms shared by all models per language:

| Language | Shared terms |
| --- | --- |
| Chinese | 22 |
| English | 21 |
| Spanish | 13 |
| Italian, Portuguese, French | 6–7 |
| others | under 10 |

Romance languages do not cluster, so this is **training-data imbalance, not linguistics**. The word a VLM produces reflects its language training as much as its pixels.

### Ablations

- **Language model matters independently of vision.** Scaling InternVL's LM from 1B to 14B with the same vision encoder shifts both the frequency of common terms and individual colour preferences.
- **Object binding.** The same 957 colours rendered on 3D objects produce object-dependent naming and modifier usage. Flat chips are a baseline, not the whole behaviour.

## Caveats

- Flat chips, no illumination, no context. Deliberate, but it means the reported accuracies are an upper bound for real photographs.
- Six open-weight models of one size class. No proprietary VLMs.
- Consistency is measured in HSV, which the skill would not normally recommend for distance; the authors use it because it maps to the modifiers people use.

## Takeaways for the skill

1. When an agent names a colour from an image, expect Berlin & Kay-grade answers: fine for a saturated red or yellow, unreliable for taupe, sage, mauve, or a lightness step between two greys.
2. A VLM saying "dark teal" instead of "teal" is a lightness modifier, not evidence of finer chromatic discrimination.
3. Two VLMs disagreeing on a name may have seen identical pixels. Vocabulary is a property of the language model.
4. For any deliverable that depends on the name, sample pixel values and use a naming tool built from human data: `colornames-oklab`, ISCC-NBS, or a fuzzy model such as COLIBRI ([colibri-fuzzy-color-model.md](colibri-fuzzy-color-model.md)).

## Links

- Paper: https://arxiv.org/abs/2509.22524
- Lindner et al. 2012 colour thesaurus (source of the 957 samples): the "Color Thesaurus" from Ecole Polytechnique Fédérale de Lausanne, derived from XKCD survey data
- XKCD colour survey: https://blog.xkcd.com/2010/05/03/color-survey-results/
- NICE colour naming model: Parraga & Akbarinia 2016, *PLoS ONE*
- Benavente, Vanrell & Baldrich 2008, "Parametric fuzzy sets for automatic color naming," *JOSA A* 25(10)
- Companion work by the same group: Ehab et al. 2026, [vision-encoder-color-thresholds-ehab.md](vision-encoder-color-thresholds-ehab.md); Alabau-Bosque et al. 2025, "Hues and cues: Human vs. CLIP," CCN 2025
