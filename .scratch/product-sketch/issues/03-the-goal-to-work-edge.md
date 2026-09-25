# The goal-to-work edge: decomposition, gating, and what the Tickets screen is

Type: grilling
Status: resolved
Blocked by: 01, 02

## Question

The human reached for the issue-tracker analogy hardest here and could not articulate it as a
category: *"if I were to set a goal like 'Pass the German C1 exam' those are technically deliverables
but they require a decomposition into manageable pieces that are gated by one another."* The charting
hypothesis is that **Tickets is not a concept but a screen** — the workspace where a goal becomes
gated work — as distinct from Today, which is the execution surface. This ticket confirms or kills
that.

- **Is the decomposition a new structure, or the existing DAG?** The first repo's definition graph is
  already a DAG with many parents allowed, guarded by a SQL recursive CTE, and its cascade already
  rolls a parent up when every non-optional child is done. If a goal's decomposition is that graph
  with a goal at the root, almost nothing is built. If it is a separate graph, say what the second one
  buys.
- **Gating is the one process mechanic imported on evidence.** "This cannot start until that is done"
  is a real fact about life work and the old engine has no representation for it — `after_task_id`
  chains schedules, not readiness. Is blocking an edge between work items, between goals, or both?
  What does a blocked item look like when it is not yet actionable — hidden, dimmed, or absent?
- **What does the screen actually show?** Candidates: one goal and its tree; every unblocked item
  across all goals; everything outstanding. The frontier reading is the one the analogy points at, and
  it is also the one that answers *what should I do next* without being Today.
- **Where does an undecomposed goal live?** A goal filed with no children yet is the most common state
  and the one that rots. Does the app surface it as owing work, and is that the same mechanism as a
  work item citing no goal?
- **Does decomposition ever complete?** Ticket 02 separates preparation from satisfaction. A goal can
  always gain another child, so "fully decomposed" may not be a state the app can know — which makes
  any progress bar over children a lie worth refusing before it is drawn.

## Answer

**Tickets is neither a concept nor a screen: it is the goal detail view.** The charting hypothesis
was that it is a screen rather than a concept, and the truer answer demotes it one step further —
you reach it by opening a goal, and the word does not survive into `PRODUCT.md`. What survives the
analogy is **one mechanic**, and it is the only part that arrives with an engine.

### The word is `prerequisite`, not `gate`

Settled first because every paragraph below depends on it. `gate` already carries three meanings in
this repo — `PROCEDURE.md`'s merge-and-reading gate, the `.kt` commit gate this map exists to open,
and *What a goal is*'s own "gated at commitment" for the citation requirement. A fourth sense, inside
the app, is the exact failure `CONTEXT.md` exists to prevent, and the developer analogy is where it
would have come from.

So: a **prerequisite** is the edge, **blocked** is the derived state it produces, and `gate` stays a
word about this repository rather than about the app. `prerequisite` appears nowhere in the tree today.

### Gating passes the two-claims test; Tickets fails it

`SALVAGE.md` refuses a new top-level concept that cannot separately evidence a stage nothing else
covers **and** an engine.

- **Prerequisite** names *readiness*, which no existing mechanism represents, and arrives with an
  engine: a predicate, an inheritance rule, a cycle guard and a reversal.
- **Tickets** names the stage where a goal becomes gated work — and the goal already owns that stage.
  One claim, not two. It is refused.

### Two structures, three edge kinds

The decomposition is **not** the existing definition DAG. Two reasons, both from re-derivation rather
than from the ticket's premise.

`task_link` carries `position`, `context_label`, `optional`, `cadence_rule` and `cadence_anchor` —
five fields that are routine-step semantics. A goal's child has no position in a routine and no
cadence, so unifying hangs five meaningless columns on every decomposition edge.

The second reason is a contradiction rather than a cost. If a goal's decomposition were the definition
graph, `CompletionCascade`'s step 4 would fire on goals, **writing `ROLLED_UP` or `DISMISSED` onto a
goal** — and *What a goal is* settled that satisfaction is derived, computed on read, never stored.
Both cannot hold. The cascade stays entirely inside the run layer and never reaches a goal.

| Edge | Between | Shape |
|---|---|---|
| Citation / decomposition | definition → goal, goal → goal | Tree, single parent, defaults to the root |
| Step | definition → definition | DAG, many parents, ported unchanged |
| Prerequisite | any node → any node | DAG, independent of the other two |

**The decomposition edge is the citation edge read backwards.** "The goal's children" *is* "the
definitions and sub-goals citing it" — one edge, two readings, no second structure. This is why almost
nothing is built: the tree already exists as a consequence of 02's citation rule.

### The prerequisite, and what it replaces

**A prerequisite replaces a schedule; the two never coexist.** A definition is clock-driven or
dependency-driven. Letting both apply would materialize a run each day for work that cannot be
started, and *The work-item model* settled that a schedule fires whether or not the last run was
done — so every such day records a skip for being un-startable. The live database says why that is
not a theoretical cost: all 56 `SKIPPED` rows are already machine skips, 40 `SUPERSEDED` and 16
`SCHEDULE_CHANGED`, and it records no user skip at all. A third machine reason would make the log
worse in the same direction it is already broken.

This tells us what `ScheduleMode.AFTER_ROUTINE` was: **the right shape attached to the wrong entity.**
`NextDueCalculator` returns `null` for it, commented *"The clock never makes it due"* — which is
precisely a prerequisite. Lifted out of `schedule` into its own edge, the mode dies. It has **zero
rows** in the live database, so the subtraction costs nothing.

Because materialization is suppressed, the ticket's "hidden, dimmed, or absent?" resolves to
**absent**. There is no run, so there is nothing for Today to show.

**Endpoints are any node, and the prerequisite graph is independent of the citation tree.** Readiness
and purpose are orthogonal: *book the exam* is admin filed under another goal and still genuinely
blocks prep work, and a prerequisite confined to one subtree would force work to be filed under
whatever unblocks it rather than what it serves. Blocking **inherits down the citation tree** — a node
is blocked if it or any ancestor has an unopened prerequisite. Cycles are refused by the same
`WITH RECURSIVE ancestors` guard `TaskLinkDao.isAncestorOrSelf` already uses; that pattern ports
directly to the new graph.

**Multiple predecessors, AND only.** OR is expressible by an intermediate node, and offering both
turns a trivial all-of test into a boolean grammar with an editor and a way to be wrong. Identical
reasoning to `cadence_rule`'s refusal of RRULE: a small closed set beats a general language that
cannot be explained.

### What opens a prerequisite, and what closes it again

It reads the predecessor's **satisfaction predicate**, extended to a definition node as **has at least
one completed run that still stands**. That is not a new mechanism; it is 02's derived
definition-graph family evaluated at a leaf.

*Still stands* is load-bearing. Undo is exact in the ported cascade, so **a prerequisite re-closes
when its predecessor's completion is reversed**, and everything downstream becomes unactionable again.
A stored "unlocked" flag would get this wrong, which is `SALVAGE.md`'s storage rule arriving at the
same answer from the other side.

**Abandonment opens nothing.** *What a goal is* made abandoned a state beside satisfied, and abandoned
is simply not satisfied — no exception is carved, because the app cannot tell whether abandoning a
predecessor makes downstream work moot. Abandoning *book the exam through the agency* does not make
*study* moot, and guessing is wrong half the time. One case **is** checkable at creation and is
refused there: **a prerequisite naming the root**, which can never be satisfied, so the edge is dead
on arrival and the app says so immediately.

### Dormancy is measured over actionable time

An amendment to a rule owned by *What a goal is*, which could not have seen this: gating did not exist
when it resolved.

02's dormancy prompt is *no evidence in N days*. A node correctly waiting on a prerequisite produces
no runs, so the prompt fires and proposes culling work whose only fault is waiting exactly as
designed — the same false positive 02 already caught once with the sobriety goal, reached by a
different road.

**Dormancy counts only time a node was actionable.** Blocked time does not count. That makes the
prompt mean *you could have done this and did not* in every family, which is the only reading that
supports a culling decision. It also gives abandonment its safety net for free: work stranded behind
an abandoned predecessor is never actionable, so it never reads as dormant, and instead sits visibly
un-startable on the goal detail view where the human can abandon it deliberately.

The session working *Observability* reports the same shape one layer up, from a corrected finding of
its own: a threshold goal's evidence is observations on its metric, and a week away from the scale
produces none, so travel reads as dormancy. That is a third cause of a gap beside the engine's and
the user's refusal — **the measurement was not possible** — and it is recorded in neither log. The
metric side is 04's; this rule is the one it cites.

### No progress bar, ever

A goal can always gain another child, so *fully decomposed* is not a state the app can know. A
**count** of known children is a fact and is fine. A **percentage** is a claim about the goal's
completeness that nothing supports, and it is refused before it is drawn rather than left to taste —
which makes it a line in *what is not built* rather than an omission.

### Inherited, not re-decided

Two of the ticket's bullets were already answered by *What a goal is* and are recorded here only so a
reader does not think they were missed. **Where an undecomposed goal lives**: its root-adjacency and
dormancy prompts, the declared family's evidence being its subtree's, so an empty subtree is
unserviced by definition. **Whether that is the same mechanism as uncited work**: no — uncited work is
a place, a backlog you pull from; an undecomposed goal is a prompt. Different mechanisms, both named
in 02.

### Consequences this answer spends

- **The schedule engine ports minus one mode.** `SALVAGE.md` marks it *port these, and read them
  before changing them*, so the subtraction is named here rather than discovered at port time.
- **`prerequisite` and `blocked` owe a `CONTEXT.md` entry** — `gate` is the collision that earns it
  under that file's own rule. **Nothing on this map owns that write.** *Write the sketch* is chartered
  for `PRODUCT.md` and the two `ARCHITECTURE.md` sections and names no third file, so this is a real
  gap in the execution plan rather than a task with a home.
