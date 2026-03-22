# Inigo Quilez — Cosine Palette Formula

**Source:** [Inigo Quilez](https://www.youtube.com/@InigoQuilez) (YouTube Shorts)
**Date:** 2024-08-22
**URL:** https://www.youtube.com/shorts/TH3OTy5fTog
**Views:** 51,707
**Full article:** https://iquilezles.org/articles/palettes/

## The Formula

```
color(t) = a + b * cos(2π * (c * t + d))
```

Where `t` goes from 0 to 1, and `a`, `b`, `c`, `d` are **3D vectors** (one component per RGB channel).

## What Each Parameter Controls

| Parameter | Controls                              | Type |
| --------- | ------------------------------------- | ---- |
| **a**     | Color brightness (base offset)        | vec3 |
| **b**     | Color contrast (amplitude)            | vec3 |
| **c**     | How quickly colors change (frequency) | vec3 |
| **d**     | Location of color peaks (phase)       | vec3 |

## How It Works

- The cosine function oscillates smoothly through color space
- Since a, b, c, d are 3D vectors, each RGB channel gets its own cosine wave
- The result: a smooth, continuous color ramp from any `t` value
- Only 4 vectors (12 floats total) define an entire palette

## Why It's Brilliant

- **Extremely compact** — 12 numbers define infinite colors
- **GPU-friendly** — single cosine evaluation per pixel (trivial in GLSL)
- **Smooth by construction** — cosine guarantees no discontinuities
- **Intuitive tweaking** — each parameter has clear visual meaning
- **Endlessly variable** — random values produce diverse, often beautiful results

## Usage (GLSL)

```glsl
vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    return a + b * cos(6.28318 * (c * t + d));
}
```

## Practical Tip

"Pick some random values at first and then tweak from there until you find a palette that you like."

## Full GLSL Implementation with 7 Preset Palettes

```glsl
// The MIT License - Copyright © 2015 Inigo Quilez
// https://iquilezles.org/articles/palettes/

vec3 pal( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}
```

### 7 Presets (a, b, c, d vectors)

| #   | a               | b               | c               | d                  | Character                                   |
| --- | --------------- | --------------- | --------------- | ------------------ | ------------------------------------------- |
| 1   | (0.5, 0.5, 0.5) | (0.5, 0.5, 0.5) | (1.0, 1.0, 1.0) | (0.00, 0.33, 0.67) | Rainbow — evenly spaced RGB phase           |
| 2   | (0.5, 0.5, 0.5) | (0.5, 0.5, 0.5) | (1.0, 1.0, 1.0) | (0.00, 0.10, 0.20) | Cool blue-green gradient                    |
| 3   | (0.5, 0.5, 0.5) | (0.5, 0.5, 0.5) | (1.0, 1.0, 1.0) | (0.30, 0.20, 0.20) | Warm red-orange                             |
| 4   | (0.5, 0.5, 0.5) | (0.5, 0.5, 0.5) | (1.0, 1.0, 0.5) | (0.80, 0.90, 0.30) | Green-yellow-magenta (halved blue freq)     |
| 5   | (0.5, 0.5, 0.5) | (0.5, 0.5, 0.5) | (1.0, 0.7, 0.4) | (0.00, 0.15, 0.20) | Sunset — different frequencies per channel  |
| 6   | (0.5, 0.5, 0.5) | (0.5, 0.5, 0.5) | (2.0, 1.0, 0.0) | (0.50, 0.20, 0.25) | High-frequency red, constant blue           |
| 7   | (0.8, 0.5, 0.4) | (0.2, 0.4, 0.2) | (2.0, 1.0, 1.0) | (0.00, 0.25, 0.25) | Asymmetric — different offsets + amplitudes |

### Pattern Analysis

- **Presets 1–6** share the same `a` and `b` — only `c` (frequency) and `d` (phase) vary. This shows the power of those two parameters alone.
- **Preset 7** changes all four — different brightness offset, different amplitude per channel, different frequencies. Most complex.
- When `c` components differ: channels oscillate at different rates → richer color variety
- When `d` components are close together: narrow color range; far apart: wider hue sweep
- `c = (2.0, 1.0, 0.0)` means red cycles twice as fast as green, blue is constant → creates stripe-like patterns

### Full Shadertoy Source

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 p = fragCoord.xy / iResolution.xy;
    p.x += 0.01*iTime; // animate

    vec3                col = pal( p.x, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,1.0),vec3(0.0,0.33,0.67) );
    if( p.y>(1.0/7.0) ) col = pal( p.x, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,1.0),vec3(0.0,0.10,0.20) );
    if( p.y>(2.0/7.0) ) col = pal( p.x, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,1.0),vec3(0.3,0.20,0.20) );
    if( p.y>(3.0/7.0) ) col = pal( p.x, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,0.5),vec3(0.8,0.90,0.30) );
    if( p.y>(4.0/7.0) ) col = pal( p.x, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,0.7,0.4),vec3(0.0,0.15,0.20) );
    if( p.y>(5.0/7.0) ) col = pal( p.x, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(2.0,1.0,0.0),vec3(0.5,0.20,0.25) );
    if( p.y>(6.0/7.0) ) col = pal( p.x, vec3(0.8,0.5,0.4),vec3(0.2,0.4,0.2),vec3(2.0,1.0,1.0),vec3(0.0,0.25,0.25) );

    float f = fract(p.y*7.0);
    col *= smoothstep( 0.49, 0.47, abs(f-0.5) );
    col *= 0.5 + 0.5*sqrt(4.0*f*(1.0-f));

    fragColor = vec4( col, 1.0 );
}
```

## Links

- **Full article:** https://iquilezles.org/articles/palettes/
- **Shadertoy demo:** embedded in the article
- **License:** MIT
- Widely used in shader art, Shadertoy, generative art, procedural textures
