# The documentation growth curve, and why the correction did not hold

Type: research
Status: resolved

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

## Answer

Full findings: [research\/01-documentation-growth-curve.md](../research/01-documentation-growth-curve.md)

1,738 → 8,197 Markdown lines over eight days, one net-negative day. The hypothesis holds: every addition was locally justified and the failure is purely aggregate. #87's arithmetic verifies (median ADR 14 → 47 lines) but its diagnosis is wrong — ADRs 0001–0051 were bulk-extracted from SPEC.md on day 6 between 11:17 and 12:11, so the "drift at 0061" is a change of authoring method, not decay; filing #87 changed nothing. #88's timeline is wrong: the 194 → 244 regrowth took 2h52m, not a day. Map #86 was chartered *after* all the growth, is still open and parked, and its tripwire tickets never ran; the correction that did work (154 → 24 lines/day) predates it. The corpus is far larger than the repo: the tracker holds 107k words against the repo's 90k, permanent and un-trimmable.
