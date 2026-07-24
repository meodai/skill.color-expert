# ray-color — Raytraced Scene Palettes

**Source:** [GitHub — meodai/ray-color](https://github.com/meodai/ray-color)
**Author:** meodai
**Playground:** https://meodai.github.io/ray-color/
**npm:** `npm install ray-color` (v0.2.0) | **License:** MIT (bundled sound effects excluded)

## What It Does

Generates color palettes by raytracing a small scene — one white-ish sphere in a five-sided room, lit by up to three colored lights — and sampling colors off the sphere's surface. Tagline: **"edit the conditions, not the colors."**

The origin story: a tennis ball under a Philips Hue setup. Every time the room lights changed, the ball became a new palette — a red key light, a cold fill, warm bounce from the tabletop — and the colors always fit together *because they were all made of the same light in the same room*. ray-color simulates that room; palette coherence comes from shared illumination physics instead of color-wheel geometry.

## Why It's Different

Most generators (RampenSau, Poline, IQ cosine, harmony tools) construct palettes as *paths or point sets in a color space*. ray-color instead constructs a *physical situation* and reads colors out of it. Harmony emerges the way it does in photography and painting: every sample shares the same light sources, surface color, and bounce light, so hue/chroma/lightness co-vary the way they do on a real object. Good when you want "colors that look like they belong to one scene/moment" rather than a mathematically shaped ramp.

## The Scene Model

- **Sphere** at origin (`sphereRadius`, `sphereHex`), camera on the negative z-axis looking toward +z.
- **Five-sided room**: walls at ±2 world units (`left`/`right` on x, `top`/`bottom` on y, `back` at z = 2), front open toward the camera like a stage. Wall color via `wallHex`; ambient bounce via `indirect`.
- **Up to three lights**, `directional` or `point`, each with `hex`, `intensity`, `angle`, `size` (area-light softness).
- **Mirror walls**: `scene.wallReflect` sets per-wall reflectivity (0 matte … 1 mirror). Reflective walls both visually mirror the scene (one bounce) and act as **virtual light sources** — every light is mirrored across each reflective panel and re-illuminates the sphere, tinted by the wall color. That's the tabletop bouncing warm light back onto the tennis ball.

### Light positioning — dual parameterization

- **Spherical**: `yaw`/`pitch` in degrees + `dist` in world units (what the playground's orbit globe edits).
- **Cartesian**: `position: [x, y, z]` takes precedence; `commit()` derives yaw/pitch/dist from it and writes them back onto the light so both stay in sync. `dist` is clamped to `[sphereRadius, MAX_LIGHT_DISTANCE]` — a position inside the sphere gets pushed out to the surface along the same direction.
- `positionToAngles(x, y, z)` is exported standalone.

## Sampling API

Palette sampling is **resolution-independent** — no canvas, no pixel dimensions needed. `shade(dir)` returns the linear-RGB color the sphere shows in a given surface direction.

- `sampleLineDirs(a, b, count, spacing)` — walks the **geodesic arc** between two surface directions.
- `sampleCircleDirs(center, rho, count, spacing)` — walks a circle of angular radius `rho` around a center direction.
- Both take a `Distribution` — any `(t: number) => number` over [0, 1] — to space the points; `distributions.linear` and `distributions.smoothstep` ship with the library.

```ts
import {
  createEngine, sampleCircleDirs, distributions, toSRGB8,
} from 'ray-color';

const engine = createEngine(
  {
    cameraZ: -9, fov: 30, sphereRadius: 1.2,
    sphereHex: '#ffffff', wallHex: '#999999',
    indirect: 0.3, areaQuality: 6,
    wallReflect: { back: 0, left: 0, right: 0, top: 0, bottom: 0 },
  },
  [
    { type: 'directional', yaw: -150, pitch: 48, dist: 6, hex: '#ff0000', intensity: 0.95, angle: 30, size: 0.15 },
    { type: 'point', position: [2.5, -3, 1], hex: '#fff700', intensity: 0.3, yaw: 0, pitch: 0, dist: 0, angle: 30, size: 0.4 },
  ],
);
engine.commit();

// sample 5 colors along a circle drawn on the sphere's surface
const dirs = sampleCircleDirs([0, 0, -1], Math.asin(0.8), 5, distributions.smoothstep);
const palette = dirs.map(d => {
  const c = engine.shade(d); // linear RGB
  return '#' + [c.r, c.g, c.b].map(v => toSRGB8(v).toString(16).padStart(2, '0')).join('');
});
```

Pass `createEngine(width, height, scene, lights)` when actually rendering pixels — the engine is DOM-free and renders into any `Uint8ClampedArray`, so it works headlessly (Node, workers).

## Guarantees

- **Deterministic** — same scene, same colors, always. Area-light sampling uses a fixed golden-angle pattern, no RNG.
- **Linear-light shading** — all math in linear RGB; sRGB conversion only at the 8-bit boundary (`toSRGB8`). This is why the bounce/mix behavior looks physically plausible instead of gamma-muddy.
- **Sample = pixel** — a color from `shade(dir)` matches the rendered pixel it points at bit-for-bit.
- **Zero runtime dependencies**, ~6 kB gzipped, ESM + CJS + types.

## The Playground

`npm run dev` (or the hosted playground) — an interactive scene editor:

- Click the sphere to sample single colors; drag a **line** or **circle** across it and sample N points along the shape (linear or smoothstep spacing).
- Everything is draggable: lights, sample points, shape handles — dragging past the silhouette rolls onto the back of the sphere like a trackball.
- Left drawer: palette collection with color names, exports (copy, PNG, token-beam), and a live code snippet reproducing the current palette with the library.
- Right drawer: scene + per-light controls, orbit globe for aiming lights, mirror-wall reflectivity.

## How It Relates to Other Tools

| Tool               | Approach                                       | Best For                                        |
| ------------------ | ---------------------------------------------- | ----------------------------------------------- |
| **ray-color**      | Physical light simulation, sample the surface  | Scene-coherent palettes, "same light" harmony   |
| **RampenSau**      | Hue cycling + easing per axis                  | Deterministic ramp shapes                       |
| **Poline**         | Anchor interpolation with position functions   | Refining between specific colors                |
| **CuspHanger**     | Wijffelaars gamut-triangle model in OKLCH      | Dataviz sequential/diverging ramps              |
| **FarbVelo**       | Structured random with dark→light range        | Quick inspiration                               |
| **Spectral.js**    | Kubelka-Munk pigment mixing                    | Paint-like *mixing*, not scene lighting         |

Conceptually closest to how painters and photographers get harmony (one light situation unifies everything) — the same insight behind "limited palette under one light" studio exercises. Complements rather than replaces color-space generators: sample a scene with ray-color, then feed the result to colorsort-js for ordering or colornames-oklab for naming.

## Links

- **GitHub:** https://github.com/meodai/ray-color
- **Playground:** https://meodai.github.io/ray-color/
- **npm:** https://www.npmjs.com/package/ray-color
