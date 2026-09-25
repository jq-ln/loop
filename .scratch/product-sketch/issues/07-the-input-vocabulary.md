# The input vocabulary: which actions exist, and which gesture means what

Type: prototype
Status: resolved
Blocked by: 06

## Question

The first repo had a `docs/ACTION_VOCAB.md` and nothing in this repo owns that claim. The scope
boundary is already set by the map: the **vocabulary** is decidable at a desk and is this ticket's
business; the **feel** — thresholds, animation, discoverability — needs a device and is out of scope.

- **What is the full set of acts on a work item?** Candidates from the first repo's model: complete,
  complete off-list, skip with a reason, snooze, dismiss, reopen, boost, start a timer. Each one that
  survives must name the state it writes. `closed_reason` exists because `SKIPPED` was written by four
  paths and only one meant the user did not do something — so a vocabulary that collapses them makes
  *"how often do I skip things"* wrong rather than merely imprecise.
- **Which acts are reversible, and is reversal exact?** The cascade computes a whole plan before
  writing anything, which is what makes undo exact, and reversal must reach only what this completion
  satisfied. Whatever the gesture is, undo is a real guarantee here and should be spent deliberately.
- **One gesture, one meaning, everywhere.** A swipe that completes on Today and dismisses on Tickets
  is the defect this ticket exists to prevent. The output is a table of gesture to meaning that holds
  across every surface, including the ones ticket 06 names.
- **What is reachable without a gesture?** Gestures are undiscoverable and this app has exactly one
  user, who will know them. That argues for gestures as accelerators over an always-visible path, not
  instead of one.
- **What does entering a thing look like?** Filing is the act the tracker analogy makes central, and
  the first repo's creation paths always wrote a daily schedule with no way to opt out. Ticket 01
  decides whether unscheduled is creatable; this one decides how many taps it costs.

## Re-derivation, 2026-09-25

Per the map's Notes, every archive claim in the question above was re-derived from source before
grilling. **Four of the five were wrong or incomplete, and the correction changes what this ticket
is about.** Archive paths are quoted with the package owner redacted as `<user>`.

### The archive has a complete action vocabulary, and a list of its own defects

`docs/ACTION_VOCAB.md` exists and is 220 lines. It is not a stub: §1 is the gesture, symbol and
commit-word inventory, §2 the by-surface listing, and **§3 is nineteen numbered inconsistencies the
archive found by surveying its own code and never resolved**. That third section is the more
valuable half and the question above did not know it was there.

The gesture table, verbatim in substance: **tap** unfolds or opens; **press and hold** opens the
row's menu; **hold, then move** drags to reorder; **swipe right** is Done; **swipe left** is
Dismiss; **Return** adds an item in the note sheet and is a newline in the journal sheet; **back**
leaves, losing nothing because everything writes as it goes. A swipe commits on 144 dp travelled at
release, never on velocity. Only two acts ask first — **Delete routine** and **Import** — and the
stated rule is *only irreversible acts ask*.

### Correction 1 — `closed_reason` has five values, not four, and none of them is a user act

`ClosedReason` (`core-routine/.../core/routine/occurrence/ClosedReason.kt`) has **five** constants —
`SUPERSEDED`, `SCHEDULE_PAUSED`, `SCHEDULE_REMOVED`, `SCHEDULE_CHANGED`, `REVERSAL` — written from
**seven** call sites across three repositories. Its own header still says *"`SKIPPED` is written by
four paths"*: the docstring is stale against the enum it heads, and `SALVAGE.md` and this ticket
both inherited the stale number. The archive's own documentation is a survey that went stale in
place, which is the map's fourth warning arriving from a new direction.

More important than the count: **`closed_reason` is not a reason the user gives.** It is the app's
own bookkeeping about why *it* closed a tree. There is no gesture anywhere that writes a skip. The
user's "I am not doing this" is a different status entirely — `DISMISSED` — and `DISMISSED` carries
**no reason column at all**. So *skip with a reason* is not a candidate act to keep or cut; **it
never existed**, and what the vocabulary actually has to decide is whether a reason is attached to
**dismiss**.

### Correction 2 — *Preserve the running database*'s finding 2 is over-read, and the correction matters

That ticket recorded *"every one of the 56 `SKIPPED` rows is a machine skip"* and *"a database
holding no recorded user skip"*. The counts are exactly right and re-confirm: 40 `SUPERSEDED`,
16 `SCHEDULE_CHANGED`, none null. The reading is not.

`SUPERSEDED` has two write sites and both mean *the routine was due, the day ended, it was not
done* — `OccurrenceGenerator.supersede` at the day break, and `bringFollowersRound` closing an
earlier day's leftover the generator's clock never reaches. The enum's own comment calls it *"the
one genuine skip"*. It is machine-**written** and user-**caused**, and those are different claims.
The 40 rows land on **8 of the 10 days** (1, 8, 4, 1, 3, 5, 13, 5), which is a daily lapse pattern
and not a one-off bookkeeping event.

So the honest answer to *how often do I skip things* over the baseline is **40 lapses and 23
dismissals**, and only the 16 `SCHEDULE_CHANGED` are noise. The conflation the column exists to undo
is real; the claim that the data holds no user skip is the opposite error, and would have cost this
ticket the distinction it most needs: **a lapse and a dismissal are both the work not happening, and
only one of them is an act.**

### Correction 3 — five of the eight candidate acts have zero recorded use, and two have no gesture

Every one of these is a count over the preserved ten days, from the `occurrence` table's own
columns.

| Candidate act | Mechanism in the archive | Use in ten days |
|---|---|---|
| Complete | `complete()`, swipe right | **68** (15 root, 53 step) |
| Dismiss | `dismiss()`, swipe left | **23** (9 root, 14 step) |
| Complete off-list | `completeNow()`, *Not today* row hold | **0** |
| Put on today | `putOnToday()`, *Not today* row hold | **0** |
| Snooze | `snooze()`, *Later* chips | **0** (`snoozed_from` null on all 210) |
| Reopen / un-complete | `revert()`, row menu | **0** (`reopened_count` 0 on all 210) |
| Boost | `boost()` / `easeOff()` | **0**, and **no caller anywhere** |
| Start a timer | `TimingRepository` | **0** (`occurrence_timing` holds no rows) |
| Note on a run | `setNote()`, row menu | **2** |

Two of these are stronger than disuse. **`boost()` and `easeOff()` have no caller in the entire
archive** — not a dead gesture, no gesture, and `boost` is `0.0` on all 210 rows. *Today* already
established that `ScoreCalculator.score()` never ran; this closes it from the input side, and the
two findings are the same finding: the whole priority mechanic was built with neither a producer nor
a consumer.

**Nothing was ever added to Today by hand.** All 64 root occurrences were materialized by the
generator — the smallest gap between `due_at` and `created_at` across every root is **17 minutes**,
where both hand-add paths materialize at `now()` and would show a gap of under a second. So the two
acts the *Not today* menu exists for were both offered for ten days and taken zero times.

### Correction 4 — un-complete is refused exactly where it is most wanted

`CompletionCascade.REVERTIBLE` covers `DONE`, `DONE_SHARED`, `AUTO_CLOSED`, `ROLLED_UP` and
`DISMISSED`, and excludes `SKIPPED` deliberately: *"the one terminal status nobody asserted and
nobody can retract."* But membership is necessary and not sufficient — `leavesWorkToDo` refuses any
reversal that would hand the user nothing to do, so **a routine every step of which was really done
cannot be un-completed**; the user must reopen a step and let the ancestor rule carry the parent.
The row menu draws *Un-complete* either way and replaces it with a line saying why not.

### Confirmed as stated

- The cascade **computes the whole plan before writing anything** — `CascadePlan` is *"the complete
  effect of one user action, computed before anything is written"*, the `from` status on every
  transition is what undo restores, and reversal reads `satisfied_by` rather than the dedup key so
  it reaches **only** what this completion satisfied. Exact undo is real and is the archive's best
  engineering.
- `UndoRecord` is **held in memory for the snackbar's life and deliberately not persisted**:
  *"an undo that survives a process death would let the user reverse something they can no longer
  see."*
- A leaf tap **does nothing** unless it is a plugin step or a check-in, which is the gesture hole
  *Today* handed here.
- Both creation paths wrote a schedule unconditionally, as *Today* found.

### Correction 5 — a zero is not a verdict until you know the act was offered

The table above is the count of acts **taken**. Three of the zeros are not disuse, and separating
them is the whole of what the archive's first shape — *a capability the archive costed and
retracted* — looks like when it arrives as a number instead of a comment.

**Complete off-list and Put on today were offered behind a filter.** Both live in Today's *Not
today* group, and `TodayScreen`'s own comment says it is **"only ever drawn under a filter"**. The
user had to type a name into the filter field to see a routine that was not due, and then hold its
row. Ten days of zero is a fact about the filter, not about the acts.

**Snooze was structurally unofferable on half the day.** `SnoozePreset.at` returns null for *In an
hour* and *In three hours* on any routine with no time of day, and null for *Tomorrow* when it
lands at or past the rule's next firing. For a **daily untimed** routine, tomorrow's day break
*is* the next firing, so **no preset qualifies and the *Later* section is absent from the menu
entirely** — which the view model states outright: *"an offer that cannot be taken is worse than no
offer."*

Against the schedules actually in the database — 4 daily untimed, 1 daily timed, 1 every-two-days,
2 weekly, 8 spent one-offs — that resolves to a count:

| | root runs | could a snooze chip appear? |
|---|---|---|
| `FREQ=DAILY`, untimed | **34** | **never** |
| `FREQ=DAILY`, timed | 10 | yes, all three presets |
| `ONE_TIME` (spent, unlimited) | 9 | yes, *Tomorrow* |
| `FREQ=WEEKLY` / `BYDAY=WE` | 7 | yes, *Tomorrow* |
| `FREQ=DAILY;INTERVAL=2` | 3 | yes, *Tomorrow* |
| no schedule row | 1 | yes, *Tomorrow* |

So **34 of 64 root runs — 53% — could never have been snoozed**, and that is exactly the daily
recurring work that fills Today. The remaining 30 were genuine offers and were taken zero times.
Snooze's zero is half a design defect and half a real signal, and only the second half is evidence
about the act.

**The timer, by contrast, is a clean zero.** `▶` / `⏸` was drawn on any row with a clock configured,
took no filter and no qualifying rule, and `occurrence_timing` holds no rows. Same for **boost**,
which is cleaner still: there was no gesture to take.

## Answer

**One meaning per gesture, everywhere. A meaning may be *absent* on a surface; it may never be
*different*.** That single rule generates the whole table, and the reason it can is that the
inventory turned out to be much smaller than the archive's — four of the eight candidate acts do not
survive, and one of them never existed.

### The act set

In: **complete, dismiss, un-complete, snooze, defer, note, record a reading, edit** — plus
**commit** and **abandon** on an `Offered` row.

Out, with the reason each is out, because they are not the same kind of cut:

- **Skip with a reason** — *never existed*. `closed_reason` is the app's bookkeeping about why *it*
  closed a tree, not a reason the user gives, and no gesture anywhere writes a skip.
- **Boost** — *no gesture and no caller*. `boost()` and `easeOff()` are unreferenced in the entire
  archive, which closes *Today*'s `ScoreCalculator` finding from the input side: the priority
  mechanic had neither a producer nor a consumer.
- **Complete off-list** and **put on today** — *absorbed, not cut*. They were filter-only acts
  solving a visibility problem, and they return below with a real home.
- **The timer** — *a clean zero*. Drawn unconditionally on any row with a clock, no filter, no
  qualifying rule, ten days, and `occurrence_timing` holds no rows. This is the one act whose zero
  is a verdict, and it is the second-cheapest line in *what is not built* after the score.

**`snooze` pushes a run later today; `defer` pushes to another day.** Two words because two objects,
per *The work-item model*, and this ticket owes that decision its presets.

### The table

| Surface | Row | tap | hold | swipe → | swipe ← | rail | chevron |
|---|---|---|---|---|---|---|---|
| Today | root, branch | detail | menu | Done | Dismiss | reorder roots | fold |
| Today | root, leaf | detail | menu | Done | Dismiss | reorder roots | — |
| Today | step | detail | menu | Done | Dismiss | — | — |
| Today | finished row | detail | menu | — | — | reorder roots | fold |
| Today | reading | detail | menu | Record | — | — | — |
| Today | `Offered` row | detail | menu | Done | — | — | — |
| Today | search result, not due today | detail | menu | Done | — | — | — |
| Today | the app bar's date | the day's note | — | — | — | — | — |
| Goals | goal | detail | menu | — | — | — | — |
| Metrics | metric | detail | menu | — | — | — | — |
| Revise | flag | detail | menu | — | — | — | — |
| Routine editor | step card | detail | menu | — | — | reorder steps | — |

A dash is **absent**, never disabled. The six meanings: **tap** opens this thing's detail; **hold**
opens the complete menu of acts on this row; **swipe →** discharges this row; **swipe ←** refuses
this run; **rail** reorders; **chevron** folds for this session.

**Membership is decided by the object, not by the row.** An act whose object is the run's *day*
belongs to the root — snooze, defer, the rail. An act whose object is the *work* belongs wherever
the work is — complete, dismiss, note. One sentence instead of a per-row inventory, and it predicts
the answer for every act added later.

### What the table settles that the archive could not

**Tap opens, with no exception, and folding gets the chevron.** The archive's leaf tap did nothing
at all except on a plugin step or a check-in, which its own §3 listed as a defect and never fixed.
Tap-opens-detail fills that hole and gives notes, history, prerequisites and the cited goal a home
that is not a hold menu. It costs a smaller fold target on the screen used most, which *Today*
had already paid down by making expansion a stored property.

**Expansion is layered.** The stored property from *Today* is the row's **default**; the chevron
folds for this session only and writes nothing; the property is changed from the hold menu. Peeking
costs nothing and leaves nothing behind, which is what keeps *set once* honest.

**The rail is a property of a draggable row, not a screen fixture** — the author's generalisation,
and better than the recommendation it replaced. Two surfaces have one: Today's **roots** and the
routine editor's **step cards**. Steps get none on Today, because their order is the definition's
`position` and dragging one there would be editing a definition from inside a run.

This is the decision that pays for itself three times. The archive arbitrated drag against menu on
one hold, so its haptic tick fired before it knew which it was, the timeout was device-dependent and
lengthened with the accessibility setting, and reordering ended up as drag in one place and `↑`/`↓`
buttons in another. Giving drag its own target retires **§3 items 5, 6 and 18** together, and the
archive's *"the rail is a mark, not a target"* is overturned deliberately rather than drifted from.

**Swipe → discharges the row, and the input writes as it goes.** The archive listed *"swipe right
completes most rows but opens the questions on a check-in"* as its §3 item 2. That was the wrong
defect to name: the labels *Done* / *Answer* / *Record* carry a narrowing, not a second meaning. The
real defect is one its list of nineteen **missed** — the check-in **stages** its answers and writes
nothing until *Done*, in an app whose own gesture table promises *back loses nothing, because
everything writes as it goes*. The recorder is the same. Killed here: a reading writes on entry,
there is no *Done* button, and *Done* keeps the one meaning it has in the editor, which is **leave**.

This is not tidiness. *Today* already found that a dismissal at 09:07 silently destroyed a day's
weight; a staged check-in is the identical loss by a second route, and both are cases of a capture
being coupled to something that can be abandoned.

**An unavailable act is absent, not present-and-explained.** `CompletionCascade`'s `leavesWorkToDo`
refuses any reversal that would hand the user nothing to do, so a routine every step of which was
really done cannot be un-completed — the user reopens a step and the ancestor rule carries the
parent. The archive drew *Un-complete* anyway and swapped in a line saying why not. Here it is gone
from the menu, consistently with *The goal-to-work edge* making blocked work **absent** from Today
rather than dimmed, and with the archive's own view model, which had already reached this rule for
snooze chips and never generalised it: *"an offer that cannot be taken is worse than no offer."*

**The hold menu lists every act on the row, gestures included.** The archive's menu held
*Un-complete, Reset timer, Later, Add note, Edit* — and not *Done*, not *Dismiss*, the two acts that
matter. Adding them costs two lines and makes the menu the artifact this ticket was asked to
produce: a complete, per-row inventory of the vocabulary, readable on the device without opening a
document. With the absence rule above, it is also **checkable** — what you can do to a row is
exactly what is in it, so a `docs/ACTION_VOCAB.md` that drifts from the code is visible on the phone
rather than only in a survey.

**Gestures are bound only where there is a daily rhythm.** Goals and Metrics bind tap and hold;
Revise binds tap alone, because dismissing a flag takes a dated reason and a bare swipe cannot carry
one. Declaring a goal satisfied is cheap and retractable enough to swipe and still does not get one:
it happens a handful of times a year, so the accelerator would buy muscle memory that never forms,
at the cost of the guarantee that a swipe in this app always means the same thing.

### Snooze's presets, and why the archive's could not be ported

*The work-item model* ruled the untimed-snooze defect **fixed, not ported**, and kept the same-day
limit with its reason. The presets that satisfy both are **day-part anchors — *This morning* /
*This afternoon* / *This evening*** — each offered only while still ahead of both now and the run's
due time. One list for timed and untimed rows alike, which is the one-meaning rule applied to a menu
rather than a gesture, and it keeps the archive's *"presets rather than a picker, because the case
this exists for is fast."*

When every anchor is behind you the section is **absent**, and what remains is **Defer…**. That is
correct rather than a fallback: late evening is exactly where *later today* stops being a
distinction, and defer's object was always a definition for a named day.

### Capture, and the one field

**One text field, in the `Offered` band's header, searching every definition; capture is a result
row** reading **Create "…"**. This revises the round-one recommendation that capture get its own
affordance — two text fields on Today is worse than the discoverability problem that recommendation
was avoiding, and a labelled result row is discoverable where the archive's `+`-appears-inside-a-
filter was not.

The collapse earns three things at once. The search **is** the duplicate check, so filing starts by
showing you what you already have. It is the home the two absorbed acts needed: a searched
scheduled-but-not-today row takes **swipe → Done** (materialise and complete, the archive's
`completeNow`) and **hold → Put on today**, with **no swipe ←**, because there is no run to refuse.
And capture itself asks **nothing** — no goal, no schedule, no shape — landing uncited in `Offered`,
where *What a goal is* gates citation at commitment rather than capture. The archive's dialog asked
*Routine or Tally?*; *The work-item model* collapsed the categories, so the dialog has nothing left
to ask and the act is one line of typing.

### Defer disposes of today's run by dismissing it, and the link says it moved

Three readings were available and they produce three different answers to *how often do I skip
things*. Leaving the run to lapse is wrong: you did not forget, and filing a deliberate act as a
passive miss is precisely how the archive's `SKIPPED` became unreadable. A new *moved* status is the
tempting one and is the trap — a sixth reason on a column this ticket has just pruned to zero
user-facing ones, encoding something a link already carries.

**The dismissal answers *did the work happen today?* — no. The link answers *why not?* — because you
moved it.** Two questions, two places, consistent with dismissal staying reasonless on the fast
path, and the deferred-from-refused distinction stays recoverable from the data without the
vocabulary carrying it.

### Dismissal takes no reason, and where the reason lives instead

Taxing the most-used negative act with a picker is how a fast path dies, and the row already has a
note. The reason machinery exists on **Revise**, where *Does Reflect survive its own test?* put it: a
flag is dismissed with a dated reason, and that is where *Observability*'s third cause of a gap —
*the measurement was not possible* — is finally recorded.

The cost is a **latency**, and it should be named rather than discovered: a reading lapses on day
one and its reason is written on day three. The pre-registered falsifier is that if Revise keeps
surfacing flags that can only be explained by recalling a dismissal from days ago, the reason wanted
capturing at the moment and a reading wants a swipe ← after all — which would be the first thing to
overturn *swipes only where there is a daily rhythm*.

### `Offered` has exactly two exits, and neither is a delete

**Commit** — cite a goal and give it a schedule or a prerequisite, at which point it is no longer the
uncited backlog and leaves by definition. Or **abandon** — *What a goal is*' state, extended from
goals to definitions, dated and retractable. Both in the `Offered` row's hold menu.

This is what makes that ticket's falsifier mean anything. The backlog grows monotonically for a
fortnight **only if you are neither committing nor abandoning**, which is exactly the dodge the
citation rule was written to catch. A delete would let you clear the evidence and keep the habit.

### The prototype

A single self-contained file driving the table through seven cases, captured to the throwaway branch
`prototype/07-vocabulary` and removed from the working tree; it does not survive into the repo. The
table and the simulator are generated from **one** data structure, so a walkthrough that disagreed
with the table would be a real contradiction rather than a copy drifting.

It is a **logic** prototype and not a look-and-feel one, which is the right branch for this ticket
and worth recording as such: the map puts feel out of scope, so density and discoverability are not
what it can answer. What it *can* answer is whether the vocabulary is consistent and whether it
survives the cases that cannot be held in the head at once — defer's dismissal-plus-link, the
reversal that is absent rather than refused, the anchors running out, the 09:07 dismissal leaving
its reading alive, the reading that lapses with its reason arriving later, capture as a search
result, and `Offered`'s two exits. All seven hold.

**Reviewed on sight by the author, 2026-09-25, and passed.**

### What this answer contributes to *what is not built*

- **The timer**, with the clean-zero evidence: offered without condition, ten days, no rows.
- **Boost and ease-off**, which are the score's input half and cost a deletion rather than a refusal.
- **A reason on a dismissal**, with the Revise latency named as its price and its falsifier.
- **A gesture on any surface but Today**, and the argument for it rather than an omission.
- **A delete on the daily path.** Abandon is a state; nothing in the vocabulary destroys a record.

### Consequences this answer spends

- **`SALVAGE.md` is amended, not merely consumed.** Its *"`SKIPPED` was written by four paths"* is
  inherited from a docstring that went stale against its own enum: there are **five** reasons and
  **seven** call sites. The entry should be corrected at port time rather than ported as written.
- **A correction to *Preserve the running database*'s finding 2**, recorded above. Its counts are
  exact; its reading that the data holds no user skip is the opposite error to the one it was
  guarding against, and the honest baseline is **40 lapses and 23 dismissals**.
- **Six words for the register**, handed to *Register the vocabulary and the ADRs this map owes*:
  **discharge** (what swipe → means), **refuse** (what swipe ← means), **anchor** (a snooze preset),
  **commit** and **abandon** (the `Offered` exits, the second extending *What a goal is*' state from
  goals to definitions), and **rail**. `snooze` and `defer` are already that ticket's from
  *The work-item model*; this answer fixes their gloss — *snooze pushes a run later today, defer
  pushes to another day*.
- **An ADR owed at port time**: the check-in's staged commit is deleted and every capture writes on
  entry. It is hard to reverse, surprising without the reason, and the archive shipped the opposite
  deliberately — the three tests an ADR has to pass.
- **A dependency discharged**: *Today*'s two editable properties both have affordances — root order
  on the rail, expansion in the hold menu — so *set once* is no longer a promise about a screen that
  does not exist.
- **A dependency handed to *The first shippable slice***: the table is the whole vocabulary, not the
  slice's. `Offered`'s search, defer, the reading row and the day's note are four lines that ticket
  may draw differently, and cutting **defer** would take the deferred-from link with it and make
  dismissal ambiguous again.
- **Nothing handed to the fog.** Every question this ticket opened is answered or explicitly priced.

### What this answer does not decide

- **Thresholds, animation and discoverability** — out of scope by the map, and unanswerable without a
  device and a debug build.
- **Which of these acts is in the first slice** — *The first shippable slice*'s.
- **Whether a reading needs swipe ←** — pre-registered above as a falsifier rather than left open.
