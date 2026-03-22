# PickyPalette — Interactive Color Palette Sculpting

**Source:** [GitHub — meodai/pickyPalette](https://github.com/meodai/pickyPalette)
**Author:** meodai
**Demo:** https://pickypalette.color.pizza/
**License:** PolyForm Noncommercial 1.0.0

## What It Does

Interactive color palette tool where **the canvas IS the instrument**. Users sculpt color arrangements directly on a color model visualization — dragging colors on the space reshapes the entire palette dynamically. Uses perceptual distance metrics to determine how colors claim territory (Voronoi-like regions from the palette-shader library).

## How It Works

- Colors placed on a 2D cross-section of a 3D color space
- Each color "claims" nearby territory based on perceptual distance
- Moving one color reshapes ALL regions — see palette balance in real-time
- Third dimension controlled via slider/scroll
- Built on **palette-shader** (WebGL2 Voronoi rendering) + **culori** (color math)

## Key Features

- **Multiple color spaces:** OKHsl, OKLab, HSL, and more
- **Multiple distance metrics:** OKLab, ΔE2000, RGB
- **sRGB gamut clipping** — hide out-of-gamut in wide-gamut models
- **ML-trained auto-sorting** via colorsort-js (3+ colors)
- **Hex import/export** — paste comma/space-separated values
- **URL-based sharing** — entire palette + settings encoded in URL
- **Design tool export** — Figma, Aseprite, Blender via Token Beam protocol
- **Undo support** (Cmd+Z)

## Interaction

| Input        | Action                  |
| ------------ | ----------------------- |
| Double-click | Add color               |
| Click        | Select nearest color    |
| Drag         | Move selected color     |
| 1 / 2 / 3    | Switch display axis     |
| Scroll       | Adjust 3rd dimension    |
| Alt/Option   | Reveal raw color space  |
| Shift+Alt    | Isolate single color    |
| Cmd+hover    | Preview new color       |
| P            | Toggle position markers |
| Delete       | Remove color            |

## Built With

| Component          | Purpose                                  |
| ------------------ | ---------------------------------------- |
| **palette-shader** | WebGL2 Voronoi region rendering          |
| **culori**         | Color space conversions                  |
| **colorsort-js**   | ML-trained color sorting                 |
| **Token Beam**     | Real-time design token sync (Figma etc.) |

## Why It Matters

Traditional color pickers show one color at a time. PickyPalette shows the **entire palette in context** — you see immediately:

- How much color space each palette entry "owns"
- Whether colors are too similar (tiny regions)
- Whether the palette is balanced across the space
- What happens to the whole palette when you adjust one color

## Links

- **Live demo:** https://pickypalette.color.pizza/
- **GitHub:** https://github.com/meodai/pickyPalette
- **Token Beam:** https://tokenbeam.dev
- **palette-shader (rendering engine):** https://github.com/meodai/color-palette-shader
