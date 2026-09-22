# The budget, and what enforces it

Type: grilling
Status: open
Blocked by: 07, 09

## Question

Decided already: this repo constrains documentation by **both** a numeric budget and a structural
rule, because structural rules alone are what the old repo had. "One owner per kind of claim" and
"overwritten, never amended" were good rules that every individual addition satisfied while the
total grew to 8,191 lines. A budget is the only constraint that fails in aggregate.

Settle:

- **The numbers.** `CLAUDE.md` ≤ 200 lines is the working figure; ticket 07 says whether it is
  guidance or folklore, and whether it generalises. What is the ceiling for the total process
  corpus, for a single reference doc, for an ADR if ADRs survive at all?
- **Per-document or aggregate, or both?** The old repo's growth was aggregate; its most-cited
  individual failure was one file.
- **What enforces it.** A check that fails the build, a pre-commit hook, a line in `CLAUDE.md`, a
  step of finishing a ticket. The old repo's style gate ran after the push (#83) and its entry
  rules were prose that nothing checked (#76) — prose alone has already been tried here and lost.
- **What happens when the budget is hit.** This is the half that decides whether the budget works:
  the answer must be "something gets cut", and *which* thing must be decidable by an agent at 2am
  without asking. A budget with no eviction rule is a suggestion.

## Amendment after tickets 05 and 07

This ticket was chartered to enforce a **length** budget. Two research tickets independently
falsified that variable, and the ticket must not be resolved on its original premise.

- **07**: the 200-line figure is published guidance but carries no measurement, and every paper
  usually cited for "length hurts" measures retrieval accuracy, not instruction adherence. The one
  study measuring adherence scales instruction *count* and finds near-ceiling compliance at the
  size a real `CLAUDE.md` occupies. Better evidenced: **dilution and conflict**.
- **05**: the old repo's ADRs averaged 23 lines. What generated the day-8 repair work was 106 files
  carrying 640 cross-references, one per 12.8 lines.
- **01**: the tracker held 107k words against the repo's 90k — permanent, un-trimmable, and outside
  any budget expressed in repository lines.
- **03**: the two rules with a perfect compliance record were attached to an artifact the commit had
  to touch anyway. A budget enforced by a standalone check has no such artifact.

So the live question is no longer "how many lines". It is **what quantity, if constrained, actually
prevents the day-8 failure** — plausibly file count, reference density, or detectable conflict
between rules — and **what artifact the constraint attaches to** so it is not one more prospective
rule of principle. The 200-line figure survives for the always-loaded file alone, cited as guidance
rather than as measurement.

The eviction rule requirement is unchanged and is now the more important half.
