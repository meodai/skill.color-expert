# colorsort-js — Perceptually Smooth Color Sorting

**Source:** [GitHub — darosh/colorsort-js](https://github.com/darosh/colorsort-js)
**Author:** darosh (inspired by meodai's CodePen exploration)
**License:** MIT
**Demos:**

- Sorting test: https://darosh.github.io/colorsort-js/sorting-test/
- R&D sandbox: https://darosh.github.io/colorsort-js/

## What It Does

TypeScript library implementing multiple algorithms to sort colors in **perceptually smooth sequences**. Addresses the question: "What is the smoothest order of colors?" Evaluates and compares different sorting methods with performance metrics.

## Core Problem

Given an unsorted list of colors, find the ordering that produces the smoothest perceptual transitions. This is non-trivial because:

- RGB sorting produces jagged transitions
- HSL sorting has perceptual non-uniformity issues
- The optimal path depends on the color space and distance metric used
- It's related to the Travelling Salesman Problem

## Features

- **Multiple sorting algorithms** — comparative framework evaluating different approaches
- **Perceptual smoothness metrics** — quantitative measurement of sort quality
- **Fingerprint analysis** — similarity-based sorting via spectral analysis
- **FFT processing** — experimental spectral domain processing (treating palettes like audio signals — applying FFT and inverse FFT)
- **Interactive R&D sandbox** — 3D/2D color space previews, filter system, stats dashboard
- **Production-ready** — powers okpalette.color.pizza and farbvelo.elastiq.ch

## Used By

- **[okpalette.color.pizza](https://okpalette.color.pizza/)** — palette tool
- **[farbvelo.elastiq.ch](https://farbvelo.elastiq.ch/)** — color generation
- **PickyPalette** — ML-trained auto-sorting in the palette sculpting tool

## Technical Stack

- TypeScript monorepo (pnpm workspace)
- Vue frontend for demos
- Vitest testing
- Deno compatible
- Core library: `./packages/colorsort`

## Why Color Sorting Matters

When generating palettes (via RampenSau, Poline, or any method), the raw output order may not be perceptually smooth. Sorting creates coherent sequences for:

- **UI color scales** — sequential ramps need smooth progression
- **Data visualization** — categorical scales need distinct but ordered colors
- **Design systems** — swatch panels need logical arrangement
- **Generative art** — palette order affects visual rhythm

## Links

- **GitHub:** https://github.com/darosh/colorsort-js
- **Sorting test demo:** https://darosh.github.io/colorsort-js/sorting-test/
- **R&D sandbox:** https://darosh.github.io/colorsort-js/
- **Inspiration (meodai CodePen):** https://codepen.io/meodai/full/mdpNJQQ
