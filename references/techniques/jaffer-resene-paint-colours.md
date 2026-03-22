# Aubrey Jaffer — Resene Paint Colours

**Author:** Aubrey Jaffer
**Source:** section within Color-Name Dictionaries
**URL:** https://people.csail.mit.edu/jaffer/Color/Dictionaries

## What It Covers

Jaffer's Resene section evaluates Resene's paint-color lists as one of the strongest sources of **surface color names** available online.

## Why He Likes It

- very broad coverage, with more than 1300 colors
- good spread through CIELAB space
- the obvious additive primaries are absent, which is appropriate for physically realizable paints
- breadth and organization make it more useful than many ad hoc web dictionaries

The key judgment is simple: **Resene is an excellent source for surface colors**.

## Important Caveat

Jaffer distinguishes between the earlier Resene list and the later Resene-2010 update.

For the older list, he notes technical flaws:

- whitepoint too high, causing too many 255 channel values
- blackpoint too low, causing too many 0 channel values
- some colors outside sRGB gamut do not reproduce faithfully

He still considers the overall system strong, but prefers the moderated later values for practical digital use.

## Why This Matters

- Good reference when you want a **paint-derived naming system** instead of one built from RGB grid corners
- Useful corrective to web-color defaults that overemphasize saturated additive primaries
- Relevant to palette naming, material design references, and any workflow that wants realistic surface colors rather than fluorescent screen colors

## Practical Takeaways

- Resene is a better source for **surface-color naming** than most legacy web dictionaries.
- Even a strong paint dictionary still needs scrutiny around whitepoint, blackpoint, and gamut conversion.
- For digital usage, prefer measured or moderated values over raw legacy RGB exports.
