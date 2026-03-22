# glsl-lut — Lookup Table Color Grading in Shaders

**Source:** [GitHub — mattdesl/glsl-lut](https://github.com/mattdesl/glsl-lut)
**Author:** Matt DesLauriers (mattdesl)
**npm:** `glsl-lut` | **Stars:** 184
**Demo:** https://mattdesl.github.io/glsl-lut/example/demo.html

## What It Does

GLSL shader library for applying color transforms via **lookup table (LUT) textures**. A 512×512 image encodes an entire color grading operation — apply Instagram-like filters, film emulation, or custom color science transforms in real-time on the GPU.

## How LUT Color Grading Works

1. Sample the original pixel color from your image
2. Use that color as **coordinates into a 512×512 lookup table**
3. The LUT pixel at those coordinates = the transformed color
4. Result: any color mapping that can be baked into a texture

This means: curves, levels, desaturation, hue shifts, split toning — anything that's a per-pixel color→color transform. Does NOT work for spatial operations (blur, sharpen, median).

## Usage

```glsl
uniform sampler2D uLookup;
#pragma glslify: transform = require('glsl-lut')

void main() {
  vec4 original = texture2D(uTexture, vUv);
  gl_FragColor = transform(original, uLookup);
}
```

**Critical:** set texture filter to `NEAREST` (not linear) to avoid interpolation artifacts.

## Creating LUTs

### From Photoshop

1. Open the identity LUT image (ships with the library)
2. Apply any adjustments (curves, color balance, hue/sat, etc.)
3. Save — the modified image IS your LUT

### Programmatically (Node.js)

Generate LUTs in code for precise color science operations:

```bash
glsl-lut > images/lut.png  # CLI: outputs identity LUT
```

Then modify pixels programmatically — e.g., "desaturate all colors some distance from a target hue in OKLAB color space."

## Why LUTs Matter

- **Performance:** one texture lookup per pixel — trivial GPU cost
- **Portability:** same LUT works in any renderer (WebGL, Unity, Unreal, DaVinci Resolve)
- **Composability:** stack multiple LUTs or blend between them
- **Film industry standard:** color grading in cinema uses LUTs (3DL, CUBE formats)
- **Generative art:** programmatic LUT generation = procedural color grading

## Relation to Color Science

LUTs encode arbitrary color→color mappings, so they can implement:

- **Gamut mapping** (e.g., Display P3 → sRGB)
- **Color space transforms** (baked into a texture)
- **Film stock emulation** (Kodak Portra, Fuji Velvia characteristics)
- **CVD simulation** (bake a deuteranopia transform into a LUT)
- **Perceptual adjustments** in OKLAB/OKLCH (via programmatic generation)

## Links

- **GitHub:** https://github.com/mattdesl/glsl-lut
- **Demo:** https://mattdesl.github.io/glsl-lut/example/demo.html
- **GPU Gems 2, Ch. 24:** LUT theory reference
- **npm:** `npm install glsl-lut`
