# Do Vision Encoders Exhibit Human-like Color Thresholds?

**Source:** arXiv preprint 2607.16540 (July 2026)
**Authors:** Eslam Ehab, Pablo Hernández-Cámara, Nour Belal, Jesús Malo, Javier Vazquez-Corral, Alexandra Gomez-Villa (Computer Vision Center Barcelona / Universitat de València)
**URL:** https://arxiv.org/abs/2607.16540
**Local PDF:** [pdfs/ehab-2026-vision-encoders-color-thresholds-arxiv-2607.16540.pdf](pdfs/ehab-2026-vision-encoders-color-thresholds-arxiv-2607.16540.pdf)
**Found via:** Umma Gohil's *Colour in Computer Vision* ([colour-in-computer-vision-vlm.md](colour-in-computer-vision-vlm.md))

## Why this matters

[MacAdam's ellipses](macadam-ellipses-jnd.md) are the canonical picture of how unevenly human colour discrimination is spread across chromaticity: small ellipses in blue, large ones in green, all of them tilted. This paper asks whether the neural networks that now sit in front of every image an AI system sees have learned the same unevenness. The answer is a clear no, from the broadest test yet: **more than 50 pretrained encoders, best overlap with human discrimination regions under 0.25.**

For the skill, this is the quantitative backing for a rule of thumb: an embedding-based "similar colour" judgement (image search, CLIP-guided palette matching, VLM "these two look the same") is not a perceptual colour-difference judgement. Use ΔE₀₀ or OKLab distance for that.

## Method

- **Stimuli.** 18 reference colours (the paper's E1–E18) defined in CIELAB at constant L = 50, each at four chroma levels C ∈ {5, 20, 60, 80}, converted to sRGB and rendered as uniform patches. Human ground truth is the CIEDE2000 discrimination ellipse around each reference, the modern formalisation of the MacAdam just-noticeable-difference regions.
- **Sampling.** Around each reference, 500 colours are sampled inside a circle of radius twice the ellipse's semi-major axis: 250 inside the human ellipse, 250 outside.
- **Model side.** Every sample is embedded by the frozen encoder; cosine distance to the reference embedding gives a similarity field. The 250 most-similar samples form the model's "discrimination region."
- **Metric.** Intersection over union between the model's 250 and the human 250, averaged over references and chroma levels (mIoU). Equal set sizes remove size bias; 1 is perfect agreement, 0 none.
- **Models.** Over 50 encoders across four regimes: supervised (VGG16, SENet, ConvNeXt, Swin, EVA, BEiT, FlexiViT, SAM2 and others), self-supervised (DINOv2, Perception Encoder, MAE variants), language-supervised (OpenAI CLIP, OpenCLIP, SigLIP, Apple AIM-v2, MobileCLIP), unsupervised (Stable Diffusion XL VAE).

## Findings

### Everything is anisotropic, nothing matches

Every encoder develops **structured, strongly anisotropic** similarity fields around each reference: preferred directions of chromatic similarity whose size and orientation change with hue. So the networks do learn that colour space is non-uniform. But the extent and boundaries of the learned regions "typically diverge from the psychophysical human regions." The human ellipse often cuts across a zone of rapidly changing model similarity instead of sitting inside a coherent high-similarity blob.

### Ranking by training regime

| Regime | Behaviour | Examples |
| --- | --- | --- |
| Self-supervised | Strongest and most consistent alignment; similarity fields often follow the principal axes of the human ellipses | DINOv2, Perception Encoder |
| Language-supervised | Most polarised: **AIM-v2 is the single best model (mIoU ≈ 0.22)**, several other CLIP-family models are among the worst; fields are smooth and diffuse, "semantically compressed," subtle chroma differences de-emphasised | AIM-v2, OpenCLIP, SigLIP, MobileCLIP |
| Supervised | Highest variability; VGG16 remains competitive with far larger transformers | VGG16, ConvNeXt, Swin |
| Unsupervised (generative) | Weak alignment; noisy, fragmented fields | Stable Diffusion XL VAE |

Scale does not help. "Increases in model scale and representational capacity do not necessarily translate into improved perceptual chromatic organization." The ranking is stable across hue regions and chroma levels, so it reflects a property of each latent geometry rather than lucky spots.

### Hue and chroma dependence

- **Blues score lowest** for nearly every encoder, the same region where human discrimination is most non-uniform.
- **Low chroma** (C = 5, 20): human ellipses are small, which makes IoU geometrically easier, yet models show their largest variability and most failures there.
- **High chroma** (C = 60, 80): human ellipses are large and more elongated, harder to match, but model alignment is more stable.

### Implications the authors draw

For "precise color matching, digital art preservation, or fine-grained product inspection," frozen embeddings "may introduce systemic errors, particularly in highly saturated or non-uniform regions of the color space. If a model treats a perceptually distinct color change as a region of high latent similarity, downstream tasks will inherently fail to preserve human-aligned color fidelity."

## Caveats

- Uniform synthetic patches at one lightness. No texture, context, or illumination. The authors flag this.
- The metric is set overlap at a fixed cardinality; it measures shape and orientation agreement, not whether the model's threshold is too tight or too loose overall.
- Ground truth is CIEDE2000 ellipses rather than raw MacAdam data, which is standard but itself an approximation of human JNDs (see [macadam-ellipses-jnd.md](macadam-ellipses-jnd.md) on the limits of the ellipse model).

## Takeaways for the skill

1. Do not use CLIP or any image embedding as a colour-difference metric. Compute ΔE₀₀ or OKLab ΔE on sampled pixels.
2. Expect embedding-based colour similarity to be worst for blues and for low-chroma, near-neutral colours.
3. If a pipeline must use an encoder for colour-sensitive retrieval, self-supervised encoders (DINOv2, Perception Encoder) or AIM-v2 are the least bad choices measured here.
4. This is the "discrimination" half of a pair with [color-names-in-vlms-gomez-villa.md](color-names-in-vlms-gomez-villa.md) (the "naming" half), from the same group. Together: VLMs neither name nor discriminate colour the way people do outside the focal hues.

## Links

- Paper: https://arxiv.org/abs/2607.16540
- MacAdam 1942, "Visual sensitivities to color differences in daylight," *JOSA* 32(5) — the original ellipses, see [macadam-ellipses-jnd.md](macadam-ellipses-jnd.md)
- CIEDE2000: Sharma, Wu & Dalal 2005, *Color Research & Application* 30(1)
- Companion: Igali & Shamoi 2026 ask the categorical version of the same question, [beyond-color-geometry-igali.md](beyond-color-geometry-igali.md)
