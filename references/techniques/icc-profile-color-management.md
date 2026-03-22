# ICC Profiles — PCS, Rendering Intents, and Color Management

**Source:** International Color Consortium — Introduction to the ICC profile format
**Overview:** https://www.color.org/iccprofile.xalter
**Spec:** http://www.color.org/specification/ICC.1-2022-05.pdf

## What It Is

The canonical framework for **device characterization and cross-device color conversion**. ICC profiles are what make color management operational across scanners, cameras, displays, printers, and documents.

## Key Points

- **Profiles connect device spaces to a device-independent PCS.** ICC v4 uses a **D50-based Profile Connection Space**.
- **PCS decouples transforms.** Input and output profiles can be created independently and paired later by a color management module.
- **Rendering intents are trade-offs, not magic.** Relative colorimetric, absolute colorimetric, perceptual, and saturation serve different goals.
- **Viewing conditions matter.** ICC explicitly accounts for reference media, adaptation, flare, and viewing environment assumptions.
- **Embedded profiles preserve meaning.** The same numbers can represent different colors if they belong to different spaces.

## Why This Matters for the Skill

- Best reference for explaining why **screen RGB values do not directly equal print appearance**.
- Clarifies why **D50** shows up in print workflows and **Lab editing**.
- Useful when answering questions about **proofing**, **gamut mapping**, **profile mismatches**, and **soft proof** workflows.

## Practical Use

- Use for **screen-to-print** or **multi-device** workflows.
- Use when a user asks what an **ICC profile** actually does.
- Pair with Hunt, Fairchild, and CSS Color 5 when discussing **calibrated CMYK** or **browser-accessible color management**.
