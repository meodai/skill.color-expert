# Goethe's "Edge Colors" Are Actually a Design Hack

**Source:** [Color Nerd](https://www.youtube.com/@ColorNerd1) (YouTube)
**Date:** 2025-02-08
**URL:** https://www.youtube.com/watch?v=qiXHiABcl-I
**Duration:** 11:16
**Views:** 26,046

## Description

Reverse-engineering Goethe's prism "edge color" observations into a framework for creating readable, accessible linear gradient palettes. The edge color sequences naturally satisfy all three requirements for readable data viz palettes.

## The Goethe Edge Colors

**Newton:** shone light through a prism → projected spectrum onto wall
**Goethe:** put the prism in front of his eye → observed how it distorted an image

Looking at a black bar through a prism produces two edge color sequences:

- **Warm edge:** black → dark red → red → orange → amber → yellow → (desaturates toward white)
- **Cool edge:** black → dark blue → blue → cyan → (desaturates toward white)

Key observation: **hue and lightness shift together** — they're aligned. Darker = more saturated red/blue; lighter = more yellow/cyan.

## The 3D Helical Structure

When plotted in 3D color space, these edge color sequences form **helices** — they curve through hue, chroma, AND lightness simultaneously:

1. Start at black
2. Gain saturation → loop around through hues
3. Hit maximum saturation → continue shifting hue
4. Lose saturation → spiral back toward center (white)

Pipe cleaner model demonstrates the spiral path through color space.

## Three Requirements for Readable Gradient Palettes

1. **Monotonic lightness** — must progress consistently from dark to light (or vice versa)
2. **Graceful degradation to monochrome** — must still work in grayscale (accessibility)
3. **Perceptually uniform steps** — can't rely on RGB or HSL; must use perceptually uniform space

**Goethe's edge color series naturally satisfies all three.** They are the "primordial example of readable gradient palettes."

## Existing Examples of This Principle

### Matplotlib Colormaps

- **Viridis:** black → violet → azure → blue-green → desaturated yellow → white — traces a helix through color space
- **Magma:** same helical principle through different hues (warm circuit)
- Peter Karpov's critique: some colormaps have hue discrimination issues in places

### Dave Green's Cubehelix

- Explicitly designed as a helical path through RGB space
- Specifically for astronomical visualization
- Monotonic lightness + hue variation + grayscale safe

## Practical Tool: Colorbox

**Colorbox** (by Kevyn Arnott / Lyft, now at colorbox.io) lets you construct these helical palettes interactively:

1. Set starting hue (e.g., yellow) and ending hue (e.g., red)
2. Adjust saturation curve (clip when it oversaturates)
3. Choose easing function: quadratic, quintic, ease-in, ease-out, ease-in-out
4. Adjust brightness curve — end brightness should go to black
5. Result: readable gradient palette following the helical structure

## Key Insight

**What if all three dimensions of color (value, chroma, and hue) could remain distinct throughout a palette?**

Traditional palettes often only vary one dimension (monochromatic = just lightness, or just hue rotation at constant lightness). The edge color / helix approach varies ALL THREE simultaneously — and that's what makes it readable AND colorful AND accessible.

## Links

- **Dave Green's Cubehelix:** https://people.phy.cam.ac.uk/dag9/CUBEHELIX/cubetry.html
- **Colorbox:** https://colorbox.io/
