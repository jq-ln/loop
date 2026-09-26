# Rename the project-level concept: `GOALS.md` becomes `CRITERIA.md`

Type: task
Status: resolved

## Question

Decided elsewhere, landing here. [What a goal is, and what
satisfies one](../../product-sketch/issues/02-what-a-goal-is.md) settled that the app gets the word
**goal** unqualified and the project-level concept gives it up. That map recorded the rename in its
**Out of scope** section rather than ticketing it, correctly: its destination is `PRODUCT.md` and two
`ARCHITECTURE.md` sections, and the rename is not a step on that route. But an out-of-scope line is a
record and not a queue, and this map owns how the repository is kept. So it is filed here, where
something will pick it up.

**The decision is made and is not reopened here.** The argument, in one line: the project's own items
would fail the app's admissibility rule — they are standing, they never latch, and neither names a
measurable condition — so they are not goals but the standing tests every decision must pass, and the
accurate word for a test is a criterion. `constraint` was unavailable (`ARCHITECTURE.md` opens by
claiming it) and `commitment` was half-spent by `PROCEDURE.md`. What is open is execution and four
small naming consequences.

## Why now rather than later

`docs/adr/` is empty. `GOALS.md` states that a goal's identity changes only by deletion and that the
deleting commit lists every ADR citing it. That list is empty today and never will be again: every
ADR written under the old word lengthens it. **The rename should land before the first ADR does**,
and nothing else on either map is waiting on it.

## Four costs, all keyed to the filename, all silent

Found by reading the hook rather than by reading the rename, which is why they are written down here
instead of being left for the diff to carry.

| What stops working | Where |
|---|---|
| The 40-line hard cap on the file stops firing | `.githooks/pre-commit`, the literal `'GOALS.md=40'`; the check continues past a name that is not staged |
| The isolated-commit rule stops firing | `.githooks/pre-commit`, `ALONE='GOALS.md PROCEDURE.md'`, the same shape |
| `just goals` reports "none yet" forever while looking like it worked | the recipe greps `^Goal: G[0-9]+` |
| New ADRs scaffold a citation line nothing reads | `just adr new` writes a `Goal:` line |

The second is the one that matters. That hook is the whole mechanism behind `PROCEDURE.md`'s claim
that a goal edited after the work it justifies is visible in `git log`, and it fails by going quiet
rather than by refusing anything.

## The hook cannot see the rename

Verified by staging `git mv GOALS.md CRITERIA.md` alongside an unrelated edit in a throwaway clone:
`git diff --cached --name-only --diff-filter=MRD` reports `CRITERIA.md` and the other path, and
**`GOALS.md` never appears**, because git collapses a detected rename to its destination.

Two consequences. The rename may legally share a commit with the fixes — not because the rule permits
it, but because the rule is blind to it. And from that commit onward `ALONE` guards a file that does
not exist, so **every later edit to `CRITERIA.md` is unprotected until the literal is updated**. The
hook edit is not tidying; it is what restores the protection, and there is no mechanism that will
complain if it is forgotten.

One thing that does **not** break: `governed()` matches `^([^/]+|docs/.+|\.claude/.+)\.md$`, so the
renamed file stays inside the standing-claim perimeter and the count against the cap is unchanged.

## What the work is, split at the owner boundary

Only the repository's owner edits `GOALS.md` and `PROCEDURE.md`, and each moves in a commit that
touches nothing else.

**The owner's, one isolated commit each:**

- `GOALS.md` → `CRITERIA.md`: the rename, the ids, and one line recording that `C1` was `G1` so dated
  records written under the old word still read.
- `PROCEDURE.md`: six mentions.

**An agent's, and no decisions left in them once the four below are answered:**

- `.githooks/pre-commit`: the line-cap literal and the `ALONE` list.
- `justfile`: the `goals` recipe and the `adr new` scaffold.
- `CLAUDE.md` (three mentions), `ARCHITECTURE.md` (two), `CONTEXT.md` (one, plus the new entry).

**Ordering.** The hook and justfile edits must not lag the rename, because the window between them is
unprotected and silent. Since the hook cannot see the rename, the safe sequence is the owner's
isolated rename commit first, the agent's mechanism commit immediately after, and nothing else
committed in between.

## What this ticket decides

Four small things, all naming, none of them reopening the word itself.

- **Do the ids change letter?** `G1`/`G2` → `C1`/`C2` is implied by the rename but is an identity
  change under the file's own rule, and the alternative is keeping `G` against a word that no longer
  starts with one.
- **Do non-goals become exclusions?** `N1` currently names the store-and-channel prohibition, and
  *non-goal* is built from the word being surrendered. If they become exclusions the id moves too,
  and both maps' Out-of-scope sections cite `N1` by name.
- **Does the recipe get renamed?** `just goals` → `just criteria`, and its grep to
  `^Criterion: C[0-9]+`, or the recipe keeps its old name while reading the new file.
- **Does the ADR trailer change?** `Goal:` → `Criterion:` in the `adr new` scaffold. Whatever it
  becomes, the recipe's grep and the scaffold must agree, or the instrument reads zero forever.

## What it does not touch

Committed records in `.scratch/` are not rewritten. [The work-item
model](../../product-sketch/issues/01-the-work-item-model.md) already says an ADR is written at port
time *"citing G2"*, and dated records stay as written — the rename commit is where the mapping is stated, not retroactively in the records.

`CONTEXT.md`'s entry for **criterion** belongs to this ticket, because it is repository vocabulary.
The app-side terms this decision settled belong to the product-sketch map's final write pass and are
not written here.

## Answer

**Landed, in five commits rather than three, and the ticket's central mechanical claim was half
wrong.** `CRITERIA.md` exists, its ids are `C1`, `C2` and exclusion `E1`, and the hooks guard it by
name — proven by refusal in a throwaway clone, not by the passing commits: a `CRITERIA.md` edit
staged beside `README.md` is refused as not edited alone, and a 41-line file is refused at the cap.

The four naming decisions, all as recommended: the ids change letter, because the ADR list the
file's own identity rule makes the deleting commit enumerate is empty now and never will be again;
non-goals become **exclusions**, since *non-goal* is built from the surrendered word; the recipe is
`just criteria`; the scaffold writes `Criterion:` and the grep reads `^Criterion: C[0-9]+`, shown to
agree by scaffolding a throwaway ADR, filling it and counting it. Three placements followed: the
`G1 → C1`, `N1 → E1` mapping lives in `CONTEXT.md`'s new **criterion** entry, which already states
that a renamed term keeps its former name there, rather than taking `CRITERIA.md` to 40/40; the
closed product-sketch map's `N1` is left as a record; and the owner's text was drafted to the
scratchpad and committed by the owner.

**The correction.** *"The hook cannot see the rename"* is true only of a **pure** rename, which is
what the clone test staged. The owner's first attempt renamed and rewrote the file together, which
dropped git's similarity below its threshold: the diff became a delete of `GOALS.md` plus an add of
`CRITERIA.md`, even under `-M`, and `ALONE` refused it. So the planned rename-then-mechanism order was
not merely safe but forced, and it improved: **pure rename (owner) → hooks renamed (agent) → content
(owner) → `PROCEDURE.md` (owner)**, so that no edit to the file's content ever landed unguarded. The
hook now carries that fact as a comment beside `ALONE`.

**The survey missed three things, again.** `pre-push` repeats both literals (the cap, and the
edited-alone rule as a `case` arm) with the same blindness — a fifth silent cost; `PRODUCT.md` cited
`` `GOALS.md` `` and would have been refused by the path check on its next edit; and only one map,
not both, cites `N1`. A fourth thing was confirmed rather than missed: the path and owns checks read
`--diff-filter=ACM`, so a renamed governed file escapes both on its rename commit.
