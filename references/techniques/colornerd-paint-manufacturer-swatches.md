# colornerd — 29,875 Paint Manufacturer Color Swatches

**Source:** [GitHub — jpederson/colornerd](https://github.com/jpederson/colornerd)
**Author:** jpederson (NOT the YouTube Color Nerd channel)
**npm:** `colornerd` | **Stars:** 86
**Picker:** https://jpederson.com/colornerd/

## What It Does

Library of **29,875 color swatches** from 12 major paint and color manufacturers, available as Sass/SCSS, Less, Stylus, JSON, and CSV. Zero runtime impact — colors compile directly into output.

## Supported Manufacturers

| Manufacturer         | Type                  |
| -------------------- | --------------------- |
| **Behr**             | Consumer paint        |
| **Benjamin Moore**   | Consumer/pro paint    |
| **Sherwin Williams** | Consumer/pro paint    |
| **PPG**              | Paint & coatings      |
| **Dunn Edwards**     | Paint                 |
| **Hallman Lindsay**  | Paint                 |
| **Vista**            | Paint                 |
| **RAL**              | Industrial standard   |
| **HKS**              | Printing inks         |
| **TOYO**             | Printing inks (Japan) |
| **TRUMATCH**         | CMYK color matching   |
| **Avery**            | Vinyl/wraps           |

## Usage

```scss
// SCSS
@include "node_modules/colornerd/scss/colornerd";
a {
  color: hks("36-K");
}
a {
  color: benjamin-moore("HC-172");
}
a {
  color: sherwin-williams("SW 6258");
}
```

```javascript
// JSON
import colors from "colornerd/json/benjamin-moore.json";
```

Also available as CSV for spreadsheet/data analysis.

## Why It Matters

- **Real-world pigment colors** — not theoretical swatches but actual manufacturer formulations
- **Cross-manufacturer comparison** — see how Benjamin Moore "Hale Navy" compares to Sherwin Williams "Naval"
- **Design-to-paint bridge** — use exact manufacturer colors in CSS/design tools
- **Industrial standards** — RAL, HKS, TOYO, TRUMATCH are industry references for print, manufacturing, vinyl

## Links

- **GitHub:** https://github.com/jpederson/colornerd
- **Color picker:** https://jpederson.com/colornerd/
- **npm:** `npm install colornerd`
