# Today: what is on it, and how is it ordered?

Type: prototype
Status: claimed
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
