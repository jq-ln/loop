# The work-item model: do tickets and routines collapse into one thing?

Type: grilling
Status: resolved

## Question

The human described four shapes of work and then said the "tickets" idea did not live in any of
them: a repeatable routine with ordered steps, some conditional; a pure one-off; a thing done that
was not planned but is worth tracking; and a thing noticed now and pushed to a specific future time
or made to reappear until done. The hypothesis this ticket tests is that **all four are one engine**,
differing only in whether a schedule is attached and when it was known — and that what felt like
four types was one model with affordances that were never built.

An archive survey of the first repo's `task` / `task_link` / `schedule` / `occurrence` model
returned the evidence. Three of the four are already representable; the gaps are specific.

- **Which of the four are genuinely distinct in the model, and which are UI affordances?**
  Representable today: ordered steps via `task_link.position`; "only Fridays" and "every Nth day"
  via `task_link.cadence_rule`; a one-off via `ScheduleMode.ONE_TIME` *or* by having no schedule row
  at all; carry-forward-until-done via `AFTER_COMPLETION`, whose cursor only moves when the work is
  done. If these are one engine, the answer says so and the four shapes become four entry points.
- **Three real gaps, each needing a verdict.** *Every Nth execution* is refused in the source, not
  merely absent — re-planning happens from definitions alone, so an execution counter has nowhere to
  live. *Retroactive logging* requires a definition to already exist and always stamps `now`; there
  is no path for "I did a thing that has no row." *Unscheduled at creation* is representable but
  unreachable: both creation paths default to a daily schedule, and an unscheduled task never reaches
  Today on its own. Which of these does the new app fix, and which becomes a line in *what is not
  built*?
- **`AFTER_COMPLETION` and `FIXED` daily are different products, not two settings.** The first
  carries one row forward forever; the second supersedes yesterday's run, records a genuine skip, and
  issues a fresh one. "Nag me until it is done" and "ask me every day" differ in whether missing it is
  a recorded fact. Which is the default, and is the other reachable?
- **Does `snooze` survive?** The model accepts an arbitrary epoch, but the UI offered three presets
  and a `FIXED` schedule refuses a snooze past its own next firing, so a daily routine can only be
  pushed inside its own day. The archive's own reading is that "next Tuesday 13:00" is cleanly a
  `ONE_TIME` schedule rather than a snooze at all. If that is right, snooze is a same-day instrument
  and the deferral case is a different act with a different word.
- **What is the word for a work item?** `CONTEXT.md` earns an entry when a term is already in use and
  has been mistaken for something else. "Task" is overloaded already — the first repo used it for both
  the definition and the thing on the list, with `occurrence` the real name for the second.

## Survey corrections

Re-derived from the archive before grilling, because a ticket's survey table has been stale every
time it was checked. Five of the question's claims do not survive. The corrections, not the original
claims, are what the answer is built on.

- **"Every Nth execution is refused in the source" is wrong.** There is no validator, `require` or
  thrown error; the cadence parser deliberately *degrades* an unknown tag rather than throwing. The
  archive explicitly retracted the stronger claim — its changelog calls "structurally unavailable"
  *"too strong"*, and ADR 0009 records that run-counting *"was costed rather than dismissed: it is
  available, but it costs the planner's purity."* That ADR rejects a **stored** counter specifically
  and points at reading the occurrence log instead. The real objection is planner purity, and the
  cost is one read, not a schema change.
- **"Retroactive logging always stamps `now`" is wrong.** The completion path already takes a
  supplied instant — `complete(occurrenceId, at = now())`, with the default overridable — and the
  countdown path already calls it with a past instant, documented as *"a countdown that reached zero
  while nobody was watching is done at its zero instant, not when the app next noticed."* What is
  actually missing is narrower and in two parts: materialization throws for a task that does not
  exist, so there is no path for work with no definition; and no UI path passes a user-chosen `at`.
- **A one-off has one definition-level representation, not two.** `ONE_TIME` is real, and a schedule
  row is genuinely optional, but nothing materializes a task without one — generation iterates due
  schedules only. The second "representation" is an occurrence-level hand-placement onto Today that
  the generator closes at the day break: *"one day's work, not a row that outlives the day."* It is a
  manual tap each time, not a shape the definition can hold.
- **`AFTER_COMPLETION`'s cursor advances on dismissal too, not only on completion.** Deliberately:
  *"leaving it alone would strand an `AFTER_COMPLETION` schedule with `next_due_at` permanently in
  the past."* Dismissal is the built-in escape from carry-forward, which changes what "nag me until
  it is done" actually means.
- **Snooze stores the origin, and the picker was never built.** The column records where the run came
  from; the target overwrites the due instant. Three preset chips shipped and the arbitrary-epoch
  picker the source calls *"a fallback for the rest"* does not exist. The `FIXED`-mode limit is
  confirmed and its reason is recorded — a snooze past the next firing *"would put two live runs of
  one rule in one window."* Every other mode is unbounded and lapses at the day break. New finding:
  an **untimed** routine cannot be snoozed at all, because both hour-presets refuse an item with no
  time of day and `TOMORROW` is then over the limit.

Confirmed as stated: step ordering by `position`; weekday and every-Nth-**day** cadences;
`AFTER_COMPLETION` and `FIXED` daily being substantively different products; discriminated close
reasons; unscheduled-at-creation being representable but unreachable.

Two findings the question did not anticipate:

- **A cadence only ever subtracts.** *"A cadence is not a schedule… can never pull the routine onto a
  day its own schedule denies."* Step-level "only Fridays" cannot make a non-Friday routine run on a
  Friday. Monthly cadences are not expressible at all.
- **The overloaded word is `routine`, not `task`.** The archive's glossary defines it as the
  definition, and the Today query's own documentation uses it for materialized trees: *"a routine
  counts as live today if it is due today whatever its status."* The same overload appears in the
  timing entity and the clock, and the engine module's name spans both sides. `task` and `occurrence`
  are schema words the archive's glossary already bars from prose, which says to *"say run"*; that
  glossary separately flags `task` as possibly the wrong name for the definition, with `definition`
  as the candidate and *"not a decision yet"*, and flags its skipped status as misnamed.

## Answer

**The collapse holds. There is one engine and one pair of words, and the four shapes are entry
points over it.** A **definition** is what could be done; a **run** is a materialized instance of a
definition at a time. Nothing else is a kind of work. What felt like four types is two fields:
whether a schedule is attached, and when the work became known.

| Shape | What it is |
|---|---|
| Routine with ordered steps | A definition with child definitions ordered by position, with a schedule |
| Pure one-off | A definition with a one-time schedule, or with none at all |
| A thing done, never planned | A definition created at logging time, no schedule, one run stamped in the past |
| Noticed now, pushed to Friday | A definition with a one-time schedule on Friday |

Three of the four were already representable and the fourth was a gap in reachability rather than in
the model, which is the whole of why this collapses rather than branching.

### The words

`definition` and `run`, one word each across schema and prose, so there is no translation layer to
get wrong. The archive kept `task` and `occurrence` in the schema and barred both from prose,
instructing itself to *"say run"*, and it had already reached for this answer without taking it: its
glossary records `definition` as the candidate name and *"not a decision yet"*.

**`routine` is demoted from a category to a shape: a definition that has ordered steps.** This is the
entry the glossary earns, by its own test — the word is in use and has been mistaken for something
else. The archive's glossary called a routine a definition while its Today query called materialized
trees routines, and the same overload ran through the timing entity, the clock, and the name of the
engine module. Demoting it dissolves the overload instead of legislating against it, and it is true
of every use the word has had here.

**`snooze` and `defer` are different verbs because they act on different objects.** A snooze moves a
**run** inside its own day. A defer creates a **definition** for a named future day, which under the
collapse is just a one-off and needs no concept of its own. The archive's own reading was that "next
Tuesday 13:00" is cleanly a one-time schedule rather than a snooze; that reading is adopted.

### Defaults

**A schedule fires whether or not the last run was done, so an untouched day closes as a recorded
skip.** The passive miss is a fact the app owns. Carry-forward stays reachable per item for
genuinely "until done" work, where a daily row would be noise.

The difference between the two is narrower than it looked and it is exactly this. Both record an
*active* refusal — dismissal writes its own terminal status and also advances the cursor, because
*"leaving it alone would strand an `AFTER_COMPLETION` schedule with `next_due_at` permanently in the
past."* Only the firing mode records the *passive* one. Silence about untouched days is the single
thing that cannot be reconstructed later, and it is the question the archive discriminated five close
reasons to keep answerable.

**Capture defaults to unscheduled** — the inverse of the archive, where both creation paths wrote a
daily schedule unconditionally and the schedule editor had no "none".

### The three gaps: all three are in

- **Retroactive logging.** A definition is created on the fly, and **it sticks**, with no schedule.
  The timestamp half was already solved in the archive and the survey was wrong to call it missing.
  What was missing is narrower: no path for work with no definition, and no screen that passes a
  user-chosen instant. The created definition lands in the same shape capture produces, which is the
  evidence that the collapse is real rather than asserted — the fourth door adds nothing to the model.
- **Every Nth execution.** In, by reading the run log; never a stored counter. The archive costed
  this rather than refusing it and retracted the stronger claim itself, recording that *"it is
  available, but it costs the planner's purity"* and pointing at the log. One query, no schema.
- **Unscheduled at creation.** First-class. A definition with no schedule row is already the shape.
  It leaves the backlog by being pulled onto a day, and the archive's day-break close of a
  hand-placed run is correct behaviour rather than a bug: *"one day's work, not a row that outlives
  the day."*

### Consequences for the port

- **The rename is an ADR written at port time**, in the commit that renames, citing G2. Not now, and
  not silently. `SALVAGE.md` says read the split before changing it, and a rename is neither a
  contradiction of the model nor designing around it, so it does not get to be implicit.
- **An untimed item must be snoozable.** In the archive it is not: both hour-presets refuse an item
  with no time of day, and tomorrow is then over the same-day limit, so a plain daily checklist item
  has no snooze at all. Fixed, not ported. The same-day limit itself is kept, and its reason with it —
  a snooze past the next firing *"would put two live runs of one rule in one window."*
- **A cadence only ever subtracts.** *"A cadence is not a schedule… can never pull the routine onto a
  day its own schedule denies."* Step-level "only Fridays" cannot pull a non-Friday routine onto a
  Friday. Carried as a written rule rather than left as a surprise.
- **Monthly step cadences are not built**, one line. The schedule engine already handles month-end,
  so this is only about steps, and a monthly step inside a daily routine waits for a real want.

### What this does not decide

Where unscheduled work is visible, and whether the backlog is a room that gets opened. That is
Today's business. It leaves a constraint rather than a question: **if Today has nowhere to show
unscheduled work, unscheduled must not be the capture default** — a backlog nothing opens is exactly
the kind of thing G1 rules out.
