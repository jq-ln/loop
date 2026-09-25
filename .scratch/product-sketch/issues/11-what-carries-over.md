# What carries over from the running app, and by what route

Type: grilling
Status: resolved
Blocked by: 01, 08

## Question

Graduated from the map's fog by *The work-item model*, which the fog entry named as the thing it was
waiting on. Now phrasable: **which of definitions and run history carries from the running app into
the new one, and by what route.**

Two halves with different stakes, and they are unlikely to get the same answer.

- **Definitions are tedious rather than irreplaceable.** Every routine already entered can be
  re-entered by hand, at a cost measured in an evening. Carrying them means a migration path from a
  schema the archive took to version 13 in eight days, into a schema that does not exist yet and
  whose definition entity is being renamed. Re-entering them means the new app's first day is spent
  typing, which is a real cost against G1 but a one-time one.
- **Run history is irreplaceable and is the only baseline observability could ever have.** It cannot
  be re-entered, it is the only evidence of what was actually done, and *Observability* is downstream
  of whether it exists. But it references definitions by fields that were deliberately not foreign
  keys, and carries snapshot columns taken at materialization time and never back-filled, so it
  arrives with display text frozen from a schema that is being renamed.

- **Which half carries?** The asymmetry above suggests history carries and definitions are re-entered,
  which is the opposite of what is easier to write. Test that against the actual numbers rather than
  the argument: *Preserve the running app's database* records the schema version, the row counts and
  the span of the history, and those numbers price this decision.
- **By what route?** A migration chain from the archive's schema, a one-off import of an exported
  file, or a read-only side table the new app reads and never writes. The third is worth pricing: it
  keeps the old shape out of the new schema entirely, at the cost of every query that wants history
  crossing a boundary.
- **What happens to the frozen snapshots?** Display text and estimates were snapshotted at
  materialization and never back-filled, on purpose — editing a definition tomorrow cannot alter last
  week's record. Carrying history carries those snapshots, spelled in the old vocabulary. Either that
  is fine because a record of the past *should* read as the past, or it is a rewrite, and the rewrite
  contradicts the snapshot rule.
- **Does the old app keep running afterwards?** *Preserve the running app's database* says the two
  coexist on the device by having different application ids, and the running app stays in use until
  the new one is off the ground. If history carries once, it goes stale from that moment; if it
  carries repeatedly, the route has to be re-runnable and idempotent.

`SALVAGE.md`'s hazard applies to every reading of the copy, not only the first: pull the database
with its `-wal` and `-shm` files, because opening the copy with `sqlite3` checkpoints it and destroys
the evidence.

## Answer

**This is the most speculative ticket on the map, and it is deliberately not formalized like the
others.** There is no route to design, because the back-fill is manual and happens after the fact:
once the new app is up and running, comb through what the old one tracked, make a place for whatever
is still wanted, and write SQL inserts against the new database to fill it. Nothing about it needs
to be settled before the first line of Kotlin, which is what this map exists to unblock.

What follows is therefore a record of what is worth carrying and what will bite whoever writes those
inserts — not a mechanism.

### What this rules out

Because it is hand-written SQL run once, outside the app:

- **The new app builds no import feature**, and this ticket makes no claim on the first shippable
  slice. *The first shippable slice* keeps "migration from the first Loop" on its unbuilt list, and
  it stays unbuilt permanently rather than being deferred at one ADR — the back-fill happens outside
  the app and never becomes a feature of it.
- **No migration chain, no read-only side table, no translator program.** All three were routes for
  getting the old shape into the new app, and none is needed. **Nothing of the old schema ever
  enters the new app** — the inserts speak the new schema and the old one is only ever read.
- **The old app's data is read at a desk, from a copy.** Source is a fresh pull taken before the old
  app is uninstalled, by the procedure *Preserve the running app's database* already wrote and
  proved: force-stop, `run-as`, tar with both sidecars, never open the tar. The 2026-09-24 copy
  stays frozen as the evidence four tickets on this map cite.

**Cutover**: parallel until the new app holds a week of real routines, then a hard stop — the old
app uninstalled, not kept. Parallel entry into two apps is the thing nobody sustains.

### What is worth carrying, as named

| Named | Where it lives | Rows |
|---|---|---|
| Weight measurements | `observation`, `core.question.3`, via the **Weigh-in** step | **5**, 09-17 to 09-21 |
| Wake up / sleep **times** | **`occurrence.completed_at`** — not in `observation` at all | 8 and 7 |
| Follow-ups | `observation`, q1 *"How tired are you?"* on **Go to sleep**, q2 *"How rested do you feel?"* on **Wake up** | 7 and 7 |
| Take pills | `occurrence` rows only — no measurement attached | 7 done, 2 machine skips, 10 days |

That is **the whole live metric surface**: all 19 observations in the database belong to those three
check-in steps. One bare root and three check-ins is what the carry-over comes to, and it spans the
run log and the metric log both — there was never a half to choose, which is what the ticket's
framing assumed.

**The times are the correction worth keeping.** The questions on *Wake up* and *Go to sleep* are
ratings, not times; the time is `completed_at`, when the row was tapped. That is *Observability*'s
`RoutineTimes` metric group — the one computed on read from completion timestamps — and it is why
that group has never held a row: there is nothing to hold.

**The three check-ins are measurement and need no routine around them.** *Wake up* and *Weigh-in*
are steps 0 and 4 of **Morning Routine**, *Go to sleep* is step 3 of **Night Routine**; only *Take
pills* is a root. Nothing about a weight series depends on having been step 4 of anything.

**Scale Degree is cut** — the one recurring definition carrying `owner_module_id = eartraining`, a
plugin this map rules out of scope, run daily. Its removal takes 1 of 8 recurring definitions and 9
of 210 runs out before anything else is decided.

### What will bite whoever writes the inserts

**`completed_at` is not a record that something happened.** It is non-null on **125 rows across four
statuses, and only 68 of them are `DONE`** — `AUTO_CLOSED` 24, `DISMISSED` 23, `ROLLED_UP` 10. In
the four above that is three rows: one dismissed *Wake up*, and **two `AUTO_CLOSED` Weigh-ins on
09-23 and 09-24, timestamped 14:56 and 19:08 UTC**. Those are the travel days *Observability* found,
the gap that read as abandonment. Selecting on the timestamp being present rather than on
`status = 'DONE'` manufactures two weigh-ins on the two days the author was away, and makes the
weight series appear to run to 09-24 when it ends at **09-21 with five readings**. This is the map's
own stale-survey warning arriving as a back-fill bug: a number that exists is not a number that
means what its column is called.

**`window_key` cannot be recomputed from `due_at`.** It is a local `YYYY-MM-DD` string taken against
a **04:00 day boundary**, and the zone it was written in is stored nowhere. If a day label is wanted,
it is asserted by the person writing the insert, who knows which zone they were in.

**Enums are stored as TEXT names, not ordinals**, so the old status vocabulary reads straight out of
the database — `ROLLED_UP`, `SUPERSEDED`, `SCHEDULE_CHANGED`, `AFTER_ROUTINE`, the exact words 01,
03 and 07 redefined or killed. Convenient for reading, and a reminder that the mapping to the new
vocabulary is a judgement rather than a rename.

**`Take pills` carries as a thin series** — 7 done and 2 machine skips in ten days, and the database
holds no user skip anywhere, so it answers *when* and never *why not*.

**There is an easier way to read the old data than SQL.** The archive ships a full JSON export: a
hand-written DTO contract over all nine tables, an Export button in Settings, and an in-app nag when
one is overdue. Combing through a readable document beats combing through SQLite. One caveat if it
is used — `OccurrenceDto` has 24 fields and **omits `snoozed_from`**, undocumented and unnoticed
because the column is null on all 210 rows.

### Amendments

Three, each independent of how the back-fill happens, which is why they survive this ticket being
informal.

- **Amends 01**: a definition is **archived, never deleted**. 02 made culling a state and 07 gave
  `Offered` two exits and never a delete; the engine now says the same about definitions. The
  argument is one row — occurrence 103, `display_name` **Cat litter**, `task_id` 22, and no task 22.
  Deleted inside ten days, its schedule and links cascaded away, its run left pointing at nothing.
  `Cat litter` exists again as task 23, so the database holds two histories for one act under two ids
  and the older is unreachable. Meanwhile `task.archived_at` is **null on all 42 definitions**: the
  affordance shipped and was never used, while the delete that was used produced the only dangling
  row in the database.
- **Amends 04**: **`SCALE_1_5` is deleted, not kept reader-only.** It was retained "so old backups
  decode." Migration 11 to 12 doubled every answer onto the ten-step scale on 2026-09-19, and the
  three live questions are `SCALE_1_10`, `SCALE_1_10` and `NUMBER` — **there are zero `SCALE_1_5`
  rows to decode.** The clause's reason does not exist.
- **Amends `SALVAGE.md`, which is stale against the code.** Its definition/occurrence entry says
  display fields are *"snapshots taken when the run is materialized and never back-filled."*
  `TaskRepository.updateTask` back-fills `display_name` onto every `PENDING` row on a rename, added
  after a device report: a step typed wrong and corrected seconds later went on showing the typo all
  day. `estimated_minutes` and `optional` genuinely are never back-filled. The true rule is narrower
  and better — **a finished run keeps the name it was done under; a run still waiting does not** —
  and under `CLAUDE.md` the code wins and the document is the bug. `SALVAGE.md` is the owner's file,
  so this is flagged and not edited.

### Premises of this ticket that did not survive

- **"Definitions are tedious rather than irreplaceable, at a cost measured in an evening."** The
  real inventory is **7 recurring routines** (8 less Scale Degree), 18 distinct step tasks, 21 links.
  The other 8 scheduled items are `ONE_TIME`, all paused, every run already closed — **spent**, not
  definitions.
- **"Run history is the only baseline observability could ever have."** The metric log is **19
  readings in 3 series**: two ten-step scales at 7 each, and weight at 5.
- **"Snapshots arrive spelled in the old vocabulary."** **Zero drift across all 209 resolving rows.**
  The snapshot has never differed from a live definition; it has differed from a deleted one exactly
  once, and that orphan is the only place the words survive.
- **"*Preserve the running app's database* says the two coexist by having different application
  ids."** It does not — its *question* anticipated the archive's real/test profile pair, its *answer*
  found one id installed. The archive declares `applicationId` with no suffix, no flavours and no
  debug build type, so debug installs over release. Coexistence is the new app's choice to make, and
  being greenfield it simply makes it.
- **The chain is 12 migrations across five calendar days**, inside an eight-day repo lifetime, not
  twelve in eight.
