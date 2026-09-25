# What carries over from the running app, and by what route

Type: grilling
Status: open
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
