# What the 106 issues were actually about, and what generated them

Type: research
Status: resolved
Ticket: `../issues/02-issue-lifecycle.md`
Harvested: 2026-09-22, from `jq-ln/loop` via `gh`, before the remote was destroyed.

**Raw evidence**: `02-issues-raw.json` in this directory — all 106 issues with full bodies, all
171 comments, labels, state, `stateReason`, `createdAt`/`closedAt`, sub-issue edges, and the
product/process classification used below. Nothing in this file needs the remote to verify.

## The shape of the tracker

| | |
|---|---|
| Issues opened | **106** (numbered #1–#107; **#68 never existed** — deleted or lost) |
| Window | 2026-09-20 04:04Z to 2026-09-22 04:42Z — **48h 38m**, not eight days |
| Closed | **82** (65 `COMPLETED`, 17 `NOT_PLANNED`) |
| Open at death | **24** |
| Author | one account (`jq-ln`) on every issue and every comment |
| Comments | 171 total; **16 issues had none**; median comment 1,901 chars |
| Body size | median **31 lines**, mean 40, max **343** (#37, the publishing map) |
| Total prose | **279 KB** of issue bodies + **388 KB** of comments = **667 KB in 48 hours** |

The repo ran 2026-09-17 to 2026-09-22 (242 commits), but the tracker only existed for the last
two days. Every rate below is a two-day rate.

## 1. Product vs process, and the trend

Classification is manual, one label per issue, recorded as `_subject` in the raw dump.
**Product** = app code, behaviour, bugs, the plugin wire, the database. **Process** = documents,
rules, the tracker itself, workflow, the repo's own publication.

**45 product / 61 process — 58% process, ratio 1.36 process per product.**

The ratio is not stable. It inverts monotonically across the tracker's life:

| Issue range | Product | Process | % process |
|---|---|---|---|
| #1–#27 | 19 | 8 | **30%** |
| #28–#54 | 12 | 15 | 56% |
| #55–#81 | 9 | 17 | 65% |
| #82–#107 | 5 | 21 | **81%** |

By creation day (local, UTC−5): 2026-09-20 was 42% process; 2026-09-21 was **73%**. The last 26
issues the repo ever filed contain **five** about the app.

**The repo's own `process` label saw none of this.** Only 11 of 106 issues ever carried it, and
#66's own re-derivation (comment, 2026-09-22T01:57Z) measured the cohort at **four** against
`docs/agents/triage-labels.md`'s definition — then used that to falsify #64's premise that process
was "drowning out the two unbuilt pillars". The label was scoped to *"about how this repo is
worked"* in the narrowest sense; by subject, process outnumbered product 61 to 45. **A taxonomy
that undercounts its own dominant category by 15× cannot be the instrument that detects the
problem.**

## 2. Provenance: the tracker fed itself

46 of 106 issues (43%) name their origin in the first lines of the body. Breaking that down:

| Origin phrasing | Count |
|---|---|
| `Part of #N` (a map's charted ticket) | 32 |
| `Found by #N's review` / `#N, round two` | 6 |
| `Found while closing/resolving/checking #N` | 5 |
| `Surfaced by #N` | 2 |
| `Raised in #N` | 1 |
| No stated origin | 60 |

**14 issues (13% of the tracker) exist because a review or close of an earlier ticket produced a
finding.** They are #62, #63, #69, #70, #71, #75, #99, #100, #102, #103, #104, #105, #106, #107
(#83 is a fifteenth, filed in the same minute #79 closed). Twelve of the fourteen are in the last
third of the tracker.

Counting bodies whose *opening sentence* cites a review or a close rather than an external
observation gives 13 more loosely (#36, #69, #70, #71, #75, #82, #85, #89, #99, #102, #103, #104,
#105).

**Chains.** Review-to-review lineage (excluding map membership):

- `#50 → #105 → #106` and `#50 → #105 → #107` — depth 3, and both leaves were still open or
  just-filed when the repo died. #50 was "Pre-flight against the decisions, then hand over the
  flip"; #105 was its review's round-two finding about commit subjects; #106 and #107 are #105's
  own findings.
- `#67 → #71 → #104` — depth 3. #67 dispositioned four inherited triage issues; #71 was found
  checking one of them; #104 was found resolving #71.
- Including the map edge, the longest lineage is **depth 4**: `#37 → #50 → #105 → #106/#107`, and
  `#64 → #67 → #71 → #104`.

**#50 is the single most generative ticket**: its review produced #103 and #105 directly, and #105
produced #106 and #107 — four issues from one ticket's review, all four about citations in text
rather than about the app.

The last four issues the repo ever filed (#104–#107) are all descendants of a review, and all four
are about text that cites issue numbers. **The tracker's terminal state was writing issues about
its own issue numbers.**

## 3. Time to close

82 closed. **Median 4.1h, mean 10.5h.**

| Band | Issues |
|---|---|
| < 1h | 25 (30%) |
| 1–4h | 16 |
| 4–12h | 13 |
| 12–24h | 10 |
| 24–48h | 18 |
| > 48h | 0 |

Percentiles: p10 0.4h, p25 0.8h, p50 3.8h, p75 14.9h, p90 27.4h. Longest-lived: #2 at 44.9h.
The 24 still open had a median age of 10.7h and a max of 34.3h — **nothing was ever old**. The
board was not a backlog of stale work; it was a high-throughput queue that outran its own drain.

The two close modes are completely different animals:

| | n | median |
|---|---|---|
| `COMPLETED` | 65 | **1.7h** |
| `NOT_PLANNED` | 17 | **21.9h** |

A completed issue closed in under two hours. A declined issue sat for nearly a day — because
almost all of them were declined in one batch, on the last day, by one ticket.

## 4. Declining: it did not exist, then it happened all at once

ADR 0073 (`docs/adr/0073-a-finding-inside-the-radius-is-fixed-not-filed.md`, settled by #91)
introduced the blast-radius damping rule and the decline path. It landed in commit `afffebb`,
**2026-09-21 19:23 −0500 = 2026-09-22T00:23Z**.

The ADR's own diagnosis: *"In two days that produced 92 issues created against 50 closed — 1.84
created per closed — with `wontfix` used zero times."* Confirmed from the tracker:

| | Before 00:23Z | After 00:23Z |
|---|---|---|
| Issues closed | 50 | 32 |
| Closed `NOT_PLANNED` | **0 (0%)** | **17 (53%)** |
| Issues created | 92 | 14 |

**Every one of the 17 declines happened in a 61-second window**, 2026-09-22T01:27:xx–01:28:xx Z —
64 minutes after the ADR landed — as #66's single ship-line triage sweep. 11 carry the `wontfix`
label (#2, #6, #7, #14, #23, #36, #53, #72, #81, #84, #85); the other 6 were declined into
`docs/ROADMAP.md` (#15, #16, #17, #70, #97, #98).

**The backlog curve** (cumulative created minus closed, by UTC hour):

```
09-20 16h  17   09-21 03h  41   09-21 17h  37   09-22 00h  45  <- peak
09-20 18h  19   09-21 04h  40   09-21 18h  32   09-22 01h  28  <- the 17 declines
09-21 01h  26   09-21 15h  35   09-21 20h  36   09-22 03h  27
09-21 02h  27   09-21 16h  37   09-21 21h  40   09-22 04h  24  <- death
```

The board **never went down for more than a few hours** in 44 hours of work, peaked at 45, and was
cut by 38% in one minute by a policy change rather than by any work. The gain-above-1 diagnosis in
ADR 0073 is correct and is visible in the data; what the data adds is that **the rule arrived with
about five hours of repo life left to validate it**. Post-rule, 14 issues were created against 32
closed (0.44 created per closed, down from 1.84) — but 4 of those 14 are the #105 cascade, so the
loop was still running at the end.

## 5. The wayfinder maps

**54 of 106 issues (51%) carry a `wayfinder:*` label.** Four maps ran.

| Label | Count |
|---|---|
| `wayfinder:grilling` | 26 |
| `wayfinder:task` | 22 |
| `wayfinder:map` | 4 |
| `wayfinder:research` | 1 |
| `wayfinder:prototype` | 1 |

Wayfinder issues closed at **74%** (40 of 54); non-wayfinder at **81%** (42 of 52). Mapped work was
not more likely to finish.

| Map | Subject | Charted | Closed | Open |
|---|---|---|---|---|
| **#20** | Plugins as separate apps, the wire | 16 | 10 | 6 |
| **#37** | Publishing loop: what a public repo may carry | 22 | **20** | 2 |
| **#64** | Shipping loop: Loop finished and on F-Droid | 11 | 8 | 3 |
| **#86** | Writing loop: what an ADR and CLAUDE.md carry | 4 | 2 | 2 |

**All four maps were still open when the repo died.** 53 distinct issues sat under a map;
including the maps themselves, **54 of 106 issues were inside a wayfinding effort**.

#64 is a *meta-map*: its sub-issues include #37, #20 and #86 — three maps nested under a fourth.
So the top-level structure was one map whose children were maps. **Two of the four maps (#37, #86)
and half of #64's own children are process subjects**; only #20 is unambiguously about the app.

The two ratios worth carrying: the grilling label (26) outnumbered the task label (22) — **more
issues existed to hold a conversation than to do work** — and exactly one issue in 106 was a
prototype (#45, the README).

## 6. How much of this existed only because the process could observe itself

Of the 61 process issues:

- **30** exist because the repo was being *published* and therefore read its own tree, history,
  commit messages, vocabulary and tracker: #13, #14, #19, #37, #38–#47, #49, #50, #54–#59, #61,
  #76, #77, #102, #103, #105, #106, #107.
- **31** exist because the repo governs itself in documents and checks: #1, #3, #4, #11, #18, #33,
  #60, #64, #66, #67, #69, #72, #74, #75, #78, #79, #82–#93, #99, #100, #101, #104.

Subtracting the four that an external party actually required — #13 (LICENSE), #14 (signing), #47
(F-Droid recipe), #61 (store copy) — leaves **57 of 106 = 54% of the tracker that exists only
because the process could observe itself.**

A tighter reading, counting only issues whose subject is a *rule, a document about rules, the
tracker, or the review gate* (the 31-issue self-governance set plus the vocabulary migrations
#41, #55, #57, #58, #59), gives **36 of 106 = 34%** as the irreducible self-observation core.

Either way: **between a third and a half of everything the project ever tracked was the project
looking at itself.** Three issues (#103, #104, #105) even carry the marker
*"This was generated by AI during triage"* — the process had begun annotating its own output as
machine-generated, in a tracker where 100% of it was.

## 7. Two details worth keeping

- **Surveys in this repo were stale on arrival.** #66's comment: *"The ticket's own figures were
  wrong in three places, which is the fourth time a survey table in this repo has been stale when
  checked."* Charted: 39 open, 23 unmapped, "roughly a dozen" process. Actual: 45, 28, 4. A ticket
  written a few hours earlier was already wrong about the board it was chartered to triage.
- **Several issue bodies were rewritten in place** (#5, #49, #107 carry explicit "rewritten"
  markers; #107 carries a "Radius expanded, by agreement" section). The tracker inherited the
  amend-in-place failure mode that `SPEC.md` was dissolved for in #1.

## What this means for the next repo

- **Cap the review-to-issue loop before the first review, not after 92 issues.** ADR 0073's damping
  rule is correct and arrived with five hours of repo life left; start with it, and start with the
  decline path, since `wontfix` was used zero times in the first 50 closes.
- **Measure subject, not label.** The `process` label counted 4 where the subject count was 61.
  Whatever the next repo's taxonomy is, run a periodic count by *what the issue is about* — the
  81%-process endgame was invisible to every instrument the repo had.
- **A tracker whose median close is 1.7h is not being used as a tracker.** Most issues were filed
  and finished inside one session; they were work notes, not a backlog. Decide deliberately whether
  a finding short of an hour's work earns an issue at all.
- **Cap the map count and forbid nesting maps under maps.** Four maps, 51% of all issues inside
  one, #64 containing three others, none finished. Grilling tickets (26) outnumbering task tickets
  (22) is the warning sign to watch for.
- **Publishing a private repo is a document-rewriting project, not a flag flip.** 30 issues — 28%
  of the tracker — came from it, and four of the last five issues were still chasing issue-number
  citations in commit text. If the next repo is public from commit one, all 30 never exist.
