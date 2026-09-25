# Product

What the app does, its screens, and its input vocabulary: the whole app as designed, including the
parts not built yet. It does not own which parts exist (`ARCHITECTURE.md`, under *The first
shippable slice* and *Not built*), what a term means (`CONTEXT.md`), or the goals every decision
answers to (`GOALS.md`). A part the code lacks is an absence and has a line in *Not built*; a part
the code does differently is a bug in this file, because the code wins.

## What the app is

A single-user, offline Android app for running one's own life: the work, the measurements, and what
the work is for. The daily path needs no network. The app contains no language model: breaking a
goal down happens outside it, by hand or in a conversation whose result is brought in, and the app
never writes content on the user's behalf.

It is a loop. Work is done, what happened is measured, and what the work serves is revised in light
of it. Each part below is one edge of that loop.

## Work

A **definition** is what could be done; a **run** is one instance of it on a day. Nothing else is a
kind of work. A **routine** is a definition with ordered steps, and a step may belong to more than
one routine. A step can carry a cadence ("only Fridays"), which only ever removes the step from a
day its routine is on; it never adds a day.

A definition may have a schedule, or none. A schedule fires whether or not the last run was done, so
a day the user never touched closes as a recorded skip. Work that genuinely waits until done opts in
to **carry-forward** instead, one definition at a time. A schedule can fire every Nth time the work
was done, counted from the run log.

Work arrives by several doors, all of them the same shape underneath: a routine, a one-off, something
noticed now and pushed to a named day, and something already done that was never planned, which is
logged after the fact and keeps its definition. **Capture asks nothing** and lands the work
unscheduled and uncited in `Offered`.

**Commitment is gated; capture is not.** Before a definition can be scheduled, put on a day or logged
as done, it must cite what it serves: a goal or a principle. A thought needs no reason; a commitment
does. Doing uncited work is a commitment too, so marking it done first asks what it served.

A definition is never deleted. It is **abandoned**, dated and retractable, and its history stays.
Abandoning a routine abandons, on the same date, the steps that belong to no other routine, and
retracting it brings them back. A step removed from its only routine is abandoned too; capturing it
again finds it and retracts that.

## What work serves

**Principles** sit at the top: propositions the user holds, such as *I inhabit a body*, which can be
served or neglected and never closed. A principle can be abandoned and never satisfied. Its wording
changes freely, and each change is a dated revision; creating one is its own act and is never
offered from inside the flow of filing something else. The app starts with none.

A **goal** is something worked toward that names what satisfies it, and the app refuses one that
cannot. A goal cites exactly one parent, a goal or a principle; a goal with none sits in an
**unassigned** pile, which is not a principle. Goals form a tree. A definition likewise cites exactly
one goal or principle, so reading a goal's citations backwards is its breakdown: its detail view
lists the sub-goals and definitions that cite it.

**A step inherits what its routine serves** and never cites on its own, so adding one to a routine
asks nothing. A step in several routines serves what each of them serves, and its runs count toward
each. A definition that is also scheduled on its own cites for that role and counts under both.

Satisfaction comes from one of two families, and nothing stores the verdict:

- **Derived**, computed on read: the work beneath the goal is done, or a metric has met a target.
- **Declared**: the user attests it, on a date. When the derived test passes on a declared goal the
  app offers the attestation and never makes it.

A goal either **latches**, closing the first time it is satisfied, or is **standing**, re-checked
forever and losable. A standing goal must be satisfied by a metric; one satisfied by finishing work
is a routine, and is refused. Abstaining from something is a standing goal over a metric whose
target is zero. A goal ends **satisfied** or **abandoned**, both dated, and either can be retracted
on a later date. Abandoning a goal leaves the work beneath it in place, uncited.

A **prerequisite** says one thing cannot start until another is done. It joins any two nodes,
independent of what either serves; a node with several must wait for all of them. Being **blocked**
passes down: work under a blocked goal is blocked too, including work filed there later. A
prerequisite opens when its predecessor is satisfied, or for a definition, when it has a completed
run that still stands, and closes again if that completion is undone. Abandoning the predecessor
opens nothing. A definition has a schedule or prerequisites, never both, and blocked work is absent
from Today rather than shown dimmed. A prerequisite that could never open, one naming a principle or
forming a cycle, is refused when it is made.

## Measurement

A **metric** is a named series: a unit, an aggregation, and its **readings**. It is fed by **sources**:
a **question** asked at a step of a routine, or a value entered directly. A metric is created as its
own act, and is **archived**, never deleted. Its view is one line chart, with the target, the window
and the verdict in words drawn on it, and the raw readings listed beneath.

A **target** belongs to a goal, not to the metric, so two goals may chase one metric differently. It
names the metric, an aggregation, a window in days, a direction to beat (*at least* or *at most*), a
number, and the fewest readings that count. A goal can only target a metric that already exists.

A target has three verdicts: **satisfied**, **breached**, and **undecided** when too few readings fall
in the window. A verdict is computed only from the values recorded, **never from days with no
value**: a gap may mean the user did not do it, or that the measurement was not possible, and the
app cannot tell which. So "did it on N days this week" is not a target over a metric. It is a
question for the run log.

## Revision

**Revise** is where what the work serves is changed in light of what happened. A **revision** is a
dated change to something that stays in place: a principle's wording, a goal, a target, a
definition's steps. It carries a note saying why.

Revise raises **flags**. Each is computed on read and names a problem, shows the evidence, and
suggests the kind of remedy. It never picks the numbers or writes the change.

- **Out of reach**: a goal's target sits far beyond anything the metric has recorded.
- **Stalled**: readings keep arriving and do not move.
- **Dormant**: no evidence for a while, counting only time the goal could have been worked on. The
  evidence depends on the family: runs beneath it, readings on its metric, or for a declared goal,
  its subtree's.
- **Rarely done**: a definition run far less often than its schedule asks. It says whether a routine
  is dropped whole or one step inside a working routine is, because the remedies are opposite, and
  it counts only what the user dismissed, never the steps the app closed along with them.
- **Backlog dodging**: the uncited work in `Offered` has grown for two weeks without a pause.
- **Coasting**: a target satisfied continuously, never undecided, and never revised.
- **Long-blocked**: a prerequisite open far longer than its predecessor should take. Blocked work
  is absent from Today, so this flag is the only place such work is reported.
- **Work without effect**: runs accumulating beneath a goal whose metric is flat.
- **Done but still working**: a satisfied goal whose subtree still produces runs.
- **Unserved**: a principle with nothing under it, or with everything under it dormant or stalled.
  A principle served only by a practice, with no goal, is served, and is not flagged.

A flag is **dismissed** with a dated reason, which quiets it for a while. That reason is where *the
measurement was not possible* is recorded, and later flags read earlier dismissals. Revise is reached
when the user goes there: **it has no cadence, and it is not a row on Today.**

## Notes

A **note** is prose with a subject: a run, a reading, a revision, or the day. There is one kind of
note, not a text box per screen. The day's note is written from the date on Today's app bar, since
the day has no row.

## Notifications

**The app notifies about a moment the user chose, never about a judgement it formed.** Setting a
time of day on a scheduled definition asks for a notification at that time; there is no separate
switch. A definition can be marked **silent** to keep the time without the sound. Without a time,
work is due that day and nothing fires.

A notification fires once per run, stays silent if the run is already done, clears when the run
closes, and never repeats. It opens the item and carries no acts. The permission is asked the first
time a time is set or a run is snoozed to a part of the day. A run snoozed to a part of the day notifies there, because that too is a moment
the user chose. Flags, dormancy and missed work never notify.

## Screens

The destinations are **Today**, **Goals**, **Metrics** and **Revise**. The first three are places to
look; Revise is the place to act.

### Today

Today is what could be done today, not only what the schedule says. It holds, and labels:

- runs the schedule placed on today;
- runs carried forward by choice, each showing its age;
- readings a metric wants today;
- `Offered`, at the foot, holding all the uncited work, with no selection from it.

Blocked work is absent, and reflection does not appear.

**The order is the user's.** Top-level rows keep an order the user sets by dragging, and steps keep
their routine's order. The one computed rule is that finished rows sink, struck through and still
visible. There is no score and nothing reorders the list on its own.

Whether a routine shows as one row or as its steps is **a property of the routine**, set once and
changed from its menu. The chevron folds or unfolds it for the session without changing the setting.
Steps are never lifted out of their routine, since one step can belong to several.

A reading is its own row and is ticked by recording it, independently of any run, so dismissing the
routine a reading's question sits in does not lose the reading. The row leaves once any source has
supplied the day's value. The day's dismissals collapse to one line.

`Offered`'s header is a single search field over every definition. A result not due today can be
done now or put on today. The last result is **Create "…"**, which is capture: the search is also the
check for a duplicate.

### Goals

Principles at the top, the goals citing each beneath them, and the unassigned pile. A principle's or
goal's detail lists what cites it, its prerequisites, and its history.

### Metrics

Every metric, each opening its chart. Archived metrics are kept, out of the way.

### Revise

The flags currently raised, each opening onto its evidence and the thing it concerns, where the
revision is made.

## Input vocabulary

**One meaning per gesture, everywhere. A meaning may be absent on a surface; it is never different
there.** An act the row cannot take is absent, not shown and refused.

- **Tap** opens this thing's detail. Always, on every row.
- **Hold** opens the menu of every act on this row, including the ones a swipe performs.
- **Swipe right** discharges the row: done, answered, recorded. On uncited work it first asks what
  the work served.
- **Swipe left** dismisses the run for today. It asks no reason; the run's note is there for one.
- **The rail** drags a row to reorder it, where order is the user's to set.
- **The chevron** folds a routine for this session.

| Row | tap | hold | right | left | rail | chevron |
|---|---|---|---|---|---|---|
| Today: routine | detail | menu | done | dismiss | reorder | fold |
| Today: top-level item | detail | menu | done | dismiss | reorder | |
| Today: step | detail | menu | done | dismiss | | |
| Today: finished row | detail | menu | | | reorder | fold |
| Today: reading | detail | menu | record | | | |
| Today: `Offered` row | detail | menu | done | | | |
| Today: search result, not due | detail | menu | done | | | |
| Today: the date | the day's note | | | | | |
| Goals, Metrics, Revise | detail | menu | | | | |
| Routine editor: step | detail | menu | | | reorder | |

Swipes exist only on Today, where there is a daily rhythm. A notification is a surface with no acts.

**An act belongs to its object.** Acts on the run's day, which are snooze, defer and the rail, belong
to the top-level row. Acts on the work, which are done, dismiss and note, belong wherever the work is.
Step order is the routine's, edited in the routine editor, never dragged on Today.

- **Snooze** moves a run later today, to *this morning*, *this afternoon* or *this evening*, whichever
  are still ahead of both now and the run's due time. When none is, only defer remains.
- **Defer** moves the work to another day: today's run is dismissed and a one-off definition for the
  named day is created, linked to it. The dismissal says it did not happen today; the link says why.
- **Un-complete** undoes a completion exactly. It is absent when undoing it would leave nothing to do.
- An `Offered` row leaves one of two ways: **commit**, by citing what it serves and giving it a
  schedule or a prerequisite, or **abandon**. There is no delete.
- Everything is written as it is entered. Answering a question writes the answer; there is no staged
  form waiting for a final *Done*.

## What the app refuses

Refusals are statements about what the app is, not work deferred. The ones that can be bought back
say what would buy them.

- **A computed priority, score or order**, anything that boosts one item over another, and any
  overdue treatment beyond a carried row's age.
- **A notification about a judgement**, including a badge counting what is outstanding.
- **A progress bar or percentage.** A goal can always gain another child, so a count of its known
  children is a fact and a percentage is a claim.
- **Importing from the first Loop.** What carries over is written by hand into the new app's
  database, once, and never becomes a feature.
- **A delete on the daily path.** Things are abandoned or archived, never destroyed.
- **A reason on dismissing a run**, bought back if Revise keeps raising flags that can only be
  explained by remembering a dismissal from days before.
- **A review cadence**, bought back if Revise is never visited because nothing prompts it.
- **A target date on a goal**, bought back if a stall is flagged too late to be useful.
- **A prerequisite satisfied by any one of several predecessors.** An intermediate node says it.
