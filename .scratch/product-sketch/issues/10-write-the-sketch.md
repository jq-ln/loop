# Write PRODUCT.md and both ARCHITECTURE.md sections

Type: task
Status: resolved
Blocked by: 09, 12

## Question

The single late write pass. **Decide first, write once** — the post-mortem's dominant finding was
that the first repo wrote the rule at the moment of insight, 76 ADRs in eight days, each true when
written. Conclusions accumulate in the ticket answers above and become files exactly once, here.

- **`PRODUCT.md`**, chartered as **what the app does, its screens, and its input vocabulary**. Nothing
  else in the repo owns that claim. It takes the standing-claim count from 8 to 9 against a cap of 12,
  which is inside headroom, so it is a declared act and no `Folded:` trailer is owed.
- **`ARCHITECTURE.md`'s two `**Unwritten.**` sections**, overwritten in place with ticket 09's answer.
  That is the change that opens the `.kt` gate.

Constraints this file must satisfy, all mechanically checked:

- A declaration paragraph between the H1 and the first H2 stating what may be written here. `just
  owns` generates the index from exactly that paragraph, so it cannot disagree with its source.
- **No structural fact the source asserts about itself** — no module names, no layer claims, no
  counts. A document pointing at structure points at a path, in backticks, and the hook checks that
  the path resolves. `PRODUCT.md` describes an app with no source yet, so nearly every path it might
  name does not exist: prefer naming nothing.
- No home-anchored path and no personal-domain address, on every tracked path with no exclusions.
  Archive citations are redacted at the point of quoting, in the form `<user>`.
- Commits over 300 changed lines need an `Oversized:` trailer. This pass will approach that.

Two obligations beyond writing the files:

- **Consume what was spent.** `SALVAGE.md`'s keep half is the one document in the repo with a shrink
  rule: an agent deletes an entry in the commit that consumes it. Any port pointer these decisions
  cashed out is deleted here, not left standing.
- **Raise defects rather than drafting around them.** Where a ticket's answer carries no finished
  text, the gap is reported and a new ticket is filed. That refusal is what produced the README
  ticket in the post-mortem map, and it is the behaviour that ticket 20 existed to demonstrate.

`CONTEXT.md` gains an entry for every term these decisions settled that has already been mistaken for
something else — which on current evidence is at least the word for a work item and the two axes of
goal satisfaction.

## Comments

2026-09-25, from [Register the vocabulary and the ADRs this map owes](12-the-vocabulary-and-adr-register.md):
**`CONTEXT.md` is already written**, so the last paragraph above is stale. Fifteen entries went in
with that ticket, and the two axes of goal satisfaction were not among them. Two things this ticket
now carries: the **port-time ADRs**, stated in the first-slice section as what each port changes
about the ported engine, since that section is the one thing the porting session is certain to
read; and the **two `SALVAGE.md` corrections** the register lists, which are the owner's to make.

## Answer

**Written: `PRODUCT.md`, both `ARCHITECTURE.md` sections, and a one-word fix to `CONTEXT.md`. The
`.kt` gate is open.** `just owns` reports 8 of 12 standing-claim files.

### What the author settled while writing, 2026-09-25

- **`PRODUCT.md` describes the whole designed app, not only slice 1.** Asked whether goals, targets,
  prerequisites and `Revise` belonged there or in the ADR that builds each, the author's answer was
  *"we should be writing the whole plan down in `PRODUCT.md` and the first slice under the appropriate
  header in `ARCHITECTURE.md`."* That overrules the register's routing of the goal-satisfaction and
  flag vocabulary to future ADRs — for `PRODUCT.md`, not for `CONTEXT.md`, whose bar is unchanged.
  The declaration paragraph states the consequence: a part the code lacks is an absence with a line
  in *Not built*, and only a part the code does differently is a bug in `PRODUCT.md`.
- **Swiping uncited work done asks what it served, then completes it.** A defect no ticket owned:
  02 requires a citation before work *"can reach Today or be logged as done"*, and 07's table gives
  an `Offered` row swipe → Done. Both now hold: the swipe still discharges, and doing uncited work
  counts as a commitment. The same applies to logging after the fact. **Amends 02 and 07.**
- **A flag row binds tap and hold.** 07's prose says `Revise` *"binds tap alone"* and its table,
  generated from the prototype's single data structure, gives hold → menu. The table wins; the
  prose's reason was about swipes, which stay absent.

### Found while writing

- **`CONTEXT.md`'s `note` omitted a revision as a subject**, which 05 decision 11 names as the
  load-bearing half. Fixed in the same commit.
- **"A step cites nothing" was nearly written and is not decided anywhere.** 02 says every
  definition cites; 13 keeps steps on a separate many-parent edge; no ticket says whether a step,
  which is a definition, needs its own citation or inherits its routine's. `PRODUCT.md` says
  neither. It matters first at the port of the commitment gate, and is left for whoever writes it.

### What was spent

- **`SALVAGE.md`: no entry consumed.** Every *Port these* entry is consumed by its port, not by a
  document describing the product; the port-time changes are stated in the first-slice section, not
  deleted from `SALVAGE.md`. *Carry this* is used, not held elsewhere: the second-slice trigger names
  the report-back session without restating how to pull the data. **The two corrections the register
  lists are still owed and are the owner's**: the display-snapshot rule (11: a finished run keeps
  the name it was done under; a waiting run's name is back-filled) and *four code paths* (07: five
  reasons, seven call sites).
- **The port-time ADRs** are stated in the first-slice section as what each port changes, with no
  ADR cited, per 12's hand-off. 12's register lists six ported-engine changes, one conditional, and
  all six are there. `SCALE_1_5` and the untimed snooze are stated beside them as changes needing no
  ADR.
- **09's four `GOALS.md` non-goal candidates** remain named in 09 and unwritten, being the owner's.
- **Oversized**: the pass is one indivisible write, which is this map's *decide first, write once*.
