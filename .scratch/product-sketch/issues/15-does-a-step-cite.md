# Does a step cite what it serves, or inherit its routine's?

Type: grilling
Status: resolved

## Question

Surfaced by [Write the sketch](10-write-the-sketch.md), which nearly wrote *"a step cites nothing"*
into `PRODUCT.md` and found no ticket had decided it.

[What a goal is](02-what-a-goal-is.md) makes every definition cite what it serves, gated at
commitment, and a step is a definition. [Do goals serve principles?](13-goals-serve-principles.md)
keeps the citation edge a single-parent tree and the step edge a many-parent DAG, where a step such as
`Sweep` belongs to two routines. So: does a step carry a citation of its own, inherit its routine's,
or may it do either? And what follows for the commitment gate when a step is added, for blocking, for
dormancy and `unserved`, and for a step shared by routines serving different things?

## Answer

**A step inherits what its routine serves, and never cites on its own.** Settled by the author,
2026-09-25, from recommendations, in two rounds. Written into `PRODUCT.md`'s *Work* and *What work
serves*.

1. **Inheritance, not citation.** Only a definition that passes the commitment gate itself sits in
   the citation tree, which stays single-parent. Adding a step in the routine editor asks nothing.
   Rejected: a required citation per step, which forces a shared `Sweep` to pick one room (the
   invented answer 13 refused), and an optional override, which gives what a step serves two sources
   of truth. A step that matters on its own terms is served by its metric, or made its own
   definition.
2. **A shared step serves each of its routines' parents**, derived on read and never stored. That is
   what dormancy's *runs beneath it* and 13's `unserved` roll-up already count.
3. **Abandoning a routine abandons the steps that belong to no other**, on the same date, and a
   retraction restores them. Shared steps carry on under their other routine. Rejected: orphans
   landing in `Offered`, which would feed backlog-dodging a routine's worth of chores at once.
4. **Removing a step from its only routine abandons it**, by the same rule. Capturing it again finds
   it through the search, and retracts rather than duplicates.
5. **A definition may be both a step and top-level**, citing for its top-level role and counting
   under both. Re-derived from the archive before writing, not assumed: its link entity says a step
   given a schedule of its own *"would also make it a routine in its own right"*, its schedule
   editor's removal leaves the definition running as a step inside its parents, and
   `CompletionCascade.isSeparatePlannedInstance` exists to tell the two firings apart. So this is the
   ported engine's behaviour, not a change to it.
6. **Prerequisites are untouched.** A step can be a predecessor; a blocked routine has no run, so its
   steps are absent with it.

**No ADR** — nothing here changes the ported engine. **No `CONTEXT.md` entry** — *step* has not been
mistaken for anything.
