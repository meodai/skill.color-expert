# Triggering Policy

`trigger-evals.json` is only useful if it encodes a rule rather than a set of hunches. This is
the rule it encodes.

## The test

**Trigger when the task needs a colour-quality judgment the agent would otherwise get wrong.**

That means any task where the answer depends on:

- which colour space to work in (perceptual spacing, interpolation, gamut)
- whether two colours are distinguishable, readable, or safe under CVD
- how colours mix (light vs pigment)
- what a colour should be called
- which colours to choose in the first place

**Do not trigger when the colour is incidental** — the colours are already decided and the work
is plumbing, layout, copy, tooling, or an unrelated bug. A task can mention colour heavily and
still be incidental: forwarding a `color` prop, persisting a theme choice to `localStorage`, or
moving hard-coded hexes into a config object are refactors, not colour decisions.

## Why the boundary sits there

The frontmatter description is deliberately broad, because the expensive failure is the skill
*not* loading when an agent is about to pick a muddy mid-gradient or ship 2.1:1 body text. The
cheap failure is loading it during a refactor that happens to touch hex values.

So the negatives in the eval set are not "tasks that mention colour." They are tasks where
loading the skill would add tokens and change nothing about the answer. If you find yourself
arguing that a negative case *might* benefit from the skill, it is probably a positive — flip it
and record why.

## Field meanings in `trigger-evals.json`

| Field | Meaning |
| --- | --- |
| `query` | The user's prompt, written the way people actually type |
| `should_trigger` | Expected outcome under the test above |
| `kind` | `colour-decision` (always `true`), `colour-incidental` or `not-colour` (always `false`) |
| `why` | One line: which judgment is at stake, or why there isn't one |

`kind` and `should_trigger` must agree — `colour-decision` implies `true`, the other two imply
`false`. That consistency is the thing to check first when editing the file.

## Known edge cases

These are the cases that were argued over, recorded so they are not silently re-flipped:

- **Colour picker component.** Counted as a positive. "No external dependencies" means the
  conversions get hand-rolled, and which space the picker exposes (OKHSL vs HSL) is exactly the
  judgment the skill exists to supply.
- **Theme switcher with persistence.** Counted as a negative. The palettes already exist; the
  task is state management.
- **Dashboard from a brand palette.** Counted as a positive. Assigning given colours to series
  still needs adjacent-contrast and CVD reasoning, which is a judgment, not plumbing.
- **"Make this chart more readable, reduce visual clutter."** Counted as a negative, narrowly —
  no colour is named and clutter is mostly layout. If the prompt said "the series are hard to
  tell apart," it would be a positive.
