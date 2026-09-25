# Observability: does the measurement layer gain a prescriptive half?

Type: grilling
Status: open
Blocked by: 02

## Question

The first repo built the descriptive half completely and the prescriptive half not at all. Stored:
`observation` (one `Double` per metric per occurrence), `question` (a prompt whose answers are a
series), `occurrence_timing`, `recording`. Computed on read, never stored: `MetricDef`,
`MetricSource`, `MetricPoint`, and a `MetricsRepository` unifying four groups behind one API. The
governing rule is `SALVAGE.md`'s: **store facts, compute judgements on read**, so changing a formula
re-grades the whole history instead of freezing yesterday's verdict into every past row.

What does not exist anywhere is a target. If ticket 02 confirms threshold-satisfied goals, this layer
is where they are evaluated, and observability stops being a view over work and becomes the
satisfaction condition for a whole class of goal.

- **Is a target stored, or is it part of the goal?** The re-grading property depends on nothing
  derived being stored. A threshold is not derived — it is a fact the human asserted — but the verdict
  *"satisfied"* is, and must stay computed. Say where the line falls before a `satisfied` column gets
  written by accident.
- **What is a metric in the new app, and who creates one?** The first repo's answer was that a
  question *is* a metric and its answers are one series. That made every metric a thing the app asks
  you about. A weight goal needs a number the human enters unprompted, which may be a different route
  into the same table or a different table.
- **Does `Direction` earn its place now?** `HIGHER_BETTER / LOWER_BETTER / NEUTRAL` was written for
  goals and consumed by nothing. A standing threshold needs it to know which side is a breach.
- **What does the app show about a metric?** Charting is where an offline single-user app can spend
  unlimited effort for no benefit. Name the smallest thing that serves a goal's satisfaction condition,
  and put the rest in *what is not built*.
- **Does this concept pass the two-claims test?** It has an engine. The stage is the question: is
  "measurement" something the human *does*, or is it a property of work already being done? If the
  latter, it is a view and not a pillar, and it should be said plainly here.
