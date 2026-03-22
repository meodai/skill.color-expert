# Simulating Impossible Pigments — FocalPaint

**Source:** [Color Nerd](https://www.youtube.com/@ColorNerd1) (YouTube, full-length)
**Date:** 2022-02-13
**URL:** https://www.youtube.com/watch?v=KMPZOb7Z-tE
**Duration:** 5:28
**Views:** 1,156
**Guest:** Biren Dieterle (creator of FocalPaint)

## Description

Interview with Biren Dieterle about FocalPaint, an iPad app that simulates spectral reflectance-based paint mixing. Discussion of reflectance recovery, Kubelka-Munk theory, spectral upsampling, impossible pigments, metamers, and Herbert Ives's 1930s thought experiment.

## Key Topics Discussed

### Digital Paint Mixing Revolution

- **Mixbox** being integrated into Rebelle 5
- **OKLAB** as gradient space in Photoshop
- **FocalPaint** — iPad app with spectral reflectance-based mixing

### How FocalPaint Works

- **Reflectance recovery** — technique to generate spectral reflectance curves from RGB values
- Inspired by **Scott Burns's website** on spectral reflectance recovery
- Started from **MyPaint** forums where Annatim had made a patch for real color blending
- Uses **Kubelka-Munk theory** for modeling paint mixing (scattering + absorption)
- Computational overhead: like having 4 texture layers instead of 1 in Photoshop

### Editable Spectral Profiles (Impossible Pigments)

- Users can **directly edit the spectral waveform** of simulated pigments
- Creates pigments that don't/can't exist in the real world
- Produces unique colors that mix differently than anything else

### Metamers

- Great teaching tool: "find three different ways to create the same brown with totally different waveforms"
- Most RGB upsampling techniques can't produce metamers because they use static R/G/B primaries summed together
- FocalPaint's editable waveforms allow true metamer creation

### Laser Simulation

- Single-band spectral colors (like lasers) can be created
- Mixing two adjacent single-band reds → black (they don't share spectral overlap subtractively)

### Herbert Ives's Thought Experiment (1930s)

- What if pigments reflected the whole spectrum EXCEPT one tiny piece?
- "Reverse laser" — high reflectance with one dip
- Theorized these would mix to very bright secondaries/tertiaries
- Ives couldn't test it; FocalPaint now can simulate this

## Links

- **FocalPaint:** https://focalpaint.com
- **FocalPaint Twitter:** @focalpaint
- **Scott Burns's spectral reflectance recovery:** referenced but URL not given
- **Mixbox:** spectral mixing library (integrated into Rebelle 5)
- **MyPaint:** open-source painting software (where the idea started)

## Source References

- **Herbert Ives** (1930s) — thought experiment on "reverse laser" pigments
- **Kubelka-Munk theory** — mathematical model for paint mixing (scattering + absorption)
- **Scott Burns** — spectral reflectance recovery research
