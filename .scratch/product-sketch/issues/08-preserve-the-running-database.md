# Preserve the running app's database before anything forces the decision

Type: task
Status: resolved

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

## What the answer must record

- The **schema version** (`PRAGMA user_version` — Room stores it there). The archive reached version
  13 with 12 migrations in eight days, so the version is not a formality: ticket 09 prices a
  migration against it.
- The three **row counts**: `task`, `schedule`, `occurrence`.
- The **earliest and latest occurrence date**, which needs the column name the schema dump in step 7
  returns rather than a guessed one.
- **Where the copy is parked**, as a fact and never as a path — `CLAUDE.md` refuses home-anchored
  paths on every tracked path with no exclusions, `.scratch/` included.
- Whether `run-as` worked at all, and whether the `-wal` came out non-empty. A non-empty `-wal` is
  the evidence that the hazard below was real for this copy rather than a precaution.

## Checklist — run these

Run each with `!` so the output lands in the session: `adb run-as` is refused to an agent even for a
plain read, so the human runs it and the agent reads the result.

The design that makes the hazard unreachable instead of merely warned about: **the tar is the
artifact and is never opened.** `sqlite3` checkpoints whatever it opens, so it only ever sees a
throwaway extraction. A mistake at step 7 costs nothing and is repeatable.

```sh
# 0. One device, listed as `device` and not `unauthorized`.
adb devices

# 1. The device is the authority for the application id, not the archive.
#    Expect one — possibly two, since the archive ran a real profile beside a
#    test profile on one device under different ids. Copy every one that
#    appears, and say in the answer which is the one in daily use.
adb shell pm list packages | grep -i loop

# 2. Per id. If this fails with "not debuggable", stop: report the exact error
#    and do not uninstall, reinstall or clear anything. The route is then a
#    decision, not a command, and this ticket stays open for it.
PKG=<the id from step 1>
adb shell run-as "$PKG" ls -l databases

# 3. Stop the app so nothing is mid-write. force-stop clears no data and does
#    not checkpoint the WAL, which is the whole point.
adb shell am force-stop "$PKG"

# 4. One stream, all three files together, before any of them is opened.
#    exec-out and not shell: shell mangles binary. The whole directory, so the
#    database filename never has to be known or guessed.
DEST=<the directory that already holds the pre-rewrite bundle>
TAR="$DEST/loop-databases-$PKG-2026-09-24.tar"
adb exec-out run-as "$PKG" tar cf - databases > "$TAR"

# 5. Verify the tar without opening a database. Expect three entries for the
#    live db: <name>, <name>-wal, <name>-shm. Report the sizes as they come.
tar tvf "$TAR"

# 6. Extract a working copy. This is the expendable half.
WORK=$(mktemp -d) && tar xf "$TAR" -C "$WORK" && ls -l "$WORK/databases"

# 7. Query the working copy, never the original and never the tar.
DB="$WORK/databases/<name from step 5>"
sqlite3 "$DB" 'PRAGMA integrity_check;'
sqlite3 "$DB" 'PRAGMA user_version;'
sqlite3 "$DB" '.tables'
sqlite3 "$DB" '.schema occurrence'
sqlite3 "$DB" 'select count(*) from task;'
sqlite3 "$DB" 'select count(*) from schedule;'
sqlite3 "$DB" 'select count(*) from occurrence;'

# 8. Restart the app on the phone. It stays in daily use until the new one is
#    off the ground; the two coexist by having different application ids.
```

Paste steps 5, 6 and 7 back and the agent derives the occurrence-date query from the schema dump,
writes the answer, and closes the ticket.

## Standing constraints

- Copy the database and **both** sidecar files together, before opening any of them. `SALVAGE.md`:
  opening the copy with `sqlite3` checkpoints it and destroys the evidence. A copy taken wrongly
  looks like a copy.
- Park the copy outside this repository.
- Verify on the **copy**, never the original.
- Do not delete or modify the running app.

## Answer

Taken 2026-09-24, from user 0, package `dev.<user>.loop` — the id read off the device with
`pm list packages`, which is the authority here and the reason this ticket quotes no archive path.
Only one id is installed: the real-profile / test-profile pair the archive ran is not on the device,
so there is no second dataset to preserve.

**The copy.** One tar holding `routine.db` and **both** sidecars, streamed out with
`adb exec-out run-as ... tar cf -` after an `am force-stop`, before anything opened them. Parked
outside the repository and outside every tracked path — not beside the pre-rewrite bundle, which is
in a different place. `PRAGMA integrity_check` on the extraction returns `ok`.

**What ticket 09 asked for.**

| | |
|---|---|
| Schema version (`PRAGMA user_version`) | **13** — matching the archive's 12 migrations in eight days |
| `task` | **42** |
| `schedule` | **16** |
| `occurrence` | **210** |
| Earliest occurrence (`due_at`) | **2026-09-15** |
| Latest occurrence (`due_at`) | **2026-09-30** — future-dated; see below |

Tables present: `task`, `task_link` (29), `schedule`, `occurrence`, `occurrence_timing` (**0**),
`observation` (19), `question` (3), `recording` (**0**), `journal_entry` (**2**).

### The hazard was real, and is now priced

`routine.db` was 167,936 bytes; `routine.db-wal` was **457,352** — nearly three times the database.
`sqlite3` zeroed the WAL on first open, observed directly on the throwaway extraction, which is what
the tar-is-never-opened structure was for.

A second extraction with the sidecars deleted answers what a `routine.db`-only copy would have said:

| | with the WAL | without |
|---|---|---|
| `occurrence` | 210 | **201** |
| `journal_entry` | 2 | **1** |
| `task`, `schedule`, `observation` | 42 / 16 / 19 | unchanged |

It opens cleanly, passes `integrity_check`, and is silently nine rows stale. `SALVAGE.md`'s *a copy
taken wrongly looks like a copy* now has a number against it.

### Four findings that bear on tickets already on the map

Recorded here rather than written into those tickets, so each stays the one place its own decision
lives. None of them is a decision this ticket may make.

1. **The baseline is ten days, not a history** — 2026-09-15 to 2026-09-24, 185 occurrences in the
   past and 25 already-materialized future ones. Ticket 11 frames run history as *irreplaceable and
   the only baseline observability could ever have*. True in kind, small in degree: ten days of one
   person's routines. That weakens the case for carrying it through a migration and strengthens
   *start clean* on both halves, which is 11's to decide with this number in hand.

2. **Every `SKIPPED` row is a machine skip.** 40 `SUPERSEDED`, 16 `SCHEDULE_CHANGED`, **none null**;
   the other statuses carry no reason at all (`DONE` 68, `PENDING` 29, `AUTO_CLOSED` 24,
   `DISMISSED` 23, `ROLLED_UP` 10). `SALVAGE.md` says only one of four paths meant the user did not
   do something — in this data, none do. *How often do I skip things* returns 56 against a database
   holding no recorded user skip. Which status the user's own skip lands in is ticket 07's to settle
   against the archive source, and it is a sharper question than the vocabulary bullet assumes.

3. **`kind` is the empty string on all 42 definitions.** The type discriminator the archive shipped
   received a value never once. Independent corroboration, from data rather than from code reading,
   of *The work-item model*'s conclusion that four shapes were one model with unbuilt affordances.

4. **`occurrence_timing` and `recording` hold zero rows**, against `observation` 19 and `question` 3.
   Two of the measurement layer's four stored tables took no row in ten days of daily use, and
   `journal_entry` holds two entries — one of 267 characters, one of **21**, both from the final two
   days. Ticket 04 inherits the first half; ticket 05 asks whether Reflect survives its own test, and
   this is the use record it gets to ask against.

### Housekeeping

The extractions are throwaway and live outside the repo; the tar is the artifact. The running app
was force-stopped to take a consistent copy and is safe to reopen — nothing was cleared, uninstalled
or modified, and it stays in daily use until the new one is off the ground.
