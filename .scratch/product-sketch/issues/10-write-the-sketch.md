# Write PRODUCT.md and both ARCHITECTURE.md sections

Type: task
Status: open
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
