# Fairchild — Color Appearance Models

**Source:** _Color Appearance Models_ (2nd ed., Wiley, 2005)
**Author:** Mark D. Fairchild
**Local PDF:** [pdfs/Fairchild M. Color appearance models (2ed., Wiley, 2005)(ISBN 0470012161)(O)(409s)_CsIp_.pdf](pdfs/Fairchild M. Color appearance models (2ed., Wiley, 2005)(ISBN 0470012161)(O)(409s)_CsIp_.pdf)
**Archive.org:** https://archive.org/details/colorappearancem0000fair

## What It Is

One of the core references for **color appearance modeling**: how colors actually look under different viewing conditions, not just how they are measured numerically. This is the source to reach for when XYZ or Lab are not enough.

## Key Points

- **Color appearance is contextual.** The same tristimulus values can look different depending on surround, adaptation state, luminance level, flare, and white point.
- **Appearance attributes are distinct.** Lightness, brightness, chroma, colorfulness, and saturation are not interchangeable.
- **Colorimetry and appearance are different layers.** XYZ/Lab describe colorimetry; appearance models predict perceived appearance under specified conditions.
- **CAM02/CAM16 matter when conditions vary.** Appearance models are the right tool for cross-media prediction, viewing-condition compensation, and more faithful perceptual mapping.

## Why This Matters for the Skill

- Best corrective when someone asks why the “same color” looks different on screen, in print, or under another light.
- Provides the precise vocabulary behind distinctions the skill already relies on: related vs unrelated colors, brightness vs lightness, chroma vs colorfulness.
- Useful boundary marker: **OKLCH/OKLAB are great working spaces**, but **CAM16/CIECAM02** are the stronger answer when surround and adaptation are part of the problem.

## Practical Use

- Use for **cross-media appearance prediction**.
- Use for **viewing-condition compensation**.
- Use for **explaining perceptual terminology rigorously**.
- Use when evaluating tools based on **CAM16-UCS** or **CIECAM02**.
