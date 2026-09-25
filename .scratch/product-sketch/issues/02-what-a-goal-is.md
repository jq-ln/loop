# What a goal is, and what satisfies one

Type: grilling
Status: claimed

## Question

The first repo had **no goal entity at all** — no target, no threshold, nothing satisfied by a
measured value. `ROADMAP.md` recorded the deferral explicitly: *"Goals as first-class entities. For
now a root routine* is *the goal."* But the measurement layer reserved space for the feature and
never used it: `MetricDef` carries `goalable: Boolean`, commented *"whether a goal may target this
metric; not everything worth recording is worth chasing"*, beside a `Direction` enum of
`HIGHER_BETTER / LOWER_BETTER / NEUTRAL`, commented *"which way is better, for goals and for review"*.
Two dead fields waiting for this ticket.

This is the concept with the strongest claim under `SALVAGE.md`'s two-claims test, and the one whose
vocabulary will be mistaken for something else fastest.

- **Three satisfaction conditions, or more?** Candidates surfaced while charting: **completion** (the
  decomposition finishes), **threshold** (a measured value crosses a line), and **attested event**
  (an external fact is declared to have happened). The worked example matters: *pass the German C1
  exam* is attested, not completion — every prep child can complete and the exam still be failed, so
  "all children done, goal unsatisfied" must be a legal and visible state rather than a bug.
- **Terminal or standing, as a second and orthogonal axis.** *Reach 140 lbs* and *stay under 140 lbs*
  are the same measurement with different semantics: one closes, the other can only be held and can be
  lost again. A standing goal has no done state. The first repo's routines were standing goals that
  were never named as such, which is worth checking before the axis is adopted.
- **The admissibility rule, and whether it has teeth.** The human's own constraint is that a goal must
  be measurable in some capacity or there is no way to gauge completion. Stated as a mechanism: **a
  goal is admissible only if it names its satisfaction condition**, and the app refuses one that
  cannot. That is the direct analogue of `GOALS.md`'s *citable only if it can rule a decision out*,
  and it is what would make this a concept with an engine rather than a label. Does it survive contact
  with a real goal the human would actually file?
- **The ultimate goal.** The human wants a root that every lower goal services. Is that a real edge in
  the model — a single root every goal must reach — or a convention? If it is enforced, a goal that
  cannot trace a path to the root is refusable, which is the same teeth one level up. If it is not,
  say so, because an unenforced root is a decoration.
- **Does a goal rule work out?** `GOALS.md` earns its authority by rejecting things. The app analogue
  is a work item that cites no goal being visibly suspect. That is either the best feature in the
  sketch or a nag that makes the app unpleasant to live with, and G1 rules out anything the author
  would have to be talked into using.
