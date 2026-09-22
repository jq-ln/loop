# The documentation growth curve, and why the correction did not hold

Type: research
Status: open

## Question

`../old_loop` accumulated 8,191 lines of Markdown in eight days. Chart the curve and explain it.

- Volume of Markdown over time, by commit. Which commits added the most, and what was each
  responding to — a finding, a review, a collision, a decision?
- The 76 ADRs in `docs/adr/`: length distribution over time. Issue #87 claimed "the ADRs since
  0061 are four times the length of the rule that owns them" — verify it and find where the drift
  begins.
- `CLAUDE.md` specifically: issue #88 recorded it "was cut to 194 lines and was 244 a day later".
  Find both commits. What was added back, by whom, and what argument justified each addition?
  Map #86 was chartered over exactly this growth — establish what it changed and why the change
  did not survive 24 hours.
- Was any addition unjustified *on its own terms*? The hypothesis to test is that every individual
  addition was locally correct and the failure was only ever aggregate. Evidence either way is the
  finding.
