# Roadmap

Planned work for the skill beyond reference collection and curation.

## Color-Specific Scripts

These are intentionally planned as **future utilities**, not part of the skill yet. The goal is to add small deterministic helpers that make the skill more useful in practice without turning the repo into a large application framework.

### 1. Palette naming helper

**Goal:** Given one or more colors, return the nearest useful names from one or more dictionaries.

**Planned behavior:**

- default to querying the color.pizza API with the `bestOf` list
- allow switching to a user-preferred naming system when specified
- return multiple naming registers when useful, for example practical/UI versus historical/naturalist
- keep the output transparent about which dictionary produced each name

**Why it fits this repo:**

- color naming is one of the strongest distinctive areas of the skill
- the repo already recommends multiple naming systems and naming datasets
- a small wrapper would turn naming guidance into something executable

### 2. Contrast matrix helper

**Goal:** Given a palette, compute a readable matrix of foreground/background contrast relationships.

**Planned behavior:**

- accept a list of colors
- compute pairwise contrast values
- make it easy to inspect useful text/background pairs quickly
- ideally support both WCAG and APCA-oriented views if the implementation stays simple

**Why it fits this repo:**

- accessibility is a core trigger for the skill
- contrast checking is deterministic and repeated often enough to justify a script

### 3. Duplicate and near-duplicate detector

**Goal:** Catch colors that look too similar to function as distinct palette entries.

**Planned behavior:**

- detect exact duplicates
- detect near-duplicates in a perceptual space rather than only by raw hex equality
- report which colors are likely to collapse visually
- help identify muddy or redundant palette steps

**Why it fits this repo:**

- this is a practical palette-analysis task the skill is likely to get repeatedly
- it complements the contrast matrix and sorting work

### 4. Perceptual sorting helper

**Goal:** Sort colors into an order that feels smoother and more intentional than raw hue or hex sorting.

**Planned behavior:**

- use `colorsort-js`, which the skill already recommends
- expose a simple wrapper for palette sorting
- preserve enough metadata that the result can be explained, not just output blindly

**Why it fits this repo:**

- the repo already points to `colorsort-js` as the relevant recommendation
- a wrapper would make that recommendation easier to use in agent workflows

### 5. Ramp and scale wrapper

**Goal:** Generate a ramp or scale using one of the recommended generators, while also explaining how to reproduce the exact result.

**Planned behavior:**

- call one of the recommended libraries or generators rather than reimplementing everything from scratch
- output the final ramp in a practical format such as JSON, CSS variables, or token-like data
- include the recipe used to generate it: tool choice, anchors, options, space, and other relevant parameters
- make the result reproducible instead of being a one-off opaque output

**Why it fits this repo:**

- the skill recommends many good generators already
- a wrapper could unify them into one reproducible workflow
- reproducibility is more useful than returning a palette without provenance

## Design Constraints For Scripts

Any future script added under `scripts/` should follow these rules:

1. Be deterministic and practical.
2. Wrap or support the repo's recommendations instead of competing with them.
3. Prefer clear input/output formats over clever abstractions.
4. Make results reproducible when generation is involved.
5. Stay small enough that the skill remains a knowledge resource first, not a framework.

## Likely Build Order

If these scripts are implemented, the most useful order is likely:

1. palette naming helper
2. contrast matrix helper
3. duplicate / near-duplicate detector
4. perceptual sorting helper
5. ramp and scale wrapper

That order follows the current strengths of the repo: naming, accessibility, palette analysis, and generator recommendations.