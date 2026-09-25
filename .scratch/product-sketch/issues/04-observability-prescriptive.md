# Observability: does the measurement layer gain a prescriptive half?

Type: grilling
Status: claimed
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

## Corrections to the survey

Re-derived from the archive and from the preserved database on 2026-09-24, per the map's Notes.
The question's survey was wrong in three places and thin in two more. These corrections, not the
original claims, are what the answer is built on.

**The stored set is right; the computed set undercounts.** `observation` (one `Double` per metric
per occurrence, enforced by a unique index on `occurrence_id, metric_id`), `question`,
`occurrence_timing` and `recording` are the four stored tables, as stated. Computed on read:
`MetricDef`, `MetricSource`, `MetricPoint` and `MetricsRepository`, as stated — but also
`Aggregation` (`MEAN SUM MAX MIN LATEST COUNT`), `MetricSeries.byDay`, `TrackRange`, `DayValue`,
`YesNoSummary`, and an `Axis` that rounds chart bounds. The read side is a small library, not four
types.

**"What does not exist anywhere is a target" is wrong.** A complete target grammar exists, in
`docs/plugin/MANIFEST.md`, as `<goal-template>`: `metricId` (which must be a metric marked
`goalable`), `aggregation`, `windowDays` (an integer, 1 or more), `comparator` (`at_least` or
`at_most`), and `target` (a number). That is a windowed aggregation compared against a threshold —
exactly the prescriptive half this ticket asks about, specified in full.

It is specified and **not implemented**. The declaration reader parses two elements, `step-type`
and `metric`; `<goal-template>` is not one of them, no `DeclaredGoal` type exists, and the
validator has no test for it. So the grammar is documentation with no code behind it. This
corroborates *What a goal is* from the other direction: the only surviving goal artifact in the
archive is in the plugin wire, and it turns out not even to be code.

`MetricDef.goalable` is the residue of a removed **Plan** pillar — the archive's own words are that
what is left of Plan is `MetricDef.goalable` "and nothing else". It defaults to true and is set
false in exactly one place: routine times.

**"`Direction` … consumed by nothing" is wrong in a way that matters.** `Direction` is written
everywhere and read nowhere. The wire validator parses and validates it, with tests asserting that
`higher-better` is accepted and `up` refused. All three of core's own metric groups hard-code
`Direction.NEUTRAL`. So its two informative values could only ever arrive from a plugin
declaration, and nothing anywhere branches on the field. "Validated on the way in, never read" is
the accurate claim, and it is a sharper warning than "unused".

Note also that `Direction` and the `<goal-template>` `comparator` are two answers to one question,
made independently: which side is a breach. A comparator on the goal makes the enum on the metric
redundant for satisfaction.

**The four metric groups are three plus plugins.** `MetricGroup` is `Questions`, `RoutineTimes`,
`Countdowns` and `Plugin`. The fourth is the plugin platform, which is out of scope, so core's own
answer is three groups.

**The scale is 1 to 10, not 1 to 5.** `ValueType` is `NUMBER BOOLEAN SCALE_1_10 SCALE_1_5 DURATION`.
`SCALE_1_5` is reader-only, kept so old backups decode, never offered. The ten-step scale was the
author's decision on 2026-09-19 and the reason is about reading a scale rather than arithmetic:
people anchor on 0-to-N even when the scale starts at 1, so a five-step scale had no usable neutral
answer. `SALVAGE.md`'s "a 1-to-5 scale too coarse to say 'a bit better than last time'" is the same
decision, reached by use. Two KDoc comments still say 1 to 5 and are stale; the code validates
1 to 10.

`Question.tally` is a fifth thing the survey missed: a number counted through the day rather than
answered once, where each add writes its own `observation` and the day's figure is their `SUM`.

## What the use record actually says

From the preserved database — the numbers *Preserve the running app's database* did not take.

**Three questions, nineteen answers, ten days.** `question` holds 3 rows, all created 2026-09-17,
the app's third day: "How tired are you?" and "How rested do you feel?" (both `SCALE_1_10`, no
unit) and "Weight" (`NUMBER`, lbs). `observation` holds 19 rows — 7 for each scale question across
7 distinct days, and 5 for Weight across 5 days.

**Only one of the three core groups has ever produced a row.** `occurrence_timing` and `recording`
are empty, so RoutineTimes and Countdowns are structurally empty in the only database that exists.
One definition carries `timed = 1`, so the timer was configured and never once run. Every metric
the author has ever recorded is a check-in answer.

**Weight was built as a question, and it is the one with a gap.** The survey asks whether a weight
goal needs a number entered unprompted. The archive answered it by routing weight through a
prompted check-in step, "Weigh-in", and that series runs 09-17 to 09-21 and then stops, while both
scale questions run to the last day.

**Corrected by the author, 2026-09-24: the gap is travel, not abandonment.** He was away from home
and away from the scale, and the weigh-ins resume tomorrow. The inference this ticket first drew
from the shape of the data — that routing an unprompted number through a prompted step is what
killed the series — is **not supported**. The series is alive. What the data showed was a person
with a scale at home, and nothing in the database says so.

**The engine wrote the gap, and the reason was outside the app entirely.** The Weigh-in occurrences
read: `DONE` on each of the five answered days, then `SKIPPED`/`SUPERSEDED` on 09-22, then
`AUTO_CLOSED` on 09-23 and 09-24, then `PENDING`. `AUTO_CLOSED` is what the cascade writes when the
routine above a step is completed without it; the app's own words for it are "Closed by the routine
above it". So the engine closed those two days — and the fact that actually explains them, a trip,
is recorded nowhere at all.

That makes a **third** cause of a gap, beside the engine's and the user's own refusal:
**the measurement was not possible.** It is not an edge case. Not every metric is measurable every
day for a given person, and the app has no way to know which days those were.

This is the shape *Preserve the running app's database* found in the skip reasons, one layer up,
and worse: the series cannot tell the engine's holes from the user's own, and neither log records
the third cause at all. Any predicate over "how many days in the window" reads engine behaviour and
a trip alike as user behaviour. The occurrence log discriminates four statuses and still could not
have answered this one; `observation`, which is what a threshold would be computed over, carries
nothing but values and times.

The correction strengthens the rule it was first used to argue for rather than weakening it. A
windowed count would have scored a week away from home as five failures.

**Nothing in the app ever drew a target.** Track's three chart kinds are a line chart, a day strip
for yes-or-no, and a sparkline. None takes a threshold, a band or a goal line.

