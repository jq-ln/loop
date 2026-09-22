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

## Amendment after ticket 17

Two fixed inputs. Both are consequences of 17's attachment decision — **the merge is the human's
gesture, and no agent performs one** — and neither is re-openable here; the mechanisms remain this
ticket's to design.

- **The declared file list must be machine-readable.** 17's comprehension gate diffs a branch's
  touched paths against the list at `just land` and stops on an undeclared path, so the list is no
  longer only a collision-avoidance device between concurrent sessions — it is a consumed artifact
  with a second reader. Ticket 06 measured its value already: zero file-level violations wherever a
  declared list existed, and it existed in only 10 of 41 tickets. Whatever shape this ticket gives
  it, `just land` must be able to parse it without a human in the loop.
- **The version decision is taken last, at merge time, inside `just land`.** Raised by the user
  while resolving 17 and routed here. A worktree cannot collide over a number it never touches, so
  the branch never sets a version; the human sets it at the moment of landing, which also makes the
  *order* in which tickets land the human's gate. 06 found eight live counters under three
  incompatible regimes, with the dominant cost adjudication rather than error — 18 issues spending
  a paragraph arguing no bump was owed, via a precedent chain seven deep. This ticket owns which
  counters exist and what `just land` actually does to them.

Note also that 17 closed this map's fog patch on **what the review actually reads**: the reviewed
artifact is the diff of declared files, and commit prose is not reviewed. That was filed as adjacent
to this ticket and is now decided.
