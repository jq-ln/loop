# Today: what is on it, and how is it ordered?

Type: prototype
Status: resolved
Blocked by: 01, 03

## Question

The app opens to Today. G1 makes this the load-bearing decision in the sketch — an app used every day
is mostly this screen, and everything else is reachable from it. The first repo's answer was Do →
Today, where Do was *"≈ the whole app"*, and its Today query carried overdue pending roots forward
alongside the day's fresh ones.

This is a prototype ticket because it is a *how should it look* question, and the prototype is
throwaway: the artifact is linked from the answer and does not survive into the repo.

- **What is on it?** Everything due today is the obvious answer and probably wrong: the charting
  hypothesis is Today as *due plus unblocked and worth doing* — the frontier reading — in one list
  rather than two screens. Test that against a real day with a routine, a deferred one-off and a
  standing goal in flight.
- **How is it ordered, and is the order computed or chosen?** The first repo had a `ScoreCalculator`
  weighting importance against overdue-ness against a decaying boost, and its own KDoc argued there
  are *deliberately no absolute priority integers, because they require a global consistency the user
  will never maintain*. That argument survives the rewrite; the score may not.
- **What does a missed thing look like?** *The work-item model* settled that an untouched day closes
  as a recorded skip rather than being carried silently, so the miss is a fact and Today is where it
  becomes visible or invisible. A list that grows a tail of yesterdays is the failure mode that makes
  a tracker unpleasant to open, and the decision is now Today's alone: the record exists either way.
- **Where does unscheduled work show, and does the backlog get opened?** *The work-item model* made
  unscheduled the default for capture, and left this as a constraint rather than a question: **if
  Today has nowhere to show unscheduled work, unscheduled must not be the capture default.** A
  backlog nothing opens is what G1 rules out, and this ticket owns the call.
- **How does a routine's step tree appear?** A run tree is nested and a list is flat. Whether
  Today shows roots, leaves, or a root that expands changes what a tap means.
- **What is the second screen?** Today plus Tickets plus whatever ticket 04 and 05 leave standing is
  already four destinations, and the first repo shipped four menu rows with one of them greyed out.
  Name the navigation, do not classify it.

## Re-derivation, 2026-09-25

The map requires a ticket's archive claims to be re-derived from source before they are grilled on,
and the corrections rather than the original claims to be what the answer is built on. Four claims
were checked against the archive at `../old_loop`; **three needed correcting**, one of them fatally.
All quotations are redacted at the point of quoting. Two findings nobody asked for are recorded
after them, and they are the two that matter most.

### 1. "Do → Today, where Do was *≈ the whole app*" — half right

Today was the root, and it was the only place routines were listed. But the app had **13
destinations** in a hand-rolled sealed navigation type, and only three of them were reachable *from*
Today (the routine editor, settings, and the step runner). `Track` owned a subtree of five more —
metric, notes, recordings, take, compare — and not one was reachable from Today. Roughly half the
app hung off the other two pillars. The claim is true of the **list** and false of the **app**, and
the distinction is this ticket's whole business: a screen you can reach everything from is a
different design from a screen that is merely first.

### 2. The Today query — three corrections, all of which change the design question

The deciding clause, verbatim:

```sql
WHERE r.status <> 'SKIPPED'
  AND (r.window_key = :today OR (r.window_key < :today AND r.status = 'PENDING'))
```

- **It does not filter to roots.** The predicates are on the *root* alias; a root that qualifies
  brings its entire subtree at every status. An older leaf filter was deliberately removed, with
  filtering to leaves handed to the presenter. So the query is a tree query and the *screen* decided
  what a row was — which means the archive's answer to bullet 5 lives in the presenter, not the DAO.
- **The carry-forward has no time in it.** Overdue-ness is a `yyyy-MM-dd` **string comparison** on
  the day-window key. No `due_at`, no grace period, **no age bound and no cap**. A leftover is on the
  list because its root is still pending from an earlier window, full stop.
- **There is no `ORDER BY` in the query at all.** So "carried forward alongside the day's fresh ones"
  is true in a stronger sense than the ticket intended: leftovers were **interleaved and
  indistinguishable**.

Two deliberate behaviours worth keeping in view. Completed items **stay on the list, struck
through**, because *"seeing progress is the reward"*. A `SKIPPED` root **drops at once**, because
*"a crossed-out row for a routine the user has just stopped reads as something they failed to do."*

### 3. `ScoreCalculator` — the formula and the argument are real; the mechanic is not

The KDoc argument the ticket quotes is verbatim and survives: *"There are deliberately **no absolute
priority integers**: they require a global consistency the user will never maintain."* The formula is
real — `importance + overdue + decayed`, an unweighted sum, overdue capped at 5 days, boost decaying
on a 24-hour time constant.

**It ordered nothing.** `score()` has exactly one call site in the whole archive, in its own unit
test. Zero production callers. `boost()` and `easeOff()` exist, have no callers at all — not even
tests — and there is no boost gesture anywhere on Today. What actually ordered the list was four
comparators: terminal-last, then untimed before timed, then time of day, then display name; siblings
by `position`. The presenter states the refusal outright: *"Running a routine the same way every time
is the point of the app, and a score that reorders the list between runs actively works against
that."*

The live data closes it from the other side. **`importance` is `1` on all 42 definitions. `boost` is
`0.0` on all 210 occurrences and `boosted_at` was never set. `time_of_day` is null on 15 of 16
schedules.** Every input a computed order could have used was constant across the entire recorded
history of the app. The documented boost half-life (~3 days) is also four times its implemented one
(~17 hours), a defect the archive had already found and filed.

So the ticket's "the score may not survive" understates the finding: **there is no score to
survive.** It is a fourth instance of the map's nastiest failure shape — a formula, a KDoc argument,
a test, and no consumer — and the design question is not *keep the score or not* but *what, if
anything, has ever earned the right to order this list.*

### 4. "Four menu rows, one greyed out" — verified, and the doc that disagrees is the bug

The enum has four entries and exactly one is unbuilt: `Plan`. It is dimmed to 0.5 alpha and not
clickable. Its own reason: *"It is listed so the menu says what the app is for rather than only what
it currently does — and so that adding it later fills in a gap the user has already seen rather than
arriving as a surprise."* The file's own header comment claims three pillars are unbuilt; it is stale
and the enum wins. Not a bottom navigation bar, incidentally: a modal sheet behind a `☰`, with
installed plugins listed under a divider below the four pillars.

### 5. A check-in question was never a Today row — and the archive says where it should be

Not asked, and it decides a bullet this ticket owns. A question reached the user two ways, neither a
list row: as a **chip on a strip above the list** if it was a tally, or on a **separate pushed
screen** opened from the row of the step that asks it. On that step's row, swipe-right does not
complete it — the label becomes *"Answer"*, because *"done means answered, and a swipe that closed it
would record a check-in with nothing in it."*

The strip's reason for not being rows is the sharpest sentence either half of the archive wrote about
Today: *"Neither a tally nor the journal has a done state, and a row that can never be ticked reads
as work dodged — water you did not drink would look like a routine you skipped."*

But **no tally ever existed**: all three questions in the live database have `tally = 0`. The strip
shipped for tallies and only the journal chip ever occupied it, so it is a place built for the
journal rather than a general third affordance — a correction owed to the session working *Does
Reflect survive its own test?*, which surfaced the strip and accepted this.

And the capability this ticket needs was **built, shipped, and retracted**: recording an answer
outside any run was unplugged in 0.9.2, and is kept with six passing tests and no caller. Its own
words: *"nothing the user does belongs on a view. Kept, with its tests, because a capture outside a
run is wanted and is expected back on Today."* The archive is on the record that this belongs here.

### 6. A miss was **indistinguishable**, and `AUTO_CLOSED` is not what it looks like

The row model carries no `due_at`, no window key, no age and no `isOverdue`. The subtitle can say the
time of day, *"Covered by X"*, *"Dismissed"*, and a timing line — nothing about being late. The
status dot paints `PENDING` the same colour whatever its age. There is one flat list and the only
section divider on the screen appears while filtering. **A four-day-old leftover and a fresh row were
the same row.** So this ticket's premise that Today is where a miss becomes visible or invisible is
right, and the archive's answer was *invisible* — by omission rather than by decision.

`AUTO_CLOSED` is not the overdue tail. The tail closes as `SKIPPED` + `SUPERSEDED`. `AUTO_CLOSED` is
the cascade closing pending children when an ancestor is completed **or dismissed** — gesture-driven,
never the clock, never the day break. It counts as work *performed*, it is the only reversible
cascade marker, and its reason is visible **only in the hold menu**: *"Closed by the routine above
it."*

### 7. What the preserved day says, which is more than the archive's code does

The fixture for the prototype is **2026-09-24 at 14:34**, the day the copy was taken, read out of the
preserved database. It was not chosen for being convenient:

- **Morning Routine and Clean Kitchen were both dismissed at 09:07**, one minute after *Wake up* was
  ticked. Seven steps went `AUTO_CLOSED` behind them. The same pattern holds on the 23rd, where
  *Clean Bathroom* was dismissed with six steps behind it. The author's real use of a routine is to
  tick the first step and dismiss the rest.
- **Every one of the 19 readings in the database was recorded by completing a run** — zero rows with
  a null occurrence id, because the only path that would write one is the unplugged one. *Weigh-in*
  is a step of Morning Routine, so dismissing Morning Routine `AUTO_CLOSED` it, so **the 24th's
  weight could not be recorded at all, and no screen said so.** This is the same shape as
  *Observability*'s travel gap, arrived at by a different road and with a mechanism attached:
  coupling a capture to a run's completion loses data silently. It is the sharpest argument on this
  ticket and it belongs to Today, because Today is the only screen that could have offered the
  reading anyway.
- **The tail is one row.** In ten days, exactly one occurrence carried forward: *Cat litter*, pending
  since the 20th, four days old. The "list that grows a tail of yesterdays" is a real failure mode
  and the live evidence for it in this app is a single row — which is an argument about *what a miss
  should look like*, not about how much room to give it.
- **Snooze: 0. Reopen: 0. Estimated minutes: set on 0 of 42. Timed: 1 of 42.** Snooze's absence is
  explained rather than chosen: the two hour-sized presets are refused outright on an untimed item,
  and 41 of 42 definitions are untimed, so snooze was structurally unavailable for nearly everything
  it might have applied to.
- **There was no backlog.** Zero definitions exist with neither a schedule nor a parent. Both
  creation paths wrote a schedule unconditionally, so the archive has **no evidence of any kind**
  about where unscheduled work should live. Bullet 4 is greenfield, and the two one-offs that were
  never done — one skipped twice and superseded — are now definitions with a spent schedule and no
  live run, reachable from nothing.

### Prototype

`.scratch/product-sketch/prototypes/06-today.html` — one self-contained file, three structurally
different Today screens over this real day, at phone width. Throwaway: it is captured to a branch at
resolution and does not survive into the repo. Weight values are shifted and no third party is named;
the shape of every series is real.

### What *Does Reflect survive its own test?* hands this ticket, 2026-09-25

Read at source on resolution, not taken on report. Three things land here, and one of them is new
work this ticket's bullets did not anticipate.

- **The navigation slot is named.** Reflection is a **destination where the act happens**, not a
  surface that ranks and routes — decided by the archive's own `recordNow` line, *"nothing the user
  does belongs on a view"*, which is the same evidence this ticket re-derived for a different purpose.
  So bullet 6 is no longer conditional on another live ticket. The concept entering the documents is
  `revision`; whether the surface is still **called** Reflect is naming rather than classification,
  and that naming is explicitly **this ticket's and the vocabulary register's**.
- **Reflection is not a Today row**, and no part of it is scheduled: signal-driven, manual entrance
  always open, cadence explicitly refused. The Today-row mechanism therefore does not have to stretch
  to cover it, and the chip strip was not claimed either.
- **Capture is real and is Today's.** New: there is now **one `note`** whose subject discriminates
  over **a run, a measurement, or the day**, replacing three text boxes with three sets of rules. So
  if Today offers a place to write, it writes a `note` with one of those subjects — and *where* is a
  question this ticket owns and had not asked. It is in the prototype on all three variants,
  deliberately in three different places.

One tension it creates, and this ticket should resolve it rather than leave it: 05's flag catalogue
takes **long-blocked** precisely because *The goal-to-work edge* made a blocked item **absent** from
Today and nothing reported it. With Reflect reporting it, a "1 blocked, not shown" footnote on Today
is no longer a safety net — it is a soft contradiction of *absent*, and it should probably go. It is
drawn in variant C so the cost of keeping it is visible rather than argued.

The auto-closed weigh-in stays here. 05 records the third cause of a gap at **dismissal** time, which
makes later dormancy and stall computations correct, but that is after the fact; the loss happens at
**capture** time and Today is the only screen that could have prevented it.

## Round one, settled 2026-09-25

Five of the ticket's questions are answered. Recorded here rather than held in a session, because the
sixth question was reopened by the answer to the second and the ticket is not yet resolvable.

- **Order is the structure's, not a rank.** Roots in an order set once and changed by dragging; steps
  by position. No score, and it becomes a line in *what is not built*. One computed element survives:
  **terminal-last**, so finished work sinks but stays visible, struck through — which is the archive's
  *"seeing progress is the reward"* kept for its own reason rather than inherited.
- **A miss is a fact on the record, not a row on Today.** The day's dismissals collapse to one line.
  **The cap is replaced by the opt-in**: *The work-item model* already made carry-forward per-item, so
  the tail holds only work explicitly asked for and is bounded by a choice rather than by an invented
  number. In ten days it held exactly one row, four days old.
- **Unscheduled work shows on Today, in an `Offered` band at the foot, and it is the backlog itself
  rather than a slice of it** — because any rule for choosing which unscheduled work to show is a
  score under another name. **Adopted provisionally, by the author, to be judged in use.** The
  evaluation already exists and needs nothing new: *What a goal is*' falsifier — an uncited backlog
  growing monotonically for two weeks — is the signal, and *Does Reflect survive its own test?*'
  **backlog-dodging** flag is what reports it. If it fails, the pre-registered remedy is the backlog
  destination that the navigation answer below declines.
- **A reading is a row, and it ticks.** The archive's strip argument — *"a row that can never be
  ticked reads as work dodged"* — does not reach a reading: a tally is unbounded and the journal has
  no done state, but a reading due today is recorded or it is not. They were grouped because both
  lived under Track, not because they behave alike. The row is **independent of any run**, which is
  what stops a dismissal three levels up from destroying a measurement, and the step-attached
  check-in stays as a convenience. The row disappears once any source has supplied the day's value.
- **The navigation is four destinations: Today, Goals, Metrics, and the reflection surface.** The
  backlog does not earn one, because `Offered` is the whole of it and a destination would be a second
  place for the same thing. Four without a greyed row, where the archive had four with one.

### Q2 is reopened, because the author corrected the reason under it

The recommendation was *roots that expand*, argued partly from a reading of the author's use — tick
the first step, dismiss the rest — that the author says is **coincidental**. The real act is *tick the
steps I do and dismiss the ones I know I am not going to do*. That is a **per-step** judgement, and
collapsing the routine hides the unit of the decision.

Re-derived from the run log rather than from the two days the first reading generalised from, and it
splits cleanly. **14 of 23 dismissals are at step level, not root.**

| Routine | Step runs | Done | Dismissed individually | Root rolled up | Root dismissed whole |
|---|---|---|---|---|---|
| Morning Routine | 49 | 21 | **7** | 4 | 3 |
| Night Routine | 41 | 17 | **6** | 3 | **0** |
| Clean Bathroom | 30 | 6 | **0** | 1 | 1 |
| Clean Kitchen | 14 | 3 | **0** | 1 | 3 |

Two classes, wanting opposite things. **Morning and Night are worked through step by step** — high
completion, individual dismissals, roots that roll up, and Night Routine's root was never once
dismissed wholesale. **Clean Kitchen and Clean Bathroom are never judged per step** — a fifth of their
steps get done and not one was ever dismissed individually; they are dropped whole or left to be
superseded. They are also the routines the author names as candidates for the reflection surface,
*"since I rarely if ever do them"* — which is `Rarely done` from 05's catalogue, confirmed from the
author's own data at 6/30 and 3/14 before the flag has been built.

So a global answer gets one class wrong either way: collapsing costs a tap every day on the two
routines used most, and expanding spends six rows of Today on work done a fifth of the time. The
hoisting objection also sharpens — `Sweep` and `Mop` are steps of **both** cleaning routines, and
those are exactly the two that should not be expanded.

Drawn as **variant D** in the prototype, alongside everything above, so the composite can be judged
rather than the pieces.

## Answer

**Today is the frontier, and the frontier is not the schedule's output.** The charting hypothesis —
*due plus unblocked and worth doing, in one list rather than two screens* — holds, and the reason it
holds is narrower than the hypothesis: the schedule's claim on the day and what is merely worth doing
are **different claims that belong on one screen**, because a backlog behind a destination is the
thing `GOALS.md` G1 rules out. One screen, two claims, visibly labelled.

Six classes of thing are on it: **runs the schedule materialized**, **runs carried forward by an
explicit choice**, **readings a metric wants today**, **unscheduled definitions offered**, and
nothing else. Blocked work is **absent**, per *The goal-to-work edge*. Reflection is not here at all.

### The order is the structure's, and there is no score

Roots in an order set once and changed by dragging; steps by `position`. **Terminal-last** is the one
computed element, so finished work sinks while staying visible and struck through — the archive's
*"seeing progress is the reward"*, kept for its own reason rather than inherited.

`ScoreCalculator` is not weighed and rejected; **it never ran**. Its formula is real, its argument is
real, and `score()`'s only caller in the whole archive is its own unit test. `boost()` has no caller
at all and no gesture anywhere. The data closes it from the other side: `importance` is `1` on all 42
definitions, `boost` is `0.0` on all 210 occurrences, `time_of_day` is null on 15 of 16 schedules.
**Every input a computed order could have used was constant across the app's entire recorded life.**

The argument the archive wrote survives its own mechanic and is adopted verbatim as the reason: *"There
are deliberately no absolute priority integers: they require a global consistency the user will never
maintain."* So does the presenter's, which is the sharper half: *"Running a routine the same way every
time is the point of the app, and a score that reorders the list between runs actively works against
that."* **A score is a line in *what is not built*,** and it is the cheapest line on this map to write,
because it costs a deletion rather than a refusal.

### Expansion belongs to the definition, and this is the answer the author's correction bought

A routine is neither one row nor its steps. **It is one row or its steps according to a property of the
definition,** set once and changed when it is wrong.

The first recommendation was *roots that expand*, argued partly from the reading that the author ticks
the first step and dismisses the rest. The author corrected it: the act is *tick the steps I do and
dismiss the ones I know I am not going to do*, and the first-step coincidence is a coincidence. That is
a **per-step judgement**, and the run log agrees against the two days the first reading generalised
from — **14 of 23 dismissals are at step level**. The table is in the round-one record above. Morning
and Night are worked through step by step and Night Routine's root was **never once** dismissed
wholesale; Clean Kitchen and Clean Bathroom had **not one** step dismissed individually in ten days.

So the two classes want opposite shapes and a global answer gets one of them wrong: collapsing costs a
tap every day on the two routines actually used, and expanding spends six rows on work done a fifth of
the time. This is the same principle as the order rather than a second knob — **both are properties you
set once**, which is the whole of this screen's answer to *computed or chosen*.

**Hoisting is refused**, and the data says why rather than taste: `Sweep` and `Mop` are steps of **both**
cleaning routines, so a flattened list draws `Sweep` twice with nothing naming the room — and those are
exactly the two definitions that should not be expanded.

### A miss is a fact on the record, not a row

The day's dismissals collapse to one line. Nothing is lost by this, because the record is already
complete: *The work-item model* made an untouched day a recorded skip, so the miss exists whether or not
Today draws it.

**The cap is replaced by the opt-in.** Carry-forward is already per-item, so the tail holds only work
explicitly asked for and is bounded by a choice instead of by an invented number — variant C's cap of
two was drawn precisely to show that it invents one. In ten days the tail held exactly one row, four
days old. The archive's answer here was *indistinguishable*: its row model carries no age, no window key
and no `isOverdue`, so a four-day-old leftover and a fresh row were the same row. That was invisibility
by omission; this is visibility by decision, and the age is on the row.

### Unscheduled work is on Today, and the band is the backlog itself

An **`Offered`** band at the foot, visible without a tap, holding the whole uncited backlog rather than a
selection from it — because any rule for choosing *which* unscheduled work to show is a score under
another name, and the section above has just refused one.

This discharges *The work-item model*'s constraint — *if Today has nowhere to show unscheduled work,
unscheduled must not be the capture default* — so **capture may default to unscheduled**, and it is
greenfield rather than a port: the archive has **zero** definitions with neither a schedule nor a
parent, because both creation paths wrote a schedule unconditionally. Its two undone one-offs are now
definitions with a spent schedule and no live run, reachable from nothing at all.

**Adopted provisionally, by the author, to be judged in use** — and the evaluation needs nothing new.
*What a goal is*' falsifier is the signal (an uncited backlog growing monotonically for two weeks) and
*Does Reflect survive its own test?*' **backlog-dodging** flag is what reports it. If it fails, the
pre-registered remedy is the backlog destination the navigation below declines.

### A reading is a row, and it ticks

The archive's strip argument is the best sentence it wrote about this screen — *"Neither a tally nor the
journal has a done state, and a row that can never be ticked reads as work dodged — water you did not
drink would look like a routine you skipped"* — and **it does not reach a reading.** A tally is
unbounded and the journal has no done state, but a reading due today is recorded or it is not. They
were grouped because both lived under Track, not because they behave alike, and the live data shows the
group was never even populated: all three questions have `tally = 0`, so no tally chip was ever drawn.

The row is **independent of the run that used to carry it**, and this is the decision the preserved day
forced. Every one of the 19 readings in ten days was recorded by completing a run — zero with a null
occurrence id, because the only path that would write one is the one the archive unplugged. *Weigh-in*
is a step of Morning Routine, so **dismissing Morning Routine at 09:07 auto-closed it, and the 24th's
weight could not be recorded at all while no screen said so.** Coupling a capture to a run's completion
loses data silently; *Observability*'s third cause of a gap — *the measurement was not possible* —
turns out to have a mechanism, and the mechanism is on this screen. *Does Reflect survive its own test?*
records that cause at dismissal time, which makes later dormancy and stall computations correct, but the
loss happens at capture time and Today is the only screen that could have prevented it.

The step-attached check-in **stays** as a convenience — answering while doing the thing is why it was
built, and its swipe-right correctly reads *"Answer"* rather than completing it. The row disappears once
any source has supplied the day's value.

This is also the capability the archive **costed and retracted rather than refused**: recording outside a
run was unplugged in 0.9.2 and kept with six passing tests, annotated *"a capture outside a run is wanted
and is expected back on Today."* It is back on Today.

### The day's note is written on the date

*Does Reflect survive its own test?* gave the model one **`note`** whose subject discriminates over a run,
a measurement, or the day, and gave Today the capture. Runs and readings have rows, so their notes belong
to those rows and need no new affordance. The day has no row — and giving it one would be exactly what the
strip argument refuses.

**So the app bar's date is the day's handle.** Today already prints the date and the date *is* the
subject; a `✎` there is one affordance, no new structure, and nothing that can be mistaken for work
dodged. The alternative was reviving the strip, which is a structural element brought back for a single
chip — and the strip's precedent is thinner than it looks: it was a place built for the journal that only
the journal ever occupied.

### Four destinations, and the fourth is called **Revise**

**Today, Goals, Metrics, Revise.** Four, where the archive had four with one greyed out — and the greyed
row's stated reason (*"so the menu says what the app is for rather than only what it currently does"*) is
not needed, because nothing here is unbuilt-but-promised.

The backlog does **not** earn a destination: `Offered` is the whole of it, and a destination would be a
second place for the same thing.

The reflection surface's **name** was handed here by *Does Reflect survive its own test?*, which settled
the concept as `revision` and left the naming to this ticket and to the register. **It is not called
Reflect.** `Reflect` is the analogy's word for a pillar whose concept was refused, and keeping it would
be a word in the navigation whose meaning the model no longer contains — the collision `CONTEXT.md`
exists to prevent, arriving by the exact route the map's Notes warn about. It is **`Revise`**, the
concept's own verb.

Three nouns and one verb is the right asymmetry rather than an inconsistency: **three places you look,
one place you act.** That is *"nothing the user does belongs on a view"* — the archive's own line, which
decided that surface was a destination in the first place — read off the navigation bar.

### What this answer contributes to *what is not built*

- **A priority score, of any kind.** Named, with the archive's argument and the constant-input evidence.
- **A progress bar**, inherited from *The goal-to-work edge* and drawn nowhere here.
- **A distinct overdue treatment** beyond the age on the carried row — no badge, no section, no
  sort-to-top.
- **A backlog destination**, conditionally: the pre-registered remedy if `Offered` fails in use.
- **Reordering by anything the app computes.** The order is set; the app does not have an opinion.

### Consequences this answer spends

- **`SALVAGE.md` is untouched.** No entry consumed. The schedule engine and the cascade are used exactly
  as ported; the one subtraction on this screen was already named by *The goal-to-work edge*.
- **A dependency handed to *The input vocabulary***, which this ticket unblocks: **two properties must be
  editable** — a root's order and a definition's expansion. *Set once* is a promise about a screen that
  does not exist yet, and if editing them is awkward both this answer's order decision and its tree
  decision degrade quietly. That is the honest cost of both, and it lands on the ticket that owns taps.
- **Two words for the register**, neither asserted here: **`Offered`** (the band, and whether it is the
  same word as *backlog* or a second one) and **`reading`** (a value in a metric's series, against the
  archive's `observation`). Handed to *Register the vocabulary and the ADRs this map owes*, with `Revise`
  as the surface's settled name.
- **A fifth stale-survey shape, from this ticket's own first draft**: *a pattern inferred from the two
  most recent days of a ten-day window.* The recorded day showed two wholesale dismissals and the ten
  days showed the opposite, and it was the author and not the data that caught it. It sits beside the
  fourth shape — a count read as a verdict across a window in which the feature did not exist.
- **A confirmation *Does Reflect survive its own test?* has not got yet**: its `Rarely done` flag is
  confirmed from the author's own use before being built, at 6/30 and 3/14, and the author names those
  two routines unprompted. Its `Long-blocked` flag also becomes **load-bearing rather than
  belt-and-braces** — Today draws no footnote for suppressed work, because a footnote is a soft
  contradiction of *absent*, so if that flag is cut from the first slice, work can be removed from a
  person's life with nothing anywhere reporting it.

### What this answer does not decide

- **Which gesture does any of it.** *The input vocabulary* owns that, including the one this screen
  creates: a tap on an expanded routine's row, where the archive's leaf tap did nothing at all.
- **Whether any of this is in the first slice.** `Offered`, the reading row and the note are three
  separate lines *The first shippable slice* may draw differently.
- **Reminders.** The fog patch that waited on Today is now sharp and graduates to its own ticket, with
  one fact in hand: the archive shipped a `remind` flag on every schedule and **it is `0` on all 16**.

### Prototype

Four variants over the real day of 2026-09-24, the fourth being the composite of everything above.
Captured to the throwaway branch `prototype/06-today` and removed from the working tree; it does not
survive into the repo, per this ticket's own charter.
