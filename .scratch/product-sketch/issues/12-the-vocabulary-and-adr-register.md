# Register the vocabulary and the ADRs this map owes

Type: task
Status: resolved
Blocked by: 09

## Question

Nothing to decide. This map is accumulating two kinds of debt that no ticket owns, and both come due
at documentation time rather than at decision time.

**Vocabulary.** Every resolved ticket has coined words, and `CONTEXT.md` is a standing-claim file
that nothing on this map is chartered to write. *The goal-to-work edge* recorded that as a real gap
in the execution plan: *Write the sketch* names `PRODUCT.md` and the two `ARCHITECTURE.md` sections
and no third file. *Observability* first folded the write into *Write the sketch*; the author
redirected it here, so the register is a ticket rather than a line in someone else's charter.

**ADRs.** Decisions have been deferred to an ADR written at a later moment — at port time, or after
the post-mortem finishes — and a deferral with no register is a decision that quietly does not get
recorded. The first repo's failure was the reverse (75 ADRs bulk-extracted from one file in two
days), but the post-mortem's own evidence is that *"ADR in the same commit as the code, never a
follow-up"* broke in 1d 7h and left two decisions permanently unrecorded when the repo was killed.

This ticket is the register, kept current as tickets resolve and resolved when the decisions are in.
It decides nothing; it is the list *Write the sketch* reads from.

**The inventory below is as of this ticket's opening and is suspect by the map's own rule.**
Re-derive it from the resolved tickets before writing anything from it — this map has found a stale
survey table in every ticket that carried one, including one this session wrote itself.

### Vocabulary coined so far

| Term | From | Note |
|---|---|---|
| `definition` / `run` | [01](01-the-work-item-model.md) | The ported entity's rename; owes an ADR at port time |
| `routine` | [01](01-the-work-item-model.md) | Demoted from a category to a shape |
| `snooze` / `defer` | [01](01-the-work-item-model.md) | Two words the archive used for one thing |
| `goal` / `criterion` | [02](02-what-a-goal-is.md) | The app keeps `goal`; the project-level concept is renamed |
| `derived` / `declared` | [02](02-what-a-goal-is.md) | The two satisfaction families |
| `latches` | [02](02-what-a-goal-is.md) | Terminal vs standing, as one boolean |
| `satisfied` / `abandoned` | [02](02-what-a-goal-is.md) | Culling is a state, never a delete |
| `prerequisite` / `blocked` | [03](03-the-goal-to-work-edge.md) | Named to avoid `gate`, which already carries three senses here |
| `metric` / `source` | [04](04-observability-prescriptive.md) | Split from `question`, which narrows to one source |
| `target` / `undecided` | [04](04-observability-prescriptive.md) | The third verdict, and the dormancy signal for the threshold family |
| `archived` | [04](04-observability-prescriptive.md) | A metric's equivalent of `abandoned` |
| `revision` | [05](05-does-reflect-survive.md) | A dated attested change to a goal, definition or target — the verb 02 lacked |
| `note` | [05](05-does-reflect-survive.md) | One concept with a discriminated subject, replacing three text boxes; overturns the archive's *never merge the two* |
| `stalled` | [05](05-does-reflect-survive.md) | Evidence with no movement — a third inactivity predicate beside 02's `dormant` |
| `flag` / `dismissal` | [05](05-does-reflect-survive.md) | What reflection raises, and the dated reason that suppresses it |

`CONTEXT.md`'s own bar is that a term earns an entry once it is in use **and has been mistaken for
something else**. Two already clear it: `gate` collided three ways, and `metric`/`question` mean one
thing in the archive and two here. The rest are judged at write time, not admitted wholesale.

### ADRs owed so far

- **The ported entity's rename**, from [01](01-the-work-item-model.md) — written at port time, in
  the commit that renames, citing G2. Not now.
- **Why a windowed count is not expressible as a metric threshold**, from
  [04](04-observability-prescriptive.md) — **after the post-mortem finishes**, at the author's
  direction. What it records is the trade-off, not the rule: a windowed count is the most natural
  goal a person states, and the app refuses to compute it from measurements because the measurement
  log cannot say who caused a gap.
- **Whether `occurrence.note` moves off the occurrence**, from
  [05](05-does-reflect-survive.md) — written at **port time**, the same moment as 01's rename, and
  **only if** the single-`note` decision lands as a move rather than an addition. `occurrence.note`
  is a column on a ported entity, so relocating it is a change to the definition/occurrence split.
  Flagged rather than resolved by that ticket, and the one candidate found so far for the bullet
  below.
- **Why the top of the goal tree is a set of principles rather than a single root**, from
  [13](13-goals-serve-principles.md) — **written by this ticket, not deferred.** The only entry on
  this list whose moment is here. 01's and 05's are genuinely undecidable until port time (05's is
  explicitly conditional on how the single-`note` decision lands); this one is fully decided and
  nothing at port time can change it, so deferring it would borrow their reason without their cause
  — the failure recorded at the top of this ticket. It records the trade-off: 02's zero-friction
  default parent, given up to buy an orientation predicate that can fail. Cites **G1**, names no
  path.
- Any **contradiction with the ported engine**, per the map's Notes — an ADR, never a silent
  redesign. None found so far, which is itself worth stating when this resolves — with the
  `occurrence.note` question above as the one live candidate.

### What this ticket does

- Re-derive both tables from the resolved tickets. **The vocabulary table predates 06, 07, 11 and
  13 and has not been extended as they resolved** — deliberately, because a table half-brought-up-to-
  date reads as current and is the stale-survey shape this map keeps finding. Re-derive it whole.
  `principle` is one of the terms waiting there.
- Decide which terms enter `CONTEXT.md` against that file's own bar, and write them.
- Confirm each owed ADR has a moment attached, and that the moment is one someone will actually
  reach — a deferral to a step that never happens is the failure this register exists to catch.
- **Write the one ADR whose moment is this ticket**, per [13](13-goals-serve-principles.md). This is
  the single exception to "it decides nothing": it still decides nothing, but it does write once.
  `docs/adr/` is outside the standing-claim perimeter, so the write costs nothing against the cap.

## Comments

Opened by [Observability](04-observability-prescriptive.md), at the author's direction, amending
that ticket's decision 9. The post-mortem map holds a ticket on the ADR practice itself; this one is
scoped to what *this* map produced and does not revisit whether the practice exists.

Amended 2026-09-25 by [Do goals serve principles?](13-goals-serve-principles.md), at the author's
direction: this ticket is widened from register-only to **register plus one write**, and gains the
principles ADR at a moment that is here rather than at port time.

2026-09-25, from [The first shippable slice](09-the-first-slice-and-what-is-not-built.md): **no ADR
added** — a cut is not a decision against a ticket, building each cut line is what costs one. Two
inputs for the re-derivation: `revision` ships scoped to a single subject, `principle`, and the slice
cuts `goal` proper while keeping the Goals destination, which holds principles only — a name and its
contents that disagree in slice 1, worth judging against `CONTEXT.md`'s bar.

## Answer

**Fifteen terms are in `CONTEXT.md`, the principles ADR is written, and the ADR register has eight
rows, not the four this ticket opened with.** Its claim that there was no contradiction with the
ported engine was wrong: re-derived, the resolved tickets change the ported engine in four places,
and none of the four had an ADR attached.

Three collisions were settled by the author on 2026-09-25, from recommendations:
**`timed` is retired** from both of its senses; **`abandoned` is the end state of anything that
serves** (goal, principle, definition), while a metric, which serves nothing, is **`archived`**, and
11's *a definition is archived, never deleted* reads as abandoned; and **04's windowed-count ADR
moves to the ADR that builds Goals**. The author also approved the admission list below as proposed.

### The vocabulary, re-derived whole

The bar is `CONTEXT.md`'s own: in use, **and** already mistaken for something else. A term that
clears only the first goes to the document that describes the thing, not to the glossary.

| Term | From | Where it goes | The collision, if any |
|---|---|---|---|
| `definition` / `run` | 01 | **CONTEXT** | Renamed from `task` / `occurrence` |
| `routine` | 01 | **CONTEXT** | One word for a definition, a tree of runs, and the engine |
| `snooze` / `defer` | 01, 07 | **CONTEXT** | The archive used both for one thing; 07's gloss adopted |
| `goal` | 02 | **CONTEXT** | `GOALS.md`'s goals; and 13 found standing practice mistaken for goals |
| `criterion` | 02 | Arrives with the rename | Post-mortem map's ticket, not this one |
| `derived` / `declared`, `latches`, `satisfied` | 02 | The ADR that builds Goals | None: goals are cut from slice 1 and nothing has mistaken them |
| `abandoned` / `archived` | 02, 04, 07, 11, 13 | **CONTEXT** | Two words for a definition's end state, across 07 and 11 |
| *the root* | 02 | Deleted by 13 | Noted under `principle`, so an older record still reads |
| `dormant`, `stalled`, `flag`, `unserved` | 02, 05, 13 | The ADR that builds `Revise` | Distinct by design; not mistaken |
| `prerequisite` / `blocked` | 03 | **CONTEXT** | `gate`, three senses in this repo |
| `metric` / `question` / `source` | 04 | **CONTEXT** (`source` to `PRODUCT.md`) | One thing in the archive |
| `reading` | 06 | **CONTEXT**, under metric | 02's answer itself says `observation` for the same thing |
| `target` / `undecided` | 04 | The ADR that builds Goals | None |
| `revision` / `Revise` | 05, 06, 13 | **CONTEXT** | `Reflect`, and the archive's unbuilt `review` |
| `note` | 05 | **CONTEXT** | The journal and `occurrence.note`, which the archive kept apart |
| `dismiss` | 05, 07 | **CONTEXT** | **New.** A run's dismissal is reasonless and a flag's takes a dated reason: one word, two rules |
| `anchor` | 07, 14 | **CONTEXT** | **New.** The snooze preset, the step edge's `cadence_anchor`, and 14's wall-clock anchor of a recurrence |
| `Offered` | 06 | `PRODUCT.md` | 06 asked whether it is *backlog*. One thing: `Offered` is the band, the uncited backlog is what it holds, and *backlog* survives only in Not-built line 12 |
| `discharge` / `refuse` | 07 | `PRODUCT.md`, as glosses of the two swipes | None in the app |
| `commit` | 07 | `PRODUCT.md` | Same meaning as 02's *gated at commitment*, so not a collision |
| `rail` | 07 | `PRODUCT.md` | None |
| `principle` | 13 | **CONTEXT** | The Goals destination holds only principles in slice 1 |
| *unassigned* | 13 | `PRODUCT.md` | None |
| time of day / `timed` | 14 | **CONTEXT** | `timed`: has a time, and has a stopwatch. Retired |
| *silent* (the opt-out) | 14 | `PRODUCT.md` | None |

*Write the sketch*'s own last paragraph expected *"the two axes of goal satisfaction"* to reach
`CONTEXT.md`. They do not: nothing has mistaken them, and goals are not in slice 1.

### The ADR register

| ADR | From | Moment | Status |
|---|---|---|---|
| The top of the goal tree is a set of principles | 13 | This ticket | **Written**, `docs/adr/2026-09-25-principles-at-the-top-of-the-goal-tree.md` |
| `task`/`occurrence` become `definition`/`run`, citing G2 | 01 | The commit that ports the definition/occurrence split | Owed |
| `occurrence.note` moves into `note` | 05 | The same port, **only if** the note moves rather than being added | Conditional |
| The check-in's staged commit is deleted; every capture writes on entry | 07 | The commit that ports check-in questions | Owed. **Missing from this register until now**, though 09 said it was registered here |
| A time of day is the notification request: `remind` is not ported, and `USE_EXACT_ALARM` is chosen | 14 | The commit that ports notifications | Owed. Exact alarms were likewise **missing** here despite 09. **`remind` is newly added**: dropping a column from the ported schedule is an engine change |
| `ScheduleMode.AFTER_ROUTINE` is not ported | 03 | The commit that ports the schedule engine | **Newly registered.** 03 named the subtraction and attached no ADR |
| A definition is never deleted | 11, amending 01 | The commit that ports the definition repository | **Newly registered.** It removes a delete path the archive used |
| A windowed count cannot be a metric threshold | 04 | **The ADR that builds Goals** (Not-built line 1) | Moved from *after the post-mortem*, a moment nothing pointed at, by the author |

**Every port-time moment falls inside slice 1**, so all five are reachable. The risk is that nothing
at port time reads `.scratch/`. That hand-off is recorded on [Write the
sketch](10-write-the-sketch.md): the first-slice section states, as conditions of the port, what each
of those ports changes about the engine. It cites no ADR, since none exists yet, and the porter
cannot miss it.

**Not ADRs**, and why:

- **`SCALE_1_5` deleted** (11): there are zero rows, so there is nothing hard to reverse.
- **Two `SALVAGE.md` corrections**: the display-snapshot rule (11) and *four paths* that is really
  five reasons and seven call sites (07). These are edits to the owner's file, flagged for *Write the
  sketch*, which consumes `SALVAGE.md` entries.
- **The thirteen cut lines** (09): building each one is what costs an ADR.

### Found while re-deriving, outside this ticket's files

- **`just adr` never receives its arguments.** The justfile has no `set positional-arguments`, so
  `just adr new <slug>` silently falls through to listing, and a search `just adr <path>` returns
  nothing whatever it is given. The ADR above was written by hand in the scaffold's format. The
  recipe's comment says `just start` consumes the path case, but it does not: `start` greps
  `docs/adr/` itself and is unaffected. So the damage is limited to the two human-facing uses, and
  the comment is stale. Not fixed here, because the justfile is not this ticket's file.
