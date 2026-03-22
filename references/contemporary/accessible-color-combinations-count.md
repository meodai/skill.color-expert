# How Many Hex Color Combinations Are Accessible?

**Source:** Research by @mrmrs* — https://x.com/mrmrs*/status/2034403566040088832
**Method:** Rust brute-force across all ~281 trillion hex color pairs for six algorithms. Reported runtime: 39 hours.

## The Numbers

Total possible hex code pairs: **~281 trillion** (16,777,216² / 2)

| Threshold    | Passing Pairs               | % of All Pairs |
| ------------ | --------------------------- | -------------- |
| **APCA 60**  | 20.6 T (20,637,683,557,008) | 7.33%          |
| **APCA 75**  | 4.4 T (4,405,913,610,605)   | 1.57%          |
| **APCA 90**  | 239 B (239,182,492,850)     | 0.08%          |
| **WCAG 3.0** | 74.6 T (74,553,266,253,058) | 26.49%         |
| **WCAG 4.5** | 33.7 T (33,723,177,965,830) | 11.98%         |
| **WCAG 7.0** | 10.2 T (10,236,606,051,802) | 3.64%          |

## Key Insights

### WCAG 2.1 Contrast Ratios

- At **3:1** (minimum for large text / graphical objects): ~1 in 4 pairs pass (26.49%)
- At **4.5:1** (AA normal text): ~1 in 8 pairs pass (11.98%)
- At **7:1** (AAA): ~1 in 27 pairs pass (3.64%)

### APCA (Advanced Perceptual Contrast Algorithm)

- **APCA is significantly more restrictive** than WCAG at comparable thresholds
- APCA 60 (roughly equivalent to WCAG AA body text): only 7.33% — vs WCAG 4.5:1 at 11.98%
- APCA 75 (fluent reading): only 1.57%
- APCA 90 (preferred for body text): a mere 0.08% — only 239 billion out of 281 trillion

### What This Means for Designers

- **At WCAG AA (4.5:1):** you have ~33.7 trillion valid pairs — sounds like a lot, but it's only 12% of color space
- **At APCA 90 (best readability):** only 0.08% of pairs work — the design space is EXTREMELY constrained
- This quantifies why accessibility-first color selection is hard — and why tools like Color Buddy's palette linting, APCA calculators, and contrast-aware palette generators are essential
- The jump from WCAG 3:1 to 7:1 is a 7× reduction in available pairs
- The jump from APCA 60 to 90 is an 86× reduction

### APCA vs WCAG

- WCAG's ratio is symmetric (text on background = background on text)
- APCA is polarity-aware (light text on dark ≠ dark text on light) — which is why the numbers differ
- APCA better models actual readability, but constrains the palette more

## Method

- Computed in Rust
- Brute-force across all ~281 trillion hex color pairs
- Covered six algorithms
- Reported runtime: 39 hours
- 16,777,216 possible hex colors (256³)
- Pairs counted as unordered for WCAG (symmetric), ordered for APCA (asymmetric/polarity-aware)
