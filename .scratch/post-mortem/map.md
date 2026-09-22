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
- [Was it the process, or was it the scope?](issues/09-process-or-scope.md): neither — three layers, not a weighting. Root: no destination existed to check anything against. Proximate: breadth outran comprehension. Third-order: the process volume, a real triage that became its own load. Outputs the comprehension criterion, ordered before 03's latency test; re-charters 12, 17 and 18, and makes 15 block every ticket that writes a rule (10, 11, 12, 13, 17).
- [The goals document, and the citation rule that gives it teeth](issues/15-the-goals-document.md): two goals governing two objects — the app (G1, used every day) and the repository (G2, legible to people who might hire or build with me) — with the tie-break that would have killed F-Droid on day one; a goal is citable only if it can rule a decision out, and every ADR names the goal *and what it ruled out*; goal ids never reused, deletion carries a `grep` re-check list; `GOALS.md` ≤ 40 lines, written verbatim, edited only by the human in a commit touching nothing else.
- [The human's own procedure](issues/17-the-humans-own-procedure.md): where a commitment can become a step in a command already run, it stops being a commitment — a comprehension gate at the merge (nothing lands unread), with the merge as the act no agent may perform; the pace gap made visible as unmerged worktrees, capped at three in `pre-commit`; a 300-line commit cap with an `Oversized:` trailer and a branch conformance check against its declared file list; review once per branch inside `just land`, an input to the human's reading and never a pass/fail; and `PROCEDURE.md` ≤ 60 lines that indexes mechanisms rather than restating them, with three clauses labelled as resting on nothing.
- [The budget, and what enforces it](issues/11-the-documentation-budget.md): the budgeted quantity is **file count**, not length — 12 standing-claim files (root `*.md`, `docs/**.md`, `.claude/**.md`), the kit landing with 9, `.scratch/` and the justfile outside the perimeter and no standing rule allowed to hide there; enforced in `pre-commit` on the commit that adds the file, and when the cap is reached **the document is not written** — its claim folds into the file that already owns it, with the cap a knob only the human turns; no document asserts a structural fact the source asserts about itself, and backticked paths must resolve; ADRs are exempt **conditional on being leaves** — nothing cites an ADR, found by `just adr <term>`, superseded ones deleted — with ticket 19 holding the final say.

## Not yet specified

- **The null artifact.** Ticket 06 found 18 issues arguing that no version bump was owed, via a
  precedent chain seven deep, because the rule had no way to record a considered "nothing". Likely
  a general principle for every rule in the kit, but not yet sharp enough to ticket. Ticket 17
  applied the shape twice without generalising it — an `Oversized:` commit trailer, and stray paths
  recorded in the merge commit — so the pattern now has worked instances as well as a failure.
  Its sharpest instance is still a bullet inside ticket 19: does a rejected ADR leave a trace?
- **Global registries** — a changelog, a version, an index — that no worktree can isolate and no
  ticket can declare off-limits. Ticket 10 must answer it for this repo; whether the answer
  generalises into a rule about derived-versus-stored state is fog.
- **What replaces the salvaged conclusions' provenance** once `../old_loop` is a local-only
  archive with no reachable issue URLs.

## Out of scope

- **Rebuilding the app.** The next effort; this map produces what it starts from.
- **Loop v2's product scope** — what the app does, as distinct from how it gets built.
- **F-Droid submission and store metadata.** Not assumed to be the target at all.
- **Destroying the old remote**, and any data recovery from the test device.
- **The old repo's 24 open issues.** Findings about a codebase that will not exist. The salvage
  ticket may harvest a fact from one; none of them migrates and none earns a ticket here.
