# GenColor: Generative Color-Concept Association in Visual Design

**Source:** CHI '25, Yokohama, Japan (ACM)
**Authors:** Yihan Hou, Xingchen Zeng, Yusong Wang, Manling Yang, Xiaojiao Chen, Wei Zeng
**Institution:** HKUST (Guangzhou), Zhejiang University
**arXiv:** 2503.03236v1
**DOI:** https://doi.org/10.1145/3706598.3713418
**Local PDF:** [pdfs/gencolor-color-concept-association.pdf](pdfs/gencolor-color-concept-association.pdf)

## Problem

Selecting colors that semantically match a concept (e.g., "Statue of Liberty," "quiet forest," "lively market") is laborious. Existing approaches:

- **Query-based image referencing** — search Google Images, extract colors. But queried images have wildly inconsistent colors due to lighting, quality, style.
- **Linguistic co-occurrence** — mine color-concept pairs from text corpora. But N-gram is sparse for uncommon/context-dependent concepts.
- **Crowdsourcing** — time-consuming and resource-intensive.

## GenColor Framework (3 stages)

### 1. Concept Instancing

- Use **diffusion models (text-to-image)** to generate images from concept prompts
- Key insight: T2I models already encode visual patterns from large-scale real-world data → more consistent color representation than queried images
- Enhanced prompts improve results: "quiet forest" + "evoking feelings of silence and lonely" → more consistent mood

### 2. Text-Guided Image Segmentation

- Segment generated images to identify **concept-relevant regions** only
- Avoids extracting colors from backgrounds or irrelevant objects

### 3. Color Association

- Extract **primary + accent colors** from segmented regions
- Produces color compositions, not just single colors

## Key Findings

- **Generated images produce more consistent colors** than queried images (photos or clipart) for the same concept
- **Context-dependent color extraction works:** "clear sky" vs "polluted sky" → different palettes from the same base concept
- **Primary-accent composition** matches how designers actually use color (not just "the color of X" but "the dominant color + supporting accents")

## Design Scenarios

- **Graphic design:** tourist pins for cities using landmark-associated colors
- **Data visualization:** categorical color assignment based on semantic meaning
- **Brand design:** context-appropriate color from abstract concepts

## Why This Matters for the Skill

- **Color-concept association** is a common task: "what color represents [concept]?"
- Traditional approach (search images, extract palette) produces unreliable results
- Using AI-generated images as color sources is more consistent
- The primary-accent structure is more useful than single-color answers
- Context modifiers ("quiet" vs "lively" forest) significantly change the appropriate palette
- Connects to: color-name-lists (naming), color-description (emotional adjectives), image extraction tools (okpalette, img-colors)

## References of Note (from the paper)

- Schloss et al. (2018) — Color inference in visual communication
- Setlur & Stone (2016) — Linguistic approach to categorical color assignment
- Szafir (2018) — Modeling color difference for visualization design
- Shi et al. (2023) — De-Stijl: 2D color palette recommendation
