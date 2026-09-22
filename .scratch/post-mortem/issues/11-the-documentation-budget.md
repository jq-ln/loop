# The budget, and what enforces it

Type: grilling
Status: open
Blocked by: 07, 09, 15

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

## Amendment after ticket 09

The re-charter above stands unchanged; 09 adds one test and one blocker.

- **The comprehension criterion, applied to this ticket's own mechanism**: a rule that adds an
  artifact to read is net-negative unless it pays for itself. The two tests are **ordered** —
  comprehension first (should this rule exist?), then 03's latency test (can it be made to hold?).
  A budget enforced by a standalone check has no artifact to attach to and fails the second test;
  finding one is this ticket's hardest half, alongside eviction.
- **Blocked by 15.** A budget is a rule, and no ticket that writes a rule resolves before the goals
  file it must be checkable against exists.
- **Rank.** 09 placed a bounded corpus third of the kit's three means, behind a stated goal and
  protected comprehension. This ticket constrains 17 but does not outrank it, and the two are
  deliberately left unordered against each other.

## Amendment after ticket 15

Two fixed inputs, neither of them re-openable here.

- **`GOALS.md` is ≤ 40 lines**, decided in 15 and confirmed against the written file. This ticket
  inherits the number rather than re-deriving it; the budget must accommodate it, not adjudicate it.
- **A worked example of the hardest half.** 15's *"`GOALS.md` is edited alone — a commit touching it
  touches nothing else"* is a constraint with a real artifact to attach to and a mechanical check
  (a diff including that path and any other fails). It is the shape this ticket has been looking
  for: not a standalone check of a quantity, but a rule riding on a commit the work must make
  anyway. Whether the corpus budget admits the same shape is this ticket's question; that it is
  possible at all is no longer speculative.

Note also that **ticket 19 is deliberately unordered against this one**, for the reason 09 gave for
11 and 17: a budget set without knowing whether an ADR directory exists will be wrong, and an ADR
practice designed without a budget will be too generous. Whichever resolves second adjusts.

## Amendment after ticket 17

Three inputs. The first two are fixed and inherited; the third is a rule 17 derived and handed to
this ticket to own outright.

- **`PROCEDURE.md` is ≤ 60 lines**, alongside `GOALS.md`'s 40. 57 lines as written and confirmed
  verbatim in 17. The budget accommodates it rather than adjudicating it. 09 called it the kit's
  load-bearing document and ruled that being load-bearing buys no exemption; the extra 20 lines over
  `GOALS.md` exist because it indexes more distinct objects, and it holds its size only because of
  the structural rule that it **never restates a mechanism living elsewhere, it points at it**.
  That rule is worth this ticket's attention generally: it is 15's one-claim-one-owner principle
  applied to a document whose subject matter is scattered across a hook, a harness setting and a
  justfile.
- **The justfile is exempt from a prose budget.** It counts as a file, but it is not prose, and it
  exists to *subtract* prose: 17's rule is that a command worth documenting is a recipe rather than
  a line of text, and that a recipe which deletes no prose when it lands has not earned its place.
  This is a budget-adjacent mechanism that clears the comprehension criterion by subtraction, and a
  stale recipe fails loudly where stale prose merely misleads. `../old_loop` spent review rounds 3–6
  of #101 enforcing a 634-column rule **no file stated**; the justfile is where that rule would have
  lived.
- **The doc-code entry rule, routed here to own**: *a document may not assert a structural fact the
  source already asserts about itself.* No document names a module type, a layer boundary, a file
  layout, or a count of anything; a document that wants to point at structure points at a path.
  Ticket 04's `:core-api` defect — three documents asserting a module type against an 8-line enum,
  undiscovered until a post-mortem inventory — requires a document to be *allowed* to make that
  claim. This kills the class rather than checking for it, passes the comprehension criterion by
  subtraction, and needs no attachment because it is an entry rule rather than an ongoing
  obligation. It belongs here because this ticket owns what may be written, and it is squarely the
  **conflict** half of this ticket's re-charter. 17 keeps only the paired reading-time noticing.

One hazard 17 recorded that bears on this ticket's framing: `code-review`'s Standards axis asks
whether the *code* violates a documented standard. Where the document is the thing that is wrong, it
reports a code violation and sends the human to change working code to match a false claim. A
corpus rule is the only available defence; review is not one.
