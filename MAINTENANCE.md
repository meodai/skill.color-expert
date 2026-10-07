# Maintenance Guide

Use this file when extending or reviewing the skill.

## What Belongs in Each Layer

### `SKILL.md`

Put only the highest-leverage guidance here:

- concepts the agent should reach for repeatedly
- corrections to common misconceptions
- short recommendation tables
- compact tool recommendations
- distinctions that change the answer materially

Keep it concise. If a section starts reading like notes for a lecture, it probably belongs in `references/`.

Keep it concise in bytes, not just in tone. `SKILL.md` and `references/INDEX.md` are the two files
an agent pays for on almost every color task, so treat their size as a budget: run
`scripts/stats.sh`, and if either drifts much past ~35 KB (~9K tokens) move detail down a layer
rather than letting the always-loaded layer absorb it. The per-directory indexes exist for exactly
this — they can be as long as they need to be, because they are opened on purpose.

### `references/`

Put deeper material here:

- source summaries
- transcripts
- detailed implementation notes
- historical context
- library and spec documentation

Each reference should justify its presence by being either authoritative, unusually clarifying, or practically useful.

Most reference files are written summaries. A few are near-verbatim site scrapes kept for fidelity
(`contemporary/huevaluechroma/`, `contemporary/colorandcontrast/`); those carry machine-extracted
text with original line breaks, so they read roughly and some are very large. If a scrape is the
only copy of something worth keeping, keep it — but give it a written summary at the top rather
than expecting an agent to read 80K tokens of raw extraction, and say so in `SECURITY.md` rather
than describing the whole directory as curated.

### `evals/`

Put realistic prompts here for checking two things:

- whether the skill should trigger
- whether it gives the right level and shape of answer

These files are for human review, not rigid benchmarking.

## Source Quality Bar

Prefer sources in this order when possible:

1. primary papers, standards, official specs, original books
2. authoritative secondary explainers with strong citations
3. high-signal practical resources that correct common mistakes or expose real workflows

Avoid adding a source just because it is popular. Keep it if it adds one of these:

- a concept the skill otherwise lacks
- a better explanation than existing sources
- a practical tool or workflow the skill can recommend
- an important corrective to a widespread misconception

## Keep `SKILL.md` Opinionated, But Defensible

The skill should make choices. It should not flatten everything into "it depends." But recommendations need a reason behind them.

Good:

- recommend OKLCH for perceptual ramps because lightness and chroma behave more predictably than HSL
- recommend CAM16 or CIECAM02 when viewing conditions are part of the problem

Weak:

- list many spaces without telling the agent when each one is the right tool
- repeat folk design advice without a perceptual or workflow reason

## Review Rubric

Use this checklist when reviewing edits:

### 1. Trigger clarity

- Would the frontmatter description catch adjacent real-world color tasks?
- Does it avoid triggering on generic coding or design work that merely mentions color?

### 2. Factual accuracy

- Are the core claims technically defensible?
- Are key distinctions preserved instead of collapsed into simplified but wrong advice?

### 3. Source quality

- Are links stable and reasonably canonical?
- Is the source worth keeping, or is it duplicating weaker material already present?

### 4. Practical usefulness

- Would the guidance help someone make a better decision, not just learn trivia?
- Does it recommend tools, spaces, or references that fit the actual task?

### 5. Scope discipline

- Does the content belong in `SKILL.md`, `references/`, or nowhere?
- Is the top-level skill still a strongest-hits document rather than a dump of everything known?

## Signs of Drift

Watch for these failure modes:

- too much generic design advice and not enough color-specific reasoning
- too much wheel-theory language without perceptual grounding
- recommendations that confuse standards with shipping support
- stale counts or claims that will rot quickly — every number in `README.md` comes from
  `scripts/stats.sh`, so refresh it there instead of editing prose
- duplicate references that add no new angle

## Preferred Update Loop

When making non-trivial edits:

1. update the skill or references
2. scan `evals/trigger-evals.json` and ask whether the new description still triggers in the right places; `evals/TRIGGERING.md` holds the rule those cases encode, and any relabelling belongs there first
3. try at least one prompt from `evals/task-prompts.md`
4. fix anything that became misleading, overbroad, or too abstract
