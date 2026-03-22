# dittoTones — Generate Palettes from Design System DNA

**Source:** [GitHub — meodai/dittoTones](https://github.com/meodai/dittoTones)
**Author:** meodai
**Demo:** https://meodai.github.io/dittoTones/
**npm:** `dittotones` | **Stars:** 116

## What It Does

Generates complete color palettes from a single input color by extracting the **"perceptual DNA"** — the underlying lightness and chroma curves — from established design systems (Tailwind, Radix) and applying those patterns to your custom hue. Your color, their structure.

## The Problem

Design systems like Tailwind (50–950) and Radix (1–12) have carefully crafted lightness/chroma curves that ensure consistent contrast and vibrancy across all shades. Recreating that quality for a custom brand color by hand is extremely difficult. dittoTones automates it.

## Algorithm

1. **Parse input** → OKLCH (via culori)
2. **Detect neutrals** — low chroma? return as-is
3. **Find nearest reference ramp** — Euclidean distance in OKLCH space
4. **Select strategy:**
   - **Exact match** — input color matches a reference shade closely
   - **Single ramp** — one reference ramp is close enough
   - **Blended dual-ramp** — combines two ramps when no single match is perfect
5. **Transform** — rotate hue + correct lightness (piecewise linear interpolation) + adjust chroma (hybrid scaling: linear for delicate tones, power curves for vivid)

### Lightness Adjustment

Piecewise linear interpolation anchored at black (0) and white (1). Preserves target lightness at matched shade, prevents clipping.

### Chroma Adjustment

Hybrid scaling: linear for lower saturation (preserves delicate tones), power curves for higher saturation (prevents oversaturation). Constant offset for desaturation below reference.

## API

```typescript
import { DittoTones } from "dittotones";
import { tailwindRamps } from "dittotones/ramps/tailwind";

const ditto = new DittoTones({ ramps: tailwindRamps });
const result = ditto.generate("#F97316");

result.scale; // { '50': Oklch, '100': Oklch, ..., '950': Oklch }
result.matchedShade; // '500'
result.method; // 'exact' | 'single' | 'blend'
result.sources; // [{ name: 'orange', diff: 0.02, weight: 1 }]
```

### Custom Ramps

```typescript
const customRamps = new Map([
  [
    "brand",
    {
      "50": oklch(parse("oklch(98% 0.01 250)")),
      "500": oklch(parse("#3B82F6")),
      "950": oklch(parse("oklch(25% 0.05 250)")),
    },
  ],
]);
const ditto = new DittoTones({ ramps: customRamps });
```

## Built-in Ramp Systems

| System           | Shades                      | Notes                       |
| ---------------- | --------------------------- | --------------------------- |
| **Tailwind CSS** | 50, 100, 200, ..., 900, 950 | Default ramps               |
| **Radix UI**     | 1–12                        | Alternative scale structure |
| **Custom**       | Any                         | User-defined ramp maps      |

## Why It Matters

- **"Your color, Tailwind's quality"** — get production-grade shade scales for any brand color
- **Smart blending** — when input falls between two reference hues, blends both ramps weighted by distance
- **Neutral awareness** — desaturated colors handled separately to avoid forced chromatic shifts
- **OKLCH throughout** — perceptually uniform = consistent perceived contrast across all shades

## Links

- **GitHub:** https://github.com/meodai/dittoTones
- **Demo:** https://meodai.github.io/dittoTones/
- **npm:** `npm install dittotones`
