# Beyond Color Geometry — Do Vision Encoders Carry Human Colour *Categories*?

**Source:** arXiv preprint 2607.13647 (July 2026)
**Authors:** Ayan Igali, Pakizar Shamoi (Kazakh-British Technical University, Almaty)
**Title:** *Beyond Color Geometry: Evaluating Human-Like Color Representations in Vision Models*
**URL:** https://arxiv.org/abs/2607.13647
**Local PDF:** [pdfs/igali-2026-beyond-color-geometry-arxiv-2607.13647.pdf](pdfs/igali-2026-beyond-color-geometry-arxiv-2607.13647.pdf)
**Found via:** Umma Gohil's *Colour in Computer Vision* ([colour-in-computer-vision-vlm.md](colour-in-computer-vision-vlm.md))

## Why this matters

[Ehab et al.](vision-encoder-color-thresholds-ehab.md) ask whether vision encoders discriminate colour like humans (they don't). This paper asks the complementary question: do encoders **categorise** colour like humans, with graded, overlapping categories? Its innovation is the reference. Previous alignment studies compared model embeddings with CIELAB distances or with hard colour labels. Igali and Shamoi compare against [COLIBRI](colibri-fuzzy-color-model.md), the 86-category fuzzy model fitted to 2,496 survey participants, and then **partial out CIELAB geometry** so that whatever agreement remains is about human category structure, not about the model having learned something like Lab.

The headline is counter-intuitive: the encoder trained on nothing but reconstructing masked image patches carries the most human-like colour categories. The language-supervised encoders that power most VLMs carry the least, and encode colour as a property of *the object* rather than of the pixels.

## Method

**Stimuli.** The 330 World Color Survey Munsell chips rendered two ways: flat patches, and shaded 3D spheres (closer to natural images). Plus 7,744 natural images from the balanced MegaCOIN subset of Tiny ImageNet with labelled foreground-object and background colours.

**Reference.** Each chip's HSI coordinates → COLIBRI membership vector over 9 hues × 3 saturation × 3 intensity + 5 achromatic = 86 categories (product of the per-axis memberships). Its largest component gives a dominant label for clustering metrics; the whole vector gives a graded reference.

**Models.** Eleven frozen ViT encoders in four regimes:

| Regime | Models |
| --- | --- |
| Language-supervised | CLIP ViT-B/32, CLIP ViT-L/14, OpenCLIP ViT-L/14 (LAION-2B), SigLIP-Large, SigLIP-2-Large |
| Class-supervised | ViT-B/16, ViT-L/16 (ImageNet-1k) |
| Self-distillation | DINOv2-base, DINOv2-large |
| Masked reconstruction | MAE ViT-B/16, MAE ViT-L/16 |

**Metrics.**

- *Category level:* silhouette score (are embeddings closer to their own COLIBRI category than the nearest other one?) and Adjusted Rand Index of k-means clusters against COLIBRI labels.
- *Graded level:* representational similarity analysis. Spearman correlation ρ_fuzzy between the model's cosine-distance matrix over chips and COLIBRI's cosine-distance matrix over 86-dim membership vectors.
- *Beyond geometry:* partial correlation p∆ of model vs COLIBRI while controlling for the CIEDE2000 distance matrix. This is the number that says how much human category structure the model holds that plain Lab distance does not explain.
- *Natural images:* linear probes for foreground-object colour and for background colour, balanced accuracy, and object selectivity ∆ = acc_fg − acc_bg.

## Findings

### Category boundaries look alike; graded structure does not

Silhouette and ARI sit in a narrow band with overlapping confidence intervals for all eleven models. If you only ask "does the model separate red from orange," every encoder looks about the same. The graded measures pull them apart:

| Model | Regime | ρ_fuzzy (spheres) | p∆ (spheres) |
| --- | --- | --- | --- |
| MAE-large | reconstruction | **0.673** | **0.467** |
| MAE-base | reconstruction | 0.667 | 0.455 |
| DINOv2-base | self-distillation | 0.576 | 0.248 |
| CLIP-B | language | 0.563 | 0.207 |
| ViT-B (IN1k) | class | 0.560 | 0.237 |
| DINOv2-large | self-distillation | 0.548 | 0.227 |
| SigLIP-2-L | language | 0.543 | 0.277 |
| CLIP-L | language | 0.533 | 0.193 |
| SigLIP-L | language | 0.476 | 0.171 |
| ViT-L (IN1k) | class | 0.457 | 0.163 |
| OpenCLIP-L | language | 0.444 | **−0.027** |

Both MAE models clear the best non-MAE encoder with non-overlapping confidence intervals, and the gap survives after Lab geometry is partialled out. OpenCLIP-L has essentially **zero** human category structure beyond what Lab distance predicts. The MAE advantage is not tighter clusters (its silhouette scores are low); it is a closer match to the *graded* COLIBRI structure, the overlaps and boundary ambiguities.

Flat patches versus spheres: MAE is unchanged; language-supervised models improve markedly on shaded spheres, which look more like their training images.

### Natural images: global colour versus object colour

On MegaCOIN, language-supervised encoders decode the **foreground object's** colour best, MAE decodes **background** colour best. Object selectivity ∆:

| Regime | ∆ = acc_fg − acc_bg |
| --- | --- |
| Language-supervised | +0.12 to +0.14 |
| Class-supervised, self-distillation | +0.07 to +0.11 |
| Masked reconstruction | +0.02, +0.00 |

Embedding size does not explain it: DINOv2-large and MAE-large both have 1,024 dimensions, and DINOv2-large has the *lowest* background-colour accuracy. Interpretation: language supervision binds colour to the thing being named ("a red car"), so colour becomes an attribute of the object token; reconstruction keeps a global map of surface colour.

### Layer dynamics

Language-supervised encoders start with high ρ_fuzzy at the input embedding and **lose** it toward the output as features become semantic. MAE models are the only encoders that keep alignment all the way to the final layer.

## Caveats

- Eleven models; the authors read the result as an *association* with training regime, since data, scale, patch size and recipe also differ.
- COLIBRI is one population's category structure (see the caveats in [colibri-fuzzy-color-model.md](colibri-fuzzy-color-model.md)); the 330 chips are dominant exemplars of only 50 of its 86 categories, so cluster metrics use only categories with ≥ 4 chips.
- Final embeddings only for the main results; the layer analysis uses mean-pooled tokens and is read for shape, not level.

## Takeaways for the skill

1. **CLIP-family encoders treat colour as an object attribute.** Asking one about the colour of a background, a gradient, or an abstract patch is asking it something it was trained to ignore. This is the mechanism behind the Arias et al. Stroop finding (the word wins over the ink) summarised in [colour-in-computer-vision-vlm.md](colour-in-computer-vision-vlm.md).
2. **"Separates categories correctly" is not the same as "shares human category structure."** Any evaluation of a naming tool or model should test boundary colours, not just focal ones. Same lesson as Gomez-Villa et al.
3. If you ever need an embedding that respects human colour categories (image search by colour mood, palette retrieval), a masked-autoencoder backbone is the measured best choice, and a CLIP backbone the worst.
4. Human colour category structure is *not* reducible to Lab distance. The p∆ column is the proof: it is what remains after Lab is removed, and it is far from zero for humans-versus-MAE, near zero for humans-versus-OpenCLIP.

## Links

- Paper: https://arxiv.org/abs/2607.13647
- COLIBRI: https://arxiv.org/abs/2507.11488, [colibri-fuzzy-color-model.md](colibri-fuzzy-color-model.md)
- World Color Survey: https://linguistics.berkeley.edu/wcs/
- MegaCOIN dataset (colour-annotated natural images): Li et al. 2024, arXiv 2412.03927
- Discrimination-side companion: [vision-encoder-color-thresholds-ehab.md](vision-encoder-color-thresholds-ehab.md)
