# The first shippable slice, and what is deliberately not built

Type: grilling
Status: resolved
Blocked by: 03, 04, 05, 06, 07, 11, 13, 14

## Question

The destination. `ARCHITECTURE.md` defines the slice as *"the smallest thing that can be in a user's
hands, and what is deliberately left out of it"*, ships both sections marked `**Unwritten.**`, and
`.githooks/pre-commit` refuses the commit that adds the first `.kt` file while either one is. This
ticket writes both, and the map's own damp is that every earlier answer must trace a line to one of
them.

Settled while charting: a **beachhead**, not a thin replacement — one concept end to end that the
author would genuinely use daily, with a long *not built* list — and the user is the author, who is
currently running the first Loop and will not switch to something worse.

- **What is the smallest daily-usable app?** The candidate is work items plus Today, with goals,
  observability and reflection all deferred. If no slice can be named that the author would actually
  use daily without those, that is evidence about the model and it should be recorded rather than
  worked around.
- **What does "in a user's hands" mean when it is not on a store?** `GOALS.md` N1 forbids assuming a
  channel, so the slice is defined by being installed and lived with, not by being released.
- **Every deferral is priced at one ADR.** The unbuilt list is consumable: the ADR that authorises an
  entry deletes its line in the same commit. Known candidates already: an in-app language model,
  migration from the first Loop, the plugin platform, `core-audio`, and whatever tickets 04 and 05
  leave standing. Each is one line saying what is not built and that building it needs an ADR.
- **What is the trigger for the second slice?** Not a date and not a feature count. `SALVAGE.md`
  describes the loop that worked: live with it on a phone and keep the loop that reports back.
- **Does anything here belong in `GOALS.md` instead?** An unbuilt entry graduates to a non-goal only
  when a reader of the goals might plausibly have built it. That file is the human's alone and is
  edited in a commit touching nothing else, so this ticket names candidates and never writes them.

## Re-derived from source, 2026-09-25

Three claims in the question above were stale by the time its blockers resolved, and the answer is
built on the corrections.

- **The candidate slice — work items plus Today, goals and observability deferred — cannot exist.**
  [What a goal is](02-what-a-goal-is.md) gates commitment on a citation, and
  [Do goals serve principles?](13-goals-serve-principles.md) widened the target to a goal *or* a
  principle. Cut both and nothing can be scheduled. And [What carries over](11-what-carries-over.md)
  found that the part of the first Loop still in use is **the metric surface**; a slice without
  readings is worse than what the author runs now, which G1 rules out.
- **Migration from the first Loop is not an ADR-priced deferral.** 11 made it *"unbuilt permanently
  rather than being deferred at one ADR"*: a refusal, not a line in *Not built*.
- **"In a user's hands" was already decided** by 11's cutover, which this ticket adopts rather than
  re-opens.

The question's contingency — *if no slice can be named that the author would use daily without goals
and observability, that is evidence about the model* — fired in half: a slice exists, but it needs
the citation target and the metric surface. The evidence is that **the gate and the readings are the
floor**, not the model failing.

## Answer

**The slice is work, Today, metrics, and principles as the only citation target — three
destinations, Today · Goals · Metrics — and it is in the author's hands when it has replaced the
first Loop.** Goals proper, prerequisites and `Revise` are all unbuilt, and each is one line.

### What is in the first slice

- **Definitions and runs**, the routine shape with ordered steps, the schedule engine and the
  cascade — the ported engine, per the map's Notes.
- **Today**, with its row classes from [Today](06-today.md): runs the schedule materialized, runs
  carried forward by choice, readings a metric wants today, and `Offered` with its search field, which
  is capture per [The input vocabulary](07-the-input-vocabulary.md).
- **`snooze` and `defer`**, and 07's gesture vocabulary as a whole on Today.
- **A time of day is a notification**, per [When is the app allowed to
  interrupt?](14-when-may-the-app-interrupt.md): the field, the firing, the permission ask.
  **A snoozed untimed run notifies at its anchor** — 07 offers the day-part anchors to untimed rows,
  and a snooze is a moment the user chose, inside 14's boundary. The first such snooze counts as the
  first time set for the permission ask; the definition's silent opt-out still applies.
- **Metrics**, fed by check-in questions and by direct entry, each viewed as one line chart.
- **Principles, as the only citation target.** Goals are cut, so the first commitment requires
  creating a principle — accepted, because it is one act and the author has four in mind. The Goals
  destination holds principles only; a principle's detail lists the definitions citing it, which is
  [The goal-to-work edge](03-the-goal-to-work-edge.md)'s decomposition read backwards. Creation stays
  its own act, never inline from filing.
- **`revision` with principle as its only subject.** A rename writes a dated revision. There is no
  `Revise` destination; the log exists so 13's pre-registered decay falsifier has data from day one,
  when wording moves most.
- **The day's `note`**, on the app bar's date. It is the in-app half of `SALVAGE.md`'s loop that
  reports back, and in this slice it is also where *the measurement was not possible* is recorded —
  [Observability](04-observability-prescriptive.md)'s third cause of a gap, which 05 had put on a
  flag's dismissal. When `Revise` ships, the dismissal reason takes it over.

**There is no onboarding.** Day one is zero principles and no permission; the empty app is Today with
nothing on it but `Offered`'s field, and empty Goals and Metrics. The first capture is the first act.
What the empty screens say is copy, and copy is the rebuild's, as the feel of a gesture is.

### What "in a user's hands" means

11's cutover, adopted as the definition: **a local build on the author's phone, run in parallel with
the first Loop until it holds a week of real routines, then a hard stop.** The back-fill follows. No
channel is assumed, per N1.

### What triggers the second slice

**Evidence that one specific absence hurts**, from either source: a day's `note` naming it,
confirmed by a session reading the notes beside the run log; or a pre-registered falsifier firing.
The second slice is the *Not built* line that evidence names, and its ADR deletes that line. Not a
date, not a feature count, not another planning round.

**`Offered`'s falsifier runs by hand.** 06 adopted `Offered` provisionally, and its test — the uncited
backlog growing monotonically for two weeks — was to be reported by the backlog-dodging flag in
`Revise`, which is cut. The report-back session already reads the database, so the test is one query
there rather than a destination in the app. 14's timed-definition share is read the same way.

### What earns a line in *Not built*

**Absences only** — things buildable by an ADR, each line consumable by the ADR that builds it.
**Refusals are statements about what the app is and live in `PRODUCT.md`**; a refusal on a list
designed to be consumed reads as a to-do. Granularity is **one line per thing a user would notice
missing**: sub-features of a cut concept travel with it, and the ADR that builds the concept lists its
own remaining absences.

The list:

1. **Goals** — satisfaction, targets, verdicts, and importing a decomposition.
2. **Prerequisites** — which return **with `long-blocked`**, since blocked work is absent from Today
   and that flag is its only reporter (05's coupling). Cutting both together is why the coupling does
   not bite in this slice: nothing can be blocked.
3. **`Revise`** and its flag catalogue, `unserved` and the dismissal reason included.
4. **`revision`** on any subject but a principle.
5. **An in-app language model.**
6. **A widget.**
7. **Done-from-the-shade.**
8. **Chart forms beyond one line** — the day strip first to reconsider, per 04; sparkline,
   multi-metric, export.
9. **The timer.**
10. **Monthly step cadences.**
11. **Gestures off Today.**
12. **A backlog destination** — 06's pre-registered remedy if `Offered` fails.
13. **The ear trainer.**

**The plugin platform is not listed**: `ARCHITECTURE.md`'s *Plugin plumbing* section already owns
that claim, and one claim has one home. **The migration importer is not listed**: it is a refusal.

### Candidates for `GOALS.md` non-goals

Named, never written — that file is the owner's alone, edited in a commit touching nothing else. The
bar: actually rejected, and a reader of G1 might plausibly have built it.

- **A computed priority score or ordering** — the obvious daily-app feature, and one that never ran
  in the archive.
- **Notifying about a judgement the app formed**, a badge included.
- **A progress bar or percentage.**
- **An import from the first Loop** — a reader expects you to migrate from your own first app.

Not candidates: the reflection cadence and the optional target date, each refused **with a
falsifier** — a refusal evidence can buy back is not a rejection. And the in-app model, which is
priced at an ADR.

### What this spends

- **Clears two patches of the map's fog.** *Onboarding and the empty state* is resolved above;
  *the import format for a decomposition* folds into *Not built* line 1, its format the goals ADR's to
  decide.
- **Ports trigger the port-time ADRs already registered** in [Register the vocabulary and the ADRs
  this map owes](12-the-vocabulary-and-adr-register.md) — the rename, `occurrence.note`, the staged
  check-in, exact alarms. This ticket adds none: a cut is not a decision against a ticket, since
  building each cut line is what costs the ADR.
- **13's principles ADR is still owed at 12**, and is not weakened by goals being cut — principles
  ship in this slice as the citation target.
- **`SALVAGE.md` is untouched here.** What the slice consumes is [Write the sketch](10-write-the-sketch.md)'s
  to delete.
