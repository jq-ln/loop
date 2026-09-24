# What carries over from the old repo

Type: grilling
Status: resolved
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

## Answer

HITL session, 2026-09-24. Four rounds of grilling; every recommendation put to the user and accepted
as stated, with one terminology correction and one scope input from the user, both recorded below.
The file at the end is this ticket's real output. Skills: `grilling`, `domain-modeling`.

### The sceptical test was right, and it is answered by a bar rather than a ceiling

The ticket's own test — *if the salvage list wants to be 60 entries long it has become the ADR
directory by another name* — was the load-bearing worry, and the user's sharpening is what disposes
of it: **carry only what is novel after the post-mortem**. An entry earns its line only if three
things are all true.

1. **No ported code carries it.** This is the largest cut. The pull toward 60 came almost entirely
   from the old repo's ~20 world-fact ADRs, and most of those are second copies: *schedules float in
   local time* is both an ADR and the schedule engine's floating expansion, and the definition/
   occurrence model carries ~120 lines of KDoc arguing itself. Port the file and the conclusion
   arrives with it, with its test file as the specification. The ADR was never the carrier.
2. **No other document in the kit owns it.** The same eviction rule the budget already runs.
3. **No mechanism catches it.** A prohibition restated beside a mechanism that already enforces it is
   the dilution-and-conflict defect, which is the better-evidenced one.

The salvage list is therefore the **residue**: what the old repo taught that nothing else here is
already carrying. It lands at ten entries and ~45 lines. The 60-entry failure is refused by the bar
rather than detected after the fact, and the ceiling below is a second, blunter guard on the same
thing.

### Provenance resolves here, not to the archive

The ticket assumed an entry cites an old ADR number against a local directory. **That is wrong, and
the budget's own path check is what settles it**: every backticked path-like token in a governed
document must resolve on disk, and an archive path resolves on exactly one machine. A public
repository — which is G2's whole point — citing something no reader can open is the citation failing
in the same gesture that makes it.

`.scratch/post-mortem/` is tracked in this repo and goes public with it: 21 tickets, the map, and
seven research files, including the 388-line inventory behind ticket 04. So **an entry states its
conclusion self-containedly and its evidence lives in `.scratch/post-mortem/`**, which resolves, is
public, and is where the conclusion was actually reached. The old ADR numbers stay in the research
files, one layer down, where they are a detail rather than a citation.

Two consequences, both routed: `SALVAGE.md` is the first governed document depending on the tracker
staying as files, which constrains ticket 14; and no SHA is quoted in an entry without re-verifying
it against the archive, because the old history was rewritten and issue bodies cite dead SHAs.

### The file's bounds, lifecycle and ownership

- **≤ 60 lines, hard** — inherited from `PROCEDURE.md` rather than invented, since the budget
  declined on principle to invent per-document ceilings and ticket 07 had just shown the usual number
  to be unmeasured folklore. At ~3 lines an entry the ceiling admits ~15 entries, so the sceptical
  test is enforced at the hook rather than noticed in review.
- **Entry form**: one sentence stating the conclusion so it is usable without opening anything, plus
  the where and why. Usable-without-the-archive won over one-line-each; the budget's constraint is
  count, and this file spends its lines on ten entries rather than on forty.
- **One file, not two.** The keep half and the prohibition half share it. Splitting would cost a slot
  the budget has not got, and a prohibition travels with the evidence that produced it.
- **The keep half is consumable, and deletion rides on the consuming commit** — the commit that ports
  the code or writes the ADR also deletes the entry. This is the rule class with a clean compliance
  record: attached to an artifact the commit must touch anyway. It makes `SALVAGE.md` the only
  document in the kit with a shrink rule, which is deliberate against a corpus that only ever grew.
- **Emptying the keep half frees no budget slot.** The prohibitions are standing, the file persists,
  and the slot was spent on day one.
- **Ownership is asymmetric**: an agent deletes an entry in the commit that consumes it; **adding an
  entry is the human's**. Additions are the direction the file exists to resist. Input to ticket 21,
  which formalizes the row.
- **Name**: `SALVAGE.md`, at the repo root. Named for what survives; salvage covers both what was
  taken from the wreck and what was deliberately left in it, and it is the term this map has used
  throughout.

### Which conclusions carry

**Port pointers — five.** The four things ticket 04 ranked as costing weeks rather than days, plus
one conditional that the user's scope input made unconditional (below): the definition/occurrence
model, the completion cascade, the schedule engine, the audio core, and the wire declaration
validator.

**Conclusions with no code carrier — one.** *Store facts; compute judgements on read.* The durable
half of the old "core measures, plugins judge" rule, restated as the storage rule it actually was.
The placement framing is the half that failed: it made the rule sound like it was about module
boundaries, which is why a score calculator sat inside the rules module unchallenged.

**Prohibitions — three**, all of which survive "name the mechanism that catches this":

- A seam whose caller does not ship alongside it is not a seam yet.
- A new top-level concept must name a stage nothing else covers **and** arrive with an engine, as two
  separately evidenced claims. Kept in this form rather than as *do not install an ontology*, which
  is not checkable. It is the old repo's own brake, and it is worth keeping precisely because it is a
  brake.
- A document may not credit a structure for a property something else bought. Of the three documented
  falsehoods the inventory found, this is the one no rule catches — the budget's doc-code rule binds
  structural facts a source asserts about itself, and a causal benefit claim is not one.

**Evicted with the mechanism named**, so the omissions are recorded rather than silent: the deferred
scrub (ticket 16, and G2 rules it out in words); adopting a distribution channel (N1 and the
tie-break); writing the rule at the moment of insight and bulk-extracting decisions from one file
(ticket 19's, and this map's own *decide first, write once*).

**Handed to ticket 18, absent from the file.** Three of ticket 04's strongest conclusions are
architectural, and 18 owns the sketch: *one rules module plus one Android side rather than eight
modules*; *adopt the JVM test runner on day one, because that and not the module graph produced 945
device-free tests*; and *exported schemas in version control as the input to every migration test*.
The over-split module that existed only to solve a problem the split itself created goes with them as
a sizing argument. Putting them in both places would give one claim two owners, which is the failure
the goals ticket avoided by linking rather than copying.

### The terminology correction

The user read *"two modules, not eight"* as being about plugins, since module was the early name for
them. It is not: the eight are the old repo's Gradle build units, one repo, enforced by the
dependency graph, none of them a plugin. The collision is real and sits one layer away — both
first-party plugins were written as in-repo Gradle modules and then extracted to separate repos to
become plugins, so the word did both jobs in the same history. **Recorded as a term to disambiguate
in `CONTEXT.md`**, which ticket 20 writes: module is a build unit; plugin is a separately installed
app. Handed to 18, which is where the word does its work.

### The scope input, and what it changed

The wire declaration validator was cut in round 3 on the grounds that nothing in the rebuild has an
untrusted-manifest problem, then restored conditionally, then made unconditional when the user stated
that **plugin plumbing is in scope for the v1.0 product**.

Recorded as an input received from the human, dated 2026-09-24, **not as a decision this ticket
made** — the map rules Loop v2's product scope out of scope, and this ticket does not acquire it by
being told a fact. The consequence is confined to one salvage entry: the validator is ported rather
than re-derived, being the one part of the old seam that was built correctly — pure-JVM validation of
an untrusted declaration with no I/O, so the whole judgement is unit-testable.

It also sharpens the first prohibition rather than weakening it. *A seam whose caller does not ship
alongside it is not a seam yet* is now the live test the plumbing has to pass, not a retrospective
verdict on a dead one: the old repo shipped a complete platform with zero installed and zero
installable plugins, and the plumbing waits for the first plugin that ships with it. The validator is
what gets ported on that day.

### The file, confirmed verbatim

```markdown
# Salvage

What the first Loop repo taught that nothing else here already carries. An entry earns a line only
if no ported code, no other document, and no mechanism holds the claim. The evidence for every entry
is in `.scratch/post-mortem/`, and the archive it was read from is local-only.

Adding an entry is the repository owner's. An agent deletes an entry in the commit that consumes it.

## Port these, and read them before changing them

The things that cost most of the first repo's eight days. Each carries its own reasoning beside it,
and its tests are the specification.

- **The definition/occurrence split.** Port first: every other engine rule is downstream. The
  non-obvious parts are that display fields are snapshots taken when the run is materialized and
  never back-filled, that the references to definitions are deliberately not foreign keys, that a
  snooze stores where the run came from rather than where it went, and that skip reasons are
  discriminated because four code paths wrote one of them and only one meant the user did not do
  something.
- **The completion cascade.** A worklist run to a fixpoint, not a sequence of passes: completing one
  occurrence can close a subtree, satisfy shared work elsewhere by dedup key, and roll parents up,
  and each of those can re-trigger the others. The whole plan is computed before anything is
  written, which is what makes undo exact. Reversal is the harder direction and must reach only what
  this completion satisfied.
- **The schedule engine.** Recurrence expanded in floating local time with the zone bound only
  afterwards, which is the one detail that survives a 23- or 25-hour day. Month-end is why the
  dependency exists at all.
- **The audio core.** Pitch estimation, WAV and PCM, onset detection, a frame clock. No Android
  imports, verified against synthetic signals.
- **The declaration validator**, when the plugin plumbing is built: an untrusted declaration is
  validated with no I/O, so the whole judgement is unit-testable. It is the one part of the first
  repo's plugin seam that was built correctly.

## Carry this

- **Store facts; compute judgements on read.** Nothing derived is ever stored, so changing a formula
  re-grades the whole history instead of leaving today's verdict frozen into every past row. This is
  a storage rule, not a placement rule. Stated as placement it sounds like it is about boundaries,
  which is how a judgement came to sit inside the first repo's rules module unchallenged.

## Do not carry these

Prohibitions, because nothing else here catches them.

- **A seam whose caller does not ship alongside it is not a seam yet.** The first repo's plugin wire
  had its last consumer deliberately removed from the build, and then ten more commits built the
  wire. At the end it was a tenth of the production code and near a fifth of the test suite,
  discovering nothing, while the store listing advertised the feature.
- **A new top-level concept must name a stage nothing else covers, and arrive with an engine** — two
  separately evidenced claims. The first repo's four-part taxonomy returned an eight-line menu enum
  for six consecutive placement decisions and a build-and-revert.
- **No document credits a structure for a property something else bought.** The first repo credited
  its module split with making the invariants testable without a device; the test runner bought
  that. Say what would fail if the structure were removed, or claim nothing.
```

### Consequences for other tickets

- **18** receives three binding architecture inputs and the module/plugin disambiguation; the
  architecture conclusions live there and not in `SALVAGE.md`. Unblocked by this resolution.
- **19** receives the interaction that names it: a salvage entry dies when the decision is re-made as
  an ADR, so the keep half's exit depends on there being an ADR practice. If 19 decides against one,
  the exit rule needs a new carrier and this ticket's deletion attachment weakens. Unblocked.
- **21** receives the asymmetric ownership rule — deletion is an agent's, addition is the human's —
  as an input to the ownership table, not a decision on its behalf.
- **14** gains a constraint it did not have: `SALVAGE.md` cites `.scratch/post-mortem/` as its
  evidence, so migrating the tracker to GitHub Issues would break a governed document's path check.
  Its third bullet is superseded — salvage citations no longer resolve against the archive.
- **16** gains a small mitigation: sessions resolving a salvage citation now read this repo's
  research files rather than the archive, which narrows the contamination hazard without closing it.
- **11** is unchanged and confirmed: exactly one governed file, inside the day-one eight.
- **20** writes `SALVAGE.md` at the root verbatim, adds the ≤ 60-line check beside the others, and
  disambiguates module and plugin in `CONTEXT.md`.
