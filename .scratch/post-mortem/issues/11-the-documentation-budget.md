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
