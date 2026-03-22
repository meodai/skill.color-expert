# CLAUDE.md

This file provides guidance when working with code in this repository.

## Project Overview

This is an **agent skill** (compatible with Claude Code, Codex, Cursor, Copilot, OpenCode, and others via [agentskills.io](https://agentskills.io)). It contains a `SKILL.md` file that serves as a color expertise knowledge base, automatically loaded when the agent handles color-related tasks (naming, theory, spaces, accessibility, perception).

## Architecture

- `SKILL.md` — The skill definition with YAML frontmatter (`name`, `description`) and structured color knowledge. Loaded when color work is detected.
- `references/INDEX.md` — Master lookup table for 113 deep reference files.
- `references/historical/` — Pre-digital color science (Ostwald, Helmholtz, ISCC-NBS, etc.)
- `references/contemporary/` — Modern color science (OKLAB, Briggs, CSA webinars, etc.)
- `references/techniques/` — Tools, libraries, methods (Spectral.js, Culori, APCA, palette generation, etc.)

## No Build/Test/Lint

There are no commands to run. This project is purely declarative content consumed by agent skill systems.

## Editing Guidelines

- Keep SKILL.md frontmatter `description` field accurate — it controls when the skill triggers.
- The skill is referenced by name (`color-expert`).
- SKILL.md should be concise "greatest hits" (~150 lines) — the agent already has broad color knowledge; the skill should correct misconceptions, highlight non-obvious facts, and point to the right tools.
- Deep content goes in `references/` files, not in SKILL.md.
- PDFs are gitignored (~236MB); archive.org source links are preserved in every reference file.
