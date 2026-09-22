# Post-mortem: what the first Loop repo taught, and what this one starts from

Type: wayfinder:map

## Destination

A **seed kit** committed to this repo — the process documents, protocols and constraints Loop v2
starts its first day of real work with — produced by a post-mortem of the first Loop repo
(`../old_loop`, 242 commits over eight days, killed 2026-09-22). The findings are the route; the
committed files are the destination. The map is done when someone can begin building the app with
nothing left to decide about *how* the work runs.

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
- Documents are lean. Length correlates negatively with adherence; ticket 07 establishes how
  strongly and against what sources, and ticket 11 turns that into an enforced budget.
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
- [Where 242 commits of effort actually went](issues/05-where-the-time-went.md): process work tripled after the code stopped growing, so it is a second disease rather than a symptom; the driver is file count and reference density, not length.
- [Collisions, version confusion, and extra review rounds](issues/06-merge-and-review-forensics.md): collisions are global registries a worktree cannot isolate; versioning's cost is adjudication not error; review rounds are mostly not caused by `main` moving.
- [What the evidence actually says about document length and adherence](issues/07-doc-length-and-adherence.md): the 200-line figure is published guidance but unmeasured, and the papers usually cited measure retrieval accuracy rather than adherence; dilution and conflict are the better-evidenced defect.
- [Why it became unsalvageable](issues/08-the-terminal-account.md): unwieldiness the author could no longer account for, then two blows — a personal-information scrub for a publication that never happened, and F-Droid recognised as arbitrary after it had propagated four ADRs into the architecture; the process explosion was triage started too late, not a second disease; the structural cause is that no goals document existed and the ownership table had no row for one. All seven findings survive the counterfactual filter; forced to three, the kit carries 03, 05 and 02.

## Not yet specified

- **The kit's structure**: which files day one gets, what each owns, and how ownership is
  expressed. Ticket 04 found the ownership table asserting three things the code contradicts, so
  the mechanism is now suspect as well as the volume. Sharpened by 08: the table's one structural
  omission — no row for the project's goals — is the omission that killed the repo, and the goals
  file now outranks the table (ticket 15). The kit also has a **human-facing half** (ticket 17)
  that none of the research findings touch.
- **Whether this repo keeps an ADR practice at all**, and if so what earns one. Sharpened by 04:
  the old repo's 75 ADRs were bulk-extracted from one file in two days, so the practice the rule
  described never actually ran and has not in fact been tried. Narrowed by 08, which decided that
  *if* ADRs exist each must cite the goal it serves — so the live question is what earns one, and
  whether "cites a goal" is itself the bar.
- **The null artifact.** Ticket 06 found 18 issues arguing that no version bump was owed, via a
  precedent chain seven deep, because the rule had no way to record a considered "nothing". Likely
  a general principle for every rule in the kit, but not yet sharp enough to ticket.
- **What the review actually reads.** Ticket 06 found the reviewed artifact drifting to prose
  *about* the change — commit messages — outside any declared file list. Adjacent to ticket 10 and
  probably its own question once 10 lands.
- **Global registries** — a changelog, a version, an index — that no worktree can isolate and no
  ticket can declare off-limits. Ticket 10 must answer it for this repo; whether the answer
  generalises into a rule about derived-versus-stored state is fog.
- **What replaces the salvaged conclusions' provenance** once `../old_loop` is a local-only
  archive with no reachable issue URLs.
- **How agent output outpaces human reading.** Ticket 08 found an author who could not account for
  their own system — three documents asserting a `:core-api` type that was an 8-line enum. Ticket 17
  asks what the human commits to; whether the general rule is a rate limit, a comprehension gate or
  a scheduled debt is not yet sharp.

## Out of scope

- **Rebuilding the app.** The next effort; this map produces what it starts from.
- **Loop v2's product scope** — what the app does, as distinct from how it gets built.
- **F-Droid submission and store metadata.** Not assumed to be the target at all.
- **Destroying the old remote**, and any data recovery from the test device.
- **The old repo's 24 open issues.** Findings about a codebase that will not exist. The salvage
  ticket may harvest a fact from one; none of them migrates and none earns a ticket here.
