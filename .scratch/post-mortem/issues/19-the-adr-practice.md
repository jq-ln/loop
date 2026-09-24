# Whether this repo keeps an ADR practice at all, and what earns one

Type: grilling
Status: resolved
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

## Note after ticket 13

13 resolved; this ticket is unblocked, and 13's partial answer — *a real ADR is written here only
when the decision is actually re-made* — now has a mechanism hanging off it that 19 can break.

`SALVAGE.md`'s keep half is **consumable**: an entry is deleted by the commit that consumes it, which
is either the commit that ports the code or the commit that writes the ADR re-making the decision.
That attachment is the reason the deletion is expected to happen at all, being the rule class with a
clean compliance record. **If this ticket decides against an ADR practice, half of that attachment
has no carrier** and the entries whose exit is "the decision gets re-made" need a different one, or
none — in which case `SALVAGE.md` keeps them indefinitely and its shrink rule weakens to the port
pointers alone. Worth stating in the answer either way, as 17's timing fingerprint already is.

Two smaller inputs. 13's bar for its own entries — *no ported code, no other document, and no
mechanism already holds this claim* — is 11's eviction rule applied to a second corpus, and is
available as a shape if this ticket wants a bar for what earns an ADR. And 13 kept exactly one
conclusion from the old repo's ~20 world-fact ADRs as a standalone entry, cutting the rest because
the ported code carries them; that is direct evidence for this ticket's cross-reference question,
since it means a decisions directory would have been the second copy of most of what it held.

## Answer

**The practice exists.** `docs/adr/` is kept. But almost nothing about it survives from the old
repo's version, and the reason the evidence could not settle it is worth stating first: ticket 04
established that ADRs-as-practice **never ran** there, so this ticket had no failed practice to
learn from — only a failed artifact dump. Two fresh measurements were taken against `../old_loop`
to supply what the ticket body lacked, and both are recorded here because they overturn premises
other tickets are built on.

### The two measurements

**Citation topology.** 75 numbered ADRs. **366 inbound citations** from outside `docs/adr/` — 205
from standing Markdown, **142 from Kotlin/Gradle comments**, 19 from config and hooks — reaching
**58 of the 75**. A further **61 ADR→ADR references** over 54 edges, forming a graph that is **not a
DAG**: three cycles (`0040⇄0042`, `0052⇄0053`, and a 4-node SCC over `{0045, 0055, 0065, 0069}`) and
a longest simple chain **11 deep**. Ticket 06's "precedent chain seven deep" was an undercount.
**18.7% orphan rate** — 14 of 75 cited by nothing, including 0078, the last ADR ever written.
Supersession-by-deletion had already run: 0044, 0060 and 0063 were deleted, and **`ADR 0063` is
still cited 9 times from 5 files, two of them Kotlin.** An index file existed and **its list was
exact at death** — 75 listed, 75 on disk, zero drift — while the hand-counted prose beside it said
"134 citations" against an actual 427, and the root README said 67 ADRs against 75.

**Path decay and mutability.** Only **22 of 75 ADRs cite a repo path at all**, 36 distinct paths
total. Decay rate is **0 of 36** — no path alive at citation time ever broke; all 7 broken paths
were *born* broken (5 illustrative, 2 deliberate references to already-deleted documents) — and
**0 of 57 ADR edits ever fixed a path**. This is not evidence of durability: the repo lived two
days and nothing had time to decay. Meanwhile **39 of 75 ADRs were edited after creation**, 57
modifications: **23 bulk terminology sweeps** (one commit rewrote `owner`→`author` across 17 ADRs),
**14 corrections of a claim that had become false**, 9 appended sections. "ADRs are immutable" was
never true here.

### Citation is about direction, not volume

Ticket 11's leaf rule — *nothing cites an ADR* — was right in its effect and wrong in its reason,
and as stated it prohibited the dominant observed behaviour (366 references) with nothing to catch
it, which is ticket 03's 15m33s class exactly. Restated as a property of **what is deletable**:

> An ADR may cite **upward** (`GOALS.md`) and **outward** (file paths). **Nothing may cite an ADR,
> and an ADR may not cite another ADR.**

What rots is a pointer at a deletable thing. `GOALS.md` ids are never reused and 15 already forces
the deleting commit to list every citer; ADR numbers are deleted by design. The old repo proves
both halves — 9 dangling references to 0063, and zero goal citations because no goals file existed.

This matters beyond tidiness: the kit's one mechanism from its root finding (15's citation rule)
**is itself a citation**, and a blanket hostility to references would have forced the kit to except
its own centre. Direction dissolves that.

**The prohibition is enforced, not asserted.** `pre-commit` greps `ADR ?[0-9]{4}` outside
`docs/adr/` and refuses. This is exact — 426 of the old repo's 427 citation tokens used that single
form — attached to the commit that introduces the citation, and therefore in 03's clean-record
class alongside ADR numbering, the one rule that never broke. **Limit stated plainly:** it catches
the *form*, not the act. A citation phrased as a bare title ("as decided in *Core measures; plugins
judge*") passes it, and the forensic sweep could not see those either.

**Code comments state the claim, not the pointer.** Ticket 11's principle for documents — *a
standing document needing an ADR's conclusion owns that claim itself* — extends to code. Not
`// counter-intuitive, but see ADR 0043` but `// plugins own their own permissions; deliberate`.
The reader gets the *what* inline where they need it and loses only the *why*, which is what the
ADR is for. It is also strictly better against deletion: a comment stating a claim survives its
ADR being superseded, where a pointer becomes a lie. This disposes of 142 of the 366.

### The bar, and the filter

Citation cannot be the bar, because it tests whether a decision is goal-serving, not whether it is
worth recording. Two gates, both must hold:

- **Bar — irrecoverability.** An ADR is written when a future reader cannot recover the decision
  from the code and documents that exist. This is ticket 13's own bar (*no ported code, no other
  document, no mechanism already holds this claim*) on its **third** corpus, after 11 applied it to
  standing files and 13 to salvage entries. One concept, used three times, rather than a third
  bespoke test.
- **Filter — 15's citation.** It names the goal it serves *and what that goal ruled out*.

The domain-modeling skill's three tests (hard to reverse, surprising without context, a real
trade-off) were considered and rejected as the bar: "surprising without context" is a judgement
with no artifact to check it against, where irrecoverability is answerable by grepping the repo you
are sitting in. 13's *"a real ADR is written here only when the decision is actually re-made"*
governs salvage and is a consequence of the bar, not the general case.

### The null decision splits in two

The map's fog patch on the null artifact asked whether a rejected ADR leaves a trace. The question
conflates two things:

- **A decision to *not* do something** — "we considered X and rejected it" — is an **ordinary ADR**.
  It fits the citation rule better than most, since naming what the goal ruled out is its whole
  content. No special case.
- **A decision judged not to earn an ADR** is the true null, and it leaves **no trace**. Ticket 06's
  failure (18 issues arguing no bump was owed) came from a rule that *demanded* something and had no
  way to say "considered, nothing owed". The bar demands nothing: not writing an ADR is the default
  and silence is unremarkable, so there is no rule to be excepted from.

**This supplies the distinguishing test the fog patch was missing**, and it is the fourth worked
instance of the shape rather than a fifth mechanism: *a null record is owed where a rule demands an
act and the considered answer is "none"; it is not owed where the default is already silence.*
Ticket 10's instrument applies to the residue — if you repeatedly want to record a non-ADR, that
frequency is evidence the bar is mis-sized.

### Discovery is two mechanisms and a corpus size

The retrospective case ("why is *this file* like this?") and the prospective case ("has this already
been decided?") are different problems, and 11's `just adr <term>` is the weak form of both: it
finds an ADR only if you can already guess the word it used, against titles that are full sentences.

- **Prospective, by recognition.** `just adr` with no arguments prints the corpus. **A generated
  index is not a document** — it walks `docs/adr/` and cannot go stale because it *is* the
  directory, it is not a file, so 11's entry rule does not reach it and it costs nothing against
  the cap of 12. **11's ban on an index *file* stands, but its stated reason was wrong**: the old
  repo's index list was exact at death; what rotted was the counts in prose beside it. It prints
  **the heading line, with the date and path** — not the filename slug, which is too lossy for a
  recognition decision.
- **Prospective, automatic.** `just start` already refuses to open a worktree without a `## Files`
  block (ticket 10), so **it already holds the exact input the lookup needs**. It greps `docs/adr/`
  for every declared path and prints any ADR citing one — not a gate, just output while the
  worktree opens. This is 17's principle applied (*where a commitment can become a step in a
  command already run, it stops being a commitment*), and it is why **11's `Prior art:` field is
  cut**: the field's job was catching decisions made in ignorance of an old ADR, and this does that
  job automatically, at a better moment, without a field anyone in a hurry can fill with "none
  found".
- **Retrospective.** The same command takes an argument, tried as a path first, falling back to a
  text grep.

**The real constraint is corpus size, not tooling.** No search helps when you don't know the
vocabulary; only recognition does, and recognition needs a skimmable list. Thirty ADRs you can
skim, three hundred you cannot — and that is the number at which the practice fails regardless of
what command ships. **The length of `just adr`'s output is therefore the instrument that says the
bar is mis-sized**, the same shape as 10's frequency test. This is also why the heading line must
name the **decision**, not the topic: *"Plugins own their own permissions"*, not *"Plugin
permissions"*. The old repo's titles were already this shape. Presence is mechanically checkable;
quality is not, and ADR 0070's *"Text is not checkable"* binds here as it does on 15's citation.

### An ADR is a dated record, not a standing claim

The collision: 11 requires **backticked paths must resolve** and **no document asserts a structural
fact the source asserts about itself**, while supersession-by-deletion implies ADRs are never
edited. Both cannot hold — rename a file and every ADR citing it carries a dead path, and fixing it
means editing a document you are not supposed to touch.

Resolved on principle, because the measurement cannot settle it (a two-day repo cannot decay):

> An ADR records **a decision made on a date, against the world as it was**. It is written in the
> past tense, carries its date in its filename (ticket 10), and is **never edited**. It is therefore
> **exempt from both of 11's content checks.**

Those checks govern standing documents that claim things about the present. An ADR claims something
about a Tuesday, and the date is what tells the reader to discount it. This retroactively converts
**14 of the old repo's 57 edits** — corrections of claims that had become false, like ADR 0030
listing the ear trainer's reset among irreversible acts — into work that should not have happened:
editing history to protect a claim the document was never making.

**Terminology sweeps do not touch ADRs.** This was **40% of all ADR maintenance** in the old repo
(23 of 57 modifications; one commit touched 17 files, and ADR 0043 was even renamed) for zero
decisions recorded. The cost is accepted knowingly: a reader opening a 2027 ADR may find it saying
`module` where the code says `plugin`, with only the date to explain why. Momentary confusion at an
old word is cheap and self-correcting; a silently rewritten record of what past-you decided is
neither. Where it needs softening, **`CONTEXT.md` notes a renamed term's former name** — one line in
the glossary that already owns terminology, costing the ADR corpus nothing.

**Supersession stays deletion, and needs no tombstone carve-out.** 11 flagged the carve-out as its
clause most likely to need adjusting; it is **refused as unnecessary**, because nothing cites an ADR
and deletion therefore dangles nothing. The dangling-0063 problem exists *only* because things cited
ADRs. Immutability also makes deletion coherent for the first time: you delete an ADR precisely
because you cannot edit one.

### The template

Three fields, replacing 11's set:

1. **The goal citation** (15) — the goal served *and what it ruled out* — with **17's timing
   fingerprint folded in as a condition on this field**, not as a fourth heading: if the goal was
   edited after the work it justifies, the citation says so.
2. **`Affected paths:`** — **mandatory**, and may be genuinely empty. Without it the `just start`
   lookup covers 29% of the corpus and is theatre; with it, coverage is 100% by construction,
   because the field is filled when the author has the paths in front of them. The old repo's 29%
   is not evidence that ADRs lack paths, only that nothing ever asked. It replaces `Prior art:` at
   no net cost, and the two are not equivalent: **`Affected paths:` feeds a command, `Prior art:`
   fed a good intention.** A field with a mechanical consumer gets noticed when it is wrong; a
   field only a future human might read rots unobserved — the `134 citations` failure in miniature.
3. **A descriptive heading line**, naming the decision.

Plus a **hard line cap** on the ADR body (the old repo's averaged 23 lines, so ~20 is not austere).
The cap, not the field list, is what stops accretion — three fields and a `grep` before you may
write the body is an ADR that does not get written, and the practice then dies *quietly*, by
non-use, which is strictly worse than deciding against it here, because every mechanism riding it
would still be documented as live.

**Derived, not separately decided:** the template is not a standing file. A template file at
`docs/adr/TEMPLATE.md` would sit inside the exempt directory while not being an ADR, which the
exemption was not written for. It is the headings an ADR carries, indexed from `PROCEDURE.md` and
scaffolded by `just adr new <slug>` — the justfile being outside 11's perimeter. Flagged for
ticket 20 in case it wants to rule otherwise.

### What this does to ticket 11's four constraints

19 held the final say and used it on all four.

| 11's clause | Outcome |
|---|---|
| Exemption conditional on ADRs being leaves | **Rewritten** as the direction rule; exemption stands, now enforced in `pre-commit` |
| Discovery is `just adr <term>`; index file forbidden | **Widened** — no-arg generated index, path-first lookup, plus automatic surfacing in `just start`. Index *file* ban stands, **reason corrected** |
| Supersession is deletion; tombstone carve-out may be needed | **Stands; carve-out refused as unnecessary** |
| Template carries `Prior art:` | **Cut**, replaced by `Affected paths:` |

Two of 11's general rules are also now **inapplicable to ADRs**: paths must resolve, and no
structural facts. Nothing else in 11 changes; the cap of 12 and the perimeter are untouched.

### The three dependants

The ticket required these be stated either way. **All three have their carrier and are live:**

- **15's citation rule** rides the ADR template. The kit's root finding keeps its one mechanism, and
  `GOALS.md` is not a poster on the wall.
- **17's timing fingerprint** rides the same field rather than a new one, and `just goals` keeps the
  citation distribution it prints.
- **13's consumable `SALVAGE.md` keep half** keeps both exits: the commit that ports the code, and
  the commit that writes the ADR re-making the decision. Its shrink rule does not weaken.

### Limits

- The citation ban catches form, not act; a title-only reference passes.
- Heading quality, citation quality and `Affected paths:` completeness are all unchecked. Presence
  is all that is mechanical.
- The zero decay rate rests on a two-day repo and is worth nothing; immutability is chosen on
  principle and may prove wrong in a repo that lives a year.
- `just start`'s lookup covers overlap, not greenfield: a genuinely new file is cited by no ADR, and
  the reader falls back to skimming `just adr`.
- Corpus skimmability is a habit backed by an instrument, not a mechanism. If `just adr` stops being
  skimmable, the bar was wrong.
