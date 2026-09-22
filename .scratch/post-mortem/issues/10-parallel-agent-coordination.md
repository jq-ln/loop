# How parallel agent sessions coordinate

Type: grilling
Status: open
Blocked by: 06, 09

## Question

The old model — worktree → commit → rebase → review → merge → teardown — was close to right and
produced three distinct failures. Design the protocol this repo starts with.

Work from ticket 06's mechanisms, not from the incidents. The three failures are separate problems
and may want separate answers:

- **Scope failure**: declared owned-files lists that were not accurate, so collisions surfaced at
  the merge rather than at the claim. Is the fix a better list, a coarser claim unit, a lock, or
  fewer concurrent sessions?
- **Rule failure**: versioning. Inverted pre-1.0 semver across five or six independently versioned
  things, each bumped in the same commit as its change. How much of that survives, and what is the
  simplest scheme that still tells the truth?
- **Termination failure**: review rounds caused by `main` moving under an open review rather than
  by anything found. What ends a review, what ends a *round*, and what signals a stall?

Also settle the ceiling: how many sessions may run at once, and what enforces it. The old repo used
a blocking edge to park maps (ADR 0077) — decide whether that mechanism carries over.

Consider prototyping the protocol against a replay of ticket 06's worst collision before adopting
it.
