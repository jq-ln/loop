# Register the vocabulary and the ADRs this map owes

Type: task
Status: open
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
