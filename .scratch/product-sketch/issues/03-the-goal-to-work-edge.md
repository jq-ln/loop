# The goal-to-work edge: decomposition, gating, and what the Tickets screen is

Type: grilling
Status: open
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
