# What the 106 issues were actually about, and what generated them

Type: research
Status: resolved

## Question

`../old_loop` opened 106 issues in eight days, 82 closed. Harvest the tracker **before the remote
is destroyed** and characterise it.

- Split by subject: findings about the **product** (app code, behaviour, bugs) vs findings about
  the **process** (documents, rules, tracker, workflow). Give the ratio and its trend over time.
- Provenance: how many issues were produced by a review of work that itself existed to fix an
  earlier issue? Identify any chains, and the longest one.
- Time-to-close distribution. Which issues closed as `wontfix` or "not planned", and when did
  declining start being used — issue #73/ADR 0073 introduced the "blast radius" damping rule
  partway through, so measure before and after it.
- The `wayfinder:*` labelled issues: how many maps ran, how many tickets each charted, how many
  resolved.
- What fraction of total issues existed only because the process could observe itself?

## Answer

Full findings: [research\/02-issue-lifecycle.md](../research/02-issue-lifecycle.md)

Raw harvest of all 106 issues and 171 comments at [research/02-issues-raw.json](../research/02-issues-raw.json), taken before the remote was destroyed. The 106 issues were opened in **48h38m**, not eight days. Subject split 45 product / 61 process, inverting monotonically from 30% process in #1–#27 to 81% in #82–#107. The repo's own `process` label undercounted its dominant category ~15× and #66 reasoned from that bad measurement. Nothing was ever stale — median time-to-close 4.1h, none over 48h. Declining was never a practice: zero of the first 50 closes were NOT_PLANNED, then all 17 declines fired in a single 61-second sweep 64 minutes after ADR 0073 landed. 54% of the tracker exists only because the process could observe itself. All four wayfinder maps are still open.
