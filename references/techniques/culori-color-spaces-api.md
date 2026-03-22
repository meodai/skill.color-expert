# Culori — Color Spaces & API Reference

**Source:** [culorijs.org](https://culorijs.org/)
**npm:** `culori` | **GitHub:** [culorijs/culori](https://github.com/culorijs/culori)

The foundational color library used by many tools in this collection (PickyPalette, dittoTones, FarbVelo, etc.).

## 30 Color Spaces

### RGB-family (have gamut limits)

| Mode       | Space                   | Channels |
| ---------- | ----------------------- | -------- |
| `rgb`      | sRGB                    | r, g, b  |
| `lrgb`     | Linear-light sRGB       | r, g, b  |
| `a98`      | Adobe RGB 1998          | r, g, b  |
| `p3`       | Display P3              | r, g, b  |
| `prophoto` | ProPhoto RGB            | r, g, b  |
| `rec2020`  | Rec. 2020               | r, g, b  |
| `hsl`      | HSL (cylindrical RGB)   | h, s, l  |
| `hsv`      | HSV (cylindrical RGB)   | h, s, v  |
| `hsi`      | HSI                     | h, s, i  |
| `hwb`      | Hue-Whiteness-Blackness | h, w, b  |

### Perceptually Uniform (no gamut limits)

| Mode    | Space              | Channels | Notes                           |
| ------- | ------------------ | -------- | ------------------------------- |
| `lab`   | CIELAB D50         | l, a, b  | Print standard illuminant       |
| `lch`   | CIELCh D50         | l, c, h  | Cylindrical CIELAB              |
| `lab65` | CIELAB D65         | l, a, b  | Screen standard illuminant      |
| `lch65` | CIELCh D65         | l, c, h  |                                 |
| `luv`   | CIELUV             | l, u, v  |                                 |
| `lchuv` | CIELCHuv           | l, c, h  | Basis for HSLuv                 |
| `oklab` | Oklab D65          | l, a, b  | Best general-purpose perceptual |
| `oklch` | Oklab cylindrical  | l, c, h  | **Recommended for most work**   |
| `okhsl` | Oklab-based HSL    | h, s, l  | Gamut-mapped HSL                |
| `okhsv` | Oklab-based HSV    | h, s, v  | Gamut-mapped HSV                |
| `dlab`  | DIN99o             | l, a, b  | German industrial standard      |
| `dlch`  | DIN99o cylindrical | l, c, h  |                                 |
| `jab`   | Jzazbz             | j, a, b  | HDR-capable                     |
| `jch`   | Jzazbz cylindrical | j, c, h  |                                 |

### Specialized (no gamut limits)

| Mode        | Space         | Channels | Notes                      |
| ----------- | ------------- | -------- | -------------------------- |
| `xyz50`     | CIE XYZ D50   | x, y, z  | Foundation reference space |
| `xyz65`     | CIE XYZ D65   | x, y, z  |                            |
| `yiq`       | YIQ (NTSC)    | y, i, q  | TV broadcast legacy        |
| `xyb`       | XYB (JPEG XL) | x, y, b  | LMS-based                  |
| `itp`       | ICtCp (Dolby) | i, t, p  | HDR perceptual             |
| `cubehelix` | Cubehelix     | h, s, l  | Astronomical visualization |

## API by Category

### Parse & Convert

```javascript
parse("#ff6600"); // → { mode: 'rgb', r: 1, g: 0.4, b: 0 }
converter("oklch")(color); // → convert any color to OKLCH
formatHex(color); // → '#ff6600'
formatCss(color); // → CSS Color Level 4 string
```

### Gamut Mapping

```javascript
displayable(color); // is it in sRGB?
clampChroma(color, "oklch", "rgb"); // reduce chroma until displayable
toGamut("rgb", "oklch"); // CSS Color L4 gamut mapping algorithm
inGamut("p3")(color); // check any gamut
```

### Interpolation (gradients & palettes)

```javascript
interpolate(["red", "blue"], "oklch"); // smooth gradient function
interpolate([["red", 0], ["green", 0.3], "blue"], "oklch"); // positioned stops
// Spline methods: linear, basis, natural, monotone (+ closed variants)
// Hue fixup: shorter, longer, increasing, decreasing
// Easing: smoothstep, gamma, midpoint, in-out-sine
samples(10); // [0, 0.11, 0.22, ..., 1]
```

### Color Difference (10 metrics)

```javascript
differenceEuclidean("oklch"); // general purpose
differenceCiede2000(); // gold standard perceptual
differenceCie76(); // = Euclidean in Lab65
differenceCie94(); // improved CIE76
differenceCmc(); // textile industry (asymmetric!)
differenceHyab(); // best for large differences
differenceItp(); // HDR
differenceKotsarenkoRamos(); // image processing (YIQ weighted)
nearest(colors, metric, accessor); // find N nearest within threshold
```

### Blending (12 modes)

```javascript
blend([bg, fg], "multiply", "rgb");
// Modes: normal, multiply, screen, overlay, darken, lighten,
//        color-dodge, color-burn, hard-light, soft-light,
//        difference, exclusion
```

### Color Vision Deficiency

```javascript
filterDeficiencyProt(1.0)(color); // protanopia simulation
filterDeficiencyDeuter(0.5)(color); // deuteranomaly (partial)
filterDeficiencyTrit(1.0)(color); // tritanopia
// severity: 0 = normal, 1 = full deficiency
```

### CSS Filters

```javascript
filterBrightness(1.5)(color);
filterContrast(0.8)(color);
filterSaturate(2.0)(color);
filterGrayscale(1.0)(color);
filterSepia(0.5)(color);
filterInvert(1.0)(color);
filterHueRotate(90)(color);
```

### WCAG

```javascript
wcagLuminance(color); // relative luminance
wcagContrast(colorA, colorB); // contrast ratio
```

### Utilities

```javascript
average(colors, 'oklch')            // arithmetic mean
random('oklch', { l: [0.5, 0.8] }) // random with constraints
mapper(fn, 'oklch')                 // channel mapping
lerp(a, b, t)                      // linear interpolation
blerp(...)                          // bilinear
trilerp(...)                        // trilinear
round(4)(0.123456789)               // → 0.1235
```

## Key Insights for the Skill

- **30 color spaces** from one library — no need to manually implement conversions
- **OKLCH is the recommended default** for most tasks (perceptually uniform, intuitive cylindrical)
- **10 different distance metrics** — use CIEDE2000 for precision, Euclidean OKLCH for speed
- **Gamut mapping matters** — `clampChroma` (fast) vs `toGamut` (CSS L4 algorithm, more accurate)
- **Interpolation in perceptual space** prevents the RGB darkening problem
- **CVD simulation** built in — test accessibility without external tools
- `lab` = D50 illuminant (print), `lab65` = D65 (screen) — know which you need

## Links

- **Docs:** https://culorijs.org/
- **Color spaces:** https://culorijs.org/color-spaces/
- **API:** https://culorijs.org/api/
- **GitHub:** https://github.com/culorijs/culori
