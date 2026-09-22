# What carries over from the old repo

Type: grilling
Status: open
Blocked by: 04, 09, 15

## Question

Decided already: the old repo's 76 ADRs are **not** copied. They import a form that is implicated
in the failure. Instead a single salvage list records the conclusions worth keeping, each citing
the old ADR by number in the local archive, and a real ADR is written here only when the decision
is actually re-made.

The user is mildly sceptical of this. Test it while resolving: if the salvage list turns out to
want to be 60 entries long, it has become the ADR directory by another name and the decision
should be revisited rather than honoured.

Settle:

- **Which conclusions carry**, from ticket 04's keep / keep-with-changes / drop inventory.
- **The form of the list** — one line each, or enough that the conclusion is usable without opening
  the archive? These pull against ticket 11's budget; the budget wins.
- **Provenance**, given `../old_loop` will be local-only with no reachable issue URLs. An ADR
  number resolves against a directory on one machine. Is that enough, and if not what replaces it?
- **What must NOT carry.** More valuable than the keep list. Name the decisions, forms and habits
  that are prohibited here, and say what each would look like if it crept back.

## Amendment after ticket 09

Blocked by 15 as well: "a real ADR is written here only when the decision is actually re-made" is a
rule about what earns an ADR, and 08 already decided each ADR must cite the goal it serves. The
salvage list's entries are therefore checkable against the goals file, which gives the 60-entry
sceptical test a sharper form — an entry that cannot name a goal it serves is not a conclusion worth
carrying.

Note also that 04 enters the kit as a **binding input to the rebuild**, not as a rule (08's
counterfactual filter), so the salvage list is not itself subject to the rule-gating tests.

## Note after ticket 11

The salvage list is **one** of the nine standing-claim files 11's budget expects on day one, inside
a hard cap of 12. If this ticket concludes it wants two files, that is a decision against the cap and
belongs in its answer rather than in a quiet second file. 11's eviction rule points the other way by
default: when the cap is reached the document is not written and its claim folds into the file that
already owns that kind of claim.

Two entry rules also bind the list's contents. **No document asserts a structural fact the source
asserts about itself** — a salvage entry about the schedule engine points at a path, it does not name
a module type or a count. And **nothing cites an ADR**, which includes the old repo's ADR numbers: an
entry citing `../old_loop`'s ADR 0031 is citing a local archive rather than a live ADR in this repo,
so it is admissible, but a *this*-repo ADR number in the list is not.
