# Colourspaces (JPEG Pt0) — Computerphile

**Source:** [Computerphile](https://www.youtube.com/@Computerphile) (YouTube)
**Speaker:** Dr Mike Pound (Image Analyst, University of Nottingham)
**Date:** 2015-04-10
**URL:** https://www.youtube.com/watch?v=LFXN9PiOGtY
**Duration:** 7:31
**Views:** 250,852

## Description

Clear introduction to three core color spaces — RGB, CMYK, and YCbCr — and why each exists for different use cases (monitors, printers, video compression).

## Key Topics

### RGB (Red, Green, Blue)

- **Additive** — adding all colors → white; removing all → black
- Format used by monitors and graphics cards
- Any color created by varying amounts of R, G, B
- Color cube: R, G, B corners; secondaries at midpoints (cyan, magenta, yellow); white in center

### CMYK (Cyan, Magenta, Yellow, Black)

- **Subtractive** — adding all dyes → black (in theory)
- K (black) added because C+M+Y produces muddy dark brown, not true black — wastes toner
- Printers use CMYK; print drivers convert RGB→CMYK automatically
- Color cube: C, M, Y corners; secondaries (R, G, B) at midpoints; black in center (opposite of RGB)

### YCbCr (Luminance, Blue Chrominance, Red Chrominance)

- Separates **brightness (Y)** from **color (Cb, Cr)**
- Y = luminance (grayscale version of image), 0–255
- Cb = blue chrominance ("blueness"), -127 to +128
- Cr = red chrominance ("redness"), -127 to +128
- Center (Cb=0, Cr=0) = neutral gray; grayscale line runs through center of cube
- "Less blue" = more yellow; "less red" = more green (opponent-like encoding)

### Why YCbCr Exists

- **Human vision is more sensitive to brightness than color** — can downsample Cb/Cr without noticeable quality loss
- **Fundamental to JPEG compression** — downsample color channels, keep luminance at full resolution
- Used in TV broadcasting (PAL, NTSC), HD video, and most video compression
- This is chroma subsampling (4:2:0, 4:2:2, etc.)

### When to Use Which

- **RGB** — default for screens, graphics cards, web; widely supported
- **CMYK** — printing (drivers handle conversion)
- **YCbCr** — video, TV broadcasting, JPEG; enables efficient compression via chroma subsampling

## Key Takeaways for the Skill

- RGB and CMYK are "opposite cubes" — white center vs black center
- YCbCr's separation of luma from chroma is foundational to all modern image/video compression
- Chroma subsampling exploits the fact that human vision resolves brightness at higher resolution than color
- Y' (with prime) = gamma-corrected luminance
