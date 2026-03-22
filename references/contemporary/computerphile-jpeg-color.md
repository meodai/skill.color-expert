# JPEG Files & Colour (JPEG Pt1) — Computerphile

**Source:** [Computerphile](https://www.youtube.com/@Computerphile) (YouTube)
**Speaker:** Dr Mike Pound (Image Analyst, University of Nottingham)
**Date:** 2015-04-21
**URL:** https://www.youtube.com/watch?v=n_uNPbdenRs
**Duration:** 7:17
**Views:** 382,449
**Series:** JPEG compression (follows Colourspaces Pt0)

## Description

How JPEG uses color space conversion and chroma subsampling as the first stage of compression — exploiting the fact that human vision has much lower resolution for color than for brightness.

## Key Topics

### JPEG Is Not a File Format

- JPEG = compression method (Joint Photographic Experts Group)
- **JFIF** (JPEG File Interchange Format) = the actual file wrapper everyone uses
- **EXIF** = photographic industry metadata format, often combined with JFIF
- Full JPEG spec has many options (progressive, sequential, multiple color spaces) — impractical to implement all; JFIF standardized a practical subset

### JPEG Color Pipeline

1. **RGB → YCbCr conversion** — separates luminance from chrominance
2. **Chroma subsampling** — downsample Cb and Cr channels (color resolution reduced)
3. **Discrete Cosine Transform (DCT)** — mathematical transformation of 8×8 blocks
4. **Quantization** — the lossy step; reduces precision of DCT coefficients
5. **Encoding** — entropy coding to produce final compressed data

### Chroma Subsampling — The Key Insight

- Human eye sees luminance at much higher resolution than chrominance
- **Demo:** flower image with chrominance downsampled 10× in both directions (100× less color) — looks identical at normal zoom
- Only visible zoomed to pixel level at petal edges where color/gray mismatch
- **Common ratios:**
  - 4:2:0 — 2× downsample in both directions = 4× less color (most common)
  - 4:2:2 — 2× downsample only horizontal
  - 4:4:4 — no downsampling (highest quality, used when Photoshop quality = maximum)
- Quality slider in software controls both subsampling ratio and quantization level

### Lossy vs Lossless

- **Lossless:** BMP, PNG — like zipping; exact reconstruction (LZ compression)
- **Lossy:** JPEG — not guaranteed same output; but very close; much higher compression ratio
- The advantage of lossy: "huge amount more compression for your money"

### Frequency in Images

- **Low frequency:** gradual changes (black table → bright jumper → dark table)
- **High frequency:** rapid changes (woolen knit pattern)
- JPEG exploits that we don't perceive high-frequency intensity changes well — can blur/remove them

## Key Takeaways for the Skill

- JPEG's first compression win: **chroma subsampling** — 4× less color data, no visible difference
- This works because of the biological fact that cone cells (color) are sparser than rods (brightness) in the retina
- YCbCr is the standard intermediate for JPEG, not RGB
- Quality slider controls two things: subsampling ratio + quantization aggressiveness
- JFIF mandates YCbCr; full JPEG spec also allows CIELAB, RGB (rarely used)

## Links

- **Computerphile — Colourspaces (Pt0):** https://www.youtube.com/watch?v=LFXN9PiOGtY
- **Computerphile — DCT:** https://www.youtube.com/watch?v=Q2aEzeMDHMA
- **Computerphile — Bayer Filter:** https://www.youtube.com/watch?v=LWxu4rkZBLw
