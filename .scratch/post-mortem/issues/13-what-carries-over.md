# What carries over from the old repo

Type: grilling
Status: open
Blocked by: 04, 09

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
