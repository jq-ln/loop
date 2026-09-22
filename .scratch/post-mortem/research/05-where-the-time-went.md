# Where 242 commits of effort actually went

Answers issue `05-where-the-time-went.md`. All figures derived from `../old_loop` git history
(read-only), 242 commits, 2026-09-14 to 2026-09-21 inclusive. Method and classification rules are
at the bottom so the numbers can be re-derived or disputed.

**Verdict on the competing hypothesis (process machinery as a *symptom* of too much surface):
partly supported, then decisively refuted.** Surface explains why the machinery was *built*. It
does not explain the last four days, because the code surface stopped growing on day 4 and the
process work tripled afterwards. The machinery outlived its cause and became self-feeding. Detail
in §4.

---

## 1. The raw per-day table

Commit-level partition. A commit is `code` if every non-junk file it touched is source/build,
`proc` if every file is a process artifact (`docs/`, `CLAUDE.md`, `CHANGELOG.md`, `CONTEXT.md`,
`DEPENDENCIES.md`, `README.md`, `LICENSE`, `.github/`, `fastlane/`, `metadata/`), `both` otherwise.

| Day | Commits | code-only | proc-only | both | code LOC ± | proc LOC ± | proc share |
|---|---|---|---|---|---|---|---|
| 2026-09-14 | 12 | 1 | 0 | 11 | 16,921 | 1,942 | 10.3% |
| 2026-09-15 | 26 | 3 | 5 | 18 | 9,498 | 1,481 | 13.5% |
| 2026-09-16 | 36 | 0 | 18 | 18 | 18,822 | 1,437 | 7.1% |
| 2026-09-17 | 34 | 1 | 20 | 13 | 7,179 | 1,321 | 15.5% |
| 2026-09-18 | 2 | 0 | 0 | 2 | 1,530 | 158 | 9.4% |
| 2026-09-19 | 18 | 0 | 6 | 12 | 9,433 | 3,499 | 27.1% |
| 2026-09-20 | 38 | 1 | 8 | 29 | 13,133 | 7,384 | 36.0% |
| 2026-09-21 | 76 | 10 | 46 | 20 | 7,229 | 3,589 | 33.2% |
| **Total** | **242** | **16** | **103** | **123** | **83,745** | **20,811** | **19.9%** |

"LOC ±" is added + deleted (churn), not net. Total churn 104,556 lines.

Same days, two other cuts:

| Day | Commits | touched code (code+both) | proc-only | line-majority code | line-majority proc | median commit size |
|---|---|---|---|---|---|---|
| 2026-09-14 | 12 | 12 | 0 | 12 | 0 | 385 |
| 2026-09-15 | 26 | 21 | 5 | 20 | 6 | 396 |
| 2026-09-16 | 36 | 18 | 18 | 11 | 25 | 30 |
| 2026-09-17 | 34 | 14 | 20 | 7 | 27 | 34 |
| 2026-09-18 | 2 | 2 | 0 | 1 | 1 | 844 |
| 2026-09-19 | 18 | 12 | 6 | 11 | 7 | 260 |
| 2026-09-20 | 38 | 30 | 8 | 17 | 21 | 267 |
| 2026-09-21 | 76 | 30 | 46 | 23 | 53 | 41 |
| **Total** | **242** | **139** | **103** | **102** | **140** | — |

And the tree itself at end of each day (not churn — what was actually standing):

| Day | Kotlin LOC in tree | Δ | Markdown files | Markdown LOC |
|---|---|---|---|---|
| 2026-09-14 | 13,486 | +13,486 | 3 | 1,738 |
| 2026-09-15 | 19,361 | +5,875 | 5 | 2,795 |
| 2026-09-16 | 33,177 | +13,816 | 9 | 4,355 |
| 2026-09-17 | 38,195 | +5,018 | 10 | 5,522 |
| 2026-09-18 | 38,195 | 0 | 10 | 5,522 |
| 2026-09-19 | 43,673 | +5,478 | 28 | 7,280 |
| 2026-09-20 | 44,065 | +392 | 94 | 6,715 |
| 2026-09-21 | 43,488 | **−577** | 106 | 8,191 |

---

## 2. Is there a crossover point? Yes — three of them, at different dates

The answer depends on what you measure, and the spread between the three is itself the finding.

- **By commit count, the crossover is day 3 (2026-09-16).** Process-only commits go 0 → 5 → 18,
  and from that day on, commits whose *line majority* is process outnumber code-majority commits
  on 5 of the remaining 6 days. Median commit size collapses from ~390 lines (days 1–2) to 30–34
  lines (days 3–4). Process work is high-frequency, low-volume; code work is low-frequency,
  high-volume. Measured in *acts of attention*, process overtook product on day 3 of 8.
- **By lines changed, the crossover never quite happens** — process peaks at 36.0% of churn on
  day 7 and ends at 33.2%. Volume stays code-dominated throughout.
- **By tree growth, the crossover is day 4 (2026-09-17).** After day 4 the Kotlin tree grows by
  5,293 net lines in four days (13.9%), and on the final day it *shrinks*. Markdown files go from
  10 to 106 in the same window. This is the crossover that matters.

The three disagree because a doc commit is small and a code commit is large. Anyone tracking "lines
of code written" would have seen a healthy project to the end. Anyone counting commits would have
seen the inversion on day 3.

**The final day is unambiguous.** 76 commits — 31% of the entire project's commits in one day — of
which 46 touched no code at all. Reading the day-8 subject lines, the work is near-uniformly
document repair: *"eight citations point at issues the flip deletes"*, *"the sentence #93 falsified,
in all three of its homes"*, *"three restatements, a truncated citation and a rule in the wrong
file"*, *"two 'both's four lines apart, pointing at different pairs"*. 20 of the 76 day-8 subjects
contain an explicit repair verb (citation / stale / contradicts / falsified / repointed / inlined).
None of it changed what the app does.

---

## 3. The 43,488 lines of Kotlin, broken down

241 `.kt` files. Classification by path and filename (see §6); "net" excludes blank lines and
comment lines.

| Kind | Files | Raw lines | Blank | Comment | Net code | % of net |
|---|---|---|---|---|---|---|
| Tests | 97 | 18,448 | 2,979 | 1,481 | 13,988 | 45.8% |
| UI (Compose) | 46 | 12,267 | 900 | 2,252 | 9,115 | 29.8% |
| Domain logic | 87 | 11,373 | 1,273 | 3,630 | 6,470 | 21.2% |
| Persistence (Room entities/DAOs/migrations) | 11 | 1,641 | 209 | 460 | 972 | 3.2% |
| **Total** | **241** | **43,729**\* | **5,361** | **7,823** | **30,545** | |

\* 43,729 vs. the headline 43,488: the tool counts one trailing line per file. Same corpus.

Four things fall out of this:

- **There is almost no generated or boilerplate code.** Room's generated implementations live in
  `build/` and are not in the count. Hand-written persistence scaffolding is 972 net lines, 3.2%.
  The 43,488 is not padded — it is essentially all hand-authored (agent-authored) source. *The
  scope claim survives its first test.*
- **Tests are the largest single category at 45.8% of net code.** A 1:1.2 test-to-product ratio is
  disciplined, not bloated. The two largest files in the repo are test files (1,268 and 1,231
  lines). This is CLAUDE.md's "invariants are testable on the JVM, write those tests before any UI"
  actually being followed.
- **Real domain logic is only 6,470 net lines, 21% of the codebase.** Strip tests and UI and the
  app is small. The routine graph, schedule, cascade, priority, check-ins, audio f0 — all of it —
  is under 6,500 lines.
- **Comment density in domain code is 32% (3,630 of 11,373).** The documentation habit reached into
  the source. This is KDoc, not dead code, but it is the same behaviour as the Markdown growth, in
  a different file extension.

Churn tells the rest: `git log --numstat -- '*.kt'` gives **56,700 lines added, 13,212 deleted,
net 43,488**. So ~56,700 lines of Kotlin were actually written and 23% of them were thrown away.
One whole subsystem was written and removed inside the window — `module-dualnback` / `plugin-dualnback`
was created 2026-09-16 (*"the second module, as Jaeggi 2008 published it"*) and deleted 2026-09-20
(*"Dual N-Back leaves the repository, and Loop ships no plugins at all"*).

**Was the scope the anomaly? Yes, but not in line count.** 56,700 written lines in eight days with
agents is a plausible rate. The anomaly is *breadth*: eight Gradle modules, a versioned
cross-process plugin ABI at wire 2.0.0 with its own three-document spec, a DSP module doing YIN
pitch detection, F-Droid store metadata and a fastlane tree — for an offline single-user routine
tracker with 6,470 lines of actual domain logic. The surface area per unit of product logic is the
outlier, not the volume.

---

## 4. The hypothesis, tested

> *The process machinery was a symptom of holding too much surface in view, not the disease.*

**Supported for days 1–5.** The machinery arrives *after* the surface does. Kotlin hits 33,177
lines on day 3 and 38,195 on day 4; the docs tree is still 9–10 files. Documents were written to
hold an already-large surface in view, in the order the hypothesis predicts. Cause precedes effect.

**Refuted for days 6–8, and that is where the effort went.** If process work were a symptom of
surface, it should track surface. It does the opposite:

| | Days 1–4 | Days 6–8 (day 5 was 2 commits) |
|---|---|---|
| Kotlin net growth | +38,195 | +5,293, then −577 |
| Markdown files | 3 → 10 | 10 → 106 |
| Process share of churn | 7–16% | 27%, 36%, 33% |
| Proc-only commits | 23 of 108 (21%) | 60 of 132 (45%) |

The surface **stopped growing on day 4** and the process work **tripled after it**. Days 6–8
contain 132 commits — 55% of the project — against a code surface that net *shrank* by 185 lines
across them. That is not a symptom tracking a disease; it is a second disease.

**What the numbers say it actually was: a citation graph with no damping.** The final tree has 106
Markdown files, 8,191 lines, and **640 cross-references** between them — 262 `ADR NNNN` citations,
141 `docs/*.md` paths, 139 `#NN` issue references. One citation every 12.8 lines of prose. 76 ADRs
were created in a *single day* (2026-09-20, when `docs/adr/` first appears — `SPEC.md` was dissolved
into it), and they are individually **lean**: 1,774 lines across 76 files, averaging 23 lines each.
The bloat is not ADR length. It is ADR *count* times reference *density*: every edit to any claim
invalidates references in documents that did not change, which is exactly what day 8's 76 commits
are doing, one falsified sentence at a time. 17 commits are explicit review "round N" iterations and
8 are "what the review found" — the review loop itself generated commits.

**One more contradiction of the framing.** The ownership table in `CLAUDE.md` was written to stop
duplication, and day 8 spends its commits finding claims restated in three homes anyway
(*"the sentence #93 falsified, in all three of its homes"*, *"the fourth home was the one the other
three cite"*). The mechanism did not prevent the failure it was built for. Volume was not the only
thing at fault — the map's open question on that point resolves toward *both*.

---

## 5. Cadence

- 242 commits / 8 days = 30.3/day mean. Median day: 30.
- Shape: **12, 26, 36, 34, 2, 18, 38, 76.** Day 5 (2026-09-18) is a 2-commit near-stop.
- **First two days: 38 commits, 26,419 lines of churn, 89% code.** All 12 of day 1's commits
  touched code; 0 were process-only.
- **Last two days: 114 commits (47% of the project), 31,335 lines of churn, 65% code by line but
  54 of 114 commits touching no code at all.** Day 8 alone is 76 commits — more than days 1+2+3
  combined — and the day the tree got *smaller*.
- The acceleration at the end is not a sprint to ship. It is 46 process-only commits in one day on
  a codebase that stopped changing.
- 41 distinct issue numbers appear in commit subjects; the heaviest single issue (#20) took 11
  commits.

---

## 6. Method

- Corpus: `git log --reverse --numstat`, 242 commits, renames normalised to their destination path.
- `proc` = `docs/**`, `.github/**`, `fastlane/**`, `metadata/**`, and root `CLAUDE.md`,
  `CHANGELOG.md`, `CONTEXT.md`, `DEPENDENCIES.md`, `README.md`, `LICENSE`. Everything else is
  `code`, including Gradle build files. `.kotlin/errors/*.log` (8 touches, tool output) excluded
  as junk.
- Note the classification is *generous to the product side*: `CHANGELOG.md` is 2,631 lines — 32%
  of all Markdown — and is counted as process; moving it to the code side would lower the process
  share by roughly 5 points on the late days and change no conclusion.
- Kotlin kinds: `test` = `src/test/`, `src/androidTest/`, or the whole `:core-testing` module;
  `ui` = path contains `/ui/`, or module `:core-ui`, or filename ends `Screen|Composable|Theme|Row|Card|Dialog|Sheet|Bar|Nav`;
  `persistence` = path contains `/db/` or filename contains `Entity|Dao|Migration|Converter`;
  everything else `domain`. Files under `build/` excluded throughout.
- Tree-size-per-day figures come from `git ls-tree -r` at the last commit of each day, not from
  churn, so they reflect what was standing rather than what was typed.
- Caveat: the eight days are calendar days in the author's local timezone; a late-night session
  splits across two rows.

---

## What this means for the next repo

- **Track the tree, not the diff.** Net Kotlin LOC in tree per day would have shown the project
  stalling on day 4; commit counts and lines-changed both hid it. Pick the metric that can say
  "nothing moved".
- **Cap the citation graph, not the document length.** 76 ADRs averaging 23 lines each were lean
  and still produced a day of repair work, because 640 cross-references across 106 files means no
  claim can be edited locally. Budget *references per document*, not words.
- **Make a process-only commit visible as its own class.** 103 of 242 commits touched no code.
  A weekly ratio a human actually sees would have raised this on day 3, when it first inverted.
- **The scope failure is breadth, not volume.** 6,470 net lines of domain logic supported eight
  modules, a versioned cross-process ABI and a DSP library. Gate *new module / new seam*, not
  lines written.
- **Test the ownership mechanism before re-adopting it.** The table did not stop the same claim
  living in three files; day 8 found that by hand. Whatever replaces it needs a check that runs,
  not a rule that is read.
