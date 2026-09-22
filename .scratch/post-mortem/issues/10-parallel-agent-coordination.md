# How parallel agent sessions coordinate

Type: grilling
Status: open
Blocked by: 06, 09, 15

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

## Amendment after ticket 09

Blocked by 15 as well. 09's principle is that no ticket which writes a rule resolves before the goals
file those rules get checked against exists, and a coordination protocol is a rule — three of them,
on the ticket's own reading. It was not in the list 09 settled and is added here deliberately rather
than by inference.

The ordered tests apply. The comprehension criterion bites hardest on the **scope failure**: an
accurate owned-files list is an artifact someone has to read and maintain, so a coarser claim unit or
fewer concurrent sessions may beat a better list on this test alone. 03's latency test bites hardest
on the **versioning** rule, which in the old repo stood over the work rather than attaching to it.
