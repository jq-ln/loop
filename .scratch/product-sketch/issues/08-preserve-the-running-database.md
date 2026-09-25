# Preserve the running app's database before anything forces the decision

Type: task
Status: claimed

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
