# The budget, and what enforces it

Type: grilling
Status: resolved
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

## Answer

HITL session, 2026-09-22. Three rounds of grilling, eleven decisions, every recommendation put to
the user and accepted as stated; Q6 accepted with an amendment (19 has the final say on the ADR
clause) and Q9–Q11 exist only because the user asked the question the agent's own Q6 recommendation
had left unanswered: *if nothing cites an ADR, how is one found?* No new evidence gathered — 01, 03,
05 and 07 are the evidence, 15 and 17 are the fixed inputs.

The ticket was chartered to enforce a length budget, re-chartered after 05 and 07 to find a quantity
that actually prevents the day-8 failure, and it resolves on a different quantity, a different
enforcement point, and an eviction rule that denies rather than deletes.

### What is budgeted: standing-claim files, counted

**The quantity is file count.** Not length, which 07 falsified; not reference density, which is a
ratio satisfiable by writing more prose, which is backwards; not conflict, which is not a quantity
at all and is killed by an entry rule below rather than measured. File count is the only candidate
that is countable without parsing prose, that fails in aggregate, and that bounds the cross-reference
graph 05 identified as the engine — 106 files carrying 640 references, one per 12.8 lines.

**The perimeter is standing claims, not dated records.** Counted: root `*.md`, `docs/**.md`,
`.claude/**.md`. Not counted: `.scratch/` (the tracker — 01 found it holding 107k words against the
repo's 90k, permanent and un-trimmable, and a research note dated 2026-09-22 is a record of what was
true then, never wrong the way a rule is wrong); the justfile (17's exemption, inherited: it counts
as a file, is not prose, and exists to subtract prose); `docs/adr/` (conditionally — see below); and
generated files.

One clause closes the obvious dodge: **a standing rule may not live in `.scratch/`.** Without it the
perimeter becomes the eviction rule — move the document, keep the prose — and 01's finding is that
`.scratch/` is precisely where prose accumulated last time.

**The cap is 12. The kit lands with 9.** Both numbers are stated together, because 12 alone tells a
future reader nothing about how much room they were left. The day-one nine, from 15, 17, 20, 13 and
18: `GOALS.md`, `PROCEDURE.md`, `CLAUDE.md`, `README.md`, `CONTEXT.md`,
`docs/agents/issue-tracker.md`, `docs/agents/triage-labels.md`, the salvage list (13) and the
architecture sketch (18). Three slots of headroom is deliberate: enough for one genuine surprise in
the rebuild, few enough that the second new document is a decision and the third is an argument. 15
would leave six, and six is enough for the day-8 corpus to reassemble itself one locally-justified
file at a time.

**Per-document and aggregate, asymmetrically.** The aggregate file count is the enforced budget. Per
document, ceilings exist only for the always-loaded set — `GOALS.md` 40 and `PROCEDURE.md` 60, both
inherited and not re-derived here; `CLAUDE.md` 200, carried as **cited guidance and labelled as
guidance rather than measurement**, per 07. No general per-document line ceiling is set, and the
budget says why it declines to set one: inventing a number 07 has just shown to be unmeasured would
be the kit shipping folklore on the day it lands.

### What may be claimed: two entry rules

**The doc-code entry rule**, routed here by 17 and owned outright: *a document may not assert a
structural fact the source already asserts about itself.* No module type, no layer boundary, no file
layout, no count of anything; a document that wants to point at structure points at a path. It binds
every governed document, not only new ones. This kills 04's `:core-api` defect as a class — three
documents asserting a module type against an 8-line enum — rather than checking for it.

The general rule cannot be checked mechanically, but the instance that actually killed a repo can:
**every backticked path-like token in a governed document must resolve on disk**, relative to the
repo root or to the referring file's own directory. This is not a substitute for the rule; it is the
one case where the rule's violation is detectable for the cost of a grep. 17's hazard is why the
check is worth having at all: `code-review`'s Standards axis, reading a false document, reports a
*code* violation and sends the human to change working code to match the document. Review cannot
defend against a wrong document; a corpus rule can.

**A day-zero instance, found while fixing the perimeter and left unfixed here**:
`docs/agents/issue-tracker.md:10` cites `triage-labels.md`, which does not exist anywhere in this
repo. It is the only governed prose file the repo currently has, and it already carries a dead
reference. Ticket 20 must resolve it — create the file or delete the citation — before the check can
be installed.

### ADRs are leaves of the reference graph

19 is deliberately unordered against this ticket and **has the final say on everything in this
section**, including the right to kill all of it. What follows is the constraint 11 places on
whatever practice 19 designs, stated so that 19 adjusts against something rather than discovering it.

Counting ADRs against a cap of 12 would kill the practice before 19 opens it — 76 files last time,
averaging 23 lines. Exempting them outright would exempt the directory 05 named as the growth engine.
Neither is right, because what made 106 files unreadable was not their existence but that they were
**cited**: 640 cross-references, and a precedent chain 06 found running seven deep.

So: **ADRs are exempt from the file cap, conditional on being leaves.** An ADR may cite `GOALS.md`
and may cite paths — 15's citation rule already points that way, downward from ADR to goal. Nothing
cites an ADR back: no standing document, no other ADR, and no code comment. A standing document that
needs an ADR's conclusion **owns that claim itself**. Reading the kit then never requires reading an
ADR, so the directory grows without growing comprehension load — the comprehension criterion passed
by structure rather than by a count. The exemption and the condition are one clause, not two.

Two consequences follow, and both are 19's to overturn:

- **Discovery is search, and search is a recipe.** An index file (`docs/adr/README.md`) is forbidden
  by this ticket's own entry rule — a standing document whose whole content is a count of and a
  structure over other files — and it is the artifact in the old repo's shape that goes stale
  silently. `ls docs/adr/` is an index the filesystem generates and that cannot be wrong; grep covers
  the rest, and it works because `CONTEXT.md` is the glossary, so ADR titles and bodies use canonical
  terms by construction. Packaged as **`just adr <term>`**, per 17's rule that a command worth
  documenting is a recipe rather than a line of prose. Costs the budget nothing, and breaks loudly.
- **A superseded ADR is deleted, its number never reused, and the deleting commit states what
  replaced it.** Supersession is ADR→ADR by nature, and "Superseded by 0043" is a citation; leaving
  reversed ADRs in place uncited would make `just adr` return decisions that no longer hold, which is
  worse than the pathology being removed. Deletion keeps the search honest — everything it returns is
  live — and the reasoning survives in `git log`, which in a repo public from the first commit is a
  real archive. It is also the one rule class in the old repo with a perfect compliance record: 76
  ADRs, zero duplicate numbers, reversed ones deleted and their numbers left as gaps. **This is the
  clause most likely to need adjusting**: if 19 wants tombstones, the leaf rule needs a carve-out and
  19 writes it.

**The obligation to search attaches to the ADR template**, as a field paired with 15's goal citation:
*what the search returned, and why it does not decide this.* A line in `CLAUDE.md` saying "search
before deciding" is the prospective-rule-of-principle class that has already lost twice in this
repo's own evidence; `just start <ticket>` cannot help, because at ticket-start nobody yet knows the
terms. A template field rides on an artifact that must exist anyway and is checkable for presence,
not quality — ADR 0070's *"text is not checkable"* still binds. **Stated limit**: this catches
writing a new decision in ignorance of an old one. It does not catch silently contradicting an ADR
without writing one at all. That case is caught by 17's reading gate at the merge or it is not caught,
and no prospective rule reaches it.

### What it attaches to, and what happens when it is hit

**Attachment: `.githooks/pre-commit`, firing only on commits that add a governed path.** The
re-charter worried that a budget is a standalone check with nothing to attach to. That is false, and
15's worked example is why: you cannot add a document without committing it, so **the commit that
creates the file is the artifact the work must touch anyway**. The check is invisible on every other
commit, which is what keeps it from becoming background noise. `just land` is too late — by then the
document has existed for a day and been built on — and 10's declared file list attaches to a branch
rather than to the act of writing prose. The enforcement point already exists (`675f38e`) and already
holds the identity guard, the worktree cap and the commit-size cap.

**Eviction: the new document is not written.** Three shapes were available — cut the old, deny the
new, or ask the human. Asking fails the 2am test outright. Cutting the old needs a victim-selection
rule, and every mechanical one (least-recently-cited, oldest) requires bookkeeping that itself fails
the comprehension criterion. Denying the new is decidable at 2am because the decision is already
made: there is no victim to choose, and the agent's next move is determined — **find the file that
already owns that kind of claim and fold the claim into it**. It converts budget pressure into
ownership pressure, which is the direction 15's one-claim-one-owner principle already points. A cap
whose answer is "delete something valuable" teaches hoarding of slots; a cap whose answer is "this
belongs to an owner that already exists" teaches the thing the old repo never learned.

**The cap is a knob only the human turns.** An agent gets one outcome and one instruction, with no
trailer and no override string — an escape hatch an agent can type reflexively is the failure class
17 spent a section rejecting, and it is why this differs from `Oversized:`, which a human types about
their own commit. The human raises the cap by editing the number in the hook, in a commit that says
why, and **those commits are the data that tunes the number**: raised three times in the rebuild's
first month and 12 was wrong, with the log saying so.

### Both tests, applied to this ticket's own mechanisms

09 requires the ordered pair — comprehension first, then 03's latency test.

| Mechanism | Comprehension | Latency (what it rides on) |
|---|---|---|
| File-count cap of 12 | Passes: bounds the number of artifacts to read; adds none | `pre-commit`, on the commit that adds the file |
| Deny-the-new eviction | Passes: no new artifact; folds a claim into an existing owner | same check, same commit |
| Doc-code entry rule | Passes by subtraction: removes a class of claim | entry rule; nothing ongoing to attach to |
| Backticked-path check | Passes: instrument, adds nothing to read | `pre-commit`, on any governed file touched |
| ADRs as leaves | Passes: reading the kit never requires reading an ADR | the absence of citations; nothing to check |
| `just adr` | Instrument, not a rule — exempt by construction | — |
| `Prior art:` template field | Passes: a field on an artifact that must exist anyway | the ADR |
| The `CLAUDE.md` section itself | Passes only because it points at the hook rather than restating it | the always-loaded file |

The one row that would have failed is the one not written: an aggregate "is the corpus still
coherent?" check, which has no artifact and no mechanical form. It is a thing a human notices while
reading, and it belongs to 17's noticings, which are already labelled as resting on nothing.

### The text, confirmed

For `CLAUDE.md` — a section, not a file; it points at the hook rather than restating it, per 17:

```markdown
## What may be written

**Standing-claim files are capped at 12.** The perimeter is root `*.md`, `docs/**.md` and
`.claude/**.md`. Outside it: `.scratch/` (dated records), `docs/adr/`, the justfile, generated
files. The kit landed with 9. `.githooks/pre-commit` refuses the commit that would exceed the cap.
A standing rule may not live in `.scratch/`.

**When the cap is reached, the document is not written.** Find the file that already owns that kind
of claim and fold the claim into it. Do not raise the cap: only the repository's owner does that.

**No document asserts a structural fact the source asserts about itself.** No module type, no layer
boundary, no file layout, no count of anything. A document that points at structure points at a
path, in backticks, and the hook checks that the path resolves.

**ADRs are leaves.** Nothing cites an ADR — not a document, not another ADR, not a code comment. A
standing document that needs an ADR's conclusion owns that claim itself. Find one with
`just adr <term>`. A superseded ADR is deleted, its number never reused, and the commit that
deletes it says what replaced it.

`GOALS.md` is 40 lines, `PROCEDURE.md` 60, this file 200. The first two are hard. The 200 is
published guidance with no measurement behind it, and is carried as guidance.
```

For `.githooks/pre-commit`, joining the identity guard and 17's two caps:

```sh
# ---- Corpus budget (ticket 11) -------------------------------------------
# Fires only on commits that ADD a standing-claim file, so it is silent on
# every other commit. The cap is a knob: raising it is a human's edit, in a
# commit that says why, and those commits are the data that tunes it.

CAP=12

governed() {
    grep -E '^([^/]+|docs/.+|\.claude/.+)\.md$' | grep -vE '^docs/adr/' || true
}

added=$(git diff --cached --name-only --diff-filter=A | governed)

if [ -n "$added" ]; then
    n=$(git ls-files | governed | wc -l | tr -d ' ')
    if [ "$n" -gt "$CAP" ]; then
        printf '\n  Blocked: %s standing-claim files, cap is %s\n\n' "$n" "$CAP"
        printf '%s\n' "$added" | sed 's/^/    adding: /'
        cat <<MSG

  Do not raise the cap. Find the file that already owns this kind of claim
  and fold the claim into it. One claim, one owner.

  The perimeter is root *.md, docs/**.md, .claude/**.md. It excludes
  .scratch/ (dated records), docs/adr/, the justfile and generated files —
  and a standing rule may not be moved into .scratch/ to dodge this check.

MSG
        exit 1
    fi
fi

# ---- Structural claims point at paths, and paths must resolve (ticket 11) -

touched=$(git diff --cached --name-only --diff-filter=ACM | governed)
bad=''

for f in $touched; do
    dir=$(dirname "$f")
    tokens=$(git show ":$f" \
        | grep -oE '`[^` ]+`' | tr -d '`' \
        | grep -E '/|\.(md|kt|kts|json|toml|ya?ml|sh)$' \
        | grep -vE '[*?]|://' \
        | sed 's/:[0-9]*$//' | sort -u || true)
    for t in $tokens; do
        [ -e "$t" ] || [ -e "$dir/$t" ] || bad="$bad
    $f -> $t"
    done
done

if [ -n "$bad" ]; then
    printf '\n  Blocked: a document points at a path that does not exist\n%s\n' "$bad"
    cat <<MSG

  A document may not assert a structural fact the source asserts about
  itself. Where it points at structure, the path must resolve — otherwise a
  review reads the document as true and sends you to change working code.

MSG
    exit 1
fi
```

For the `justfile`:

```just
# Find ADRs mentioning a term. Nothing cites an ADR, so this is the only way in.
adr term:
    @grep -ril -- "{{term}}" docs/adr/ 2>/dev/null | sort | while read -r f; do \
        printf '%s  %s\n' "$f" "$(sed -n '1s/^# //p' "$f")"; done
```

For the ADR template, two fields, paired:

```markdown
Goal: <the goal this serves, and what that goal ruled out>          # ticket 15
Prior art: <what `just adr <term>` returned, and why it does not decide this>   # ticket 11
```

### Consequences for other tickets

- **19 owns the ADR section above and may overturn any of it.** It gains four constraints to adjust
  against: ADRs are exempt from the cap only while they are leaves; discovery is `just adr`, with an
  index file forbidden by this ticket's entry rule; supersession is deletion with the number left as
  a gap; and the template carries a `Prior art:` field beside 15's goal citation. If 19 decides
  against an ADR practice, all four die with it and nothing else in this ticket changes.
- **20 gains five artifacts and one repair.** The `CLAUDE.md` section verbatim; the two `pre-commit`
  checks verbatim, joining the identity guard and 17's caps; the `just adr` recipe; the ADR
  template's `Prior art:` field. The repair: `docs/agents/issue-tracker.md:10` cites
  `triage-labels.md`, which does not exist — create it (it is one of the nine) or delete the
  citation, before the path check can be installed. Its final pass now has a number to check against:
  **≤ 12 standing-claim files, expected 9, and the landed count is reported in the commit.**
- **13 and 18 each produce exactly one governed file** — the salvage list and the sketch. Both are
  inside the nine. If either concludes it wants two files, that is a decision against the cap and
  belongs in that ticket's answer rather than in a quiet second file.
- **16 is orthogonal but shares an enforcement point.** 16 owns what may not *enter* the repo; 11
  owns what may be *claimed* in a document. Both land in `pre-commit`, and 20 installs them together.
- **10** gains a small input: adding a governed prose file is a file-list event like any other, so a
  new standing-claim file appears in the branch's declared file list or trips 17's conformance check.
- **17 is unaffected.** `PROCEDURE.md` at 60 and the justfile exemption were inherited, not
  re-adjudicated. The aggregate-coherence check this ticket declined to invent is noted as belonging
  with 17's three clauses that rest on nothing.
