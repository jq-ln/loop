# Procedure

My own working rules. `CRITERIA.md` outranks this file; `CLAUDE.md` owns how agents work; the
`justfile` owns the commands. This file says what I have committed to and where each part is
enforced. It never restates a mechanism that lives somewhere else.

Only I edit this file, and only in a commit that touches nothing else.

## The gate

Nothing merges until I have read its diff and can say what it does without opening it again.

Work I have not read does not disappear into `main`. It waits as an unmerged worktree, so the gap
is always visible. At most **three** worktrees exist at once; past that, `.githooks/pre-commit`
refuses to commit anywhere until I have read one and landed it — naming the three and how long
each has been open, so a stalled branch is visible the moment it starts costing something. My
reading speed is the project's throughput, deliberately.

**Merging is mine.** No agent performs a merge, and the harness denies it. The merge commit is my
signature that I read the diff.

## What I check that an agent cannot

- **Should this exist at all.** An agent checks a change against its ticket and never asks whether
  the ticket should have been written. Under `CRITERIA.md` that question has a form: name the
  criterion, and name what it ruled out.
- **Break the code and watch a test go red.** One test per merge. A suite written alongside the
  code it tests is green whether or not it asserts anything.

## What runs without me

`just start` opens a worktree, refuses a ticket that declares no files, and refuses at the cap.
`just check` is the local gate. `just land` shows me the diff and the diffstat, runs the review,
compares the branch against its declared file list, and merges. `just drop` removes a worktree
that will not land and releases its claim. `just criteria` prints `CRITERIA.md` beside the
criterion citations across the ADRs.

The review is an **input to my reading, not a substitute for it**. It returns no pass and no fail,
I see the diff either way, and a Standards finding that cannot cite a file and a rule is advisory.
A fix re-reviews the fix, not the branch.

A commit over **300 changed lines** is refused unless it carries an `Oversized: <reason>` trailer.
Landing outside the declared file list records the stray paths in the merge commit. Both numbers
are knobs with no evidence behind them; the overrides are the data that tunes them.

If a command is worth documenting it is a recipe, not prose, and a recipe that deletes no prose
when it lands has not earned its place.

## Resting on nothing but me

Nothing checks these, and saying so is the point: a file that mixes the two teaches me to trust
the wrong half.

- **Did I re-examine the criterion, or reword it to fit what I had already built?** A criterion
  edited after the work it justifies is visible in `git log`, and an ADR citing it has to say so.
  That removes the silence, not the temptation. Bringing a missing criterion here must stay a
  two-minute act; the day it feels like a confession is the day I start rewording.
- **If every recent ADR cites the same criterion**, the citation rule has become a stamp.
- **A document just told me something about the code.** Go look.
