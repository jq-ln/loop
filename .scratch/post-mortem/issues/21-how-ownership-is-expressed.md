# How ownership of a claim is expressed, and where it lives

Type: grilling
Status: open

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
