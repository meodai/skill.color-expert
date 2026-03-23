# Security

## Skill Architecture

This skill is **read-only declarative content** — it contains no executable code, no build steps, no dependencies, and no runtime network access. There is nothing to install or run.

When an agent loads this skill, it reads `SKILL.md` and optionally reads static markdown files from `references/`. This is identical to reading any other source file in a project.

## Reference Files

The `references/` directory contains curated markdown summaries of color science literature. These files are:

- **Static** — committed to the repo as plain text, not fetched at runtime
- **Human-curated** — reviewed and edited by the maintainer, not raw scrapes
- **Read-only** — the agent reads them for context; they contain no instructions, no tool calls, and no prompts

Sources include public domain books (archive.org, Project Gutenberg), academic publications, and educational websites. All sources are cited in each file.

The reference files are a knowledge base, not executable prompts. They contain no instructions to the agent, no tool invocations, and no system-prompt-style directives. An agent reading these files receives factual color science content, the same as reading any textbook or Wikipedia article.

## No Executable Permissions

This repo contains no `settings.json`, `settings.local.json`, or any configuration that grants shell, network, or filesystem permissions. The entire `.claude/` directory is gitignored.

A `settings.local.json` existed briefly in early commits (the maintainer's local dev permissions for downloading PDFs and transcribing videos during curation). It was removed in commit `ea1f821` and the `.claude/` directory was gitignored. It is not present on the current branch and has no effect on skill consumers — `settings.local.json` files are per-machine and never loaded from imported skills.

## Reported False Positives

- **`colorwell.org`** — Flagged as "malicious" by automated scanners. This is a legitimate color/art education site by painter John Morfis ([colorwell.org](http://colorwell.org/)). It appears as a citation in a reference file from huevaluechroma.com, not as a download target. The domain may trigger heuristic flags due to the word "well" but it is a real, long-standing educational resource in the oil painting community.

- **PROMPT_INJECTION risk from reference files** — The 113 markdown files in `references/` are curated summaries of color science literature. They contain no agent instructions, no tool calls, no role-play prompts, and no behavioral overrides. The content is factual (color spaces, pigment chemistry, perception research). Treating educational content as an injection vector would flag any knowledge base, textbook, or documentation site.

- **DATA_EXFILTRATION via absolute paths** — The flagged paths (`/Users/meodai/...`) appeared only in the now-removed `settings.local.json`. This file was the maintainer's local development configuration and is no longer tracked. No absolute paths exist in any shipped skill content.

- **COMMAND_EXECUTION via settings** — The flagged `settings.local.json` is not part of the distributed skill. It was the maintainer's local dev environment for curating content (downloading PDFs from archive.org, transcribing YouTube videos). It was removed from the repo and `.claude/` is gitignored. Skill consumers never receive this file.
