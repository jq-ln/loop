# What a goal is, and what satisfies one

Type: grilling
Status: resolved

## Question

The first repo had **no goal entity at all** — no target, no threshold, nothing satisfied by a
measured value. `ROADMAP.md` recorded the deferral explicitly: *"Goals as first-class entities. For
now a root routine* is *the goal."* But the measurement layer reserved space for the feature and
never used it: `MetricDef` carries `goalable: Boolean`, commented *"whether a goal may target this
metric; not everything worth recording is worth chasing"*, beside a `Direction` enum of
`HIGHER_BETTER / LOWER_BETTER / NEUTRAL`, commented *"which way is better, for goals and for review"*.
Two dead fields waiting for this ticket.

This is the concept with the strongest claim under `SALVAGE.md`'s two-claims test, and the one whose
vocabulary will be mistaken for something else fastest.

- **Three satisfaction conditions, or more?** Candidates surfaced while charting: **completion** (the
  decomposition finishes), **threshold** (a measured value crosses a line), and **attested event**
  (an external fact is declared to have happened). The worked example matters: *pass the German C1
  exam* is attested, not completion — every prep child can complete and the exam still be failed, so
  "all children done, goal unsatisfied" must be a legal and visible state rather than a bug.
- **Terminal or standing, as a second and orthogonal axis.** *Reach 140 lbs* and *stay under 140 lbs*
  are the same measurement with different semantics: one closes, the other can only be held and can be
  lost again. A standing goal has no done state. The first repo's routines were standing goals that
  were never named as such, which is worth checking before the axis is adopted.
- **The admissibility rule, and whether it has teeth.** The human's own constraint is that a goal must
  be measurable in some capacity or there is no way to gauge completion. Stated as a mechanism: **a
  goal is admissible only if it names its satisfaction condition**, and the app refuses one that
  cannot. That is the direct analogue of `GOALS.md`'s *citable only if it can rule a decision out*,
  and it is what would make this a concept with an engine rather than a label. Does it survive contact
  with a real goal the human would actually file?
- **The ultimate goal.** The human wants a root that every lower goal services. Is that a real edge in
  the model — a single root every goal must reach — or a convention? If it is enforced, a goal that
  cannot trace a path to the root is refusable, which is the same teeth one level up. If it is not,
  say so, because an unenforced root is a decoration.
- **Does a goal rule work out?** `GOALS.md` earns its authority by rejecting things. The app analogue
  is a work item that cites no goal being visibly suspect. That is either the best feature in the
  sketch or a nag that makes the app unpleasant to live with, and G1 rules out anything the author
  would have to be talked into using.

## Survey corrections

Re-derived from the archive before grilling, because a survey table in this map has been wrong every
time one was checked. Three of the question's claims do not survive, and the two failure shapes are
the same ones the work-item ticket hit: a thing called *dead* that has a live consumer, and a
deferral quoted without the condition attached to it.

- **"Two dead fields waiting for this ticket" is wrong twice.** `Direction`'s own comment says it is
  *"for goals **and** for review"* — the review half is a consumer that needs no goal to exist, so
  the field is not waiting on anything. `goalable` has a wire validator with tests and one live
  first-party use: routine-time metrics are constructed with `goalable = false`, which is the
  editorial judgement in its comment — *"not everything worth recording is worth chasing"* — already
  being exercised on real metrics. Neither field is dead. Both are in service to something other than
  a goal.
- **The `ROADMAP.md` deferral carries a trigger the question dropped.** In full: *"Goals as
  first-class entities. For now a root routine* is *the goal. Revisit only if routines start needing
  to be grouped under shared objectives."* The first repo pre-committed to revisiting on a
  **grouping** need. The question's framing is measurement. These are opposite justifications, and
  the one the human actually arrived at is grouping — a root that every lower goal services.
- **The surviving goal surface is entangled with a platform that is not being rebuilt.** `goalable`,
  `Direction` and a `<goal-template>` element that nothing parses all live in the plugin wire's
  manifest and declaration format. The plugin platform is out of this map's scope, and `SALVAGE.md`
  has no goal entry to consume. **There is nothing to port.**

Confirmed as stated: no goal entity at all; `MetricDef.goalable` and the three-value `Direction` enum
exist with the quoted comments; and the archive's glossary saying Plan *"has no engine and exists as
a declaration only"* — which is the source case for `SALVAGE.md`'s prohibition on a top-level concept
that arrives without one.

## Answer

**A goal is greenfield, not a port, and it arrives with an engine or it does not arrive.** The engine
is a satisfaction predicate, a mandatory edge to a root, and two terminal states. Written in the
vocabulary the work-item ticket settled: a **definition** is what could be done, a **run** is a
materialized instance of one.

### Two families, not three conditions

The three candidates collapse to two, because they sit at different levels.

- **Derived** — a predicate over facts the app already stores, computed on read and never written.
  Two sources: the **definition graph** (the children under this goal are done) and the **metric log**
  (a value crossed a line).
- **Declared** — an attested instant supplied by the human, stored as a fact because it exists
  nowhere else.

*Completion* is not a third kind; it is the definition-graph predicate. A goal's children are
sub-goals and definitions uniformly, so roll-up needs no separate machinery: the same predicate
evaluated one level up.

Nothing stores a progress value. A threshold goal that wrote "satisfied" would freeze today's verdict
into history and stop re-grading when the target moved, which is exactly what `SALVAGE.md`'s
*store facts, compute judgements on read* forbids. The declared instant is admissible because an
attestation is a fact, not a judgement.

This makes the worked example legal by construction rather than by exception. *Pass the German C1
exam* is declared; every prep child can complete and the goal stay unsatisfied, because a derived
predicate firing on a declared goal **offers** the attestation and never writes it. "All children
done, goal unsatisfied" is the normal resting state of a declared goal.

### Terminal and standing

One boolean, not a second entity: does satisfaction **latch**? Terminal closes on first satisfaction.
Standing is recomputed forever and can be lost.

**Standing requires the metric predicate.** A standing goal is a held threshold. A standing goal
satisfied by completion or attestation is refused, because that is a routine wearing a hat — the
first repo's routines were standing commitments never named as such, and a concept that only
re-describes one names no stage nothing else covers.

### The root, and the one exemption

Every goal names a parent. The root is the only goal without one, and the app refuses an orphan. The
parent defaults to the root, so filing never blocks on deciding where a thing hangs.

That default is deliberate and it moves the teeth rather than removing them: connectivity becomes
true by construction, and **meaning becomes visible instead of enforced**. A pile of goals hanging
directly off the root is a legible smell at review time, which is the culling picture the root exists
to produce.

**The root is the single exemption from admissibility: it has no satisfaction condition and can never
be satisfied.** Its job is orientation, not closure, and a magnum opus you could tick is not one. One
exemption, created once at setup, unreachable by the user — not a loophole.

In the glossary and in engine prose the word is **the root**. It gets no user-facing label: there is
exactly one, and a category name above a singleton is furniture. The screen shows what the human
wrote.

### Admissibility, and where its teeth are

**A goal is admissible only if it names its satisfaction condition**, and the app refuses one that
cannot — the direct analogue of a criterion being citable only if it can rule a decision out.

For the metric predicate this means the metric **must already exist and be marked chaseable** at the
moment the goal is created; creating it inline from the goal screen is fine, naming a future one is
not. Otherwise admissibility degrades from a test into a promise. The direction comes with it, since
the app cannot know which side of the line satisfies without one.

This is the one idea from the archive that survives its platform: not the code, but the judgement
behind `goalable` and `Direction`.

### A goal that is worked against

An abstinence goal — sobriety — is a standing goal over a lower-is-better metric with a threshold of
zero. The thing logged is an **observation**, not a definition and not a run: nothing schedules *do
not drink*. Metrics are goal-agnostic and goals target metrics, so no observation is ever asked what
it was in service of.

**No new concept.** An *anti-goal* would have to name a stage nothing else covers and arrive with an
engine, and it can do neither: direction plus a zero threshold is the engine, and it already exists.

### Culling

Culling is a **state**, never a delete. **Abandoned** sits beside **satisfied**: same finality,
opposite meaning, both visible. A delete would take the runs with it, and those runs are the only
evidence the goal was ever pursued. A culled goal takes its subtree; the definitions beneath it
survive, lose their citation, and surface as uncited work rather than disappearing.

Two derived prompts make the case, and the human makes the decision. **Root-adjacency** — filed
without deciding what it serves. And **dormancy**, which is *no evidence in N days* where evidence is
**family-specific**:

| Family | Evidence |
|---|---|
| Definition-graph | Runs beneath it |
| Metric | Observations on its metric |
| Declared | Its subtree's evidence |

A single evidence type would fire on every abstinence goal forever: sobriety generates no definitions
and no runs, so the goal being held most successfully would read as the most abandoned thing in the
app. For a metric goal, silence means tracking stopped — which is the genuine dormancy signal there.
A declared goal with an empty subtree is unserviced by definition, and that prompt is correct.

`N` is a knob with no evidence behind it. It is tuned by use, not decided here.

### Every definition cites a goal, gated at commitment

Required, defaulting to the root, the same mechanic as goals so there is one rule rather than two.
The value is the mindfulness: nothing enters the day without a stated reason.

**The gate sits at commitment, not at capture.** A thought needs no goal; a commitment does. The
citation is required before a definition can reach Today or be logged as done, and capture itself
asks nothing — otherwise the cheapest act in the app becomes its most interrogated one, which
contradicts capture defaulting to unscheduled and is the shape of thing the first criterion rules
out. Asking at the moment of committing is also the better moment for the mindfulness: the human has
already stopped to think.

This fills the hole the work-item ticket left open. Its answer closed on a constraint — if Today has
nowhere to show unscheduled work, unscheduled must not be the capture default. **The uncited backlog
is that place**, and pulling something out of it is the act of saying what it serves.

Read the two root piles differently: goals on the root are unexamined, work on the root is life.

**This is the highest-friction decision in the sketch, and it ships with its own falsifier.** If the
uncited backlog grows monotonically for two weeks, the rule is being dodged rather than served. That
is a fact the run log can answer.

### Retraction

A declared satisfaction is retractable, and so is an abandonment. The retraction is dated, never an
erasure: the attestation was a fact, and a correction to a fact is also a fact. Derived satisfactions
need no retraction — they re-derive, and a standing one is designed to be lost.

### The word

**The app keeps `goal`.** The project-level concept gives it up, because those two things are
different species and the app's is the one the user says out loud.

The argument is that the project's own items would fail the app's admissibility rule: they are
standing, they never latch, and neither names a measurable condition. They are the standing tests
every decision must pass, and the accurate word for a test is **criterion**. `constraint` is
unavailable — the architecture file opens by claiming it — and `commitment` is half-spent by the
human's own procedure.

So: `CRITERIA.md`, ids `C1`/`C2`, non-goals become **exclusions**. The renamed file carries one line
saying `C1` was `G1`, so dated records written under the old word still read. Records already
committed are not rewritten; the rename commit is where the mapping is stated.

**Four mechanical costs, all keyed to the filename, all silent, all one-line edits in the rename
commit.** They were found by reading the hooks, not by reading the rename:

| What breaks | Where |
|---|---|
| The 40-line hard cap stops firing | `.githooks/pre-commit`, the literal `'GOALS.md=40'` — the check continues past a name that is not staged |
| The isolated-commit rule stops firing | `.githooks/pre-commit`, `ALONE='GOALS.md PROCEDURE.md'`, same shape |
| `just goals` reports "none yet" forever while looking like it worked | the recipe greps `^Goal: G[0-9]+` |
| New ADRs scaffold a citation line nothing reads | `just adr new` writes `Goal:` |

The second is the one that matters: that hook is the whole mechanism behind the human's own rule that
a goal edited after the work it justifies is visible in the log, and a silent failure removes the
protection from the file whose edits most need to be visible. The ADR directory is empty, so the
deletion list that a goal's identity change would have to enumerate is empty today and never will be
again.

Executing the rename is the owner's act on owner-only files, not a step on this map's route.

### What this does not decide

- **Where an observation is entered**, and whether a tally sits on Today. *Observability* and *Today*
  inherit two constraints rather than questions: the measurement layer owes goals a chaseable flag
  and a direction per metric, and an abstinence goal's observation surface must exist for a
  zero-threshold standing goal to be usable at all.
- **What the goal picker looks like** at the moment of commitment, and whether it survives contact
  with a real flow. That is the input vocabulary's business, and it is where the friction risk is
  either confirmed or retired.
- **`N`, and the shape of the cull review.** Tuned by use.
