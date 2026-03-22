# The Book of Shaders — Chapter 6: Colors

**Source:** https://thebookofshaders.com/06/
**Authors:** Patricio Gonzalez Vivo & Jen Lowe

## What It Is

The foundational GLSL color chapter from The Book of Shaders — the most widely-used resource for learning shader programming. Covers color as vectors, mixing, HSB, and polar coordinates.

## Key Techniques

### Color as Vectors

Colors in GLSL are `vec3`/`vec4` — accessible via `.rgb`, `.xyz`, or index `[0][1][2]`. **Swizzling** rearranges components freely:

```glsl
vec3 yellow = vec3(1.0, 1.0, 0.0);
vec3 magenta = yellow.rbg;  // swap green↔blue
vec3 green = yellow.bgb;    // blue into red and blue channels
```

### mix() for Gradients

```glsl
vec3 color = mix(colorA, colorB, pct);  // pct = 0.0→1.0
```

- `pct` can be a `vec3` — different blend per channel
- Map `pct` to spatial coordinates for gradients
- Use shaping functions (easing) for non-linear transitions

### HSB in GLSL

```glsl
vec3 hsb = rgb2hsv(color);
// x-axis → hue, y-axis → brightness
vec3 rgb = hsv2rgb(hsb);
```

### HSB Color Wheel (Polar Coordinates)

```glsl
vec2 toCenter = vec2(0.5) - st;
float angle = atan(toCenter.y, toCenter.x);  // -π to π
float radius = length(toCenter) * 2.0;
vec3 color = hsv2rgb(vec3(
    (angle / TWO_PI) + 0.5,  // hue from angle
    radius,                    // saturation from distance
    1.0                        // brightness
));
```

### Exercises Mentioned

- Turner sunset gradients
- Sunrise→sunset animation via `u_time`
- Rainbow with easing functions
- Flag patterns with `step()`
- Loading spinner color wheel
- **RYB color wheel** via shaping functions on hue (expand certain ranges)
- Study Josef Albers' _Interaction of Color_

## LYGIA Shader Library

Referenced as a reusable GLSL function library for color:

- Color space conversions
- Color blending
- Gradient creation
- Performance-optimized transforms

**URL:** https://lygia.xyz/

## Why This Matters for the Skill

- The `mix()` + shaping function pattern is the foundation of all procedural color in shaders
- HSB→polar coordinates = the standard way to build color wheels in GLSL
- Swizzling is the shader equivalent of channel manipulation
- This chapter is where most shader artists first learn color — good to reference when someone asks about GLSL color techniques
- The RYB exercise hint (use shaping functions to expand hue ranges) connects directly to RYBitten and harveyHue

## Links

- **Chapter:** https://thebookofshaders.com/06/
- **Full book:** https://thebookofshaders.com/
- **LYGIA shader library:** https://lygia.xyz/
- **Editor:** https://editor.thebookofshaders.com/
