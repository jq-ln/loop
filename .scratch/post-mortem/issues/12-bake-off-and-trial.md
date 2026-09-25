# The protocol for choosing between two designs

Type: grilling
Status: resolved
Blocked by: 09, 15

## Question

This repo needs a standing protocol for feature exploration. The term "A/B testing" was rejected
while charting: Loop is single-user, offline, has no `INTERNET` permission and no telemetry, so it
has no cohorts, no metric and no n. The term imports promises the setup cannot keep, and the old
repo has three separate migrations recording what a word carrying the wrong promise costs.

Two named mechanisms, both wanted:

- **Bake-off** — two rough variants built and judged side by side, immediately, by the user.
  Cheap, qualitative, the default. This is the `prototype` skill run twice.
- **Trial** — one variant lived with for a period, then the other, then a decision. For features
  where only use over time can tell, at the cost of the user's memory being the instrument.

Settle: what triggers each; how a bake-off is set up so two variants can exist without the
coordination protocol from ticket 10 fighting it; what a trial's period is and what is recorded
during it so memory is not the only instrument; how the losing variant is disposed of; where the
decision is written down and whether it earns an ADR. And which questions deserve neither — the
cost of a bake-off is real and most decisions should just be made.

Adopt the two terms into the repo's glossary as part of resolving this.

## Amendment after ticket 09

The mechanism survives the verdict; its default inverts.

Prototypes are among the few artifacts that *reduce* comprehension load: they answer a question and
are then deleted, rather than staying to be cross-referenced. So bake-off is kept — but **as the
justified exception, not the default**. This ticket's own line, "most decisions should just be made",
is promoted from caveat to rule.

Under 15's citation rule a bake-off must name the goal the choice serves, which disqualifies most
candidates by itself. Settle what clears that bar. The old repo's plugin subsystem — built day 3,
deleted day 7 — is the worked example of a decision a two-hour bake-off would have pre-empted, and
is the standard to calibrate the trigger against.

Blocked by 15 as well as 09: the citation rule is the trigger's main filter.

## Answer

HITL session, 2026-09-24. Two fact-finding sweeps against `../old_loop` ran before the first round,
and both overturned premises this ticket was chartered on. The ticket asked for a protocol; it
resolves by refusing to write one, on the user's own objection — that deciding this now is itself
the failure the map exists to prevent — and the refusal is argued below rather than asserted,
because ticket 20 must not read this as the question having been dropped.

### Both of the ticket's premises were wrong

**The calibration standard does not exist.** "The plugin subsystem, built day 3 and deleted day 7"
conflates three things. The plugin subsystem is **alive at the old repo's HEAD** — `PluginRegistry`,
`LoopRoutineHost`, `WireDiscovery`, `HostCalls`, `docs/plugin/WIRE.md` and ADRs 0052–0062 are all in
the final tree. What died was the *in-process shape* and the *bundled plugins*, and ADR 0052 gives
the reason: *"Only separate APKs give separate permission sets: vendored source produces one merged
manifest, so a plugin needing a permission would make Loop declare it."* That is a fact about
Android's manifest merger and F-Droid's inclusion policy — true before a line was written,
discoverable by reading, and in fact discovered by an adversarial session (`0012507`: *"Everything
settled by grilling on 2026-09-20, written down before any of it is built"*). Two rough variants of
an in-process host would both have worked and neither would have shown it. Dual N-Back's 3,482 lines
were not wasted either; they moved to `loop-plugin-dualnback` and still run.

**The two mechanisms were the wrong way round.** The ticket treats bake-off as the default and trial
as the expensive alternative. The evidence says the opposite:

- **Trial was the established loop**, running on a roughly one-day cycle. `README.md`: *"It is used
  daily on a real phone."* `docs/DEVICE.md` is 50 lines of procedure for a two-profile device —
  *"user 0 is in real use and holds data that has no other copy"*. An in-app note appended to
  `files/feedback.jsonl`, read at the start of the next session *"alongside the occurrence log: the
  two together say what happened and how it felt."* It produced decisions: 13 of 75 ADRs are
  justified experientially and 18 of 75 are attributed to the author directly. The purest is ADR
  0050 — *"Five points were not enough to say 'a bit better than last time'."* Cycle time was one
  day, not a period: 0.9.0 shipped a screen and 0.9.2 removed it 22 hours later.
- **Bake-off ran exactly once, in code that no longer exists.** Three notation presentations in one
  chooser screen in the ear trainer — *"a gate, not a feature"* — whose source was excised by ADR
  0067's rewrite. Inside Loop itself: **zero `@Preview` functions in 12,161 lines of UI**, no
  commented-out alternatives, no `v2` names. UI was replaced wholesale, one variant at a time.
- **They composed rather than competing.** The ear trainer ran the comparison first and judged it on
  the phone after.

### The base rate is zero, and the refusal follows from the kit's own tests

Seven reversal episodes of 100+ Kotlin lines. **None would clearly have been pre-empted by a
bake-off**; at most two on the most generous reading, 6.6% of reversed lines. By volume the
reversals are external-constraint findings (4,229 measurable lines plus the unmeasurable ear
trainer). The one episode where building *was* the experiment — day-one Edit mode — already ran as a
sequential comparison **30 minutes wide** and cost nothing.

Against that, the two gating tests both fail:

- **Comprehension criterion.** A protocol for a mechanism that cannot fire until there is a screen,
  a debug build and a device is an artifact to carry that pays for nothing until then.
- **03's latency test.** There is no artifact the work must touch anyway for it to ride on, because
  the work has not started. A rule written now is the prospective-rule-of-principle class — the one
  that broke in 15 minutes 33 seconds.

Three decisions already in the kit point the same way. 15: *"The trigger for revisiting the goals is
an ADR that cannot name one — not a calendar. An event-attached trigger is the only kind the old
repo kept."* 10, parking the version cadence: *"fixing it against an unchosen channel is the F-Droid
failure one layer down."* And the user's own statement of it in this session: making this decision
now violates the guidance about deciding at the appropriate time.

**The cost of not having it is measured, and it is low.** The old repo's UI reversals were cheap and
fast — 30 minutes, 22 hours, same-day wholesale replacement. What was expensive was architecture
reversals, and those had causes no comparison would have surfaced. The expensive part of those was
not the building either: it was the rename and doc maintenance applied to doomed code. `4a1d20a`
spent 1,224 lines renaming module→plugin across 169 files, 3h 19m before 30 of those files were
deleted outright. That argues for deleting sooner, not for building twice.

### What lands: two salvage entries, which are facts and not rules

Deferring a decision properly means the person who eventually makes it does not pay for the same
lesson twice. Both entries clear 13's bar — no ported code, no other document and no mechanism holds
either claim — and both are `SALVAGE.md`'s "Carry this" half, consumable:

```markdown
- **Live with it on a phone, and keep the loop that reports back.** Decisions the first repo could
  only reach by use — a 1-to-5 scale too coarse to say "a bit better than last time" — came from a
  real profile beside a test profile on one device, an in-app note appended to a file there, and a
  session that read those notes beside the occurrence log. Pull the database with its `-wal` and
  `-shm`; opening the copy with `sqlite3` checkpoints it and destroys the evidence.
- **A rough variant is usually too rough to judge.** The one time the first repo built variants side
  by side, a pass of device fixes came before the comparison meant anything, and the decision still
  was not made when that pass landed. Budget it, or the comparison measures prototype bugs.
```

The first is consumed by the commit that writes `docs/DEVICE.md`, at which point that file earns a
budget slot on its merits; until there is a device to point at, a file would be a slot spent on
nothing. **The second has no consuming commit** and will sit until deleted by hand — the only entry
in the keep half without a clean exit, recorded here rather than papered over.

**The arithmetic, for ticket 20.** 13 drafted `SALVAGE.md` at **54 lines** against a **hard 60**
(13's own prose says "~45 lines", which is stale against its own draft — the draft is
authoritative). These two entries are 8 lines, so the file lands at **62**. The user's input this
session, recorded because it decides the question: *the 60-line rule was chosen arbitrarily and the
reason there is a cap at all is to clamp the number of lines in files that are always loaded;
genuinely necessary context should not be left out to avoid an arbitrary line limit.* `SALVAGE.md`
is not always-loaded, its 60 was **inherited from `PROCEDURE.md` rather than derived**, and the file
is the one document in the kit that shrinks. 12 does not hold 13's say on its own file's bounds, so
this is handed to 20 with a recommendation: **lift `SALVAGE.md`'s ceiling to 65** and leave
`PROCEDURE.md`'s 60 alone, or trim at authorship. The count moves from ten entries to twelve either
way.

### What does not land, each with its reason

- **No protocol.** No trigger, no setup, no disposal rule, no record rule.
- **Neither term enters `CONTEXT.md`.** The ticket instructed that they be adopted into the glossary;
  that instruction is refused. A glossary entry for a mechanism the kit does not have is a standing
  claim with no referent, and `CONTEXT.md` is a glossary of terms in use. Neither term appears in
  the salvage entries, which state the facts without needing the words.
- **Nothing to ticket 18.** A debug-only entry point that two variants could hang off was the
  obvious hand-off and is declined: it is an app decision, and making it here under cover of a
  hand-off is the thing this ticket just refused to do.
- **Nothing in `PROCEDURE.md` or `CLAUDE.md`.** Put to the user explicitly, since the line budget
  had been treated as binding and is not. The case for one line — that an agent session has no way
  to learn that building two variants is an available move — loses to there being nothing yet to
  build them out of.
- **The bundle's path is not recorded anywhere.** `.git/filter-repo/` and ADR 0067 establish that
  the history was rewritten once on 2026-09-21, excising the ear trainer's 216 files and 76 commits;
  pre-rewrite objects are gone from the clone and none of its 27 dangling commits hold them. A
  bundle of the pre-rewrite state exists outside the repository, verified this session: 3.6 MB,
  written at the minute the rewrite ran, its `refs/heads/main` matching the pre-rewrite SHA in
  `.git/filter-repo/ref-map`. Its **existence and contents are recorded here; its location is not**,
  in any file. An absolute path resolves on one machine and this repository is public by G2, so 11's
  path check and 13's provenance decision both forbid it, and writing a path into a public repo is
  the wrong instrument against forgetting — a second copy is. Stated plainly for whoever reads this
  later: a single file in one directory on one laptop is the only extant copy of those 76 commits.

### Corrections to the record

- **Ticket 09's consequence 5** — *"The day-3 plugin subsystem deleted on day 7 is exactly what a
  two-hour bake-off would have pre-empted"* — rests on the misdescription corrected above. The
  re-charter it produced (bake-off as the justified exception, not the default) stands and is in
  fact strengthened; only its worked example fails. 09's body is immutable; the map's 09 line gains
  a pointer.
- **The 23.3% deletion figure is verified exactly** (13,212 of 56,700 Kotlin lines, the net matching
  `git ls-tree` line for line) but it is a lower bound on a redacted history, and it overstates
  waste: 13% of the deletions are a `ktlintFormat` sweep and 26% are Dual N-Back relocating.
  Genuinely abandoned work is about **11%**.
- **75 ADRs, not 76** — the 76th file is `docs/adr/README.md`.

### Limits

- **A practice that never ran cannot be measured.** Zero previews and no side-by-side variants
  inside Loop means the base rate of "reversals a bake-off would have caught" is partly a measure of
  a mechanism nobody tried — the trap 19 named for ADRs. What makes this different is that the
  reversals which *did* happen have identifiable causes, and those causes are not ones a comparison
  surfaces. That is a positive finding, not an absence, but it is weaker than a trial of the thing.
- **The ear trainer's numbers are a hole.** Its reversal is one of the two largest in the repo's
  life and is unmeasurable from the clone. The bundle was verified to exist and was not opened.
- **A deferral has no trigger**, which is the exact defect this ticket cites 15 against. Nothing
  will remind the rebuild that this was considered; the two salvage entries are the only carriers,
  and if they are consumed or trimmed the question disappears with them.
