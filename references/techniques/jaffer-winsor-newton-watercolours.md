# Aubrey Jaffer — Winsor-Newton Water-colours

**Author:** Aubrey Jaffer
**Source:** section within Color-Name Dictionaries
**URL:** https://people.csail.mit.edu/jaffer/Color/Dictionaries

## What It Is

This section covers a measured dataset of Winsor & Newton watercolor paints assembled from Richard Kirk's paint data, with three density measurements per paint.

Unlike many web color lists, the data starts in **CIE L*a*b\*** rather than in arbitrary RGB values.

## Why It Stands Out

- based on measured paint data rather than guessed screen colors
- bypasses the limitations of sRGB as a source format
- good mid-tone coverage
- no naming conflicts after normalization

Jaffer's conclusion is blunt: if an application can accept CIE L*a*b\* colors, this is **an excellent source for surface colors**.

## Key Technical Points

- none of the colors are out of CIE L*a*b\* gamut
- many are out of sRGB gamut, which shows why RGB exports alone are insufficient for paint data
- the darker octant is better populated than expected for watercolors
- the cluster of yellows may reflect either gamut limitations or pigment/transparency behavior

## Naming Notes

Winsor & Newton names are partly idiosyncratic, so Jaffer normalizes and shortens them and appends density suffixes like:

- `Light`
- `Medium`
- `Dark`

That turns the measured set into a more usable color dictionary.

## Why This Matters for the Skill

- Strong evidence for the difference between **paint measurements** and **display colors**
- Useful for discussions of gamut loss when converting pigment data into sRGB
- Good reference when the user needs a practical source of named, measured surface colors

## Practical Takeaways

- Measured L*a*b\* paint data is more trustworthy than RGB-first naming sets.
- sRGB cannot faithfully represent many real paint colors.
- For surface-color systems, good mid-tone coverage matters as much as naming convenience.
