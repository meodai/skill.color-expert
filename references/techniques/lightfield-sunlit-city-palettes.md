# Lightfield — Sun-Lit City Palettes (light-driven design-token ramps)

**Source:** [GitHub — tol-is/lightfield](https://github.com/tol-is/lightfield)
**Author:** Tolis C. ([tol.is](https://tol.is)), design engineer, London
**App:** https://lightfield-beta.vercel.app
**Stack:** React + Vite + TypeScript, MIT. Published August 2026.

## What It Does

A palette generator where you drag a **sun** around a flat-shaded axonometric **city**. Each face of each building is one solid colour, so the model is not a preview of the palette — it *is* the palette. Click a face to copy its token. Export is CSS custom properties, JSON or a Tailwind config, always as `oklch(62.34% 0.1870 264.1)`, never hex.

Same family as ray-color ("edit the conditions, not the colours"): coherence comes from shared illumination physics rather than colour-wheel geometry. The difference is the target. ray-color samples a sphere for *a palette*; Lightfield sweeps surface orientations to produce *design-token ramps* (50…950) for each pigment, and layers several perceptual corrections on top.

## The Model

**Pigments** are OKLCh materials: hue from a harmony rule (analogous, complement, split, triad, even, golden angle 137.5°), a stock lightness, and a **relative chroma** `Cr` — a fraction of the maximum chroma sRGB holds at that exact (L, h), found by bisection. Pigments hold still while the sun moves, so you see one paint under different light.

**Light** is a colour temperature on the Planckian locus (Kim et al. CIE-xy polynomial → XYZ → linear sRGB). Sun elevation drives everything at once: sun ≈ 1750 K on the horizon → ≈ 6300 K overhead, sky ≈ 6800 → 16000 K, key intensity falls as `sin(el)^0.85` so dusk can go properly dark, plus a ground bounce tinted by key + sky. A single Blinn-Phong-ish shader with Fresnel, ACES tonemapping, no shadows.

**Ramps** are not interpolations. Each ramp is a sweep of surface normals through the sun's vertical plane, from a soffit facing down and away (sees almost no sky) over the roof to a wall facing straight into the sun. Shade each orientation, convert to OKLCh, sort by L, smooth chroma and hue-drift with a 1-2-1 kernel, then **re-space evenly in L** so the stops work as tokens. Endpoints are *not* normalised: dusk gives a short dark ramp, noon a long bright one. **Lock range** fixes Floor/Ceiling if you need that instead.

## The Four Corrections (this is the transferable part)

1. **Relative chroma, not absolute.** Asking every hue for the same absolute chroma gives a vivid blue beside a dead yellow, because sRGB gives them different room. Each pigment asks for the same *fraction* of the chroma its own hue holds at its own lightness. The ramp does the same per step: measured, a positional chroma taper had blue using 86 % of available chroma while yellow used 71 % and orange 74 %, dipping to 54 % at some steps. Same principle as nutelch's `relC`.

2. **Cusp pull.** Every hue's chroma peaks at a different lightness. In sRGB-OKLCh, the cusp sits at roughly L 0.89 for the hue Lightfield calls Yellow (95°), L 0.79 for Amber (70°), L 0.63 for Red (22°), L 0.46 for Blue (266°); the sRGB yellow corner itself is at L 0.97. An equal-lightness palette is exactly why yellow so often goes to mud. Cusp pull (0…1) drags each pigment's stock lightness toward its hue's cusp. Same geometry CuspHanger and the Wijffelaars model use.

3. **Warm shift (Bezold–Brücke + Abney), profiled by hue.** Holding hue constant across a ramp is itself the problem: a dark yellow at its own hue is olive, a pale red is chalky. Perceived hue moves with intensity — for wavelengths above ~500 nm (the whole red-to-yellow arc) toward yellow as intensity rises and toward red as it falls — and Abney does the same on dilution toward white. So the ramp rotates **up to 10° toward yellow as it lightens** and **up to 28° toward red as it darkens**, weighted by a hue window that peaks in the red–yellow arc and fades to zero by the greens; OKLCh hues above 180° are untouched. Rose/pink/magenta get none, because they sit on the purple line where Bezold–Brücke doesn't apply. The README flags the wrong implementation explicitly: anchoring rotation as a fraction of the distance to a fixed yellow anchor rotates whichever hue is *furthest* from yellow the hardest, which is backwards (it dragged a rose 14° into orange and left yellow untouched). The dark pull is the stronger because that's where gamut runs out: at L 0.35 a yellow hue holds ≈ 0.07 chroma, an amber hue ≈ 0.13, so rotating is the only way a dark warm shade carries any colour at all — and it lands where real ramps land (Tailwind `amber-950` is a deep brown). Default 70 %.

4. **Hue drift cap.** The light may push a hue only so far from its pigment (`drift × 20°`). A 2400 K sun was driving a rose ramp 25° into orange — physically right, but a token named Rose must stay rose.

Plus a **tinted neutral** always included, 18° off the key hue at ~10 % of the palette's relative chroma: a blue-grey and a red-grey are different materials.

## Naming

Chromatic pigments by OKLCh hue: Rose 0°, Red 22, Orange 45, Amber 70, Yellow 95, Lime 118, Green 140, Emerald 162, Teal 182, Cyan 203, Sky 225, Azure 248, Blue 266, Indigo 286, Violet 305, Purple 325, Magenta 344. Neutrals get their own ring — Clay 15, Taupe 45, Sand 80, Sage 115, Moss 150, Mist 190, Slate 225, Steel 262, Zinc 292, Mauve 325, Blush 350 — and collapse to **Grey** only below C 0.005. Nice small vocabulary for tinted-neutral tokens.

## Caveats

- sRGB gamut only; the bisection cap is 0.44 chroma and `inGamut` is linear-sRGB clipping. No P3 option.
- The renderer is a stylised shader (ACES on a Blinn-Phong with no shadowing), not spectral. Colour temperature enters as a normalised linear-sRGB tint, so "1750 K" is an art-directed orange, not a radiometric one.
- The "measured" percentages in the README are the author's own instrumentation of the tool, not a study.
- Brand new (August 2026), one author, pre-1.0 UI ("beta"). Read it for the reasoning; treat the numbers (10°/28°, windows, 0.095 neutral chroma) as tuned defaults.

## What To Take From It

- Ramps for warm hues should **rotate hue with lightness**, toward red going down and toward yellow going up, and cool hues should not. This is the pixel-art "hue shifting" rule with the perceptual reason (Bezold–Brücke, Abney) attached and a hue-profiled bound instead of an anchor.
- Specify chroma as a **fraction of the gamut boundary** per (L, h) and pull stock lightness toward each hue's **cusp**; both are cheap to compute by bisection in OKLCh.
- Deriving ramps from a **sweep of surface orientations under one light** gives co-varying L/C/h for free; re-space in L afterwards if you need tokens.
- Always ship a **tinted neutral** and name it as a material (Slate, Sand, Mauve), not as "grey-500".

## Related

- `ray-color-raytraced-palettes.md` — the same philosophy, sphere + coloured lights, sampling for palettes rather than token ramps.
- `nutelch-gamut-relative-chroma.md` — relative chroma as a library primitive.
- `cusphanger-gamut-triangle-palettes.md` / `wijffelaars-intuitive-color-palettes.md` — the black–cusp–white triangle.
- `pixel-art-color-palettes.md` — hue shifting as craft practice.
