# Which documented rules the history actually violated, and how soon

Type: research
Status: resolved

## Question

`../old_loop/CLAUDE.md` and `docs/agents/` state many hard rules. For each, find whether the
history obeys it, and if not, how long after the rule was written the first violation landed.

Rules worth checking specifically, though the list is not exhaustive — read the documents and
check what you find:

- "No work happens on `main`. A ticket gets a worktree before its first edit." Issue #102 already
  records two commits landing on main from a branch with no ticket. Find every instance.
- "Bump the version in the same commit as the change, not as a separate chore."
- "Write the ADR in the same commit as the code, never a follow-up." Issue #99 records "three
  decisions landed as prose with no ADR".
- "Every permission has an entry in `docs/PERMISSIONS.md`, written in the same change."
- "A branch is reviewed before it merges."
- The `.gitignore` / tool-output rule, which CLAUDE.md itself admits four `.kotlin/errors/*.log`
  files defeated.

The output that matters is the **latency**: rule written → rule broken. A rule broken within a day
of being written is evidence about the rule, not about discipline.

## Answer

Full findings: [research\/03-rules-written-then-broken.md](../research/03-rules-written-then-broken.md)

**The central finding of the post-mortem.** Rules written retrospectively from a live failure, attached to an artifact the commit must touch anyway, held — version bumping: zero violations across 60 bumping commits; ADR numbering: zero violations. Rules written prospectively from principle did not: "no work happens on main" broke in **15m33s**, one commit later, and was later defeated by citing its own violations (`c00993f`: "main has precedent"). ktlint shipped in the initial commit and went unchecked for 236 commits, while being ambiguous enough that its two readings differ by 4,623 of 5,493 violations. ADR-in-same-commit broke after 1d7h and two unrecorded decisions were still unrecorded at death. The `.kotlin/errors` rule has negative latency — written 5d19h after the violation, in the commit that deleted it. Two rules collided six hours apart and were adjudicated ad hoc by an agent mid-review.
