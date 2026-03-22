# CSS-Native Color Generation Technique

**Author:** @meodai
**Approach:** Generate color palettes entirely in CSS using `oklch()` + `color-mix()` — no JS color library needed for the final output.

## Core Idea

Generate base colors in OKLCH, then use CSS `color-mix()` to interpolate between them. The browser does the perceptual mixing — no need to compute intermediate colors in JS.

## Key Functions

### Generate a Hue Ramp

```javascript
const generateHxxRamp = (colors = 4, minHueDiffAngle = 60) => {
  minHueDiffAngle = Math.min(minHueDiffAngle, 360 / colors);
  const baseHue = Math.random() * 360;
  const huesToPickFrom = new Array(Math.round(360 / minHueDiffAngle))
    .fill("")
    .map((_, i) => (baseHue + i * minHueDiffAngle) % 360);
  // Remove random hues until we have the desired count
  while (huesToPickFrom.length > colors) {
    const randomIndex = Math.floor(Math.random() * huesToPickFrom.length);
    huesToPickFrom.splice(randomIndex, 1);
  }

  // Randomized lightness/chroma ranges
  const { minLightness, lightnessRange, minChroma, chromaRange } =
    chromaLightnessRamp();

  const invertedChromaRamp = Math.random() < 0.5;

  return huesToPickFrom.map((hue, i) => {
    const relI = i / (colors - 1);
    let chromaRamp = invertedChromaRamp ? 1 - relI : relI;
    return {
      lightness: minLightness + relI * lightnessRange,
      chroma: minChroma + chromaRamp * chromaRange,
      hue,
    };
  });
};
```

### Convert to CSS OKLCH

```javascript
const hxxToCSSokLCH = ({ hue, chroma, lightness }) =>
  `oklch(${(lightness * 100).toFixed(2)}% ${(chroma * 0.4).toFixed(4)} ${hue.toFixed(2)})`;
```

### Scale Array with CSS color-mix() Interpolation

```javascript
const scaleSpreadArray = (initial, targetSize, fillFunction = lerp) => {
  const valuesToAdd = targetSize - initial.length;
  const chunkArray = initial.map((value) => [value]);
  for (let i = 0; i < valuesToAdd; i++) {
    chunkArray[i % (initial.length - 1)].push(null);
  }
  for (let i = 0; i < chunkArray.length - 1; i++) {
    const currentChunk = chunkArray[i];
    const nextChunk = chunkArray[i + 1];
    for (let j = 1; j < currentChunk.length; j++) {
      const percent = j / currentChunk.length;
      currentChunk[j] = fillFunction(percent, currentChunk[0], nextChunk[0]);
    }
  }
  return chunkArray.flat();
};
```

### Generate Final Palette (CSS-native)

```javascript
const generateColors = (
  colorsToGenerate,
  colorsFinal,
  minHueDiffAngle = 60,
  mixIn = "oklab",
) => {
  const baseColors = generateHxxRamp(colorsToGenerate, minHueDiffAngle);
  const cssColorStops = baseColors.map(hxxToCSSokLCH);
  return colorsFinal > colorsToGenerate
    ? scaleSpreadArray(
        cssColorStops,
        colorsFinal,
        (percent, lastValue, nextValue) =>
          `color-mix(in ${mixIn}, ${nextValue} ${(percent * 100).toFixed(2)}%, ${lastValue})`,
      )
    : cssColorStops;
};
```

### Hard Stops Gradient

```javascript
const hardStopsGradient = (arrOfColors) => {
  const l = arrOfColors.length;
  return arrOfColors
    .map(
      (c, i) =>
        `${c} ${((i / l) * 100).toFixed(2)}% ${(((i + 1) / l) * 100).toFixed(2)}%`,
    )
    .join(",");
};
```

## Output Example

The `generateColors(3, 8)` call produces 3 base OKLCH colors, then fills in 5 intermediate steps using `color-mix(in oklab, ...)`:

```css
oklch(15.23% 0.0412 247.33)
color-mix(in oklab, oklch(52.18% 0.1200 120.55) 33.33%, oklch(15.23% 0.0412 247.33))
color-mix(in oklab, oklch(52.18% 0.1200 120.55) 66.67%, oklch(15.23% 0.0412 247.33))
oklch(52.18% 0.1200 120.55)
color-mix(in oklab, oklch(89.44% 0.0087 43.21) 50.00%, oklch(52.18% 0.1200 120.55))
oklch(89.44% 0.0087 43.21)
```

## Why This Approach Is Interesting

1. **No color library dependency** for the final CSS — `color-mix()` and `oklch()` are native CSS
2. **Browser does the perceptual mixing** in OKLAB — no JS computation needed for intermediates
3. **Chroma can invert relative to lightness** — sometimes dark=vivid light=muted, sometimes the reverse
4. **`scaleSpreadArray` is reusable** — works for any interpolation, not just color (also in RampenSau)
5. **Blend modes** (multiply, hard-light, soft-light, plus-lighter) add another dimension of variation
