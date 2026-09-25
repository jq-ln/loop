# The product sketch: what Loop v2 is, before the first line of Kotlin

Type: wayfinder:map

## Destination

A **product sketch** of Loop v2, landing as two artifacts in this repo: `PRODUCT.md` — what the app
does, its screens, and its input vocabulary — and the two sections `ARCHITECTURE.md` currently ships
marked `**Unwritten.**`, *the first shippable slice* and *what is not built*. The map is done when
someone can begin writing Kotlin with nothing left to decide about **what** the app is.

The gate is already installed: `.githooks/pre-commit` refuses the commit that adds the first `.kt`
file while either of those two sections is unwritten. This map exists to open it.

## Notes

**Domain**: a single-user, offline Android app for running one's own life — routines, one-off work,
measurement, and the goals that work serves. The subject is the **app**, which the post-mortem map
explicitly ruled out of its own scope. How the work is run is settled and is not revisited here.

**The developer analogy is this map's vocabulary and not the app's structure.** Tickets, cron jobs,
observability, devlog and spec are how the human and the agent talk during this effort. `SALVAGE.md`
refuses a new top-level concept that cannot separately evidence a stage nothing else covers **and**
an engine, and the first repo's four pillars — eight lines of menu enum, six placement ADRs, one
build-and-revert — are what that prohibition was written from. No concept from the analogy enters
`CONTEXT.md`, `PRODUCT.md` or `ARCHITECTURE.md` until a ticket passes it through that test.

**The engine is a given.** `SALVAGE.md` names the definition/occurrence split as the first port and
says every other engine rule is downstream; the cascade and the schedule engine follow it. The
sketch designs around them. A contradiction is an ADR, never a silent redesign.

**The app contains no language model.** Decomposing a goal happens outside the app — by hand, or in
a conversation with an agent whose result is imported. Loop's daily path must work with no network,
which is what G1 buys. An in-app model is a line in *what is not built*, priced at one ADR.

**This map carries execution**, minimally: the final ticket writes `PRODUCT.md` and both
`ARCHITECTURE.md` sections in a single pass, and consumes whatever `SALVAGE.md` entries the
decisions spend. **Decide first, write once** — inherited verbatim from the post-mortem, whose
dominant failure was writing the rule at the moment of insight.

**Skills every session consults**: `grilling` and `domain-modeling` by default. A ticket asking how
something should look or behave calls `prototype`. A ticket needing a fact from outside this
directory calls `research`.

**The archive is `../old_loop`, read-only, and its package path embeds the owner's username.** Every
citation of it is redacted at the point of quoting, in the form `<user>`, per `CLAUDE.md`. That rule
has no mechanical backstop for prose and rests on the reading gate.

**Every survey table in this map is suspect until re-derived.** Both tickets resolved so far had
wrong ones, in two recurring shapes: a capability called *refused* that the archive had costed and
explicitly retracted the stronger claim about, and a field or path called *dead* that had a live
consumer. Re-derive a ticket's archive claims from source before grilling on them, and record the
corrections in the ticket, because the corrections and not the original claims are what the answer
is built on.

**Standing preferences**
- The destination is two paragraphs and one file. A ticket that cannot trace a line to *what is in
  the first slice* or *what is explicitly not built* is fog at best and out of scope at worst.
- `PRODUCT.md` describes the app being built toward, not the one that exists. Where it disagrees
  with the code, the code wins and the document is a bug.
- Budget: 7 standing-claim files of 12 today. `README.md` makes 8 and `PRODUCT.md` makes 9.
- A beachhead, not a thin replacement: the first slice is one concept end to end that the author
  would genuinely use daily, and *what is not built* is expected to be long.

## Decisions so far

<!-- one line per resolved ticket: gist, then the link to the detail -->

- [The work-item model: do tickets and routines collapse into one thing?](issues/01-the-work-item-model.md):
  they collapse — one engine, four entry points. A **definition** is what could be done, a **run** is
  a materialized instance of one, and those two words serve both schema and prose. `routine` is
  demoted from a category to a shape (a definition with ordered steps); `snooze` moves a run inside
  its day and `defer` creates a definition for a named day. A schedule fires whether or not the last
  run was done, so an untouched day is a recorded skip; carry-forward stays reachable per item.
  Capture defaults to unscheduled. All three gaps are in — retroactive logging creates a definition
  that sticks, every-Nth-execution reads the run log rather than a stored counter, and unscheduled is
  first-class. The rename of the ported entity is an ADR written at port time, citing G2.

- [What a goal is, and what satisfies one](issues/02-what-a-goal-is.md): a goal is **greenfield, not
  a port** — every surviving goal artifact in the archive lives in the plugin wire, which is out of
  scope. Satisfaction has two families: **derived** (a predicate over the definition graph or the
  metric log, computed on read, never stored) and **declared** (an attested instant, retractable and
  dated). Completion is not a third kind, so roll-up is the same predicate one level up. Terminal vs
  standing is one `latches` boolean, and **standing requires the metric predicate**. Every goal names
  a parent defaulting to the root; **the root is the single exemption from admissibility and can
  never be satisfied**. A threshold goal's metric must already exist and be chaseable. Culling is a
  state (**abandoned** beside **satisfied**), never a delete, prompted by root-adjacency and by
  dormancy — where evidence is family-specific, because a sobriety goal generates no runs and would
  otherwise read as the most abandoned thing in the app. An abstinence goal needs no new concept:
  standing, lower-is-better, threshold zero. Every definition cites a goal, **gated at commitment
  rather than capture** — a thought needs no goal, a commitment does — with the uncited backlog as
  the place unscheduled work lives, and a falsifier: if it grows monotonically for two weeks the rule
  is being dodged. The app keeps the word **goal**; the project-level concept becomes **criterion**.

- [Preserve the running app's database before anything forces the decision](issues/08-preserve-the-running-database.md):
  taken 2026-09-24 from user 0, parked outside every tracked path, `integrity_check ok`. Schema
  version **13**; `task` 42, `schedule` 16, `occurrence` 210. The WAL hazard is priced: the sidecar
  was 457KB against a 168KB database, and a `routine.db`-only copy reports 201 occurrences and 1
  journal entry while opening cleanly. Four numbers land on tickets already charted, and the answer
  holds them rather than those tickets: the baseline is **ten days**, not a history, which is
  *What carries over*'s to weigh; **every one of the 56 `SKIPPED` rows is a machine skip**, so the
  database records no user skip at all, which sharpens *The input vocabulary*; `kind` is empty on all
  42 definitions, corroborating *The work-item model* from data; and `occurrence_timing` and
  `recording` hold zero rows while `journal_entry` holds two entries, one of 21 characters, which is
  the use record *Observability* and *Does Reflect survive its own test?* get to ask against.

## Not yet specified

- **The import format for a decomposition.** Q11 settled that goals are broken down outside the app
  and the result is imported; what that artifact *is* — a paste, a file, a format — waits on the
  goal-to-work edge.
- **Reminders and notification behaviour.** The first repo had a `remind` flag on every schedule and
  this map has not yet touched when the app is allowed to interrupt. Sharpens once Today is settled.
- **Onboarding and the empty state.** What the app looks like with nothing in it. Waits on the slice.

## Out of scope

- **The feel of any gesture.** Thresholds, animation, discoverability. A preview cannot answer a
  question about a gesture; it needs a screen, a debug build and a device, none of which exist. The
  input **vocabulary** is this map's business and the tuning is the rebuild's.
- **`core-audio` and the ear trainer.** A port pointer with no product behind it. Its only surviving
  copy is outside the repo, and `ARCHITECTURE.md` already forbids plugin plumbing before the plugin
  that uses it ships.
- **The plugin platform.** Dropped by the post-mortem: ~5,600 lines discovering zero plugins.
- **Any distribution channel.** `GOALS.md` N1, and the failure that killed the first repo.
- **How the work is run.** Worktrees, claims, review, the budget. The post-mortem's map owns it.
- **The `GOALS.md` rename itself.** [What a goal is, and what satisfies one](issues/02-what-a-goal-is.md)
  decided that the project-level concept becomes **criterion** so the app can have the word `goal`
  unqualified, and records the four silent mechanical costs keyed to the filename. Executing it is
  the owner's act on owner-only files, not a step on this map's route to the sketch.
