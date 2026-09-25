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

**Every survey table in this map is suspect until re-derived.** Every ticket that carried one had it
wrong. Three shapes recur in the archive's **code**: a capability called *refused* that the archive
had costed and explicitly retracted the stronger claim about; a field or path called *dead* that had
a live consumer; and — the nastiest, because it is what a working feature looks like — a field
**validated on the way in and read by nothing**, where a parser, a validator and passing tests all
exist and no consumer does.

**Three more recur in the preserved data, and all are a number read as a verdict.** A **count read
across a window the feature did not exist in**: the journal shipped on the fifth day of a ten-day
window and both its entries fall on the last two, so *two entries in ten days* is not a use record at
all. And a **pattern inferred from the most recent days** of that window: the copy's own day showed
two routines dismissed wholesale, and across ten days the opposite is true — the judgement is
per-step, in 14 of 23 dismissals. The second was caught by the author and not by the data, which is
the thing to take from it: having the database open is no defence, because a query answers the
question you asked it.

And a **count of an act taken, read as evidence about the act** — which is only evidence once you
have checked the act was **offered**. *The input vocabulary* found five of eight acts at zero over
the baseline and three of the zeros were not disuse: two lived behind a filter that had to be typed
into first, and snooze was structurally unofferable on **34 of 64 root runs**, because a daily
untimed routine's only surviving preset lands exactly on its own next firing. The distinction is the
one the archive itself draws between a capability *refused* and one merely *never reached*, arriving
as a count rather than as a comment — and a zero is the easiest number in the world to read as a
verdict, because it looks like the feature answering for itself.

Re-derive a ticket's archive claims from source before grilling on them, and record the corrections
in the ticket, because the corrections and not the original claims are what the answer is built on.

**The archive is not the only stale survey.** *Observability* relayed a claim about another live
ticket's contents without reading it, and was corrected by the session working that ticket. Read the
ticket, not the summary of it — the failure does not need the archive to happen.

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
  **Its root decision did not survive**: [Do goals serve principles, rather than a single topmost
  goal?](issues/13-goals-serve-principles.md) deleted the root, replaced the parent default and
  widened the citation target — read that ticket before building on anything above a goal.

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

- [The goal-to-work edge: decomposition, gating, and what the Tickets screen is](issues/03-the-goal-to-work-edge.md):
  **Tickets is neither a concept nor a screen — it is the goal detail view**, and the word does not
  enter `PRODUCT.md`; the goal already owns that stage, so it fails the two-claims test. What survives
  the analogy is one mechanic, renamed: **`prerequisite`, not `gate`**, because `gate` already means
  three things in this repo. The decomposition is **not** the definition DAG — unifying would fire the
  cascade on goals and write `ROLLED_UP` onto one, contradicting 02 — so there are two structures and
  three edge kinds, and **the decomposition edge is the citation edge read backwards**. A prerequisite
  **replaces a schedule rather than coexisting with one** (a blocked item is *absent* from Today, not
  dimmed), joins any two nodes independently of the citation tree, inherits down it, allows many
  predecessors under AND only, and **re-closes when its predecessor's completion is reversed**.
  Abandonment opens nothing; a prerequisite naming the root is refused at creation. `AFTER_ROUTINE`
  dies and the schedule engine ports minus one mode. No progress bar ever — a count is a fact, a
  percentage is a claim nothing supports. **Amends 02: dormancy counts only time a node was
  actionable.** Flags a gap: `prerequisite` and `blocked` owe a `CONTEXT.md` entry and no ticket on
  this map owns that write.

- [Observability: does the measurement layer gain a prescriptive half?](issues/04-observability-prescriptive.md):
  it does, and it gains a pillar — but the pillar is **`metric`**, and *observability* is analogy
  vocabulary that does not reach `PRODUCT.md`. A **metric** is the named series; a **check-in
  question** narrows to one *source* that feeds it, and direct entry is another, which is what makes
  measuring a stage rather than a property of work already being done. A **target** lives on the
  goal, six fields — metric, aggregation, window in days, comparator, number, minimum reading count
  — the first five being `<goal-template>`, a grammar the archive **specified in the plugin manifest
  doc and never implemented**, the sixth a named departure. Three verdicts: satisfied, breached, and
  **undecided**, which costs nothing because no verdict is stored and which doubles as the dormancy
  signal for this family, citing *The goal-to-work edge*'s actionable-time rule. **A predicate is
  computed over the values recorded and may never be a function of the days with no value** — which
  makes "did it on N days this week" unexpressible here and pushes it to the run-log family, an
  author-flagged ADR for after the post-mortem. `Direction` and `goalable` are deleted; a metric's
  view is one line chart with the target on it; a metric is archived, never deleted. The evidence:
  nineteen observations across three questions in ten days, **only one of core's three metric groups
  has ever held a row**, and a weigh-in gap that read as abandonment and was travel — a third cause
  of a gap, *the measurement was not possible*, that is a refusal by nobody and is recorded nowhere.

- [Does Reflect survive its own test?](issues/05-does-reflect-survive.md): **it does not — the stage
  it was named for does, and it is not the stage the archive gave it.** The journal fails the
  two-claims test, and the archive had already run that test and shipped it having failed: *"there is
  no rule in a journal to test on the JVM."* What replaces it is the loop's return edge — **a goal
  changes because of what happened** — and the hole it fills is exact: 02 gave a goal satisfaction,
  abandonment and retraction, and **no way to change one while keeping it**. `revision` is the
  missing verb, a dated attested change whose subject is a goal, a definition or a target; **not** a
  `review` session entity, which is a container shipping before its contents. The engine is the
  **assembly** of flags already specified across three tickets and owned by none — nine of them,
  reading both logs under both families' rules — and Reflect is where the act happens, not a place
  that routes, on the archive's own unplugging note: *"nothing the user does belongs on a view."* It
  **detects and names a remedy, never authors content**, there being no model in the app. Adds
  **`stalled`** beside 02's `dormant`, because someone stuck at 8 pushups daily is maximally active
  and every existing signal reads them as healthy; **refuses an optional target date**, with a
  falsifier. A flag is **dismissed with a dated reason**, which is where *Observability*'s third
  cause of a gap — *the measurement was not possible* — is finally recorded, and which gives the
  revision log a mechanical consumer from day one. **Signal-driven, cadence explicitly refused, so
  reflection is not a Today row.** The journal survives as **raw material**, prose landing on a
  revision or against the day under **one `note` with a discriminated subject** — knowingly
  overturning the archive's *"never merge the two"*, whose stated reason was storage-shaped. Flags
  **Reflect as a consumer of** [Do goals serve principles?](issues/13-goals-serve-principles.md):
  goal-to-goal prerequisites are that ticket's to authorise, and the detection is invariant either
  way.

- [Today: what is on it, and how is it ordered?](issues/06-today.md): **Today is the frontier, and the
  frontier is not the schedule's output** — the schedule's claim and what is merely worth doing are
  different claims on **one** screen, because a backlog behind a destination is what G1 rules out. Six
  classes of row; blocked work **absent**; reflection not present at all. **The order is the
  structure's and there is no score** — `ScoreCalculator` was not weighed and rejected, it **never
  ran**: one caller in the whole archive, its own unit test, and `importance` constant at 1 across 42
  definitions with `boost` never once set. **Expansion is a property of the definition**, set once like
  the root order, which is what the author's correction bought: the act is a per-step judgement, **14
  of 23 dismissals are at step level**, and the run log splits the routines into two classes wanting
  opposite shapes — Night Routine's root never once dismissed whole, Clean Bathroom's steps never once
  dismissed individually. Hoisting is refused because `Sweep` and `Mop` are steps of both cleaning
  routines. **A miss is a line, not a row**, and carry-forward's existing opt-in replaces an invented
  cap. **`Offered` is the whole uncited backlog** at the foot of Today, which discharges 01's
  constraint so capture may default to unscheduled — **adopted provisionally**, with 02's
  monotonic-growth falsifier and 05's backlog-dodging flag as the pre-registered test and a backlog
  destination as the pre-registered remedy. **A reading is a row and it ticks**, independent of any
  run: the archive's *"a row that can never be ticked reads as work dodged"* does not reach a reading,
  and independence is what stops the 09:07 dismissal that auto-closed *Weigh-in* from destroying the
  day's weight unrecorded and unreported. **The day's note is written on the app bar's date**, the day
  having no row and deserving none. **Four destinations — Today, Goals, Metrics, `Revise`** — and it
  is *not* called Reflect, that being the analogy's word for a pillar whose concept was refused; three
  nouns and one verb, three places you look and one place you act. Hands *The input vocabulary* a
  dependency (two properties must be editable) and the register two words. **Adds a fifth
  stale-survey shape**, from its own first draft: *a pattern inferred from the two most recent days of
  a ten-day window*, caught by the author and not by the data.

- [The input vocabulary: which actions exist, and which gesture means what](issues/07-the-input-vocabulary.md):
  **one meaning per gesture, everywhere — a meaning may be *absent* on a surface, never *different***,
  and that one rule generates the whole table. Six meanings: tap opens a detail (**no exception**,
  which fills the archive's leaf-tap hole), hold opens the complete act menu **including the swipes**,
  swipe → discharges, swipe ← refuses a run, the rail reorders, the chevron folds for the session over
  06's stored default. Four of eight candidate acts do not survive, and each for a different reason:
  *skip with a reason* **never existed** — `closed_reason` is the app's bookkeeping, not a reason the
  user gives, and no gesture writes a skip; *boost* has **no caller anywhere**, closing 06's score
  finding from the input side; *complete off-list* and *put on today* are **absorbed** into a search;
  and **the timer is the one clean zero**. Membership follows the object — day-acts to the root,
  work-acts to wherever the work is. **The rail is a property of a draggable row, not a screen
  fixture** (the author's generalisation), which retires three archive defects at once by giving drag
  its own target. **One field in `Offered` searching every definition**, with capture as a
  **Create "…"** result row, so the search is the duplicate check and the two absorbed acts get a real
  home. **Defer dismisses today's run and links it**: the dismissal answers *did it happen today*, the
  link answers *why not* — no sixth reason. `Offered` has exactly **two exits, commit or abandon, never
  a delete**, which is what makes 02's monotonic-growth falsifier mean anything. **Kills the check-in's
  staged commit** — a defect the archive's own list of nineteen missed, in an app promising *everything
  writes as it goes* — and makes every capture write on entry. **Amends 08**: its counts are exact but
  its finding 2 is over-read, and the honest baseline is **40 lapses and 23 dismissals**. **Amends
  `SALVAGE.md`**: the four-paths claim is inherited from a docstring stale against its own enum, which
  has five reasons and seven call sites.

- [What carries over from the running app, and by what route](issues/11-what-carries-over.md):
  **the most speculative ticket on this map, and deliberately not formalized.** There is no route to
  design — the back-fill is manual and happens after the fact: once the new app runs, comb through
  what the old one tracked, make a place for what is still wanted, and write SQL inserts against the
  new database. So **the new app builds no import feature and this makes no claim on the first
  slice**; "migration from the first Loop" stays permanently unbuilt rather than deferred, because
  it never becomes a feature. Nothing of the old schema enters the new app. Worth carrying, as
  named, is **the whole live metric surface plus one bare root** — five weight readings, two rating
  series of seven, and wake/sleep **times that live in `occurrence.completed_at` and in no
  observation**, which is *Observability*'s `RoutineTimes` group and why it never held a row. The
  three check-ins need no routine around them; **Scale Degree is cut**. The trap for whoever writes
  the inserts: `completed_at` is set on **125 rows of which only 68 are `DONE`**, so selecting on the
  timestamp rather than the status manufactures two `AUTO_CLOSED` weigh-ins on the travel days and
  runs the weight series three days past its real end. **Amends 01** — a definition is archived,
  never deleted, argued from the one delete in ten days that left occurrence 103 pointing at nothing
  while `archived_at` stayed null on all 42. **Amends 04** — `SCALE_1_5` is deleted, there being zero
  rows to decode. **Amends `SALVAGE.md`**, stale against the code: `display_name` *is* back-filled
  onto pending rows, and the true rule is that a finished run keeps the name it was done under.

- [Do goals serve principles, rather than a single topmost goal?](issues/13-goals-serve-principles.md):
  **they do, and 02's root is deleted rather than kept above them.** The author's four — intellect,
  aesthetics, body, spirit, each a proposition and none of them tickable — settled adoption from G1
  alone, and settled more besides: **only one of the four entries is a goal**, two being standing
  practices 02 refuses and 04's rule 3 cannot rescue. So **a definition cites a goal *or* a
  principle**; permitting only goals would manufacture an invented goal above every practice and
  silence the engine by construction. The engine is **not** the unserved predicate this ticket
  argued but the **roll-up of flags already specified** — 02's dormancy, 03's actionable time, 05's
  `stalled` — of which *nothing under it* is the degenerate case; vacuous under one root, computable
  under four, and it inherits 05's dismissal-with-a-dated-reason, so the prompt cannot be silently
  ignored. Single parent throughout, no default: **goal→goal stays a tree and goal-level
  prerequisites survive**, because they outlive the absence of work, while the step edge stays a
  many-parent DAG — 29 rows, 26 children, three with two parents, re-derived and **correct as
  written**, this map's first survey claim to survive checking. Unassigned goals get a pile that is
  not itself a principle; `Offered` is untouched. **Wording is free** via 05's `revision` gaining
  `principle` as a fourth subject, **no cap and no immutability**, but creation is its own act and
  never inline from filing. The author's hope that principles *mature and settle* is a prediction
  the revision log measures: **if revision frequency does not decay, the hypothesis is false.** No
  fifth destination; `unserved` joins 05's flag assembly. **Day one is zero principles with
  everything unassigned**, so the concept costs nothing at setup. Spends 02's root, citation rule and
  dormancy table, 03's edge table wording, 05 twice, and **widens 12 from register-only to
  register-plus-one-write** — the ADR is owed and is **not** deferred to port time, because unlike
  01's and 05's it is fully decided now.

- [When is the app allowed to interrupt?](issues/14-when-may-the-app-interrupt.md): **it may, and the
  hypothesis this ticket was charted to test died of the map's own third shape — twice.** `remind` is
  `0` on all 16 schedules, but the switch is drawn only for a schedule that already has a time of day
  and **one of 16 has one**, so that is n = 1; and the app requests `POST_NOTIFICATIONS` in exactly
  two places, the switch itself and starting a countdown, of which `occurrence_timing` holds **zero
  rows** — so the app almost certainly **never once asked**, and it is **n = 0**. A reminder that
  could not be delivered is not a reminder declined, and the 1-of-16 is the defect's consequence, not
  evidence about the feature. **A sixth stale-survey shape, a refinement of the third: checking that
  the act was offered is recursive** — the offer's own entrance must be reachable — and the tell is
  that the more finished the capability, the more convincing its zero. So **a time of day *is* a
  notification at it and the two switches collapse**, no `remind` flag, a per-definition silent
  opt-out, and no time still means due *that day*. **The permission is asked the first time a time is
  set** — not at setup, which 13 leaves empty, and not at firing, when the phone is not in hand. The
  boundary, and the sentence `PRODUCT.md` carries: **the app notifies about a moment you chose and
  never about a judgement it formed**, which is what leaves 05's refused cadence intact rather than
  excepted. **Fires once, silent if already done, clears on close, never repeats**; **carries no
  acts**, which **amends 07** — a surface may carry none — with done-from-the-shade the first unbuilt
  line. **Today's order is untouched** (06), a **badge is refused by the rule** and a **widget merely
  unbuilt**. Dropping the field would have been the expensive consequence of the refusal: a time has
  **four** consumers, and the third is the gate on sub-day snooze, so **01's `snooze` has nothing to
  move against without it**. **Adopted provisionally on zero evidence** — nobody has experienced a
  Loop notification — the test being the share of new scheduled definitions that carry a time, the
  hard stop an OS-level mute, the remedy the line it would otherwise have written. Spends one ADR
  owed at port time (exact alarms) and hands 12 the **`timed` collision**: *has a time of day* and
  *has a stopwatch*, live, in the same package.

- [The first shippable slice, and what is deliberately not built](issues/09-the-first-slice-and-what-is-not-built.md):
  **work, Today, metrics, and principles as the only citation target** — three destinations, Today ·
  Goals · Metrics. The ticket's own candidate could not exist: 02's gate needs a citation target and 11
  found the metric surface is what the author still uses, so **the gate and the readings are the
  floor**. Goals proper, prerequisites and `Revise` are cut; prerequisites go **with** `long-blocked`,
  so 05's coupling cannot bite. `revision` ships with principle as its only subject, to feed 13's
  decay falsifier from day one; the day's `note` carries *the measurement was not possible* until
  `Revise` exists; a snoozed untimed run notifies at its anchor. **No onboarding** — the first capture
  is the first act. *In a user's hands* is 11's cutover; the second slice is triggered by evidence
  naming one absence, and `Offered`'s falsifier runs by hand in the report-back session. **Not built
  lists absences only**, one line per thing a user would notice missing — thirteen of them;
  refusals belong to `PRODUCT.md`, the importer among them, and the plugin platform stays with
  `ARCHITECTURE.md`'s own section. Names four non-goal candidates and writes none.

## Not yet specified

Nothing. [The first shippable slice](issues/09-the-first-slice-and-what-is-not-built.md) cleared
the last two patches: the empty state is resolved in its answer, and the import format for a
decomposition folds into its first *Not built* line.

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
  not a step on this map's route to the sketch, and it straddles the owner-only boundary, so it is
  ticketed on the map that owns how the repository is kept: [Rename the project-level concept:
  GOALS.md becomes CRITERIA.md](../post-mortem/issues/23-rename-the-goals-document.md).
- **The back-fill itself.** [What carries over from the running app, and by what
  route](issues/11-what-carries-over.md) settled that it is hand-written SQL run once against the new
  database, after the new app is up. It needs no design and nothing about it blocks the sketch, so it
  is the rebuild's work and not a step on this map's route.
