# Observability: does the measurement layer gain a prescriptive half?

Type: grilling
Status: resolved
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

## Working record

**Round 1 — settled.**

1. **A metric and a question are separate things.** A **metric** is the named series: a unit, an
   aggregation, and the values under it. A **check-in question** is one *source* that feeds a
   metric, and direct entry is another. The archive's error was in the authoring layer, not the
   read layer — `MetricSource` already had this shape, but the only way to bring a metric into
   existence was to write a prompt, which is why weight was built as something the app asks you.

2. **A target lives on the goal, and takes the `<goal-template>` grammar.** Five fields: the
   metric, an aggregation, a window in days, a comparator (`at_least` or `at_most`), and a number.
   A threshold is an assertion about a goal and not about a metric, so two goals may chase one
   metric differently. Adopting it costs nothing, because there is no code to port — only a
   document. The storage line: the goal stores those five fields, and **nothing anywhere stores a
   verdict**.

3. **A predicate is computed over the values actually recorded, and may never be a function of the
   days with no value.** `mean`, `latest`, `sum`, `min`, `max` of what is there are permitted;
   "answered on 5 of 7 days" is refused. The reason is the Weigh-in series: two of its absent days
   were closed by the cascade, and `observation` cannot tell a machine-closed day from a day never
   asked or a day refused. The rule refuses the lie rather than modelling it.

   Ruled out: writing a row for a non-answer to make the series dense. That stores the judgement
   *"this counts as a miss"* as a fact, which is exactly what `SALVAGE.md` forbids.

   Held as a fallback, reachable later without redesign because it only adds a filter: joining
   satisfaction to the occurrence log, so a machine-closed day is excluded from a denominator and a
   user-refused day is not.

### The cost of rule 3, carried

**A "did it on N days this week" goal is unexpressible as a threshold.** That is a common and
reasonable goal shape, and rule 3 refuses it on purpose: over a punctured series the count of
missing days is the engine's behaviour and not the author's, so the goal would report a breach
nobody committed.

It is not lost, only moved: such a goal has to be derived from the **run log** rather than the
metric log, which is the predicate-over-the-definition-graph family that *What a goal is* already
named. This sketch does not settle which of the two families it belongs to.

Flagged by the author as a likely ADR — **after the post-mortem is finished**, not now. What the
ADR would record is the trade-off itself: a windowed count is the most natural goal a person
states, and the app refuses to compute it from measurements because the measurement log cannot
say who caused a gap.

**Round 2 — settled.**

4. **`Direction` and `goalable` are both deleted.** The comparator on the goal carries which side is
   a breach, so `Direction` is redundant for satisfaction, and its only other claim — "and for
   review" — belongs to *Does Reflect survive its own test?*, which may reintroduce it **with a
   consumer** if it needs one. `goalable` goes because chaseability is derived from what a metric
   is rather than asserted per metric, with an explicit falsifier: **if a metric ever appears that
   is worth recording and wrong to chase, the flag comes back**, and if that never happens its
   absence was right.

   `Direction` is worth keeping as the specimen it is. It was parsed, validated and tested on the
   way in — `higher-better` accepted, `up` refused — and read by nothing, with all three of core's
   own metric groups hard-coding `NEUTRAL`. A field with a validator and no consumer is
   indistinguishable from a working feature.

5. **A metric's view is one chart kind.** A line, with the target drawn on it when a goal cites the
   metric, the window marked, and the predicate's current value stated in words. The list of raw
   values stays: it is the only place a note attached to a measurement can be read, and it is a
   list rather than a visualisation. Ruled out: a metric with no screen of its own, seen only
   through a goal — the author weighed in for five days with no goal at all.

   *What is not built*, with the reason: the day strip, the sparkline, more than one metric on a
   chart, correlation, export. **The day strip is the first of these to reconsider** — a yes-or-no
   metric genuinely reads worse as a line — and it should be bought back by use rather than assumed.

6. **A metric is created explicitly and archived explicitly, never deleted.** Deleting one would
   strand real measurements, which the archive's own design refuses: `observation` is `SET NULL` on
   its occurrence precisely so history outlives what produced it, and a metric may now have two
   sources. Archiving keeps a metric out of the goal-creation picker and out of the default list
   without destroying a measurement — the same shape as *What a goal is*'s **abandoned**.

**On a claim this ticket does not make.** An earlier draft was going to record that the goal-to-work
edge leaned on `goalable`. It does not; that session confirmed 03 never mentions the flag. The claim
was this session's, relayed without reading 03's body first, and it is the map's own stale-survey
failure with the agent rather than the archive as its source.

**Round 3 — settled.**

7. **A metric says nothing about when it is measurable.** No cadence, no availability, no
   suspension. Rule 3 already makes a gap cost nothing — the mean of the readings taken is still
   the mean of the readings taken — so a declared cadence would buy only the ability to draw a gap
   as a gap, and the moment one exists something will compute against it, which is the rule this
   ticket spent its evidence on. A manual **suspended** state is worse than nothing: it must be set
   before leaving and cleared after returning, so it fails exactly when the author is busy, and one
   forgotten is indistinguishable from the silence it was meant to replace.

   The falsifier: **if a gap ever produces a wrong answer, this was wrong** — and the place to look
   first is dormancy, not satisfaction.

8. **The window is in days, with a minimum reading count below which the verdict is `undecided`.**
   Days is the unit a person states a goal in; nobody says "my last seven weigh-ins". But days
   alone let one reading in a quiet week decide a verdict. A third verdict value costs nothing to
   store because **no verdict is stored at all**, and it does real work later: an undecided goal is
   the one worth asking about, where a satisfied or breached one needs no prompting.

   This is a **departure from `<goal-template>`**, not an adoption of it: a sixth field the archive
   did not have. Named as a departure so the grammar is not credited to a document that never
   specified it.

9. **The glossary write is folded into *Write the sketch*.** That ticket is chartered for
   `PRODUCT.md` and the two `ARCHITECTURE.md` sections and names no third file, which *The
   goal-to-work edge* recorded as a real gap in the execution plan rather than a task with a home.
   Widening it by one file is the smallest closure: it already runs last, already writes, and
   already consumes what the decisions spent, so every term both tickets coined lands in one edit
   under the map's decide-first-write-once rule. `CONTEXT.md` is an existing standing-claim file,
   so this spends nothing against the cap.

   Against waiting for a term to be "mistaken for something else", which is `CONTEXT.md`'s own bar:
   **metric** and **question** meaning one thing in the archive and two here is that collision
   already, as `gate` is for 03.

   **Amended by the author before this ticket resolved.** The write is not folded into *Write the
   sketch*; it gets a ticket of its own — [Register the vocabulary and the ADRs this map
   owes](12-the-vocabulary-and-adr-register.md) — because the glossary is only half of it. The map
   is also accumulating **deferred ADRs**, each promised at a later moment, and a deferral with no
   register is a decision that quietly does not get recorded. That is the shape of debt a line
   inside another ticket's charter would have hidden.

**Round 4 — settled.**

10. **A threshold goal's dormancy reads the verdict, not the observations.** *The goal-to-work
    edge* settled that dormancy counts only time a node was actionable; that rule does not transfer
    here unchanged, because nothing ever *blocks* a metric — the scale was simply in another city.
    So for this family the signal is **`undecided`**: a goal with too few readings inside its own
    window to decide is the one worth asking about, and one still decidable is one the app has no
    business nagging over, however long ago the readings were taken.

    This needs no second mechanism and no new threshold. Rejected: never letting a threshold goal be
    dormant, which would make a metric abandoned six months ago unculllable forever; and lengthening
    the dormancy threshold for this family, which is tuning a number to paper over a wrong signal
    and will be wrong again for the next metric.

11. **The concept passes the two-claims test, and its name is `metric`.** The engine is the
    predicate evaluator — window, aggregation, comparator, three verdicts — and it is *not* the
    goal's engine, since a metric is read by goals and exists without one, which five ungoaled
    weigh-ins demonstrate. The stage is **measuring**: recording a number that completes no work.

    That stage claim is true only because of decision 1. Before the metric/question split, every
    metric was something the app asked you during a run, so measuring *was* a property of work
    already being done — the archive's version really was a view, and it was correctly never made a
    module. The split is what buys the second claim.

    **"Observability" does not survive into `PRODUCT.md`.** It is the developer analogy talking, and
    the map's Notes require a concept from the analogy to pass this test before it enters the
    documents. What passes is `metric`, an ordinary English noun. Same demotion *The goal-to-work
    edge* gave *Tickets*.

## Answer

**Yes — the measurement layer gains a prescriptive half, and gains a pillar with it, but the pillar
is `metric` and not "observability".**

**A metric and a check-in question are separate things.** A metric is the named series: a unit, an
aggregation, and the values recorded under it. A question is one *source* that feeds a metric;
direct entry is another. The archive's error was in the authoring layer, not the read layer —
`MetricSource` already had this shape, but the only way to bring a metric into existence was to
write a prompt, which is why weight was built as something the app asks you. The split is also what
makes measuring a stage rather than a property of work, and so what makes this a pillar at all.

**A target lives on the goal.** Six fields: the metric, an aggregation, a window in days, a
comparator (`at_least` or `at_most`), a number, and a minimum reading count. The first five are
`<goal-template>`'s, a grammar the archive specified in `docs/plugin/MANIFEST.md` and never
implemented — no `DeclaredGoal` type, no parser branch, no validator test. The sixth is this
ticket's departure. A threshold is an assertion about a goal and not about a metric, so two goals
may chase one metric differently, and **nothing anywhere stores a verdict**.

**Three verdicts, not two.** Satisfied, breached, and `undecided` — too few readings in the window
to say. It costs nothing to store because no verdict is stored, and it does the work a fourth
mechanism would otherwise have to: an undecided goal is the one to ask about, and it is the
dormancy signal for this whole family.

**A predicate is computed over the values actually recorded and may never be a function of the days
with no value.** This is the rule the ticket's evidence was spent on, and it costs a common goal
shape: **"did it on N days this week" is unexpressible as a metric threshold.** It is not lost, only
moved — such a goal is derived from the run log, which is *What a goal is*'s other satisfaction
family. Flagged by the author as a likely ADR, **after the post-mortem**, recording the trade-off
itself rather than the rule.

**`Direction` and `goalable` are deleted**, and a metric's view is one chart kind — a line, the
target drawn on it, the window marked, the verdict in words, the raw values listed beneath. A metric
is created explicitly and archived explicitly, never deleted.

### What the evidence actually bought

The ticket asked five questions and the database answered a different one. Nineteen observations
across three questions in ten days, and **only one of core's three metric groups has ever produced a
row**: `occurrence_timing` and `recording` are empty, and the one definition marked `timed` was
never once run. Every metric the author has recorded is a check-in answer. That is what makes the
authoring layer, not the read layer, the thing to change.

The Weigh-in series then taught the more expensive lesson, and taught it twice. Read from the data
alone it looked like a series that died because an unprompted number had been routed through a
prompted step — a clean, wrong story that this ticket committed to paper before asking. The author's
correction is that he was away from home; the weigh-ins resume. What the database actually showed
was a person with a scale at home, and **nothing in either log says so**.

So there are three causes of a gap, not two. The engine closed the day. The user declined. Or the
measurement was not possible — and unlike the other two, that one is a refusal by nobody and is
recorded nowhere. It is the reason rule 3 is written as a prohibition rather than a preference: a
windowed count would have scored a week away from home as five failures.

### Consequences this answer spends

- **`SALVAGE.md` is untouched.** No entry is consumed. The one rule this ticket leaned on hardest,
  *store facts and compute judgements on read*, is reinforced rather than spent, and `Direction` is
  a fresh specimen of a failure mode none of its entries name: **validated on the way in, read by
  nothing**. That belongs in the map's Notes, not in `SALVAGE.md`, because it is a warning about
  reading this archive rather than a lesson to carry into the new app.
- **A sixth field on the target grammar**, named as a departure so the grammar is not credited to a
  document that never specified it.
- **The day strip is the first thing in *what is not built* to reconsider** — a yes-or-no metric
  reads worse as a line, and that should be bought back by use rather than assumed. *The first
  shippable slice* takes it with that note attached.
- **`ScheduleMode.AFTER_ROUTINE` is not this ticket's**; it is recorded in *The goal-to-work edge*.
- **The vocabulary and the ADRs this map is accumulating now have a home**: [Register the
  vocabulary and the ADRs this map owes](12-the-vocabulary-and-adr-register.md), opened by this
  ticket. It also closes the `CONTEXT.md` gap *The goal-to-work edge* recorded, which decision 9
  had folded into *Write the sketch* and which the author redirected to a ticket of its own.

