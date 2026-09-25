# Write the README

Type: grilling
Status: open

## Question

Raised by [Write the kit into this repo](20-write-the-kit.md) as a defect in its inputs, not
graduated from fog. `README.md` is counted in the day-one eight and **no ticket authors it**. Across
all nine of 20's blockers, every reference is either to the first repo's README quoted as evidence,
or to `docs/adr/README.md`, which 11 forbids. The only substantive mention is
[How ownership of a claim is expressed](21-how-ownership-is-expressed.md)'s — *"`README.md`'s opening
is a pitch to a stranger and declares nothing; it passes, and is left as a pitch"* — which exempts a
file that did not exist. The kit landed at 7 of 12 without it.

It is a grilling ticket and not a task, because the content is genuinely the human's: this is G2's
shopfront, the artifact *"legible to people who might hire me or build with me"*, and it is a pitch
for an app that does not exist yet. 20's rule was that where a ticket's answer carries no finished
text, drafting it is refused; that refusal is what produced this ticket.

- **What does it claim, when there is no app?** The first repo's README advertised two features the
  app did not have — 13 keeps that as a prohibition and 21 records the ownership row that confessed
  it in its own cell. A README written before the code is the same trap one layer earlier, and the
  post-mortem is currently the only thing this repo contains that a stranger could judge.
- **Who is the reader?** G2 names two — someone who might hire, someone who might build with. Those
  want different documents, and a README serving both may serve neither.
- **Does it carry a declaration paragraph?** 21's `pre-commit` check refuses a governed file whose
  first paragraph is empty, and 21's stated answer is that a pitch *passes* the structural check
  while declaring nothing. Confirm that reading or replace it: as the residual owner is `CLAUDE.md`,
  a README that declares nothing is the one governed file with no stated bounds.
- **Does it point at the post-mortem?** `.scratch/post-mortem/` is public, is 21 tickets and seven
  research files, and is the strongest evidence in the repo that its author can account for their
  own work. It is also 8,000 words of process writing about a dead project, which is a particular
  first impression. 13 already settled that provenance resolves there rather than to the archive.
- **What stops it rotting?** Every other governed file in the kit has either a mechanism or a
  labelled admission that it has none. A README describing a product that is being built is the
  document most likely to become false without anyone editing it, and the doc-code entry rule does
  not reach a claim about intent.

One inherited check: the kit reports its standing-claim count in the landing commit, so adding this
file takes the count from 7 to 8 against a cap of 12. That is inside headroom, so under 21 it is a
declared act rather than a fold, and no `Folded:` trailer is owed.
