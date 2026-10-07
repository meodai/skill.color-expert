#!/usr/bin/env bash
# Print the repo's reference counts. Every number quoted in README.md comes from
# here, so refresh them with this instead of editing by hand.
set -euo pipefail
cd "$(dirname "$0")/.."

# Navigation files are not reference content; exclude them from every count.
NAV=( -name INDEX.md -o -name ONLINE-TOOLS.md -o -name PDFS.md )
refs() { find "$1" -name '*.md' ! \( "${NAV[@]}" \); }
rows() { echo $(( $(grep -c '^| ' "$1") - 2 )); }   # minus header and separator

printf 'Markdown reference files   %6d\n' "$(refs references | wc -l)"
for d in historical contemporary techniques; do
  printf '  %-23s %6d\n' "$d/" "$(refs "references/$d" | wc -l)"
done
printf 'Total words                %6d\n' "$(refs references | xargs cat | wc -w)"
printf 'Online tools catalogued    %6d\n' "$(rows references/techniques/ONLINE-TOOLS.md)"
printf 'Source PDFs (gitignored)   %6d\n' "$(rows references/PDFS.md)"
printf 'Distinct video sources     %6d\n' \
  "$(grep -rhoE 'youtube\.com/(watch\?v=|shorts/)[A-Za-z0-9_-]+' references/ | sort -u | wc -l)"

printf '\nContext cost of the loaded layer:\n'
printf '  SKILL.md                 %6d bytes (~%d tokens)\n' \
  "$(wc -c < SKILL.md)" "$(( $(wc -c < SKILL.md) / 4 ))"
printf '  references/INDEX.md      %6d bytes (~%d tokens)\n' \
  "$(wc -c < references/INDEX.md)" "$(( $(wc -c < references/INDEX.md) / 4 ))"
