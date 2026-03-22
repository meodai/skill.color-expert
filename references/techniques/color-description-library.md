# color-description — Human-Readable Color Descriptions

**Source:** [GitHub — words/color-description](https://github.com/words/color-description)
**License:** MIT
**npm:** `color-description`

## What It Does

Converts technical color values (hex, RGB, HSL) into **human-readable descriptive adjectives** capturing the psychological and aesthetic qualities of colors.

```javascript
import ColorDescription from "color-description/dist/index.esm";

const cd = new ColorDescription("#ffffff");
cd.getDescriptiveList();
// → ["pale", "light", "faded", "delicate", "glistening", "bleached"]

cd.color = "red";
cd.getDescriptiveList();
// → ["saturated", "strong", "lush", "ablaze", "beaming", "bold", "brilliant", "vibrant", "vivid"]

cd.getColorFamily();
// → "red"
```

## API

| Method                        | Returns                                           |
| ----------------------------- | ------------------------------------------------- |
| `new ColorDescription(color)` | Constructor — accepts hex, RGB, HSL, named colors |
| `.getDescriptiveList()`       | Array of descriptive adjectives                   |
| `.getColorFamily()`           | Color category name (e.g., "red", "blue")         |
| `.color`                      | Getter/setter for current color                   |

## Data Sources

- **Color psychology** — colorpsychology.org, academic research, Wikipedia
- **HSL/HSV hue wheels** — 24 named hues
- **Curated adjective databases** — from human color perception studies
- **Western perspective** — reflects contemporary English color associations (culturally specific)

## Relevance to Color Naming

This library approaches color from the **linguistic/emotional** side rather than the scientific naming systems (ISCC-NBS, Munsell). It answers a different question:

- ISCC-NBS: "What IS this color?" → "vivid yellowish green"
- color-description: "How does this color FEEL?" → "lush, vibrant, bold"

Both perspectives useful for color naming tasks — technical precision vs emotional resonance.

## Links

- **GitHub:** https://github.com/words/color-description
- **npm:** `npm install color-description`
