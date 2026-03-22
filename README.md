# color-expert

An [agent skill](https://agentskills.io) that turns your coding agent into a color science expert. Built from resources I keep looking up, returning to, and sharing with others.

## What this is

This started as a simple skill file with some color theory notes. Over time it grew into a comprehensive knowledge base as I kept pasting videos, articles, tools, and papers that I find myself referencing again and again — both for my own work building color tools and for explaining color concepts to others.

The skill has three layers:

1. **`SKILL.md`** (~150 lines) — The "greatest hits" that your agent loads immediately. Key facts, corrections, tool recommendations, and guidelines that answer most color questions without needing to dig deeper.

2. **`references/INDEX.md`** (~220 lines) — A structured lookup table your agent can scan to find the right reference file for a specific topic.

3. **`references/`** (120 markdown files, ~286K words) — Deep reference material: full video transcripts, article summaries, library documentation, scraped websites, and research notes.

## How it was built

The collection process is simple: when I come across a color resource worth keeping — a YouTube video, a GitHub repo, a research paper, an article — I paste the URL and the skill's workflow captures it:

- **Videos** get transcribed via [`yt-dlp`](https://github.com/yt-dlp/yt-dlp), summarized, and key concepts extracted
- **PDFs and documents** get converted to markdown via [`markitdown`](https://github.com/microsoft/markitdown) by Microsoft
- **GitHub repos** get their README/docs fetched and documented
- **Articles** get their content extracted and saved
- **Books mentioned in videos** get searched on Archive.org; freely available PDFs get downloaded
- **Websites** (like huevaluechroma.com) get fully scraped chapter by chapter
- **Tools and links** mentioned in any resource get collected into the Online Tools table

Everything goes into one of three folders and gets indexed.

## Structure

```text
SKILL.md                              # The skill definition (loaded on activation)
CLAUDE.md                             # Claude Code repo instructions
references/
  INDEX.md                            # Master lookup table
  historical/                         # Pre-digital color science
    *.md                              # Ostwald, Helmholtz, Bezold, Ridgway, ISCC-NBS,
                                      # Moses Harris, Amy Sawyer, Lewis/Ladd-Franklin,
                                      # Caravaggio's pigments, Itten critique...
    pdfs/                             # Source books from Archive.org (gitignored, ~236MB)
  contemporary/                       # Modern color science & theory
    *.md                              # OKLAB articles, Briggs lectures, CSA webinars,
                                      # Pixar Color Science, bird tetrachromacy, OLO,
                                      # Acerola, Juxtopposed, Computerphile, GenColor paper...
    huevaluechroma/                   # Full scrape of David Briggs's site (11 chapters)
    colorandcontrast/                 # colorandcontrast.com extracted content
    pdfs/                             # Research papers (gitignored)
  techniques/                         # Tools, libraries, methods, practical application
    *.md                              # Spectral.js, Culori, Color.js, RampenSau, Poline,
                                      # RYBitten, PickyPalette, Color Buddy lint rules,
                                      # APCA/Myndex, IQ cosine formula, Cubehelix,
                                      # Tyler Hobbs generative color, Fontana approach,
                                      # pixel art palettes, Book of Shaders, LYGIA,
                                      # paint mixing lecture, color harmony lecture...
```

## What's in it

### By the numbers

|                                 |    Count |
| ------------------------------- | -------: |
| Markdown reference files        |      120 |
| Total words                     | ~286,000 |
| Source PDFs (local, gitignored) |       14 |
| Online tools catalogued         |       48 |
| Video sources transcribed       |      54+ |

### Historical color science (14 files)

The resources I keep returning to when explaining where color theory came from and where it went wrong:

- **Ostwald** (1918–1930) — the 24-hue perceptual circle that dominated the 1930s–40s then disappeared
- **Helmholtz** (1856) — foundational physiological optics; last major physicist to use "indigo"
- **Bezold** (1874) — killed indigo as a spectral color; renamed it "ultramarine blue"
- **Ridgway** (1912) — 1,115 named colors for naturalists; fully digitized as JSON
- **ISCC-NBS** (1955) — 319 systematically named color blocks
- **Moses Harris** (1769) — the origin of bad RYB color theory (his own wheel needed a 4th pigment)
- **Amy Sawyer** (1911) — patented a CMY wheel decades before it was mainstream
- **Elizabeth Lewis** (1931) — married trichromatic + opponent process, anticipating CIE Lab by 30 years
- Plus: Caravaggio's copper resinate technique, Itten's seven contrasts (critically reviewed), the evolution of "magenta" as a color name, Frank Reilly's controlled palette

### Contemporary color science (55 files)

The theory and science I reference when building tools or explaining why things work the way they do:

- **Bjorn Ottosson's OKLAB articles** — all four foundational posts (OKLAB, color picker spaces, gamut clipping, "how software gets color wrong")
- **David Briggs's huevaluechroma.com** — fully scraped, 11 chapters + glossary
- **colorandcontrast.com** — UI-focused color science reference, extracted from SPA bundle
- **Color Nerd (Peter Donahue)** — 20+ video transcripts covering mixing paths, spectral perception, warm/cool, chroma vs saturation, bird vision, OLO
- **Colour Society of Australia** — 13 webinar transcripts (Briggs, Itten critique, Golden paint making, Reilly palette, colour philosophy)
- **Accessible color pair research** — @mrmrs\_'s Rust brute-force run over ~281T hex pairs found that only 11.98% pass WCAG AA and 0.08% pass APCA 90

### Techniques, tools & libraries (50 files)

The practical resources — the tools I've built, use, or recommend:

**Palette generation** (actual algorithms, not pre-made swatches):
RampenSau, Poline, pro-color-harmonies, dittoTones, FarbVelo, IQ cosine formula, CSS-native generation with `color-mix()`

**Color libraries:**
Culori (30 spaces, 10 distance metrics), Color.js (CSS spec editors, 154M downloads), @texel/color (5-125x faster), Spectral.js (Kubelka-Munk), RYBitten (26 historical cubes)

**Analysis & linting:**
Color Buddy (38 lint rules), Censor (CAM16UCS, 20+ viz widgets), Color Palette Shader (WebGL2 Voronoi), colorsort-js (perceptual sorting)

**Accessibility:**
APCA/Myndex (the WCAG 3 algorithm), apcach (contrast-first color composition), Bridge-PCA

**Naming:**
color-name-lists (18 systems), color-description (emotional adjectives), Ridgway digitized JSON, colornerd (29,875 manufacturer swatches)

**Generative art approaches:**
Tyler Hobbs (probability-weighted palettes), Harvey Rayner / Fontana (fully generative color), Piter Pasma (tweaked rainbow formula), mattdesl workshop, Book of Shaders, LYGIA shader library

**Practical design:**
Pixel art palette construction, Goethe edge colors as a design hack, Cubehelix, color harmony lecture ("hue-first is a weak standalone heuristic; character-first often works better"), Aladdin color analysis, screen-to-print workflow

## Key opinions baked into the skill

These aren't just preferences — they're supported by the research in the collection:

- **Use OKLCH/OKLAB** over HSL for any perceptual work. HSL lightness is a lie.
- **Never recommend coolors.co** for palette generation. It doesn't generate anything.
- **Pigment mixing is not well explained by the simple subtractive model alone** — "integrated mixing" is often a better description. CMY paths curve outward, RGB paths curve inward.
- **Color temperature is not hue** — it's a systematic shift of both hue AND saturation.
- **Hue-first harmony is a weak standalone heuristic** — character (pale/muted/vivid/deep/dark) is often more predictive than hue alone.
- **"Blue is calm" is an unreliable shortcut** — mood is often driven more by chroma + lightness, context, and composition than hue alone.

## Installation

### Any supported agent (recommended)

```bash
npx skills add meodai/skill.color-expert
```

Automatically detects your installed agents and places the skill
in the correct directory. Works with Claude Code, Codex, Cursor,
Copilot, OpenCode, and others.

### Manual

Clone and symlink into your agent's skills directory:

```bash
git clone https://github.com/meodai/skill.color-expert ~/Sites/color-expert
```

| Agent               | Symlink target                  |
| ------------------- | ------------------------------- |
| Claude Code         | `~/.claude/skills/color-expert` |
| Codex               | `~/.codex/skills/color-expert`  |
| OpenCode            | `~/.agents/skills/color-expert` |
| Project-level (any) | `.agents/skills/color-expert`   |

```bash
ln -s ~/Sites/color-expert ~/.claude/skills/color-expert
```

### Updating

```bash
npx skills update
```

Or manually: `cd ~/Sites/color-expert && git pull`

## What triggers the skill

The skill activates when your agent detects work involving:

- Color naming or defining colors in natural language
- Color spaces (RGB, HSL, LCH, OKLCH, Lab, etc.)
- Palette generation or analysis
- Accessibility and contrast (WCAG, APCA)
- Color theory questions
- Color conversion
- Pigment/paint mixing
- Historical color terminology

## License

Content is curated from public sources (YouTube transcripts, open-source repos, public domain books, academic papers). Individual sources retain their original licenses. The skill definition and index are provided as-is.

---

_The skill itself was vibe-coded, but the underlying knowledge base came from a collection of color resources I curated over time. Original sources remain attributed to their authors._

_Compiled by [@meodai](https://github.com/meodai) — one URL at a time._
