# Imaginary Pigments — What Can Mixbox Reveal About Color Space?

**Source:** [Color Nerd](https://www.youtube.com/@ColorNerd1) (YouTube)
**Date:** 2022-12-05
**URL:** https://www.youtube.com/watch?v=o5spI1V3Rss
**Duration:** 2:25
**Views:** 2,182

## Description

Using Max Bo's "Hello, Mixbox" tool to visualize Kubelka-Munk pigment mixing paths in OKLAB color space. Reveals the hidden 3D structure of pigment mixing space using both real and imaginary pigments.

## Transcript

You know what I've always wondered — what can simulations using Kubelka-Munk theory reveal about the hidden structure of pigment mixing space?

Kubelka-Munk theory being of course a set of equations that allows us to predict or model mixtures of substances — how those mixtures will affect their absorption and scattering of light, and therefore you can model how the mixture of two paints might look.

If you take those predictions and put them into a perceptually uniform color space like OKLAB, you can get models like this, where it shows basically the path that you travel as you add more and more cadmium yellow to phthalo blue. This by the way is from "Hello, Mixbox" — an online resource put together by Max Bo, who's a designer at Canva.

So what if you take a whole set of pigments and chart all of the paths that they kind of network together to create? You get sort of a picture of this pigment mix space. These are based on real pigments.

But what if we use imaginary pigments to really chart the space in its entirety? Well, you might get something like this — these are all full-saturation RGB colors as though they were physical pigments, how they would mix with white. You see it sort of turns into this interesting pattern where **those paths bend towards subtractive primaries (magenta, cyan, and yellow) and away from additive primaries (red, green, and blue).**

Here are those same pigments all mixed with each other to show you the entire structure of that space.

What if however we just look at the primaries and secondaries, white and black? You can kind of see a little bit more clearly what this three-dimensional space is and how the curves again move away from CMY and squish in toward RGB.

Here is an animation showing you how as I move that imaginary focal pigment around the perimeter of RGB space, the different curves of those paths kind of weave in interesting ways. And I think there's a lot to be studied here and I don't even know where to begin.

## Key Concepts

- **Kubelka-Munk theory** — equations predicting how pigment mixtures absorb and scatter light
- **OKLAB** — perceptually uniform color space used to visualize mixing paths
- **Pigment mixing paths bend toward CMY, away from RGB** — the fundamental asymmetry of subtractive mixing space
- **Imaginary pigments** — using full-saturation RGB colors "as if" they were physical pigments reveals the complete structure of mixing space
- **The mixing space is curved and 3D** — paths aren't straight lines; they weave in complex patterns dependent on spectral properties
- Connects to: introverted/extroverted octopus concepts from the CSA webinar

## Links

- **Hello, Mixbox:** https://observablehq.com/@mjbo/hello-mixbox <!-- ⚠️ Bot-protected: open manually in a browser -->
- **OKLAB** (Björn Ottosson): https://bottosson.github.io/posts/oklab/
- **Mixbox:** spectral pigment mixing library
