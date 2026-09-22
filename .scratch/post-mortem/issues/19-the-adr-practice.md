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

## Amendment after ticket 11

11 resolved without 19, as the map allowed, and placed four constraints on whatever practice this
ticket designs. **19 has the final say on all four** and may overturn any of them; they are written
down so this ticket adjusts against something stated rather than rediscovering it.

The premise underneath them: what made the old repo's 106 files unreadable was not that they existed
but that they were **cited** — 640 cross-references, a precedent chain seven deep (06). So 11's
budget exempts `docs/adr/` from its file cap **conditional on ADRs being leaves of the reference
graph**: an ADR cites `GOALS.md` and cites paths, and nothing cites an ADR back — no standing
document, no other ADR, no code comment. A standing document needing an ADR's conclusion owns that
claim itself. Reading the kit then never requires reading an ADR, which is how the directory grows
without growing comprehension load.

- **The exemption and the condition are one clause.** An ADR practice that is cited is a practice
  inside the cap of 12, which kills it; that is the trade this ticket is choosing between.
- **Discovery is `just adr <term>`**, a grep over `docs/adr/` plus the filename slugs. An index file
  is forbidden by 11's entry rule — a standing document whose whole content is a count of and a
  structure over other files — and it is the artifact that goes stale silently.
- **Supersession is deletion**, the number never reused, the deleting commit saying what replaced it.
  "Superseded by 0043" is a citation, so a tombstone needs a carve-out from the leaf rule. 11 flagged
  this as the clause most likely to need adjusting, and if this ticket wants tombstones it writes the
  carve-out.
- **The template carries `Prior art:`** — what the search returned and why it does not decide this —
  beside 15's goal citation. 11 states the limit plainly: it catches deciding in ignorance of an old
  ADR, and does not catch silently contradicting one without writing anything.

If this ticket decides against an ADR practice, all four die with it and nothing else in 11 changes.
