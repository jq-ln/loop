# Which documented rules the history actually violated, and how soon

Type: research findings
Ticket: `.scratch/post-mortem/issues/03-rules-written-then-broken.md`
Researched: 2026-09-22

Primary source throughout: the `../old_loop` git history, read-only — 242 commits, `d1c31a8`
2026-09-14 16:13 to `0cd77ff` 2026-09-21 23:43, eight days. Every date below is the **author**
date; committer dates are unreliable here because the repository has **zero merge commits** (every
branch was rebased onto `main`, so committer dates cluster at rebase time — `9ff4676` records
exactly this trap, having mis-dated a commit by eleven minutes on the committer date).

Because there are no merges, "which branch did this land from" is not recoverable topologically.
Where a rule turns on branch discipline I use the repo's own test, the one `#102` used: a commit
whose subject carries no `#NN` ticket number had no ticket, and a ticket is what gets a worktree.

---

## The table

Latency is measured from the commit that **wrote the rule** to the commit that **first broke it**.
A negative latency means the violation was already in the tree when the rule was written — which
turns out to be the single most common shape.

| Rule | Introduced | First violation | Latency | Total violations |
|---|---|---|---|---|
| **Kotlin official style, ktlint** | `d1c31a8` 09-14 16:13 (initial commit) | the same commit — nothing checked it, and nothing did for the repo's whole life | **0 commits, 0 minutes** | **870** under the standard actually chosen; 5,493 under the one the words named. 142 files reformatted at `f490611` 09-21 15:16 |
| **Tool output does not enter the repo** (`.gitignore` is the mechanism, present from day one) | `d1c31a8` 09-14 16:13 (as `.gitignore`); written as prose at `8f9c069` 09-21 13:31 | `798b877` 09-15 18:36 — four `.kotlin/errors/*.log` compiler dumps, in a commit about Compose headers | **+1 day 2 h** from the mechanism; **−5 days 19 h** from the prose rule | 4 files, surviving ~150 commits until `8f9c069` removed them |
| **Amend the spec doc in the same commit as the code** | `d1c31a8` 09-14 16:13 | not individually attributable; the aggregate is the violation | n/a | `docs/SPEC.md` reached **2,702 lines with 62 "Amended" markers** by `7af86e6` 09-19 before being dissolved |
| **Bump the version in the same commit, not as a chore** | `8cbb181` 09-15 22:36 | **none found** | — | **0.** 60 bumping commits; `versionName` and `versionCode` never once diverged; no standalone chore bump exists. Nearest miss is `b5acfcf` 09-17 20:38, a *renumber* forced by two concurrent branches numbering independently |
| **`KeyboardCapitalization.Sentences` on every prose field** | `c199b70` 09-15 21:30 | the rule *is* the fix; the violation was reported from the device first | **negative** | written retrospectively |
| **Every permission has a `docs/PERMISSIONS.md` entry, same change** | `99b0edb` 09-16 19:25 (rule and document created together) | `6621110` 09-20 19:24 — `permission.HOST` declared in the manifest, no entry | **3 days 24 h / ~95 commits** | **2.** The second (`DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION`, 11 declared vs 10 documented) surfaced only when `#18` finally wrote a test on 09-21 21:43 |
| **ADR in the same commit as the code, never a follow-up** | `4482b71` 09-20 12:13 | `afffebb` 09-21 19:23 — three decisions landed as prose with one ADR | **1 day 7 h 10 m** | **3 decisions.** One discharged an hour later (`69c4b34`); **two still unrecorded when the repo was killed** |
| **No work on `main`; a ticket gets a worktree before its first edit** | `de106cc` 09-20 22:14:51 | `b13f463` 09-20 22:30:24 — no ticket, and it is the *next commit in the history* | **1 commit, 15 minutes 33 seconds** | **4** — `b13f463`, `4459bef`, `b8dc862`, `c00993f`. Only the last two were ever filed (as `#102`) |
| **A ticket names the files it owns and must not touch** | `03055b5` 09-21 13:01 | `#101`'s own declared-file list, amended **three times mid-ticket** (`9ff4676` calls `docs/adr/0074-*` "the third mid-ticket addition") | **~9 hours** | at least 2 tickets (`#101`, and `#101`↔`#31` colliding on `docs/adr/README.md`) |
| **A branch is reviewed before it merges** | `a55bf9a` 09-21 14:23:44 | `4256fcb` 09-21 15:52:09 — the branch that *rewrote the review rule* shows no review round | **1 h 28 m / 6 commits** | **3 of ~17** post-rule branches carry no visible review round (`#82`, `#94`, `#31`) — suggestive, not conclusive, since a clean review leaves no commit |
| **ADR numbers are never reused; a reversed ADR is deleted** | `842c9be` 09-20 16:54 | **none** | — | **0.** 0044, 0060 and 0063 are deleted and the numbers are gaps; 76 files, no duplicates |
| **Every document has an owner in the table** | `4482b71` 09-20 12:13 | `docs/DEVICE.md` was already outside the table and already wrong | **negative** | 1, fixed at `71df7e0` 09-21 11:46 |

---

## The instructive cases

### 1. The worktree rule was broken by the next commit, fifteen minutes later

`de106cc` (09-20 22:14:51) is a careful, well-argued rule. Its body explains that `#25`, `#26` and
`#27` had run as three concurrent sessions in one checkout and their uncommitted work interleaved
across five files with no extractable split. The conclusion: *one worktree per ticket, created
before the first edit.*

The very next commit in the history, `b13f463` at **22:30:24**, carries no ticket. So does
`4459bef` at 22:33 — and `4459bef` is *an edit to the worktree documentation itself*, adding a
fifth trap, made without a worktree.

This is not carelessness so much as a rule with no home for its own maintenance. Both commits are
the kind of work the ticket system had no shape for: a review sweep across an already-merged range
(`b13f463`: "Found by a two-axis review of `191ddb0..HEAD`") and a process-doc correction. The rule
said every edit needs a ticket; the repo's own `What earns an issue` policy said work like this
earns none. **Two documented rules, in direct contradiction, and the contradiction was never
noticed because each was written in its own ticket.**

### 2. The rule was eventually defeated by citing its own violations

The last no-ticket commit, `c00993f` (09-21 22:21), contains this disposition:

> Dismissed: [the finding] that the subject carries no issue number: there is no issue by design,
> and **main has precedent**.

A review raised the violation and it was dismissed on the grounds that the rule had already been
broken enough times to constitute practice. Twenty-three minutes earlier, `#101` had filed the same
observation as `#102` — so the repository simultaneously held an open issue about the violation and
a merged commit dismissing it. The rule's own erosion had become its refutation inside 24 hours.

### 3. The style rule was unenforceable for the entire life of the repository

`CLAUDE.md` said "Kotlin official style. ktlint defaults." in the **initial commit**. `f8c93e4`
(09-21 15:15), 236 commits and 6 days 23 hours later, records what that was worth:

> CLAUDE.md has named "Kotlin official style, ktlint defaults" since the repository began and
> nothing checked it: no ktlint, no detekt, no spotless, and one workflow that reads commits rather
> than code.

Worse, the sentence was **internally ambiguous**: "Kotlin official style" is JetBrains' conventions
(`intellij_idea`), "ktlint defaults" is ktlint's own stricter house style (`ktlint_official`). They
differ by **4,623 violations out of 5,493** in this codebase. The rule as written, read literally,
would have reformatted nearly every file to a standard the project never chose. A rule nothing
checks does not merely go unenforced — it goes *undisambiguated*, because nothing ever forces a
reading.

### 4. Half the rules are retrospective, and those are the ones that hold

Three of the twelve rules above have negative latency: they were written *because* the violation
had already happened.

- `KeyboardCapitalization.Sentences` — written after the device reported missing auto-capitalization.
- The tool-output rule — written in `8f9c069`, the same commit that deleted the four compiler dumps
  that had been sitting in the tree since 09-15.
- The `docs/DEVICE.md` ownership row — written after the file's paths had already gone stale.

And a fourth, the **version-bump rule**, has the best record in the repository: zero violations
across 60 bumping commits. Its body (`8cbb181`) says why: *"The versioning scheme was documented;
the habit was not, so nothing had moved while modules, a migration and a changed package landed."*
It was written against a failure that had already happened, and it names a mechanical artifact the
commit must touch — a number in `app/build.gradle.kts`. **The rules written from a live wound, and
attached to an object the work has to touch anyway, are the ones that held.** The rules written
prospectively from principle (ktlint, spec amendment, ADR timing) are the ones with the worst
records.

### 5. Mechanical checks landed on the last day, and immediately found violations

Two checks were built in the final twelve hours of the repo's life, and both found existing
violations the moment they ran:

- `ManifestPermissionsTest` (`c9fb359`, 09-21 21:43) found the merged manifest declaring **eleven**
  permissions against a table of **ten**. The rule "no entry, no permission" had been stated in four
  documents and argued in an ADR, *and nothing failed if it stopped being true*.
- The `pre-push` hook (`8f5ac62`, 09-21 14:03) was written to catch "the arrivals that have actually
  happened here" — the compiler dumps and the address a history rewrite removed. Its own comments
  concede that the half of the rule that matters most "is invisible to any grep".

The permissions test body carries the sharpest line in the corpus about why documented rules rot:

> A transitive dependency adds the permission, the build succeeds, the suite stays green, and
> F-Droid rejects the submission weeks later.

### 6. The ADR-timing rule was broken by a process ticket, and the debt outlived the repo

`4482b71` established "same commit as the code, never a follow-up" for ADRs on 09-20 12:13. On
09-21 19:23, `afffebb` — a ticket whose entire subject is *writing rules into the documents that own
them* — landed three decisions with one ADR. The review caught it twenty minutes later
(`78ade44`), and correctly declined to fix it in place because the finding fell outside the
ticket's declared files. So it became `#99`.

One of the three was discharged an hour later (`69c4b34`, ADR 0074). **Two were still unrecorded
when the repository was killed.** The file-ownership rule (`03055b5`, written six hours earlier)
and the ADR-timing rule are in direct tension: the first forbids editing a file your ticket did not
declare, the second requires the ADR to ride along with the code. `cdcd208` names the trade
explicitly, choosing the ADR rule over the collision rule in that instance — but the choice was made
per-incident by an agent mid-review, not by either document.

---

## Two caveats on the measurement

1. **"No work on main" is measured by proxy.** With zero merge commits, the only available test is
   the absence of a ticket number in the subject — which is the same test `#102` used. It can
   over-count (a ticketed branch whose commit subject omits the number) and under-count (a commit
   made directly on `main` that happens to cite a ticket). The four hits are all corroborated by
   their bodies, which describe unticketed follow-up work.
2. **"Reviewed before it merges" can only be falsified weakly.** A review that finds nothing leaves
   no trace. The three branches with no visible round (`#82`, `#94`, `#31`) may have been reviewed
   cleanly. What is certain is that the rule shipped with no artifact proving it ran — which is the
   same defect the permissions rule had until a test was written for it.

---

## What this means for the next repo

- **A rule with no mechanical check is a wish.** ktlint went 236 commits unenforced *and*
  unambiguous-only-in-retrospect; the permissions rule was stated in four places and verified in
  none. If a rule cannot be attached to something that fails, do not write it — write the check or
  drop the claim.
- **Write rules from wounds, not from principle.** The one rule with a perfect record (version
  bumps) was written against a failure that had already happened and named an artifact the commit
  must touch. The prospective rules have the worst records.
- **A rule about process needs a home for its own maintenance.** "Every edit needs a ticket" and
  "this kind of work earns no ticket" were both true in `old_loop`, and the contradiction was
  resolved by erosion — ending in a commit that dismissed a review finding because "main has
  precedent."
- **Measure latency on every new rule and treat a short one as a design fault.** Fifteen minutes and
  one commit is not a discipline failure; it is the rule telling you it does not fit the work.
- **Rules must be checkable against each other, not only against the code.** The ADR-timing rule and
  the file-ownership rule collided within six hours of both being written, and the collision was
  settled ad hoc by an agent mid-review. One document holding all the process rules would at least
  have made the conflict visible on the page.
