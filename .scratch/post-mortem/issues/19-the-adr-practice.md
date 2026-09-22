# Whether this repo keeps an ADR practice at all, and what earns one

Type: grilling
Status: open
Blocked by: 13

## Question

Graduated from the map's fog by ticket 15, which sharpened it to the point of being ticketable:
15's citation rule presupposes a carrier. **Every ADR names the goal it serves and what that goal
ruled out** — but if this repo keeps no ADR practice, the rule has nothing to ride on, and the one
mechanism the kit's root finding produced is inert.

The evidence is unusually unhelpful here, in a way that matters:

- Ticket 04 found the old repo's 75 ADRs were **bulk-extracted from one file in two days**. The
  practice its rule described therefore never actually ran, and has not in fact been tried. There
  is no evidence that ADRs-as-practice failed; there is evidence that ADRs-as-artifact-dump did.
- Ticket 05: 106 files carrying 640 cross-references, one per 12.8 lines, ADRs averaging 23 lines.
  The corpus was not too long, it was too interconnected — and a growing ADR directory is the
  densest source of cross-references a repo has.
- Ticket 03: the ADR-adjacent rules split cleanly. *"ADR numbers are never reused"* had **zero**
  violations; *"ADR in the same commit as the code, never a follow-up"* broke in 1d 7h and left
  two decisions permanently unrecorded when the repo was killed.
- Ticket 08 decided each ADR must cite the goal it serves, and 15 decided the form of that citation.
  Both are conditional on this ticket.

Settle:

- **Does the practice exist?** If not, what records a re-made decision instead, and where does 15's
  citation rule attach then? "Nothing records it" is an available answer and must be argued against
  rather than assumed away.
- **What earns one?** Ticket 13 carries a partial answer — *"a real ADR is written here only when
  the decision is actually re-made"* — but that governs salvage, not the general case. Is "cites a
  goal and names what it ruled out" the whole bar, or is the citation a *filter* on a bar set
  elsewhere?
- **The null decision.** The map's fog patch on the null artifact bites hardest here: ticket 06
  found 18 issues arguing that no version bump was owed, seven deep in precedent, because the rule
  had no way to record a considered "nothing". Does a rejected ADR leave a trace?
- **Cross-reference density**, which is 05's actual measured defect. If ADRs exist, what stops the
  directory becoming the thing that generated the day-8 repair work? A cap, an eviction rule, a
  prohibition on ADRs citing other ADRs, or nothing.
- **Both gating tests apply**, ordered: the comprehension criterion first — does an ADR practice
  reduce the human's comprehension load, or is it an artifact-to-read that must pay for itself? —
  then ticket 03's latency test.

Deliberately **not** ordered against ticket 11. A budget set without knowing whether an ADR
directory exists will be wrong, and an ADR practice designed without a budget will be too generous;
forcing an order only decides arbitrarily which one gets to be wrong. Whichever resolves second
adjusts. This is the same treatment 09 gave 11 and 17.

## Note after ticket 17

Not a re-charter, but this ticket now has a dependant. 17's answer to the honesty problem — the
timing fingerprint, *a goal edited after the work it justifies is visible in `git log`, and an ADR
citing it must say so* — presumes ADRs exist, as does the `just goals` instrument that prints
`GOALS.md` beside the distribution of goal citations. 15's citation rule already needed a carrier;
17 has now put weight on the same carrier for a second purpose.

If this ticket decides against an ADR practice, the timing fingerprint needs a new carrier and 17's
honesty answer weakens to the un-checked residue alone. Worth stating in the answer either way.
