# Which documented rules the history actually violated, and how soon

Type: research
Status: open

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
