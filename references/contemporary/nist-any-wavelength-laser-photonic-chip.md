---
title: NIST "Any-Wavelength" Laser on a Photonic Chip (Brodnik et al. 2026)
source: https://www.nist.gov/news-events/news/2026/04/any-color-you-nist-scientists-create-any-wavelength-lasers-tiny-circuits
paper: https://doi.org/10.1038/s41586-026-10379-w
preprint: https://arxiv.org/abs/2509.08092
pdf: pdfs/brodnik-2025-tantala-any-wavelength-laser-arxiv.pdf
date: 2026-04-15
---

# NIST "Any-Wavelength" Laser on a Photonic Chip

NIST news release (Apr 15, 2026) announcing a Nature paper by Grant M. Brodnik, Grisha Spektor, Lindell M. Williams, Jizhao Zang, Alexa R. Carollo, Atasi Dan, Jennifer A. Black, David R. Carlson, and Scott B. Papp: *"Monolithic 3D integration of tantalum pentoxide photonics on arbitrary substrates."*

## What they built

An integrated photonics "layer cake" stacked on a standard silicon wafer that takes a single 980 nm infrared pump laser and synthesizes arbitrary visible and near-IR wavelengths from one chip.

Layer stack:

1. **Silicon wafer** + silicon-dioxide (glass) substrate.
2. **Thin-film lithium niobate** — χ² nonlinear medium for electro-optic modulation and fast switching (metal / LiNbO₃ interfaces let them turn circuits on/off rapidly).
3. **Metal electrodes** for electrical control of the nonlinear process.
4. **Tantalum pentoxide (Ta₂O₅, "tantala")** — broadband, low-loss, deposited at low temperature so it can sit on top of the LiNbO₃ without damaging it. Tantala carries the octave-spanning frequency conversion that generates the full visible rainbow + IR.

Scale: ~50 fingernail-sized chips, ~10,000 photonic circuits each, all on a beer-coaster-sized wafer.

## Why this matters for color / light science

- **Arbitrary-wavelength coherent light from one chip.** Frequency combs + parametric oscillation + harmonic conversion together let a single 980 nm pump produce any target wavelength in the visible — e.g. 780 nm (rubidium clock transition) and 461 nm (strontium clock transition) were explicitly demonstrated, plus conversion down to blue.
- **Breaks the "one laser diode per color" constraint.** Visible-wavelength lasers (especially blue, cyan, yellow) are historically the hardest and most expensive part of any quantum-optics, display, or spectroscopy stack. A nonlinear chip can replace a rack of lasers.
- **Relevant to AR/VR displays.** Directly addresses RGB laser sources for near-eye displays: instead of separate R, G, B diode lasers with mismatched efficiency and alignment, one IR pump + designed circuits emits the three primaries from a single chip.
- **Relevant to atomic clocks.** Optical atomic clocks need very specific transition wavelengths (Rb 780 nm, Sr 461 nm, Yb, Ca, etc.). Designing the chip = picking the atom.
- **Color = geometry of a circuit.** Scott Papp's framing: *"We can create all these different colors, just by designing circuits."* The chip layout — microring resonator diameters, waveguide dispersion, poling periods — is what determines which wavelengths come out. Hue becomes a fabricated parameter.

## Application list (from the NIST release)

- Quantum computing (laser-cooled neutral-atom / ion qubits need many specific wavelengths)
- Optical atomic clocks
- AI chip-to-chip interconnects (photonic I/O)
- AR/VR displays (compact RGB sources)
- Geodesy — volcano / earthquake precursor detection via optical strain sensing
- GPS-alternative navigation (chip-scale optical clocks as timing references)
- Dark-matter searches (precision spectroscopy on novel transitions)

## Relation to existing color knowledge

- Ties into the **spectral-origin-of-color** thread: this is a direct physical demonstration that "what color a laser is" is a property of a *resonator geometry* plus nonlinear material, not an intrinsic property of the gain medium. Compare Goethe edge colors, iridescence / thin-film interference, and the general principle that perceived color traces back to a spectral power distribution that engineering can sculpt.
- Relevant to the **AR/VR / display** section of the knowledge base: practical path to wide-gamut laser-sourced displays where primaries can be tuned to match Rec.2020 / BT.2100 rather than being stuck at whatever LED diodes happen to exist.
- Relevant to **metrology / atomic standards** — which is where most of our notions of "standard white" (D50, D65) and spectral calibration ultimately trace.
- Not a color-theory paper, but an important upstream enabler for future color-technology work: compact, broadband, tunable coherent light is the substrate on which future spectral cameras, spectral displays, and per-wavelength SPD design will run.

## Key quotes

> "We can create all these different colors, just by designing circuits." — Scott Papp

> The team reports "low-loss, high-quality-factor microresonators" and demonstrates parametric oscillation, soliton microcomb generation, and harmonic conversion in one monolithic stack across visible and near-IR wavelengths. — arXiv abstract (paraphrased)

## Industry spin-out

**Octave Photonics** (Louisville, CO) — founded by former NIST researchers, commercializing the microcomb / nonlinear-chip work.

## Links

- NIST news release: <https://www.nist.gov/news-events/news/2026/04/any-color-you-nist-scientists-create-any-wavelength-lasers-tiny-circuits>
- Nature paper (DOI): <https://doi.org/10.1038/s41586-026-10379-w>
- arXiv preprint: <https://arxiv.org/abs/2509.08092>
- Local PDF: [brodnik-2025-tantala-any-wavelength-laser-arxiv.pdf](pdfs/brodnik-2025-tantala-any-wavelength-laser-arxiv.pdf)
- Phys.org coverage: <https://phys.org/news/2026-04-scientists-wavelength-lasers-tiny-circuits.html>
- NIST project page: <https://www.nist.gov/noac/any-wavelength-laser>
- Related NIST work — microcomb wavelength extension (2024): <https://www.nist.gov/news-events/news/2024/06/some-bumps-nist-scientists-devise-novel-way-extend-wavelength-range>
- Octave Photonics: <https://octavephotonics.com>
