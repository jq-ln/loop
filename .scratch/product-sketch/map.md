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
