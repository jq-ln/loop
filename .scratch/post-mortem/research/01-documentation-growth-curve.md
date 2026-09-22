# The documentation growth curve, and why the correction did not hold

Research findings for `.scratch/post-mortem/issues/01-documentation-growth-curve.md`.
Evidence: `../old_loop` at `0cd77ff`, 242 commits, 2026-09-14 to 2026-09-21.
All line counts are `wc -l`; all per-commit deltas are `git log --numstat -- '*.md'`.
History is linear (`git rev-list --merges --count HEAD` = 0), so numstat sums exactly.

**Method note.** Summing numstat over all 225 commits that touch Markdown gives 8,197; `wc -l` at
HEAD gives 8,191. The 6-line gap is exactly the 6 ADR files that end without a trailing newline
(`0028`–`0033`). Both numbers are right; the curve below uses the numstat running total.

---

## 1. The curve

End-of-day total Markdown lines, by committer date. (2026-09-18 has no commits at its committer
date — the two commits authored that day were rebased forward, which is itself a finding: author
dates in this repo are not a reliable timeline.)

| Date | Total md lines | Δ | What the day was |
|---|---:|---:|---|
| 09-14 | 1,738 | +1,738 | Initial import + first day of product work |
| 09-15 | 2,795 | +1,057 | Rename to Loop; ARCHITECTURE.md rewritten; first plugin |
| 09-16 | 4,355 | +1,560 | Second plugin, check-ins, Track; CHANGELOG starts compounding |
| 09-17 | 5,522 | +1,167 | Audio/recording features; 19 CHANGELOG-only commits |
| 09-19 | 7,280 | +1,758 | Tallies, journal, Review pillar; **CLAUDE.md cut 874→199** |
| 09-20 | 6,721 | **−559** | **SPEC.md dissolved into 51 ADRs**; ARCHITECTURE.md deleted; both plugins extracted |
| 09-21 | 8,197 | +1,476 | Process work: the tracker, the review loop, 13 ADRs, 0 product features documented |

**09-20 is the only net-negative day in the repo's life.** It is also the only day on which a
deliberate documentation correction ran to completion.

### Composition at HEAD (8,191 lines / 90,021 words)

| Bucket | Lines | Share |
|---|---:|---:|
| `CHANGELOG.md` | 2,631 | 32% |
| `docs/adr/` (76 ADRs + README) | 1,774 | 22% |
| `docs/*.md` (reference docs) | 1,807 | 22% |
| `docs/plugin/` | 650 | 8% |
| root (`README`, `CONTEXT`, `DEPENDENCIES`, …) | 576 | 7% |
| `docs/agents/` | 506 | 6% |
| `CLAUDE.md` | 247 | 3% |

Kotlin at HEAD is 43,488 lines, so the repo carries **one line of Markdown per 5.3 lines of
Kotlin**. `CHANGELOG.md` alone — append-only, never trimmed, 66 → 2,631 lines across 101 revisions —
is one third of the "documentation problem" and was never a target of any correction.

### The commits that added the most

| SHA | Lines net | Responding to |
|---|---:|---|
| `d1c31a8` | +1,356 | Initial import (baseline, not growth) |
| `51e97a4` | +680 | **A decision**: publishing the plugin wire (`docs/plugin/`, 650 lines, 4 new docs + 2 ADRs) |
| `e18b3bc` | +342 | A feature: the Dual N-Back plugin — **deleted in full 27 hours later** (`e46fb47`, −281) |
| `ea12bc2` | +241 | A rename (Loop), rippling through every doc |
| `abfbaa8` | +224 | A release (CHANGELOG + docs for 0.7.2) |
| `3d8c989` | +203 | **A finding**: "Make ARCHITECTURE.md describe the app that exists" — the doc had drifted |
| `7af86e6` | +193 | A release (0.13.0) |
| `2b6fcf3` | +158 | **A finding**: the CLAUDE.md cut (939 added / 781 removed across all md) |
| `c913e6f` | +155 | A decision: `CONTEXT.md` created |
| `afffebb` | +152 | **A review round**: #91 writing three rules into three documents |

The largest *removals* are all one event: the SPEC dissolution of 09-20 11:03–12:13
(`201b0c9`, `3b116bf`, `e85f36b`, `41a5e32`, `2b5a06b`, `6b1498d`, `be35e54`, `0d5b7b8`,
`4482b71`) plus `cc4d5a9` (ARCHITECTURE.md deleted, −541, "it was lying in six places") and
`e46fb47` (a whole plugin's docs leave, −281).

**The pattern in the top-10 adds:** three are releases, two are findings that a document had gone
false, two are decisions being recorded, one is a feature later deleted, one is a review round.
Nothing in the top ten is speculative or unprompted. Every large addition was a response to
something.

---

## 2. The ADRs — issue #87 verified, and its diagnosis corrected

#87's arithmetic is **almost exactly right**:

| Cohort | n | Lines min–max | Median lines | Median words |
|---|---:|---|---:|---:|
| 0001–0059 | 58 | 9–29 | 14 | 133 |
| 0061–0072 | **11** | 22–86 | 47 | 558 |
| 0073–0078 (after #87 was filed) | 6 | 29–74 | 47 | 608 |

Ratio: **3.36× on lines, 4.18× on words.** #87's title claim ("four times the length") holds on
words. Its stated ranges (9–29 / 22–86), medians (14 / 47) and per-ADR figures (0070 = 86 lines;
it says 1,112 words, `wc -w` says 1,115) all check out.

**Three corrections.**

1. **"Twelve consecutive ADRs" is eleven.** 0061–0072 is twelve *numbers*, but `0063`
   (`a7ccece`, 09-21 11:59) and `0060` (`7ad1de8`, 09-21 11:17) were deleted and replaced by 0068
   and 0067 before #87 was written. Eleven files exist. The repo's own rule — numbers are never
   reused — makes number-counting wrong, and #86 inherited the error ("the twelve long ADRs").

2. **The break at 0061 is not a drift, and #87's framing of it as one sends the analysis in the
   wrong direction.** ADRs 0001–0051 were not written as the decisions were made. `git log
   --diff-filter=A` shows **all 51 of them were created on 2026-09-20 between 11:17 and 12:11**, in
   nine commits, as the extraction product of SPEC.md's dissolution (`3b116bf`, `e85f36b`,
   `41a5e32`, `2b5a06b`, `6b1498d`, `be35e54`). 0052–0059 followed at 16:43 (`0012507`), also in
   bulk. The short cohort is short because it is *summary of already-settled text written 51 at a
   time*; the long cohort is long because from `51e97a4` (09-20 17:39) onwards an ADR was written
   one at a time, in the same commit as the decision, by an agent arguing a live question. Those
   are two different production processes, not one process degrading. Any rule derived from "the
   drift begins at 0061" is fitting a curve to a change of method.

3. **The step did not stop when it was noticed.** #87 and map #86 were filed at 21:04 on 09-21.
   ADRs `0074` (20:39), `0075` (21:58), `0076` (22:19), `0077` (22:43) and `0078` (23:43) followed;
   the six post-#87 ADRs have the same median length (47) as the cohort #87 objected to, and
   `0078` is 74 lines / 971 words — the second-longest ADR in the repo, written two hours after the
   ticket that called the length a bug.

**What the long ADRs are about.** Of the 17 ADRs numbered 0061+, **10 are about the process of
working** (0066 licence, 0067 history rewrite, 0070 substitution test, 0071 review gate, 0072
ktlint baseline, 0073 finding radius, 0074 ship line, 0075 anchor, 0077 parking, 0078 subject
citing a deleted issue) and 7 about the product. **Zero of the 58 ADRs numbered ≤0059 are about
process.** Mean length: process ADRs 52 lines, product ADRs 44. Length is a weak signal; *subject*
is the strong one.

---

## 3. `CLAUDE.md` — issue #88's timeline is wrong, and the direction of the error matters

Full size history (`git show <sha>:CLAUDE.md | wc -l`, committer dates, local `-05:00`):

```
09-14 16:13   90   initial
   ... 63 commits of monotone growth, never once shrinking ...
09-19 19:00  874   peak
09-19 21:01  199   2b6fcf3  "CLAUDE.md is 874 lines shorter, and four claims in it were false"
09-20 12:13  232   grows through the SPEC dissolution
09-20 16:54  196   842c9be  "Superseded ADRs are deleted, not kept; CLAUDE.md is 196 lines"
09-20 22:16  206   de106cc  worktree rule
09-21 12:24  211
09-21 12:55  194   5801bf3  #65 MVP fence comes down          <-- the floor
09-21 13:04  200   03055b5  #60  +6
09-21 13:31  236   8f9c069  #46  +36
09-21 13:58  237   6faf025  #61  +1
09-21 14:37  239   a55bf9a  #78  +2
09-21 15:47  244   675b587  #79  +5                            <-- 2h 52m after the floor
09-21 19:27  247   4256fcb  #82  +3
09-21 19:48  247   (HEAD)
```

**Verified:** `842c9be` trimmed to 196 and said so in its subject. The floor of 194 is `5801bf3`.
244 is `675b587`. The fifty lines are exactly 6+36+1+2+5 = 50, and the word delta is 2,200 → 2,904
= **+704 words** ("about seven hundred words" — exact).

**Corrected:**

- **"a day later" / "was 194 yesterday morning" is false.** 194 → 244 took **2 hours 52 minutes on
  the same afternoon** (12:55 → 15:47 on 09-21). #88 was filed at 21:04 UTC = **16:04 local, 17
  minutes after `675b587`**. The ticket appears to have conflated the 196 of `842c9be` (which *was*
  the previous afternoon) with the 194 of `5801bf3` (three hours earlier the same day). The real
  number is worse than the claim: the refill rate was ~17 lines/hour, not 50 lines/day.
- **"added by #46 (+36), #61, #78 and #79" is four of five.** #60 (`03055b5`) added 6 lines and is
  missing from the list. Map #86's "Decisions so far" already records this correction — "five
  verdicts on what were five commits and not four" — so #88's own resolution caught it.
- **`2b6fcf3`'s commit subject is itself false.** "CLAUDE.md is 874 lines shorter" — it went *from*
  874 *to* 199, i.e. 675 lines shorter. The numstat is `106 781 CLAUDE.md`. A commit whose stated
  purpose was that four claims in the file were false shipped a false claim in its own subject.

### What map #86 changed: nothing, and it was not given 24 hours to

The ticket's framing — "#86 was chartered over exactly this growth; establish what it changed and
why the change did not survive 24 hours" — inverts the sequence. #86 was **chartered at 21:04 on
09-21, after all of the growth it describes**, and is **still OPEN and explicitly parked**: *"This
map is parked. #64 is the root now and carries a WIP limit of one active map."* Its two research
tickets (#87, #88) closed with stated properties recorded in the map body. Its two remaining
tickets — **#89** (what a tripwire can honestly count) and **#90** (write the property and the
tripwire into the documents that own them) — are **both still open**. `.githooks/pre-push` exists
(146 lines) but checks *what may not enter the repo*, not length.

So: `CLAUDE.md` was never touched again after `ed3d229` (19:48, 247 lines). The map changed nothing
because it was designed to decide rather than edit, and the repo ran out of days before the edit
ticket came up. **The corrections that did happen — `2b6fcf3`, `842c9be`, `5801bf3` — all predate
#86 and none of them was the map's doing.**

### Did the correction hold?

Partly, and this is the most interesting number in the report.

- Before the cut: 90 → 874 lines in 5.1 days = **+154 lines/day**, across 64 consecutive commits
  **none of which reduced the file**.
- After the cut: 199 → 247 in 2.0 days = **+24 lines/day**, and the file was cut again twice in
  that window (`842c9be` 232→196, `5801bf3` 211→194).

The correction cut the growth rate by ~6.4× and installed a habit of re-trimming that had not
existed before. What it did not do is bound the file: `CLAUDE.md` at HEAD (247) is **larger than at
any point since the cut**, and 27% above the 194-line floor set nine hours earlier.

---

## 4. Was any addition unjustified on its own terms?

The hypothesis — every individual addition was locally correct, the failure was only aggregate —
**survives, with two concrete counterexamples of a different kind.**

Reading the five diffs that made the fifty lines:

| Commit | Δ | What it added | Locally justified? |
|---|---:|---|---|
| `03055b5` (#60) | +6 | "A worktree does not end the collision; it moves it to the merge" — names the rebase-before-merge rule and the owned-files rule | **Yes.** Three documents disagreed about worktree rules and none stated the merge collision. Also bumped "four traps" to "six traps", i.e. `issue-tracker.md` grew with it |
| `8f9c069` (#46) | +36 | The whole *What may not enter the repo* section | **Yes.** Public repo, public tracker, and the section is chartered by a closed ticket. But 36 lines to state three prohibitions, and it contains three incident narratives while explicitly saying "this section deliberately carries no list" |
| `6faf025` (#61) | +1 | One ownership-table row, with an incident clause: "which is how the store copy came to sell two things the app does not have" | **Yes.** One row, and the row was genuinely missing |
| `a55bf9a` (#78) | +2 | "A branch is reviewed **after the rebase** and does not merge until the human has answered the findings" | **Justified in intent, wrong in content** — see below |
| `675b587` (#79) | +5 | Replaced the false one-liner "Kotlin official style, ktlint defaults" with the correct statement (`intellij_idea`, not `ktlint_official`) | **Yes, and it is a net truth gain.** The prior 1 line was *wrong*; 5 lines is what accuracy cost |

**Every one of the five passes on its own terms.** Not one is speculative, not one documents
something unbuilt, and each cites the ticket that found the gap. The aggregate hypothesis holds.

**Two counterexamples, both about accuracy rather than volume:**

1. **`a55bf9a` (#78) was falsified within 5 hours.** Its two lines said the review runs *after the
   rebase* and called it a gate. `4256fcb` (#82, 19:27 the same evening) replaced them with five
   lines: *"reviewed **before** it merges … It is a loop rather than a single gate."* So one of the
   five additions was locally *incorrect at the moment it was written*, and correcting it cost
   three more lines. The pattern is not "a correct line accumulates" but "a rushed line accumulates
   twice".
2. **`2b6fcf3`'s subject line** (above) — a false claim inside the correction itself.

**The far larger dynamic the ticket's hypothesis misses: churn, not growth.** The 18 review-round
commits (`#N round two`, `what the review found`) added **270 Markdown lines and removed 215, for a
net of +55**. The review loop was overwhelmingly *rewriting documentation that had just been
written* — `#101` reached round six, `#105` round four, `#5` round four, all on 09-21. The
documentation cost of the last day is mostly not new prose; it is the same prose being corrected
repeatedly because it was written faster than it could be checked.

**And the last day stopped documenting the app at all.** Of the 42 doc-only commits on 09-21, the
most-touched files are `docs/agents/issue-tracker.md` (18), `CLAUDE.md` (10),
`docs/agents/triage-labels.md` (8), `docs/adr/README.md` (6) — every one of them about how to work,
none about what the app does. `docs/agents/issue-tracker.md` did not exist until `8f06416`
(09-19 23:05, 45 lines) and reached **336 lines in 2 days**, a 7.4× growth in the last 48 hours of
the repo's existence.

---

## 5. The figure the ticket uses is an undercount

8,191 lines is the repo only. The public tracker holds, for the same 8 days:

- **106 issues**, 4,270 body lines, **44,969 words**
- **171 comments**, 4,808 lines, **62,493 words**
- Total **107,462 words of tracker prose** against **90,021 words of repo Markdown**

**More documentation was written outside the repo than inside it**, it is subject to the same
disease (#37's map body is 343 lines / 3,988 words — longer than `CLAUDE.md` and 3.6× ADR 0070),
and it is the half that cannot be trimmed: per `CLAUDE.md`'s own *What may not enter the repo*,
"Editing removes nothing: every prior revision of an issue body or a comment stays readable."
The correction mechanism the repo built (cut, overwrite, never amend) has no counterpart on the
tracker, where every word written is permanent.

---

## What this means for the next repo

- **Measure the tracker, not just the repo.** 107k words of issue prose against 90k in files, and
  the tracker half is append-only and un-trimmable. A word budget that counts only `*.md` is
  measuring the smaller, more correctable half.
- **The ADR length "drift" was a change of authoring method, not a decay.** Bulk-extracted ADRs
  are 14 lines because they summarise settled text; ADRs written live against a contested question
  are 47. Decide which kind you want *before* setting a length rule, or the rule will punish the
  honest one.
- **Churn is the real cost, not growth.** 18 review rounds produced +55 net lines while rewriting
  215. Writing documentation faster than it can be checked costs more than writing too much of it.
- **A correction with no enforcement decays predictably.** The 09-19 cut reduced `CLAUDE.md`'s
  growth from 154 to 24 lines/day — real and large — but the file still ended 27% above its floor,
  and the tripwire ticket (#90) never ran. A budget needs a mechanical floor, not a ticket.
- **Process documentation is the thing that runs away.** Zero of the first 58 ADRs are about
  process; 10 of the last 17 are. `issue-tracker.md` went 45 → 336 lines in the final 48 hours.
  When a repo starts documenting how it documents, put that on a separate budget and watch it.
