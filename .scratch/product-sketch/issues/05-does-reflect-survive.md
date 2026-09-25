# Does Reflect survive its own test?

Type: grilling
Status: resolved
Blocked by: 04

## Question

Reflect is the concept in the analogy with the weakest warrant. In the first repo it was one screen
(244 lines), one repository (95) and one entity — `journal_entry` is `id / body / written_at /
edited_at` — and the repo's own boundary note says prose *"has no comparable form"* and is excluded
from Track. `SALVAGE.md`'s prohibition names this case almost verbatim: **storing text with a
timestamp is not an engine.**

The analogy calls it a devlog, which is a genuinely useful thing in a repository. This ticket asks
whether it is a useful thing in this app, or whether it is a text box that survived because it was
easy to build.

- **What does it do that a note on a work item does not?** The occurrence model already carries a
  `note`. If reflection attaches to a thing that happened, it may be a field rather than a concept.
- **What stage does it cover?** Under the two-claims test it must name a stage nothing else covers.
  The candidate is *looking back over a period and drawing a conclusion* — which is a real act, and is
  also what ticket 04's charts are for. If the two overlap, one of them is the feature.
- **Does it have an engine, or can it acquire one?** The honest answer may be no, and a concept with
  a real stage and no engine is exactly the case `SALVAGE.md` says to refuse. A screen that is refused
  as a *concept* may still ship as a *screen*, which the post-mortem's advice — name screens, do not
  classify them — permits without cost.
- **The one piece of evidence in its favour.** `SALVAGE.md` records that the first repo's real
  decisions came from an in-app note appended to a file on the device and read beside the occurrence
  log. That is reflection doing load-bearing work — but for the *developer*, not the user, and those
  are different products. Whether the author's two roles are the same user here is the question under
  the question.

## Answer

**No — Reflect does not survive its own test. The stage it was named for does, and it is not the
stage the archive gave it.**

The journal fails the two-claims test as a concept, for a reason stronger than this ticket had when
it was written: the archive already ran that test and the journal shipped having failed it. What
replaces it is the return edge of the loop — **a goal changes because of what happened** — which
nothing else in this model covers, and which arrives with an engine that three resolved tickets have
already half-built without naming.

### The re-derivation, which the answer is built on

Per the map's Notes. The ticket's numbers are right: the screen is 244 lines, the repository 95, and
the entity is exactly `id / body / written_at / edited_at`. The boundary quote is real and sits in
the entity's own comment — prose *"has no comparable form, so it is not an objectively comparable
data point and Track's boundary excludes it."* Four corrections:

1. **It is not one screen; it is two ends.** Add the sheet (128), the DAO (40) and the entity (45):
   552 production lines and 404 test lines. The architecture is deliberate — *"Reflect owns the
   journal and reads it back; Today occasions the jotting"* — and the chip sits on Today's strip,
   **always drawn**, where the strip previously vanished on an empty day. The ticket's "a text box
   that survived because it was easy to build" describes neither the shape nor the cost. (Thinner
   than it looks, though: re-derivation by the session working *Today* found all three questions at
   `tally = 0`, so no tally chip was ever drawn and the journal was the only thing that strip ever
   held. It is *a place built for the journal*, not a general affordance the journal joined.)

2. **The use record is not evidence of abandonment. If anything it is evidence of adoption.** The
   journal shipped **2026-09-19**, in the release *"a journal, and Review is a built pillar"*, and
   the preserved window is **2026-09-15 to 2026-09-24**. It existed for six of those ten days, and
   both entries — 267 characters and 21 — fall on the **last two**. Nothing was skipped. Two entries
   is too little to be evidence either way, but what little it leans, it leans the other way from
   this ticket's framing. This is the map's stale-survey failure in a fresh shape, and a fourth one
   to add to the three the Notes list: **a count read as a verdict across a window in which the
   feature did not exist.**

3. **The engine test was already run in the archive, and the journal shipped having failed it.**
   `docs/REFLECT.md` records that a draft predicted the journal would be *"Reflect's first engine,
   and the bar a pillar clears to become a Gradle module"*, that this *"collided with CLAUDE.md's
   storing text with a timestamp is not an engine"*, and that the prohibition won: no `:core-reflect`,
   no module, *"there is no rule in a journal to test on the JVM."* `SALVAGE.md`'s prohibition is
   therefore not a new instrument applied to the archive from outside — it is **the archive's own
   verdict, reached at the time**, and the first repo's answer was already *concept no, screen yes*.

4. **Two smaller things.** ADR 0040 is a **set-aside proposal**, not an accepted decision (set aside
   2026-09-19 by the author who proposed it); its surviving conclusion is that the journal is
   Reflect's *"on a stage-of-the-loop footing rather than a kind-of-data one"* — the kind-of-data
   warrant was already rejected there. And the entity comment calling it *"Review's table"* is a
   stale word: the pillar was renamed the following day, in *"the pillars are four verbs"*.

### The redefinition

The app is a loop: goals are set, work is done toward them, progress is tracked, and **the goals are
revised in light of what happened**. Reflect is that last edge. The archive's stage claim — *looking
back over a period* — is a **viewing** act, and a viewing act loses to *Observability*'s metric view
by construction. The stage that survives is a **writing** act, and it has no competitor: nothing
else in this model writes goals in light of evidence.

Three things establish that this stage is real and unowned rather than asserted here:

- **The archive reached it and recorded it as a correction to itself.** Its *Deliberately not built*
  file carries the entry rule *"Nothing that Loop is unfinished without may sit here"*, and then says
  that rule had to be enforced because two entries named the two unbuilt pillars: *"Active daily
  planning was Plan and a periodic review was Reflect past the journal"*, both moved out to a map
  *"where the destination already required them."* The first repo named the journal as the thing
  Reflect sat **before**, and died before building what came after.
- **Three resolved tickets on this map assume a review and none owns it.** *What a goal is* calls a
  pile of goals on the root *"a legible smell at review time"* and leaves **"`N`, and the shape of
  the cull review"** open, *"tuned by use"*. *Observability* says *"an undecided goal is the one to
  ask about."* And *What a goal is* plants a falsifier — the uncited backlog growing monotonically
  for two weeks means the commitment rule is being dodged — that **nothing is responsible for
  telling anyone.**
- **The model has a hole exactly where the loop closes.** *What a goal is* gave a goal
  **satisfaction**, **abandonment** and **retraction** — two ways to end one, one way to un-end it —
  and **no way to change a goal while keeping it**. *Observability* gave a target six fields and
  never said who changes one or when. **Revision is the missing verb.**

So the concept inverts against the journal. The journal was a name with no engine. This is an engine
already specified across three tickets, with no name.

### The decisions

1. **The developer's note is not a warrant.** `SALVAGE.md`'s favourable evidence — a note on the
   device read beside the occurrence log — is filed under *Carry this* as a **practice**, not under
   *Port these*. Counting it as the journal's warrant is `SALVAGE.md`'s own third prohibition in
   miniature: crediting a structure for a property something else bought. The dogfooding loop bought
   those decisions; the text box was where it happened to land. The practice should be repeated in
   the rebuild and supplies **zero** evidence for a user-facing concept. The author's two roles are
   two products, and this map serves the user's.

2. **The stage is revision, not capture and not review.** Named precisely: *the goal set changes
   because of what happened.* Capture is real but is Today's and is not a pillar's worth of claim;
   *looking back* is owned by the metric view.

3. **One `note`, with a discriminated subject.** v2 was heading for three text boxes with three sets
   of rules — the run note from *The work-item model*, the measurement note *Observability* kept in
   the raw-values list, and a standalone entry. One `note` whose subject discriminates over **a run,
   a measurement, or the day** replaces them. The archive's *"never merge the two"* rule is
   overturned knowingly: the reason it gives is storage-shaped — `occurrence.note` is a column, so
   *"there is no row for a note with no run"* — and under one table the day-subject/run-subject
   distinction stops being asserted twice and becomes **derived from what the note points at**,
   which is *store facts, compute judgements on read* applied to a thing the archive solved by
   duplication.

4. **What reflection produces is a `revision`**: a dated, attested change, the same shape *What a
   goal is* gave declared satisfaction. **Not a `review` session entity** — that is the archive's
   unbuilt noun, and building a container for revisions before one revision exists is the plugin-wire
   prohibition in a new coat: a seam whose caller does not ship alongside it. Why dating it is
   load-bearing rather than bookkeeping is already written in this repo, about the author:
   *"Did I re-examine the goal, or reword it to fit what I had already built?"* — `PROCEDURE.md`
   answers that with visibility, not prevention, and *"that removes the silence, not the
   temptation."* A silent goal edit is the app's version of the same failure and takes the same
   remedy.

5. **The engine is the assembly**, and it does not take *Do goals serve principles*' engine claim.
   The flags are computed over the definition graph and the two logs, on read, never stored —
   JVM-testable with no device, which is precisely what a text box could never offer. A predicate
   over the top of the goal graph and the occasion that runs predicates are different claims; *The
   goal-to-work edge* set that precedent when the goal detail view displayed what it did not own.

6. **Reflect is where the act happens, not a place that routes you.** `core-data`'s
   `track/TrackRepository.kt` decides this, in the archive's own words: `recordNow` was built,
   shipped, and unplugged in 0.9.2 because *"nothing the user does belongs on a view"* — kept with
   its tests and zero production callers, annotated with the consumer it is waiting for. A Reflect
   that ranks and routes is a notification wearing a pillar's name. A revision's **subject
   discriminates over goal / definition / target**, so raising a threshold, dropping a routine step
   and lowering a target all land in one place.

7. **Reflect detects and names a remedy; it never authors content.** The app contains no language
   model and decomposition happens outside it, so the flag carries *this goal is out of reach, here
   is the evidence, goals like this usually want decomposing* — and never picks the numbers. This is
   *What a goal is*' existing shape: *"Two derived prompts make the case, and the human makes the
   decision."* A heuristic that guesses 10 and 20 from a max of 8 is a model with worse judgement and
   no way to say it is unsure.

8. **Stall is a second predicate beside dormancy, derived, with no new field.** *What a goal is* has
   exactly one inactivity signal — dormancy, *no evidence in N days*, family-specific — and it is
   blind to the case that motivates this whole ticket. Someone doing 8 pushups every day is
   **maximally active and completely stuck**, and every existing signal reads them as healthy. So:
   **dormant** is no evidence; **stalled** is evidence with no movement. Nothing else on this map
   computes the second.

   **An optional target date on a goal is refused**, with a falsifier: if derived stall proves to
   fire too late to be useful, the date is bought back then. A date is a second way to fail that the
   user typed in themselves in a more optimistic mood, which is the G1 hazard — something you would
   have to be talked into using — and `latches` already carries the terminal/standing distinction
   without one.

9. **A flag is dismissed with a reason, dated, suppressing for a window — and that dismissal is
   where `Observability`'s third cause of a gap finally gets recorded.** That ticket ended on an open
   wound: the engine closed the day, the user declined, or *the measurement was not possible*, and
   the third *"is a refusal by nobody and is recorded nowhere."* It is why a weigh-in gap read as
   abandonment and was travel. Reflect asks, and the answer is a stored fact that makes every later
   dormancy and stall computation correct. The app still may not **compute** the third cause —
   *Observability*'s prohibition stands — but it can ask, and this is the only place that asks.

   This also decides what the revision history is for, which would otherwise be the map's own
   warned-against specimen: the suppression window **reads prior dismissals by construction**, so the
   log has a mechanical consumer from the first day and is not `Direction` again — validated on the
   way in and read by nothing.

10. **Reflection is signal-driven, with a manual entrance always open, and a cadence is explicitly
    refused.** *Observability*'s most expensive lesson one level up: a weekly review that fires
    regardless records four failures that were travel. *The work-item model* made an untouched day a
    recorded skip **deliberately, for work**, and importing that to reflecting would manufacture
    guilt about not reflecting. The honest counter is that signal-driven may mean the app never
    prompts and reflection never happens — if use shows that, a cadence is bought back by evidence
    rather than assumed. **Reflection is therefore not a Today row.**

11. **The journal survives as raw material and loses its claim to be the pillar**, which is
    word-for-word what the archive's own entity comment always said it was for: *"writing something
    down so it can be read back when you look at the week is that stage's raw material."* Prose lands
    in two places, both under decision 3's single `note`: **on a revision**, which is the
    load-bearing half, because a revision with no stated reason is the reworded goal `PROCEDURE.md`
    warns about; and **standalone against the day**, which reflection reads beside the flags —
    literally what `SALVAGE.md` describes the author doing with the device note and the occurrence
    log.

### The flag catalogue

The three the author posed, plus five derived from signals already decided. All detect; none author.

| Flag | Condition | Reads |
|---|---|---|
| Out of reach | Goal's threshold far above the metric's observed range | Metric log |
| Stalled | Evidence present, no movement over N | Metric log |
| Dormant | No evidence in N, family-specific | *What a goal is*' table |
| Rarely done | A definition or step with runs far below its schedule | Run log |
| Backlog dodging | Uncited backlog grows monotonically for two weeks | Definition graph |
| Coasting | Target continuously satisfied, never undecided, never revised | Metric log + revisions |
| Long-blocked | A prerequisite open far beyond its predecessor's expected close | Definition graph |
| Work without effect | Runs accumulating beneath a goal, its metric flat | Both logs |
| Done but still working | A satisfied goal whose subtree still produces runs | Both |

Three of these are worth calling out as things only this ticket could see. **Backlog dodging** is
*What a goal is*' own falsifier, which that ticket wrote and gave to nobody. **Long-blocked** is a
blind spot created by a resolved decision: *The goal-to-work edge* made a blocked item **absent**
from Today rather than dimmed, so a prerequisite that never closes silently removes work from a
person's life and nothing reports it. And **coasting** is the only flag pointing at a target set too
low — without it the app can tell you that you are failing and never that you are idling.

The catalogue reads two logs under two different rules, and that boundary must survive into the
build: *Observability*'s prohibition — **a predicate may never be a function of the days with no
value** — governs goal satisfaction, while *Rarely done* is entirely about absent days. Both are
correct because they are different families, and the pair is easy to collapse by accident.

`N`, the suppression window, and each threshold are knobs with no evidence behind them, tuned by
use, exactly as *What a goal is* left its own `N`.

### What this ticket does not decide

- **Goal-to-goal prerequisites.** The author's first example — *"10 pushups blocks 20 blocks 50"* —
  is a goal-level prerequisite chain, and that is open in [Do goals serve
  principles?](13-goals-serve-principles.md), which argues that under multi-parenting *"the honest
  move is to refuse goal-level prerequisites outright"* because a second citation path makes them
  advisory. **This ticket is not blocked on it**: every decision above is invariant to how it lands,
  because *this goal is out of reach and wants decomposing* is a detection that does not care whether
  the remedy is a goal-level prerequisite or definitions filed under a new sub-goal. **But Reflect is
  now a consumer of that decision, and this is the record of it.**
- **The screen's name.** The concept entering the documents is `revision`, an ordinary English noun,
  the same demotion *Observability* took to reach `metric`. Whether the surface is still *called*
  Reflect is naming, not classification — the post-mortem permits naming a screen at no cost — and it
  belongs to [Register the vocabulary and the ADRs this map owes](12-the-vocabulary-and-adr-register.md)
  and to *Today*, which owns the navigation.
- **Whether any of this is in the first slice.** [The first shippable slice](09-the-first-slice-and-what-is-not-built.md)
  takes the catalogue with the note that a flag is cheap and nine flags are not.

### Consequences this answer spends

- **`SALVAGE.md` is untouched.** No entry is consumed. *Live with it on a phone, and keep the loop
  that reports back* is reinforced as a **practice** by decision 1 rather than spent, and the two
  prohibitions this ticket leaned on — the seam with no caller, and the two-claims test — both did
  work and both stand.
- **A fourth stale-survey shape for the map's Notes**: a count read as a verdict across a window in
  which the feature did not exist.
- **A potential port-time contradiction, flagged not resolved.** Decision 3 merges the run note into
  one `note` table. `occurrence.note` is a column on a ported entity, so if the merge moves it off
  the occurrence, that is a change to the definition/occurrence split and owes **an ADR at port
  time**, the same moment as *The work-item model*'s rename. Registered in the vocabulary ticket.
- **Amends *What a goal is*** with a third inactivity predicate (`stalled`) and with `revision` as
  the verb that changes a goal without ending it. Amends it in the way *The goal-to-work edge* set
  the precedent for: recorded here, one decision one home, that ticket not reopened.
- **Closes *Observability*'s open wound.** The third cause of a gap has a place to be recorded.
  Decision 9 is that ticket's dangling end tied off, and it did not need a mechanism of its own.
- **`Direction` is not reintroduced.** *Observability* left it available to this ticket *"with a
  consumer"* if one appeared. None did: a flag reads the target's comparator, which already carries
  which side is a breach. The field stays deleted.

## Comments

**2026-09-25, from the session working [Today](06-today.md): `long-blocked` may become load-bearing
rather than belt-and-braces.** That ticket is likely to recommend dropping a *"1 blocked, not shown"*
footnote from Today, on the grounds that it is both redundant with this catalogue and a soft
contradiction of *The goal-to-work edge*'s decision that a blocked item is **absent** rather than
dimmed. That reasoning is sound and this ticket does not contest it — but it creates a coupling worth
stating plainly, because the two decisions are in different tickets and each is individually
defensible:

**If Today drops the footnote and [the first slice](09-the-first-slice-and-what-is-not-built.md) cuts
`long-blocked` from the catalogue, then work can be silently removed from the author's life with
nothing anywhere reporting it.** Neither decision is wrong on its own. The failure only exists in the
gap between them, which is exactly the kind nobody owns.

So when the slice weighs the catalogue, *"a flag is cheap and nine flags are not"* reads differently
for this row than for the other eight. The other eight report something going wrong that is visible
elsewhere if you look. This one is the only reporter of a condition that is **invisible by
construction** — the absence was designed in deliberately, and designed-in absences do not announce
themselves. If it is cut, the footnote has to come back, and that is Today's decision to unwind
rather than this ticket's.

Recorded here rather than in the slice ticket because that ticket reads its blockers and both are
among them, and because the recommendation that triggers it is not yet settled — Today is mid-round
with the author.
