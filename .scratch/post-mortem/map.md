# Post-mortem: what the first Loop repo taught, and what this one starts from

Type: wayfinder:map

## Destination

A **seed kit** committed to this repo — the documents, protocols and constraints Loop v2 starts its
first day of real work with — produced by a post-mortem of the first Loop repo (`../old_loop`, 242
commits over eight days, killed 2026-09-22). The findings are the route; the committed files are the
destination. The map is done when someone can begin building the app with nothing left to decide
about *how* the work runs.

Ticket 09 settled what the kit is protecting against, and it is not primarily process. The kit's
purpose is a repo whose author can account for it, aimed at a goal it can be checked against.
Process leanness is one of three means, and the third in rank: **a stated goal** (15), **protected
comprehension** (17), **a bounded corpus** (11).

## Notes

**Domain**: solo developer, AI-assisted engineering workflow. The subject is how a human and
several agent sessions build software together sustainably — not the app. The app is Loop, an
offline Android routine tracker; it will be rebuilt from scratch and that rebuild is out of scope.

**Evidence lives in `../old_loop`**, read-only. Its git history, 106 issues, 76 ADRs, 8,191 lines
of Markdown and 43,488 lines of Kotlin are the primary sources. Its GitHub remote is destroyed
after 2026-09-22; harvest anything needed from the tracker via the research tickets, which run
first, and do not plan on it being reachable later.

**Skills every session consults**: `grilling` and `domain-modeling` by default. Research tickets
call `research`. Any ticket proposing a protocol that involves building something to react to
calls `prototype`.

**This map carries execution.** Wayfinder plans by default; here the final task tickets write the
kit into this repo, because a post-mortem whose output is agreement has already failed once.

**Decide first, write once.** Conclusions accumulate in ticket answers; they are written into real
files in a single late pass. The old repo's dominant failure was writing the rule at the moment of
insight — 76 ADRs in eight days, each true when written — so insight and authorship are
deliberately separated here.

**Standing preferences**
- Documents are lean — but **not because length correlates negatively with adherence**, which
  ticket 07 falsified. The constrained quantity is count, reference density and detectable
  conflict (05, 07), and ticket 11 turns that into an enforced budget. Ticket 09 adds the test that
  precedes it: a rule adding an artifact to read is net-negative unless it pays for itself.
- No distribution channel is assumed. F-Droid was the first repo's target and may not be this
  one's; nothing in the kit may depend on it.
- Terminology is challenged before it is adopted. "A/B testing" was rejected this session for
  importing statistical promises a single-user offline app cannot keep; **bake-off** (two rough
  variants, judged side by side, immediately) and **trial** (one variant lived with, then the
  other) are the terms ticket 12 works from.
- A finding that contradicts the framing this effort began with wins. The user has consented to
  this explicitly; ticket 09 exists to make it possible.

## Decisions so far

<!-- one line per resolved ticket: gist, then the link to the detail -->

- [The documentation growth curve, and why the correction did not hold](issues/01-documentation-growth-curve.md): every addition was locally justified and the failure is purely aggregate; the correction that worked predates the map chartered to make it, and the tracker holds more prose than the repo.
- [What the 106 issues were actually about, and what generated them](issues/02-issue-lifecycle.md): 106 issues in 48h38m, process share rising 30% to 81%, nothing ever stale, declining never a practice but a single 61-second sweep.
- [Which documented rules the history actually violated, and how soon](issues/03-rules-written-then-broken.md): rules attached to an artifact the commit must touch anyway held perfectly; rules written from principle broke, the fastest in 15 minutes 33 seconds.
- [Which architectural decisions the code honours, and which were aspirational](issues/04-product-salvage-inventory.md): the four pillars and the plugin seam are drops; definitions-vs-occurrences, the cascade, the schedule engine and core-audio are keeps.
- [Where 242 commits of effort actually went](issues/05-where-the-time-went.md): process work tripled after the code stopped growing; the driver is file count and reference density, not length. **Causal reading superseded** — its "second disease rather than a symptom" was overturned by [Why it became unsalvageable](issues/08-the-terminal-account.md) and settled by [Was it the process, or was it the scope?](issues/09-process-or-scope.md): the numbers stand, but the process volume is third-order. Body left as written.
- [Collisions, version confusion, and extra review rounds](issues/06-merge-and-review-forensics.md): collisions are global registries a worktree cannot isolate; versioning's cost is adjudication not error; review rounds are mostly not caused by `main` moving.
- [What the evidence actually says about document length and adherence](issues/07-doc-length-and-adherence.md): the 200-line figure is published guidance but unmeasured, and the papers usually cited measure retrieval accuracy rather than adherence; dilution and conflict are the better-evidenced defect.
- [Why it became unsalvageable](issues/08-the-terminal-account.md): unwieldiness the author could no longer account for, then two blows — a personal-information scrub for a publication that never happened, and F-Droid recognised as arbitrary after it had propagated four ADRs into the architecture; the process explosion was triage started too late, not a second disease; the structural cause is that no goals document existed and the ownership table had no row for one. All seven findings survive the counterfactual filter; forced to three, the kit carries 03, 05 and 02.
- [Was it the process, or was it the scope?](issues/09-process-or-scope.md): neither — three layers, not a weighting. Root: no destination existed to check anything against. Proximate: breadth outran comprehension. Third-order: the process volume, a real triage that became its own load. Outputs the comprehension criterion, ordered before 03's latency test; re-charters 12, 17 and 18, and makes 15 block every ticket that writes a rule (10, 11, 12, 13, 17). **Consequence 5's worked example is corrected** by [The protocol for choosing between two designs](issues/12-bake-off-and-trial.md): the plugin subsystem is alive at the old repo's HEAD, and the part of it that died turned on Android's merged manifest rather than on a design choice. The re-charter it produced stands and is strengthened; only the example fails.
- [The goals document, and the citation rule that gives it teeth](issues/15-the-goals-document.md): two goals governing two objects — the app (G1, used every day) and the repository (G2, legible to people who might hire or build with me) — with the tie-break that would have killed F-Droid on day one; a goal is citable only if it can rule a decision out, and every ADR names the goal *and what it ruled out*; goal ids never reused, deletion carries a `grep` re-check list; `GOALS.md` ≤ 40 lines, written verbatim, edited only by the human in a commit touching nothing else.
- [The human's own procedure](issues/17-the-humans-own-procedure.md): where a commitment can become a step in a command already run, it stops being a commitment — a comprehension gate at the merge (nothing lands unread), with the merge as the act no agent may perform; the pace gap made visible as unmerged worktrees, capped at three in `pre-commit`; a 300-line commit cap with an `Oversized:` trailer and a branch conformance check against its declared file list; review once per branch inside `just land`, an input to the human's reading and never a pass/fail; and `PROCEDURE.md` ≤ 60 lines that indexes mechanisms rather than restating them, with three clauses labelled as resting on nothing.
- [The budget, and what enforces it](issues/11-the-documentation-budget.md): the budgeted quantity is **file count**, not length — 12 standing-claim files (root `*.md`, `docs/**.md`, `.claude/**.md`), the kit landing with 9, `.scratch/` and the justfile outside the perimeter and no standing rule allowed to hide there; enforced in `pre-commit` on the commit that adds the file, and when the cap is reached **the document is not written** — its claim folds into the file that already owns it, with the cap a knob only the human turns; no document asserts a structural fact the source asserts about itself, and backticked paths must resolve; ADRs are exempt **conditional on being leaves** — nothing cites an ADR, found by `just adr <term>`, superseded ones deleted — with ticket 19 holding the final say. **Four clauses revised** by [Whether this repo keeps an ADR practice at all, and what earns one](issues/19-the-adr-practice.md), which used that say: the leaf rule is restated as a **direction** rule and enforced in `pre-commit`, discovery widens to a generated index, the tombstone carve-out is refused as unnecessary, and `Prior art:` is cut for `Affected paths:`. ADRs are additionally **exempt from the path-resolution and structural-fact checks**, being dated records rather than standing claims. The cap of 12 and the perimeter are untouched.
- [How parallel agent sessions coordinate](issues/10-parallel-agent-coordination.md): the claim unit
  is the **whole file** — no region claims, since git enforces files and nothing enforces paragraphs
  — declared in a `## Files` block that `just start` refuses to open a worktree without, checked
  against live worktrees **at the door** rather than at the merge, and widened mid-ticket only by an
  explicit `just claim` that re-checks and leaves a dated record; **no version counters and no
  changelog exist on day one**, so eight adjudicated numbers become none and 17's merge-time version
  rule binds vacuously; ADR identity is `docs/adr/YYYY-MM-DD-<slug>.md`, allocated at write time and
  never refereed; a stall is surfaced by the cap's refusal listing the live worktrees and their age,
  never detected by a threshold, with `just drop` the cheap exit that keeps the cap from being
  bypassed; ADR 0077's parking does not carry over, and `PROCEDURE.md` goes to 59 lines.

- [What carries over from the old repo](issues/13-what-carries-over.md): carry only what is **novel
  after the post-mortem** — an entry earns a line only if no ported code, no other document and no
  mechanism already holds the claim, which disposes of the 60-entry worry by a bar rather than a
  ceiling; `SALVAGE.md` at the root, ≤ 60 lines inherited from `PROCEDURE.md`, lands at ten entries —
  five port pointers, one conclusion, three prohibitions — with the architecture conclusions handed to
  18 rather than held twice; **provenance resolves to `.scratch/post-mortem/` in this repo, not to the
  archive**, because a path that resolves on one machine fails the budget's own check; the keep half
  is consumable, deleted by the commit that ports the code or writes the ADR, making it the one
  document in the kit with a shrink rule, and addition is the human's while deletion is an agent's. **The residue goes from ten entries to twelve**, added by
  [The protocol for choosing between two designs](issues/12-bake-off-and-trial.md), which takes the
  drafted file from 54 lines to 62 against a ceiling 13 inherited from `PROCEDURE.md` rather than
  derived; ticket 20 lifts it to 65 or trims at authorship.

- [Whether this repo keeps an ADR practice at all, and what earns one](issues/19-the-adr-practice.md):
  **the practice exists**, and almost nothing of the old repo's version survives. Citation is about
  **direction, not volume** — an ADR cites upward (`GOALS.md`) and outward (paths); nothing cites an
  ADR and no ADR cites another, because what rots is a pointer at a **deletable** thing — enforced by
  a `pre-commit` grep rather than asserted, with code comments stating the claim instead of pointing
  at it. Two gates: the **bar** is irrecoverability (13's bar on its third corpus) and the **filter**
  is 15's goal citation. The null case splits — a decision *not* to do something is an ordinary ADR,
  a decision that fails the bar leaves **no trace**. Discovery is **recognition**: `just adr` with no
  argument prints a *generated* index (not a file, so 11's ban stands and cannot rot), `just start`
  surfaces ADRs citing any claimed path automatically, and **corpus size is the real constraint** —
  the listing's length is the instrument that says the bar is mis-sized. An ADR is a **dated record,
  never edited**, exempt from 11's content checks and untouched by terminology sweeps, which makes
  supersession-by-deletion coherent and the tombstone carve-out unnecessary. Template: goal citation
  with 17's timing fingerprint folded in, mandatory `Affected paths:`, a descriptive heading naming
  the **decision**, under a hard line cap. **15's citation rule, 17's fingerprint and 13's consumable
  `SALVAGE.md` half all have their carrier and stay live.**

- [The protocol for choosing between two designs](issues/12-bake-off-and-trial.md): **no protocol,
  and the refusal is the answer.** Both of the ticket's premises were falsified by measurement — the
  plugin subsystem is alive at the old repo's HEAD and its in-process half died of Android's merged
  manifest, so the calibration standard does not exist; and the two mechanisms are the wrong way
  round, **trial being the established loop** (a one-day cycle on a two-profile phone feeding an
  on-device note file read beside the occurrence log, behind 13 of 75 experientially-justified ADRs)
  while **bake-off ran exactly once, in code ADR 0067 excised**, with zero `@Preview` functions in
  12,161 lines of UI. Of seven reversal episodes, **none** would clearly have been pre-empted by a
  bake-off. A protocol fails both gating tests — it cannot fire until a screen, a debug build and a
  device exist, and has no artifact to ride on until the work starts — so writing one now is 15's
  calendar trigger and 10's unchosen channel, one layer down. What lands instead is **two salvage
  entries, facts rather than rules**: the device loop, consumed by the commit that writes
  `docs/DEVICE.md`, and the fidelity tax a rough variant charges before it can be judged. Neither
  term enters `CONTEXT.md`, nothing goes to 18, and the pre-rewrite bundle's existence is recorded
  while its path is not.

- [What may not enter the repo, checked mechanically from commit zero](issues/16-what-may-not-enter-the-repo.md):
  the perimeter is **every tracked path with no exclusions** — `.scratch/` included, since what earns a
  dated record its budget exclusion says nothing about a home path — so the shared hook holds **three
  checks across two perimeters**, stated so neither reads as wrapping the other. Four classes: identity
  (installed, holding), **home-anchored paths widened to the tilde forms** (the old check's omission,
  and where 31 of 49 real instances were), personal-domain addresses (never once violated here), and
  generated output by a `.gitignore` that **did not exist in this repo**. The author's **identity is
  deliberately not on the list** — the licence requires the name, the handle is inside the mandated
  noreply address, and a name check would fire 348 correct-as-written times on day one: the rule bans
  data disclosing the machine, not data identifying the author. The false-positive budget becomes a
  command — **a check installs only if it reports zero on the tree as it stands** — which also makes
  whole-index checking safe, since any hit is then content this commit introduced. **No exception
  exists**; a wrong pattern is edited by the human, the same knob-shape as 11's cap. The hook prints
  path, line and class and **never the matched text**, and its patterns do not match their own text, so
  unlike ADR 0070's version it needs no exception to stay at zero. The tracker half needs no separate
  check and the local tracker **closes by construction** the hole #76 could not reach — a requirement
  14 must now satisfy. **Verdict: missing commit zero costs one history rewrite, and it is free** —
  `research/02-issues-raw.json` is the repo's entire content exposure and there is no remote to
  invalidate, so the instrument the old repo spent at 195 SHAs is not spent here at all. **14 is
  unblocked.**

- [How ownership of a claim is expressed, and where it lives](issues/21-how-ownership-is-expressed.md):
  **there is no ownership table, and nothing replaces it as a document.** Each governed file states
  its own bounds in the paragraph between its H1 and its first H2, and **`just owns` generates the
  index** from exactly those paragraphs, so it cannot disagree with its sources — 19's
  refuse-the-index-file move applied to the governed corpus. The convention was already the practice:
  15, 17 and `docs/agents/issue-tracker.md` each wrote that paragraph independently, which is why
  retracting 20's *wire the ownership table* costs no text. **Ownership and editorship are split** —
  the declaration says only *what may be written here*, while who may edit stays where it is
  enforced, indexed from `PROCEDURE.md` — which dissolves the three "shapes" (15's human-only, 13's
  asymmetric, 19's nobody) said to break an owner column: all three are mechanisms, and ADR
  immutability is asserted rather than enforced anyway. The old table, re-derived, had **three**
  columns and eighteen rows, and its `Changes when` column **never fired once** — the `docs/adr/` row
  demanded the same commit as the code while all 75 ADRs were written on days 7–8, and two further
  rows document their own violations in their own cells. The finding that carries the ticket:
  **`CLAUDE.md` is the residual owner**, because an index with no bottom row has *write a new file*
  as its real default, and that default is how 106 files happened. A claim is never discarded — with
  headroom the file is a declared act, at the cap the claim folds and the commit carries a
  **`Folded: <claim> -> <file>`** trailer whose frequency is the evidence the cap is mis-sized. The
  2am test passes on the residual owner, not on the index; the index is what made its absence
  visible. Checks are structural only, and `CLAUDE.md`'s residual ownership is labelled as resting
  on nothing.

- [The architecture sketch the rebuild must produce on day one](issues/18-the-architecture-sketch.md):
  **the file states constraints, never description**, which is how it satisfies 11's structural-fact
  ban by construction rather than by exception — a constraint says what must stay true and what it
  costs to change, so the code can violate it but never contradict it, and 11's path check becomes
  its honesty rail (it cannot name a structure that does not exist). Named **`ARCHITECTURE.md`** at
  the root and **"sketch" is retired**, having named a drawing. Five topics, not seven: the seam, the
  test runner and the plugin-plumbing timing rule land filled, while the **first shippable slice** and
  **what is not built** ship marked `**Unwritten.**` — and `pre-commit` **refuses the commit that adds
  the first `.kt` file** while either is, which is the mandate 08 asked for finally attached to an
  artifact the work must touch anyway. The unbuilt list is written **priced at one ADR each** and is
  **consumable**, the second such thing in the kit after `SALVAGE.md`'s keep half. Lifecycle is
  overwrite-in-place with the changing ADR in the same commit, which makes 11's *a standing document
  owns the claim itself* and 19's direction rule fit without an exception. **An agent drafts it and no
  rule is written**, because 17's merge gate already is one. No line cap (11's own reason), the salvage
  ports are **not enumerated** (one property stated instead, so no claim gets two owners), and
  `PROCEDURE.md`'s 59th line and a `CLAUDE.md` mention are both **refused on the record**. Corrects
  this ticket's own body: **the day-one count is 8, not nine.**

- [Write the kit into this repo](issues/20-write-the-kit.md): **the kit is committed**, at `33abe66`,
  **7 standing-claim files of 12 rather than the estimated 8** — every whole-file transcription
  diffed against its source block rather than proofread, so `GOALS.md`, `ARCHITECTURE.md` and
  `.gitignore` are byte-identical to 15's, 18's and 16's text, and `PROCEDURE.md` and `SALVAGE.md`
  land at 59/60 and 62/65 with 10's and 12's amendments applied. Ten checks in `pre-commit`, the
  size cap in `commit-msg`, `pre-push` extended in kind, a harness-side denial on agent merges, and
  **eight recipes rather than six** — 10 and 21 each counted the justfile without the other. Two
  input defects were **raised rather than drafted around**, which is what the ticket existed to do:
  `CONTEXT.md` had no confirmed text *and could not be omitted*, since three confirmed files cite it
  and 11's own path check refuses the kit without it, so it was written to its forced minimum on the
  user's decision; `README.md` is authored by no ticket at all and became
  [Write the README](issues/22-the-readme.md). **Five corrections, each argued**: the size cap moved
  to `commit-msg`, because `pre-commit` cannot see the message and demonstrably reads the *previous*
  commit's; 19's numeric ADR pattern **dropped** as unable to match any citation this repo's naming
  can produce, while failing its own install budget at 179 hits and having to except 16's verbatim
  comment; 11's path filter narrowed to skip placeholders, since as written it refused the one file
  20 was told not to touch, on eight tokens 11 had claimed to check; and two stale claims in 11's
  confirmed text repaired. The undeclared blocker was real — 16's entry rule reported 17 hits, all in
  the issue dump — so the **untrack happened here and the history excision stays 14's**, the owner's.
  **The kit's first evidence about itself**: the merge denial fired on the session installing it, and
  blocked the command that would have fixed it, so it was narrowed at `c22e6e4` — the coarse version
  of a harness-side rule is the one that gets switched off.

- [Write the README](issues/22-the-readme.md): **two sentences of pitch and an MIT licence, in the
  author's words.** No first person, no status, no count, no mention of the first Loop, because what
  rots is a claim true at publish time that stops being true unedited. The README declares nothing,
  confirming 21's reading. Left without a home: the build section is written by the commit that first
  makes the app buildable.

- [Publish this repo once the namespace frees](issues/14-publish-the-repo.md): **public at
  `jq-ln/loop` since 2026-09-25, `main` only, tracker kept local.** A first push met three
  blockers, not one: the dump, ten commits made before the size cap existed, and an archive pointer
  that passed `pre-commit` only because it checked paths against the disk rather than the index. That
  last one is a hook bug, now fixed. The owner ran one rewrite that cleared all three, and the real
  `pre-push` passed. **Every SHA quoted before this line is dead.**

## Not yet specified

- **The null artifact.** Ticket 06 found 18 issues arguing that no version bump was owed, via a
  precedent chain seven deep, because the rule had no way to record a considered "nothing". Likely
  a general principle for every rule in the kit, and long held here as not sharp enough to ticket.
  Tickets 17 and 10 applied the shape three times without generalising it — an `Oversized:` commit trailer,
  stray paths recorded in the merge commit, and `just claim`'s dated widening record — so the
  pattern now has worked instances as well as a failure, and 10 notes that the *frequency* of such
  records is itself the evidence that the rule they except is mis-sized.
  **Ticket 19 resolved its sharpest instance and supplied the distinguishing test the patch was
  missing**: *a null record is owed where a rule demands an act and the considered answer is "none";
  it is not owed where the default is already silence.* A rejected ADR therefore leaves no trace —
  the bar demands nothing, so there is no rule to be excepted from — while a decision *not* to do
  something is an ordinary ADR. That is a fourth worked instance rather than a fifth mechanism, and
  it makes the patch sharp enough to ticket for the first time. **Ticket 16 then applied the test rather
  than adding to it**: its entry rule carries no exception, no trailer and no override string, and none
  is owed, because the rule demands no act whose considered answer could be "none" — the fifth case, and
  the first where the test was used to decline a mechanism rather than to justify one. **Ticket 21
  adds a sixth**, in the justifying direction: the `Folded:` trailer, owed where the cap refuses a
  file and the claim folds into an existing owner instead — and it reuses 10's reading, that the
  *frequency* of such records is the instrument rather than the record itself. **Ticket 18 adds a
  seventh**, also justifying: a rebuild whose considered answer to *what is not built* is "nothing"
  must still write "Nothing.", because the unwritten marker is refused by the hook. **It stays fog by
  decision, not by fogginess** — the human ruled against ticketing it: no open ticket waits on generalising it, and
  filing it would grow the board this map exists to shrink. A later rule that needs the test cites
  it from here; nothing in the kit is blocked on generalising it further.
- **How two design variants are set up and judged.** Deferred by [The protocol for choosing between
  two designs](issues/12-bake-off-and-trial.md) rather than answered: where two variants live so
  they can be compared, how the loser is disposed of, and whether the comparison is recorded
  anywhere. It needs a screen, a debug build and a device, none of which exist, and the shape it
  would take is constrained already — two worktrees are structurally blocked by 10's whole-file
  claims, and a preview cannot answer a question about a gesture. **Filed here for consistency with
  the version cadence below**, though both arguably belong under Out of scope by this map's own
  rules: fog gathers toward the destination, and these two wait on the rebuild, which does not.
  Nothing is blocked either way.

- **The version cadence.** Ticket 10 answered the registry question for this repo by subtraction —
  there are none — and fixed the property any future counter inherits: allocated at land by the
  human, never in a worktree, which makes batching fall out rather than needing a scheme. What
  cadence of landings earns a bump, and what a bump is *for*, waits on a distribution decision that
  is the rebuild's; fixing it against an unchosen channel is the F-Droid failure one layer down. It
  blocks nothing, because the kit ships no counter.

## Out of scope

- **Rebuilding the app.** The next effort; this map produces what it starts from.
- **Loop v2's product scope** — what the app does, as distinct from how it gets built.
- **F-Droid submission and store metadata.** Not assumed to be the target at all.
- **Destroying the old remote**, and any data recovery from the test device.
- **The old repo's 24 open issues.** Findings about a codebase that will not exist. The salvage
  ticket may harvest a fact from one; none of them migrates and none earns a ticket here.
- **A pre-`git init` checklist.** Ticket 16 asked what must be true before the first commit and then
  ruled the artifact out: this repo has already missed commit zero, the cost is priced at one free
  rewrite, and a checklist for a repository that does not yet exist is written against an unchosen
  next project — the F-Droid failure one layer down, and the same ground on which 10 declined to fix a
  version cadence. The one residue that is this repo's is a sentence in 16's answer, not an artifact:
  the hook is installed before the first commit, not after it.
