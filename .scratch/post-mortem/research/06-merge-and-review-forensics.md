# Collisions, version confusion, and extra review rounds under the worktree model

Type: research finding
Ticket: `.scratch/post-mortem/issues/06-merge-and-review-forensics.md`
Evidence: `../old_loop` git history (242 commits, 2026-09-14 → 2026-09-22), `jq-ln/loop` tracker
(106 issues, 171 comments, harvested 2026-09-22 before the remote was destroyed), `CLAUDE.md`,
`docs/agents/issue-tracker.md`, `docs/adr/`.

## How the evidence was read, and what it cannot say

The repository has **zero merge commits** (`git log --merges` → 0) and no tags. Every branch landed
by `git merge --ff-only` after a rebase, so branch boundaries are not recorded anywhere in the DAG.
They were reconstructed from two signals that *are* recorded:

- **`#<n>` commit subjects.** The convention starts at `b833c6f` (2026-09-20 19:10). Everything
  before that is unattributable to a ticket — 154 of 242 commits carry no number.
- **Committer date ≠ author date.** 69 commits were rewritten after they were authored; a shared
  committer timestamp across several commits is one rebase, i.e. one branch's landing.

A branch is therefore taken as *the set of `#n` commits*, its lifetime as *[earliest author date,
latest committer date]*. Two branches are "concurrent" when those intervals overlap. Resolution
comments corroborate this reconstruction in every case where they name a base SHA.

**The load-bearing caveat for everything below.** The protocol under investigation was written in
the last ~36 hours of the repository's life: `#60`'s sixth trap at `03055b5` (09-21 13:01), `#75`'s
single *Finishing a ticket* sequence at `68b9739`, `#78`'s review step at `a55bf9a` (14:23), `#82`'s
covered test merged at `4256fcb` (19:27), `#91`'s blast-radius rule at `afffebb`. Forty-one commits
exist after the covered test landed. **The worktree/review model was never observed steady-state**;
what follows measures the four days in which it was being invented while running.

---

## Symptom 1 — Collisions that survived the worktree model

### Measurement

Post-worktree (after 2026-09-20 19:00) there are **41 tickets with merged commits**. Reconstructing
their lifetimes and intersecting their file sets gives **14 pairs of concurrent branches that both
wrote the same file**. The shared files, ranked:

| Shared file | Concurrent pairs | Distinct tickets that wrote it in 2 days |
|---|---|---|
| `CHANGELOG.md` | 7 | 12 (#5, #20, #22, #31, #35, #48, #49, #50, #51, #55, #57, #94) |
| `app/build.gradle.kts` | 6 | 9 (#5, #18, #20, #22, #31, #35, #48, #51, #94) |
| `CLAUDE.md` | 5 | 13 (#8, #20, #46, #50, #51, #56, #60, #61, #65, #78, #79, #82, #91) |
| everything else | 1 each | `MainActivity.kt`, `docs/ACTION_VOCAB.md`, `docs/BUILD.md`, `docs/PLUGINS.md`, `docs/agents/issue-tracker.md`, `PluginHostTest.kt`, `SettingsScreen.kt`, `docs/adr/README.md` |

Two of the fourteen became real, recorded conflicts:

- **#22 vs #5**: *"before and after the rebase that resolved a `CHANGELOG.md` and `versionCode`
  conflict against #5"* (#22 resolution, `94d4d1a`).
- **#5 vs #31**: `PluginHostTest.kt` carried a wire-version fixture #31 moved to `3.0.0` while
  `loop-5` held an uncommitted edit to the same file. #31's body saw it coming and answered it with
  a `blocked_by` edge; #5's resolution records *"One file moved under this branch."*

### How accurate were the declared owned / must-not-touch lists?

`CLAUDE.md` Workflow and `docs/agents/issue-tracker.md` *One worktree per ticket* both require a
ticket to name the files it owns and the files it must not touch.

**Ten of the 41 post-worktree tickets (24%) actually carry a `## Not this ticket` section naming
files** — #31, #55, #66, #75, #76, #78, #79, #82, #91, #101. Of the ten, seven name specific paths;
the other three name only scope.

**Where a list existed, it held.** Comparing each declared-off-limits path against the files that
ticket's merged commits actually touched produces **zero file-level violations** once the regex's
false positives (paths named as *owned* in the same section, and `docs/adr/README.md` matching a
bare `README.md`) are removed by reading the sections. #55's declaration —
*"**The two tickets must not touch the same file**, so leave all four of `CLAUDE.md`'s device lines
alone"* — is honoured exactly: `docs/DEVICE.md` and `CLAUDE.md` were *"never opened"* (#55
resolution, `8db2f21`).

So the declared list is not inaccurate. **It is unpopulated, degraded, and mis-scoped**, three
separate failures:

1. **Unpopulated.** 31 of 41 tickets declared nothing. The rule was written on 2026-09-21 (#60 →
   `03055b5`), so most tickets predate it — but even after it landed, tickets charted without the
   section kept merging.
2. **Degraded from exclusive ownership to region-sharing.** #55's rule was *files must not overlap*.
   By #82 it reads *"This ticket touches **only the Workflow bullet** [of `CLAUDE.md`] and must
   leave every other line of that file alone"*, and #91 states the degradation as precedent:
   *"#55 and #56 are the precedent for two tickets sharing a file by declaring their halves."*
   A region claim is prose. Git enforces files; nothing enforces paragraphs.
3. **Mis-scoped: the radius moves during the ticket.** #101's body records its declared list being
   widened **three times mid-ticket**, each time by the author's answer to a review round, with an
   explicit rider that *"it is not a precedent"*. A list fixed at charting time cannot survive a
   review loop that discovers new files.

### The mechanism

**A worktree isolates code; it cannot isolate a registry.** The three files at the top of the
collision table are not code and not owned by any ticket — they are *append points for a global
counter or a global index*:

- `app/build.gradle.kts` holds the next `versionCode`/`versionName`.
- `CHANGELOG.md` holds the next release heading.
- `CLAUDE.md` holds the ownership table, i.e. the index of who owns what.

Every ticket that ships behaviour **must** write the first two, and every ticket that changes a rule
must write the third. No `## Not this ticket` section can exclude them, because there is no ticket
for which they are somebody else's. The repo felt this and invented a sequencing rule rather than an
ownership rule — *"Numbers follow merge order, not start order… taken at the rebase"*
(`issue-tracker.md`) — which converts a merge conflict into a serialization point but does nothing
about the textual conflict in `CHANGELOG.md` and `build.gradle.kts` that #22 hit anyway.

**Secondary mechanism: the declaration is written at charting time and consumed at merge time**,
with a review loop in between that is licensed to expand scope. The blast-radius rule (#91, ADR
0073) deliberately made the same list do two jobs — *decide what earns an issue* **and** *prevent
collisions* — so every pressure to widen the radius for the first purpose weakens it for the second.
#101 is that trade firing three times in one ticket.

**Tertiary: collisions are discovered at rebase, not at edit.** `#60`'s own body describes
`loop-48` sitting live, two commits behind, holding an edit to `docs/PERMISSIONS.md` that #55 had
already changed underneath it, with *"nothing warned either session, and nothing will until somebody
rebases"*. The one-checkout regime announced a collision loudly and immediately; the worktree regime
made it silent and deferred it to the least convenient moment. The fix shipped (step 3 of *Finishing
a ticket*, `--ff-only` as backstop) is **detection at merge**, not **prevention at claim**.

---

## Symptom 2 — Versioning confusion

### What was actually being counted

Eight independent counters were live or recently live, under **three incompatible semantic
regimes**:

| Counter | Where | Regime |
|---|---|---|
| `versionName` | `app/build.gradle.kts` | inverted pre-1.0 semver (breaking → *minor*) |
| `versionCode` | `app/build.gradle.kts` | monotonic, must increase per published build |
| `Wire.VERSION` | `core-api/.../WireDeclaration.kt:99` (now `3.0.0`) | **ordinary** semver (breaking → major), ADR 0055 |
| `PluginManifest.version` | `core-api/.../PluginManifest.kt:26` | each plugin's own, external |
| Room `version` | `core-data/.../AppDatabase.kt:44` (`13`) | plain index |
| `RoutineBackup.FORMAT_VERSION` | `core-data/.../RoutineBackup.kt:19` | discriminator |
| ADR number | `docs/adr/NNNN-*.md` (to 0078) | monotonic, never reused, never re-pointed |
| `LoopApi.VERSION` | deleted by #51 | ordinary semver; vestigial by the end |

`CLAUDE.md` Versioning explicitly warns *"it inverts the usual intuition, so do not reason about it
from memory"* and carries a four-row bump table. That warning is itself the evidence: the scheme was
known to be unmemorable while it was in force.

### Every instance found

**Real allocation collisions (the one-checkout era, and the reason the merge-order rule exists).**
#25, #26 and #27 ran concurrently and each guessed a version at start. The human owner had to assign
numbers by hand, twice:

- #25: *"Version 0.14.2 — the owner assigned this branch the first bump of the three in flight."*
  Later, same ticket: *"Version renumbered to **0.14.4 / code 48** — #27 took 0.14.2 and #26 took
  0.14.3."*
- #26: *"The owner set the merge order #25, #26, #27 this session, so this branch is **0.14.3 /
  versionCode 47**, not 0.14.2 — that belongs to #25."*

**A textual conflict on the version line.** #22 vs #5, `94d4d1a` — `CHANGELOG.md` and `versionCode`.

**An ADR-number race, flagged in advance and won by a third ticket.** #51's body: *"Take the number
at merge — #48 is racing for 0066."* Neither got it: #13 merged 0066 at `2bb7201`, #49 took 0067,
#48 took 0068, #51 took 0069. The merge-order rule held — ADR adds are strictly monotone in
committer date across 0060–0078 — but only because a human refereed.

**Version facts written into prose, invalidated by concurrent merges.**
- #61: *"`metadata/dev.jqln.loop.yml`'s note was stale twice. #47 wrote it correct and two later
  tickets invalidated it: it claimed *'The app is at 0.14.5 / 49'* against an actual 0.16.0 / 51."*
- #45's triage table: `Status: 0.14.5` → actual `0.16.0`, cause given as *"Three version bumps
  merged while the branch waited."*
- #65: `CLAUDE.md`'s whole "MVP scope (current)" section was framed by *"0.1"*, a dead scope fence,
  while the app shipped 0.15.0 — *"a stranger reading `CLAUDE.md` on the public repo reads '0.1' as
  the version and concludes the changelog is lying."*
- #24 on the device: About showed `Plugin API 0.4.4` while `LoopApi.VERSION` was 0.5.0 (#29) and
  gating nothing.

**A bump that violated "bump in the same commit".** #31 round one, fixed on the branch: *"the
version bump sitting in its own commit (squashed, per *bump in the same commit as the change*)"*.

**The version edit that defeated the review gate.** #82 round four found a path that
*"**Merges unreviewed via a version-number edit** — amending left no new commit, no rebase, no test.
'no new commits of your own' was the wrong test in a repo that amends."* The version rule and the
review rule were in direct mechanical conflict: step 3 takes the number *after* the rebase and
*before* the review, so taking it is an edit to an already-reviewed branch.

**The dominant cost is not error — it is adjudication.** **18 of the 106 issues spend a paragraph of
their resolution comment arguing that *no* version bump is owed**, almost always by citing
precedent rather than the rule: #55 cites #13 and #47; #56 cites #13 and #47; #57 cites #55 and #56;
#58 cites #55, #56 and #57; #75 cites #74; #76 cites #58; #103 cites #44. That is a precedent chain
seven deep for the question *does a doc change bump anything*, which `CLAUDE.md`'s table already
answers with the word "nothing". #20 spends a whole headed section, *"## No version bump,
deliberately"*, on the same question.

### The mechanism

**Three regimes × eight counters × a rule that forbids deferring the decision.** "Bump in the same
commit as the change, not as a separate chore" makes the version an *input* to every commit, so
every ticket must classify its own change against a table whose top row is deliberately
counter-intuitive. The classification is cheap when the answer is a bump and expensive when it is
not — there is no artifact recording "nothing moved", so the reasoning is re-derived and re-argued
every time, and the only durable record is a resolution comment that the next ticket then cites as
precedent. **A rule with no null artifact grows a case law.**

**And the allocation problem is structural, not a discipline problem.** Four of the eight counters
are monotone global allocations (`versionCode`, `versionName`, ADR number, issue number). Several
concurrent branches cannot allocate from a monotone counter without either a lock or a referee. The
repo chose a referee ("the owner set the merge order") and then a convention ("take the number at
the rebase"), which works, but pushes the allocation into the *narrowest* window in the process —
between rebase and merge, which is exactly where the review gate also sits.

---

## Symptom 3 — Review rounds

### Measurement

Nine tickets ran a multi-round review; the resolution comments record every round and every finding.

| Ticket | Rounds | Findings | Rounds attributable to `main` moving |
|---|---|---|---|
| #82 | 6 | 39 (37 fixed, 7 dismissed, 1 filed) | 0 |
| #101 | 6 | 24 (21 fixed, 2 dismissed, 1 filed) | 0 |
| #5 | 4 | 16 | 0 |
| #106 | 3 | 10 | 0 |
| #94 | 3 | 13 (11 fixed, 2 dismissed) | 0 |
| #78 | 3+ | 16 (12 fixed) | 0 |
| #91 | 2 | 19 | **1 (round two)** |
| #103 | 2 | 4 | 0 |
| #50 | 2 | — | 0 (main moved 3×; rebases did not reopen) |
| #31 | 2 | 10 | 0 |

**Only one round in the whole corpus is caused by `main` moving**, and it is stated outright:

> Round two, eight findings, and it exists because **#82 merged while the human was answering round
> one**. — #91 resolution, `ed3d229`

Its findings are genuinely caused by that merge: #82 falsified *"a review runs on every branch"* in
two places, and #82's own closure changed a count #91 asserted. So the round was both
rebase-induced **and** substantive; the branch really had become false.

The two clean counter-examples show the covered test doing its job as soon as it existed:

- **#103**: *"`main` moved twice while the rounds were open (#5, then #22); the branch rebased onto
  each and neither touched this file, so the reviewed lines never moved."* Two rebases, zero extra
  rounds.
- **#50**: *"`main` moved three times underneath them (#71, #101, and #101 again), so the branch
  rebased"* — and still only two rounds, both from findings.

### Where the rounds actually come from

Reading the finding lists rather than counting them gives three generators, none of which is `main`:

1. **A fix reopens a round, by rule.** *"changes made in response re-run the review and open a fresh
   one"*, and *"A clean review still stops for them."* So the minimum cost of any finding is one
   extra round, and the loop terminates only when a round finds nothing **and** the human answers.
   #101 round six and #106 round three are each a whole round that found ≤1 thing.
2. **Fixes regress.** #101's arc is the clearest: round three found *"the length finding
   **regressed** rather than fixed, 503 → 1023"*; round five found *"the cut had gone too far,
   leaving the charting obligation only in the ADR"*; round six put back what round five removed.
   Four of six rounds were spent on the consequences of earlier rounds — and the standard being
   enforced (a 634-column ceiling) **was not a documented standard at all**: *"`.editorconfig` scopes
   `max_line_length` to `[*.{kt,kts}]` and no markdown width is documented anywhere in this repo.
   That mis-framing is what traded the charting clause away in round five."*
3. **The reviewed surface is prose, and prose about the change is outside the reviewed diff.**
   #94: *"Three of the four round-two findings were errors in prose written *about* the change
   rather than in the change; the code and tests came through every round unchanged on substance."*
   #106 rounds two and three are **entirely** commit-message findings, fixed by `--amend`. The
   covered test explicitly cannot see these: *"a commit message is not in a diff, so a message-only
   `--amend` and an empty commit both compare equal."* An unbounded, unversioned artifact was being
   reviewed with no coverage test and no stopping rule.

#82 is the one ticket whose rounds were unambiguously worth their cost — four of its six rounds each
found a *different* path by which content merged unread (the guard keyed on "did you rebase"; a
version-number amend; `diff.context=0` from global config; a `-diff` attribute from
`core.attributesFile` or per-worktree `.git/info/attributes`). Those were found *by running the
command under hostile configuration in throwaway repositories*, not by reading.

### The mechanism

**The gate's own latency is the window, and the gate was built to close a window it also opens.**
#82 names this exactly: *"The round-trip is exactly the window in which `main` moves — the gate's own
latency is what opens it."* The human sits in the loop with no SLA; `main` keeps merging; the branch
must rebase; a rebase before the review is fine and a rebase after it merges a diff nobody read. The
covered test (normalised three-dot diff hashed) is a genuinely good invariant and it *works* — but
it was merged at 19:27 on the repo's last full day and governed 41 commits.

**The deeper mechanism is that the loop has no agent-side exit and no cost model.** *"The agent never
decides that a round is over"* and *"A clean review still stops for them"* are both deliberate (ADR
0071, argued from the observation that any exemption becomes the cheapest route to a merge). The
consequence is that round count is set by the *reviewer's* appetite, and on a doc-heavy repo where
the reviewed artifact is prose, appetite is unbounded: 24 findings on a branch that changed five
markdown files, six rounds, and the standard being enforced in three of them was invented. The human
closed the loop early on #106 and #91 — the only brake that exists.

---

## What this means for the next repo

- **Isolate the registries, don't declare them.** `CHANGELOG.md`, the version line and any ownership
  index are contended by construction; a per-ticket file-ownership list can never exclude them. Make
  them derived at release (from commits/tickets) or append-only per-ticket fragments, so two branches
  never edit the same line.
- **One counter, or make every counter derivable.** Eight counters under three semver regimes cost
  hand-refereed allocation, a stale version in four documents, and a review hole. Pick one
  human-facing version, derive the rest, and never write a version number into prose.
- **Every rule needs a null artifact.** "No bump was owed" was argued 18 times by a seven-deep
  precedent chain because there was nowhere to record *nothing moved*. Make the not-doing cheap and
  recorded, or the rule grows case law.
- **Give the review loop an explicit cost model and a stopping rule**: a bounded round budget, a
  named standard for every finding (#101 spent three rounds enforcing a line width no file
  documented), and an agent-side "nothing found, twice" exit that the human can override rather than
  must supply.
- **Keep the covered test; extend it to the commit message.** The normalised-diff hash is the one
  mechanism here that provably prevented rounds (#103, #50) — but the message is outside it, and
  message-only findings generated whole rounds in #94 and #106.
