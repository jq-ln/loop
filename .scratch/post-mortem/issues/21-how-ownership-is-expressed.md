# How ownership of a claim is expressed, and where it lives

Type: grilling
Status: resolved

## Question

Graduated from the map's fog by ticket 11, which sharpened it by depending on it. 11's eviction rule
is *"when the cap is reached the document is not written — find the file that already owns that kind
of claim and fold the claim into it"*, and that instruction is only executable if an agent at 2am can
**tell which file that is**. No ticket owns the mechanism that makes it tellable. Ticket 20 wires two
rows into an ownership table nobody has designed, and ticket 04 found the old repo's table asserting
three things the code contradicted.

The fog patch this graduates from had been accumulating since 04, sharpened by 08 (the table's one
structural omission — no row for the project's goals — is the omission that killed the repo), by 15
(a row for `GOALS.md`, which outranks the table) and by 17 (a row for `PROCEDURE.md`). What was
missing until 11 was a reason it had to be decided rather than described: now a rule executes against
it.

Settle:

- **Is the ownership table a document at all?** It is a section of `CLAUDE.md` today, which costs the
  budget nothing. But 11's entry rule forbids a document from asserting a structural fact the source
  asserts about itself, and a table of file paths is at the boundary: naming a path is explicitly
  allowed, naming *what kind of claim* a file may carry is a taxonomy the source cannot assert about
  itself. Which half of the table is which?
- **What is a "kind of claim"?** The unit the table assigns. 15 has already decided one instance
  (`GOALS.md` owns ends, and explicitly not definitions, not what gets built next, not how the work
  is done) and 17 another (`PROCEDURE.md` indexes mechanisms, never restates them). Whether those
  generalise into a vocabulary, or are just two files each stating their own non-ownership, is the
  question. The second shape has no table at all, and is a serious candidate.
- **Why the old table was wrong, and whether this shape repeats it.** 04's finding is the warning:
  the table asserted a `:core-api` module type against an 8-line enum, and nothing noticed for eight
  days. If the fix is "the table only names paths", say so; if it is "no table, each file declares
  its own bounds", say that instead — and note that the second distributes the claim to the file it
  is about, which is 15's one-claim-one-owner principle applied to ownership itself.
- **The 2am test, which is this ticket's exit condition.** An agent has a claim to record, the cap is
  reached, and it must decide where the claim goes without asking. Walk that scenario against
  whatever is decided here, with a claim that does *not* obviously belong anywhere — that is the case
  the old repo failed.
- **What happens when no file owns it.** The eviction rule assumes an owner always exists. 15's
  escape hatch for goals is the precedent: *if a decision is right and no goal covers it, that is a
  fact about this file — bring it here.* The equivalent here is the one legitimate reason to spend a
  slot, and without it the cap silently converts "unowned claim" into "claim discarded".

Both of 09's tests apply, in order: comprehension first — a table is an artifact to read, and it pays
for itself only if it prevents more reading than it costs — then 03's latency test, which the old
table failed outright, being prose that nothing checked.

Blocks 20, which cannot wire rows into a table whose shape is undecided. Not blocked by anything: 11,
15 and 17 are resolved and supply its inputs.

## Note after ticket 13

An input to the ownership table, not a decision made on this ticket's behalf. `SALVAGE.md`'s
ownership is **asymmetric**, which is the first row that cannot be a single name: an agent deletes an
entry in the commit that consumes it — the port, or the ADR re-making the decision — while **adding**
an entry is the human's. The asymmetry is the rule rather than an exception to it: addition is the
direction the file exists to resist, deletion the direction it exists to encourage, and it is the
only document in the kit expected to shrink.

Worth knowing when the table's form is settled: `GOALS.md` is human-only in a commit touching nothing
else, and if the table's column is a single owner per file, this row does not fit in it.

## Note after ticket 19

A second input to the table, and a **third row shape** — which is now enough of a pattern to be this
ticket's problem rather than a series of exceptions.

`docs/adr/` is **write-once, delete-only**. An ADR is created by the commit that makes the decision
(an agent's, ordinarily), is **never edited by anyone** — 19 made immutability the thing that keeps
an ADR a dated record rather than a standing claim — and is deleted only by the commit that
supersedes it. Terminology sweeps that touch every other Markdown file in the repo must *skip* it.

So the table now has three shapes that a single-owner column cannot express:

| file | shape |
|---|---|
| `GOALS.md` | human-only, in a commit touching nothing else (15) |
| `SALVAGE.md` | asymmetric — human adds, agent deletes (13) |
| `docs/adr/**` | write-once; no editor at all; deletion tied to supersession (19) |

The third is the one that breaks an owner column hardest, because its answer to "who may change
this?" is **nobody** — and a table that cannot say "nobody" will quietly be read as "anyone with a
reason". 19 also puts a *negative* obligation in play that no row currently carries: a file that must
be **excluded** from repo-wide edits. Whether that belongs in the ownership table or somewhere else
is this ticket's call; 19 does not presume it.

## Answer

**There is no ownership table, and nothing replaces it as a document.** Each governed file states
its own bounds in the paragraph between its H1 and its first H2, and `just owns` generates the index
from exactly those paragraphs. The index cannot go stale, because it has no content of its own: it
is a view of its sources. This is ticket 19's move — refuse the index *file*, generate the listing —
applied one level up, from ADRs to the governed corpus.

The old table died of being a second owner. `GOALS.md`'s confirmed text already says *"It does not
own definitions (`CONTEXT.md`), what gets built next, or how the work is done — those have their own
owners"*, and `PROCEDURE.md`'s says *"`GOALS.md` outranks this file; `CLAUDE.md` owns how agents
work; the `justfile` owns the commands."* A table row restating either is one claim with two owners,
on the exact subject of who owns which claim. Tickets 15 and 17 wrote those sentences independently,
in the same structural position, without coordinating — three files for three if you count
`docs/agents/issue-tracker.md`, which conforms as it stands. The convention was already the practice;
this ticket ratifies it and declines to write the artifact that would contradict it.

### What the old table actually was, re-derived

Not two columns but three — `Claim | Owner | Changes when`, eighteen rows at
`../old_loop/CLAUDE.md:24`, under the header *"One owner per kind of claim, and one rule for when it
changes."*

The third column is the interesting one, because it is 03's central finding written down a year
early and then not enforced. The `docs/adr/` row reads **"Same commit as the code, never a
follow-up"** — and 04 established that all 75 ADRs were written on days 7–8 out of `SPEC.md`. **That
column never fired once.** Two more rows confess their own failures inline: the store-copy row notes
that it "came to sell two things the app does not have", and the `docs/DEVICE.md` row that "its paths
went stale unnoticed". A table that documents its own violations in its own cells is not a mechanism;
it is prose that nothing checked, which is 03's losing category exactly.

So the old table failed on both of 09's ordered tests. It cost a read and prevented nothing
(comprehension), and its one enforceable-looking column had no enforcement (latency). This ticket
keeps the header sentence — one owner per kind of claim — and throws away the artifact that asserted
it.

### The declaration paragraph

The paragraph between a governed file's H1 and its first H2 says what that file owns, and names the
file that owns what it does not. **Position, not a marker.** A marker (`Owns:`) would be a syntax to
learn, and would force an edit to `GOALS.md` — a file only the human may touch, in a commit touching
nothing else, whose text 15 confirmed word for word. Position invents nothing and requires no edit to
any confirmed text.

**No vocabulary of claim kinds.** Each file says what it owns in its own words. The old table's
`Claim` column was never a vocabulary either — "What a word means", "What is stored", "What is
deliberately not built" are eighteen ad-hoc phrases invented one per row as rows were added. What
generalises here is the form, not a taxonomy; a taxonomy is a second thing to learn before the first
is usable, and 09's comprehension criterion refuses it.

**The check is structural, and stops there.** `pre-commit` refuses a commit touching a governed file
that has no such paragraph. Whether the paragraph is any *good* is the human's read at 17's
comprehension gate — the one place in this kit qualified to judge prose. `README.md`'s opening is a
pitch to a stranger and declares nothing; it passes, and is left as a pitch. A check that tried to
grade the paragraph would be a rule written from principle with no way to fire.

### Ownership and editorship are two questions, and the table fused them

This is what dissolves the crisis in the notes above. Three shapes were said to break a single-owner
column: `GOALS.md` human-only (15), `SALVAGE.md` asymmetric (13), `docs/adr/**` edited by nobody
(19). Look at what each one *is*: a `pre-commit` hook, a rule enforced at the merge, and an
unenforced convention. All three are **mechanisms**, and `PROCEDURE.md` already owns indexing
mechanisms without restating them.

So: **the declaration answers only "what may be written here". Editorship stays where it is
enforced, indexed from `PROCEDURE.md`.** There is no column that has to say "nobody", because there
is no column. Note that the row said to break an owner column hardest — ADR immutability — is
asserted and not enforced: 19 enforces the *citation* rule with a grep, while "never edited" rests on
nothing mechanical. A table row asserting it would have failed 03's latency test on the day it was
written, which is the second time this exercise has produced that answer.

19's negative obligation — terminology sweeps skip `docs/adr/` — needs no new home either.
Immutability already forbids the sweep, as a special case of forbidding every edit, and 19's
softener (`CONTEXT.md` notes a renamed term's former name) is the positive half. A separate
"exclude `docs/adr/` from sweeps" rule would be a second owner for a claim immutability already
makes. If it ever earns enforcement, the point is a `pre-commit` refusal of a commit modifying an
existing file under `docs/adr/`, and that is a mechanism, indexed from `PROCEDURE.md` like the rest.

### `CLAUDE.md` is the residual owner

**The finding this ticket turns on, and it came out of walking its own exit condition.** An index
needs a bottom row that catches what the rows above do not, or its real default is *write a new
file* — and a cap turns that default into a failure at 12 rather than a correct answer at 9.

The old table had eighteen rows and no residual owner. Eight days and 106 files later, that is the
failure this map exists to explain.

`CLAUDE.md` owns what no other file owns. It is the always-loaded agent-facing file, and "how agents
work here" is genuinely the residual category rather than a dumping ground chosen for convenience.
This also repairs the cap's arithmetic: with a residual owner, *"the cap is reached"* stops being a
dead end, because a file that takes the claim always exists. The `Folded:` count then measures
something real — a trailer that keeps appearing is the corpus saying `CLAUDE.md` is absorbing a
category that has earned its own file, which is the signal the old repo never got.

### The 2am test

The ticket's exit condition: an agent has a claim, must place it without asking, and the claim does
not obviously belong anywhere.

**The claim**: *git's default commit cleanup silently strips a subject line beginning with `#`, so
ticket-numbered subjects vanish on rebase.* True, costly, discovered in the act — and it is the case
that defeats a table. Not a goal: G1 and G2 rule nothing out here. Not the human's commitment:
nobody committed to anything. Not a definition. Not a salvage entry: nothing to port. Not an ADR:
recoverable, so 19's bar refuses it. Not the tracker's. Not the README's.

Under the old table it lands nowhere and the agent writes `docs/COMMITS.md`. Under this answer the
agent runs `just owns`, reaches `CLAUDE.md` — *"and whatever no other file owns"* — and writes two
lines there. Cap untouched, no trailer owed, no new artifact, and nobody woken up. **The test
passes**, and it passes because of the residual owner rather than because of the index; the index is
what made the absence of one visible.

### When the cap is reached

The claim is never discarded. Two cases, which 11 collapsed into one:

- **Headroom exists** (today 8 of 12). The file may be written, but it is a declared act: it appears
  in the branch's file list (10), carries its declaration paragraph, and the human sees it at the
  gate. No trailer is owed — the file list already carries the record.
- **The cap is reached.** The claim folds into the file that owns that kind of claim, or into
  `CLAUDE.md` if none does, and the commit that folds carries a **`Folded: <claim> -> <file>`**
  trailer.

The trailer is 17's `Oversized:` pattern reused deliberately: it rides on a commit that must exist
anyway (03's attachment), and `git log --grep='^Folded:'` is the frequency instrument 10 asked for.
Not an ADR — a fold is recoverable and 19's bar is irrecoverability. Not a line in the receiving
file — that would grow a document every time the cap refuses growth, the cap defeating itself.

### Confirmed text

For the `justfile`, alongside `start`, `check`, `land`, `goals` and `adr` — **six day-one recipes**:

```just
# What each file owns. Generated from the files themselves, so it cannot go stale.
owns:
    @git ls-files | grep -E '^([^/]+|docs/.+|\.claude/.+)\.md$' | grep -v '^docs/adr/' | sort \
      | while read -r f; do printf '\n%s\n' "$f"; \
          awk '/^# /{h=1;next} h&&/^## /{exit} h&&NF{p=1;print "    " $0;next} h&&p{exit}' "$f"; \
        done
```

Verified against this repo as it stands: it prints `docs/agents/issue-tracker.md` and its opening
sentence, and against 15's verbatim `GOALS.md` it prints the bounds paragraph and stops before the
editorship line — correctly, since editorship is not its business.

For `.githooks/pre-commit`, placed **after** 11's path-resolution block so it reuses that block's
`$touched` and `governed()` — one perimeter definition, one owner, which is this ticket's own rule
applied to its own mechanism:

```sh
# ---- Every governed file says what it owns (ticket 21) -------------------
# The paragraph between a file's H1 and its first H2 is its bounds
# declaration, and `just owns` generates the index from exactly these
# paragraphs. There is no ownership table: a table would be a second owner
# for a claim each file already makes about itself, and the old repo's ran
# eighteen rows deep while documenting its own violations in its own cells.

undeclared=''
for f in $touched; do
    git show ":$f" \
      | awk '/^# /{h=1;next} h&&/^## /{exit} h&&NF{print;exit}' \
      | grep -q . || undeclared="$undeclared
    $f"
done

if [ -n "$undeclared" ]; then
    printf '\n  Blocked: a governed file does not say what it owns\n%s\n' "$undeclared"
    cat <<MSG

  Put one paragraph between the H1 and the first H2 saying what this file
  owns, and naming the file that owns what it does not. `just owns` reads
  exactly that paragraph, so a file without one is invisible to the index.

MSG
    exit 1
fi
```

For `CLAUDE.md`, its own declaration paragraph, immediately after the H1:

```markdown
How agents work in this repo, and whatever no other file owns. `GOALS.md` outranks this file;
`PROCEDURE.md` is the human's own; the `justfile` owns the commands. `just owns` prints what each
file owns, generated from the files themselves.
```

**An amendment to 11's confirmed `## What may be written` section**, replacing its second paragraph.
11 owns the cap, so the rule about what happens when the cap refuses belongs in 11's text rather
than in a second place; recorded here, and ticket 20 transcribes the amended version:

```markdown
**When the cap is reached, the document is not written.** Find the file that already owns that kind
of claim and fold the claim into it; `just owns` prints what each file owns, and if nothing owns it,
this file does. The commit that folds carries a `Folded: <claim> -> <file>` trailer, and how often
that trailer appears is the evidence that the cap is mis-sized. Do not raise the cap: only the
repository's owner does that.

**Where a document disagrees with the code, the code wins and the document is a bug.** This is the
one row of the old repo's ownership table that was never wrong, and it is stated here rather than in
an index because the code has no declaration paragraph to generate one from.
```

### Consequences for other tickets

- **20 loses an instruction and gains four artifacts.** *"Wire the ownership table"* is **retracted**
  — there is no table, and an agent transcribing that bullet would invent the artifact this ticket
  refused. Retracted with it: 15's *"the ownership table gains a row for `GOALS.md`"* and 17's *"the
  ownership table gains a row for `PROCEDURE.md`"*. Both files already carry their own declarations
  verbatim, so **nothing is lost and no text needs writing**. What 20 installs instead: the
  `just owns` recipe, the `pre-commit` declaration check, `CLAUDE.md`'s declaration paragraph, and
  the amended second paragraph of `## What may be written`.
- **A stale number in 11's confirmed text, for 20 to repair on transcription.** That section reads
  *"The kit landed with 9"*; 11's own later correction sets the day-one count at **8, headroom 4**.
  20 transcribes verbatim, so this one would land wrong. Flagged rather than rewritten here: it is
  11's text and 20's final pass reports the real count in the commit.
- **18 inherits a requirement.** The architecture sketch is a governed file, so it needs a
  declaration paragraph between its H1 and its first H2, and the `pre-commit` check will refuse the
  commit that adds it otherwise. One sentence, written in 18 rather than composed by 20.
- **13 and 19 are unaffected in substance.** `SALVAGE.md`'s asymmetry and ADR immutability are
  mechanisms, indexed from `PROCEDURE.md`; neither needed a table row and neither loses anything by
  there not being one. `SALVAGE.md` still needs its declaration paragraph, which its "carry only what
  is novel" bar already states in prose.
- **17 gains a recipe that pays its own rule.** *A recipe that deletes no prose when it lands has not
  earned its place*: `just owns` deletes an eighteen-row table.

### Both gates

**Comprehension (09), which comes first.** The always-loaded cost is one sentence in `CLAUDE.md`'s
declaration paragraph. It prevents opening up to eight files to route a claim, and it prevents the
new-file reflex that the absence of a residual owner produces. A table would have cost eighteen rows
of always-loaded prose to prevent the same reading, while adding a second owner for every claim in
it.

**Latency (03).** Both checks attach to an artifact the commit must touch anyway — the declaration
check fires on the governed file the commit is already editing, and the `Folded:` trailer rides the
commit that does the folding. Neither is a rule written from principle waiting to be remembered.
The one clause here that rests on nothing mechanical is *`CLAUDE.md` is the residual owner*: nothing
enforces that an unhomed claim goes there rather than into a new file. Its instrument is the
`Folded:` count and the file-count report in the landing commit, and it is labelled as resting on
nothing, alongside 17's three.
