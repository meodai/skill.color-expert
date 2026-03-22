# color-name-lists — Aggregated Color Naming Systems

**Source:** [GitHub — meodai/color-name-lists](https://github.com/meodai/color-name-lists)
**Author:** meodai
**npm:** `color-name-lists`
**Demo:** https://codepen.io/meodai/full/vYddvLB

## What It Does

JavaScript package aggregating **18 distinct color naming systems** from historical, cultural, scientific, and digital sources into a single importable collection.

## API

```javascript
import { colorNameLists } from "color-name-lists";

colorNameLists.lists; // object of all lists
colorNameLists.meta; // description of each list
```

## Included Color Name Lists

### Scientific & Standardized

| List                                  | Description                                                              |
| ------------------------------------- | ------------------------------------------------------------------------ |
| **ISCC-NBS Universal Color Language** | 12-color designation system from Inter-Society Color Council             |
| **Robert Ridgway's Standards (1912)** | Public domain nomenclature of colors for naturalists (Project Gutenberg) |
| **RAL Color**                         | Industrial color matching standards                                      |
| **Werner's Nomenclature**             | Late 18th-century scientific color collection (Abraham Gottlob Werner)   |

### Digital & Web

| List                         | Description                                                |
| ---------------------------- | ---------------------------------------------------------- |
| **HTML Colors**              | CSS/HTML/SVG keyword colors (W3C)                          |
| **X11 Color Names**          | Standard Xlib/X11 protocol colors                          |
| **XKCD Colors**              | 954 survey-defined RGB colors from randall munroe's survey |
| **Microsoft Windows Colors** | Legacy system colors                                       |
| **OS X Crayons**             | macOS color picker interface                               |
| **NTC.js**                   | 2007 library combining Wikipedia + X11 + Crayola           |

### Cultural & Historical

| List                            | Description                                        |
| ------------------------------- | -------------------------------------------------- |
| **Traditional Colors of Japan** | Historically significant Japanese aesthetic colors |
| **Traditional Colors of China** | Forbidden City aesthetic palette                   |
| **Wada Sanzō Dictionary**       | Japanese color dictionary Volume I                 |
| **Le Corbusier**                | Architectural color system (63 colors)             |

### Creative & Artistic

| List                      | Description                                                   |
| ------------------------- | ------------------------------------------------------------- |
| **The Color Thesaurus**   | Writer-curated emotional color associations (Ingrid Sundberg) |
| **Wikipedia Color Names** | Crowdsourced color terminology                                |
| **Risograph Colors**      | 35+ printer-specific ink colors                               |
| **Basic**                 | Fundamental named colors                                      |

## Why This Matters for Color Naming

Different naming systems serve different purposes:

- **ISCC-NBS** → systematic scientific precision ("vivid yellowish green")
- **XKCD** → common human perception ("ugly yellow", "hospital green")
- **Traditional Japanese** → cultural/poetic resonance ("wasurenagusa-iro" = forget-me-not color)
- **RAL** → industrial reproducibility (RAL 5002 = ultramarine blue)
- **Werner's** → historical naturalist description ("asparagus green", "honey yellow")
- **Ridgway** → ornithological color matching (1912, public domain)

Having all systems in one package enables:

- **Nearest-name lookup** across multiple cultural/technical contexts
- **Cross-referencing** — same hex value, different names in different systems
- **Choosing the right register** — technical vs poetic vs casual naming

## Related Projects

- **[color-description](color-description-library.md)** — hex → emotional adjectives (different approach: describes character, not names)
- **ISCC-NBS Centroid Picker** — Peter Donahue's interactive tool for ISCC-NBS names
- **[ISCC-NBS Circular 553](../historical/pdfs/iscc-nbs-circular-553.pdf)** — the original 1955 dictionary

## Links

- **GitHub:** https://github.com/meodai/color-name-lists
- **npm:** `npm install color-name-lists`
- **CodePen demo:** https://codepen.io/meodai/full/vYddvLB
