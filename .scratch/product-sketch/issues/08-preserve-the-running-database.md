# Preserve the running app's database before anything forces the decision

Type: task
Status: open

## Question

Nothing to decide. The author is still using the first Loop daily, and its database is the only
baseline any future observability could have and the only copy of every routine definition already
entered. This ticket exists so that *what migrates* is answered by choice rather than by data loss,
and it is takeable now, in parallel with everything else.

`SALVAGE.md` records the one non-obvious hazard: **pull the database with its `-wal` and `-shm`
files, because opening the copy with `sqlite3` checkpoints it and destroys the evidence.** A copy
taken wrongly looks like a copy.

This is HITL: it needs the phone. The agent writes the checklist and verifies the result; the human
runs it.

## Checklist

- Copy the database and **both** sidecar files together, before opening any of them.
- Park the copy outside this repository. `CLAUDE.md` refuses home-anchored paths on every tracked
  path with no exclusions, so the location is recorded as a fact in the answer and never as a path.
- Verify the copy opens and reports a row count for `task`, `schedule` and `occurrence`, on the
  **copy**, never the original.
- Record in the answer: the schema version, the three row counts, and the date of the earliest and
  latest occurrence. Ticket 09 needs those numbers to price a migration, and the first repo reached
  schema version 13 with 12 migrations in eight days, so the version is not a formality.
- Do not delete or modify the running app. It stays in use until the new one is off the ground, and
  the two coexist on the device by having different application ids.
