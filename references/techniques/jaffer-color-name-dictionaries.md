# Aubrey Jaffer — Color-Name Dictionaries

**Author:** Aubrey Jaffer
**Source:** MIT CSAIL guest page
**URL:** https://people.csail.mit.edu/jaffer/Color/Dictionaries

## What It Is

This is one of the better technical audits of online color-name dictionaries. Jaffer does not just collect lists of names; he evaluates how usable they are for real color work.

The page compares many systems in terms of:

- coverage in RGB and CIELAB space
- duplicate names
- suitability for **surface colors** versus **light-source colors**
- whether colors were chosen from a naive RGB grid
- whether dark colors are badly underrepresented
- whether named colors sit outside realistic print or reflective gamuts

## Core Argument

Most online color-name dictionaries inherited bad assumptions from the Windows VGA palette and X11 `rgb.txt`:

- common names assigned to RGB-cube extremes
- too many colors outside print or reflective-surface gamut
- weak representation of dark colors
- duplicated or inconsistent naming

Jaffer argues that this makes many web-era named-color systems poor choices for **surface colors**, even if they are familiar.

## Important Distinction

One of the most useful ideas on the page is the split between:

- **surface-color dictionaries**
- **light-source dictionaries**

That distinction is strong and practical. A dictionary suitable for glowing pixels or additive displays may be inappropriate for paint, materials, or other reflective colors.

## Evaluation Methods

Jaffer uses several ways to inspect dictionaries:

- catalogs laid out in perceptual order
- RGB-cube plots to reveal grid bias and missing dark regions
- CIELAB-space plots to judge coverage and uniformity
- duplicate-name counts and provenance tracing

This makes the page valuable as a method reference, not only as a source of lists.

## Key Conclusions

- **X11 and VGA-derived systems are historically influential but technically weak**
- **CSS/HTML named colors inherit major problems from legacy palettes**
- **Resene, NBS-ISCC centroids, Winsor-Newton, and saturate** are the strongest dictionaries on the page, each for different purposes
- Good named-color systems should have explicit provenance, fewer conflicts, and better alignment with physically realizable colors

## Why This Matters for the Skill

- Strong companion to [techniques/color-name-lists.md](techniques/color-name-lists.md), which catalogs systems but does not critique them this deeply
- Reinforces the skill's preference for **physically plausible surface colors** over RGB-cube folklore
- Useful when explaining why familiar web color names can be misleading or historically contingent

## Practical Takeaways

- Do not treat legacy web named colors as a neutral standard.
- Separate naming systems for **display/light** and **surface/material** use cases.
- When choosing a color-name dataset, check its gamut realism, duplicate rate, and dark-tone coverage.
