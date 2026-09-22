# 04 — Product salvage inventory

Answers: `.scratch/post-mortem/issues/04-product-salvage-inventory.md`
Evidence: `../old_loop` at `0cd77ff` (242 commits, 2026-09-14 → 2026-09-21), read-only.
Method: file reads, `grep`, `wc`, read-only `git log`. Every number below is reproducible from the
commands named beside it.

---

## 0. The measurements everything else rests on

### Lines and files, per module

| Module | Kind | main LOC | main files | test LOC | test files | `@Test` |
|---|---|---|---|---|---|---|
| `:core-api` | pure JVM | 1,124 | 12 | 722 | 5 | 70 |
| `:core-routine` | pure JVM | 2,042 | 21 | 2,726 | 14 | 193 |
| `:core-track` | pure JVM | 363 | 4 | 271 | 4 | 25 |
| `:core-audio` | pure JVM | 672 | 6 | 625 | 7 | 43 |
| `:core-testing` | pure JVM | 150 | 2 | 69 | 1 | 4 |
| `:core-data` | Android lib | 8,063 | 51 | 8,582 | 35 | 374 |
| `:core-ui` | Android lib | 501 | 6 | 0 | 0 | **0** |
| `:app` | Android app | 12,372 | 44 | 5,206 | 29 | 236 |
| **Total** | | **25,287** | **146** | **18,201** | **95** | **945** |

`find <module>/src/main -name '*.kt' | xargs wc -l`; `grep -rhoE '^\s*@Test' <module>/src/test`.

**There are zero `androidTest` sources anywhere in the repo.** Every one of the 945 tests runs on
the JVM under `./gradlew test testDebugUnitTest`. That is the single most important number in this
inventory, and section 2 argues it was not the module split that bought it.

### What the eight days actually spent themselves on

- Commits touching at least one `.kt` file: **125**. Commits touching only Markdown: **117**.
  (`git log --format=%H | while read h; do git show --name-only …; done`)
- Lines added across all history: **Kotlin +55,967 / −12,488** (ending at 43,488 — 22% churn);
  **Markdown +14,675 / −6,478** (ending at 8,191 — **44% of everything ever written in Markdown was
  later deleted or rewritten**). (`git log --numstat --format= | awk …`)
- Room schema went to **version 13** with 12 migrations and 13 exported schema JSONs in eight days.
  (`core-data/schemas/`, `Migrations.kt`)
- `versionName` went 0.1.x → **0.18.0**, `versionCode` 55.
- **75 ADRs.** Numbered 0001–0078 with 0044, 0060 and 0063 deleted (the reversal policy did fire,
  three times). 1,774 lines total.
- **Every one of the 75 was created on 2026-09-20 or 2026-09-21** — days seven and eight.
  (`git log --diff-filter=A --date=short -- docs/adr/0*.md`) They were extracted wholesale from the
  2,702-line `SPEC.md` in a single day's run of commits titled "§3 and §8 are gone: … six more
  decisions are ADRs", "§5 is gone: ten ADRs …", "§9 is gone: fourteen ADRs …", "SPEC.md is gone".
  **The rule "the ADR is written in the same commit as the code, never a follow-up" describes how
  the corpus was meant to grow, not how it came to exist.** It was in force for at most 48 hours.

---

## 1. The four pillars (Plan, Do, Track, Reflect)

### What the code actually contains

`CLAUDE.md:7` says "Plan is a declaration in `:core-api` and nothing else." `docs/REFLECT.md:14`
says "Reflect is a declaration in `:core-api`." `CONTEXT.md:48` makes Pillar a first-class glossary
term.

**`grep -rn "Pillar" core-api/` returns nothing.** The entire pillar model in the codebase is this,
at `/Users/<user>/Projects/old_loop/app/src/main/java/dev/jqln/loop/ui/AppMenuSheet.kt:153`:

```kotlin
enum class Pillar(val label: String, val detail: String?, val built: Boolean) {
    PLAN("Plan", "Not built yet", false),
    DO("Do", "Today", true),
    TRACK("Track", "Metrics", true),
    REFLECT("Reflect", "Journal", true),
}
```

Six references, all in that one file: the declaration, one `for (pillar in Pillar.entries)`, a
three-arm `when` calling already-bound navigation lambdas, and a test-tag helper. **No other module
in the repo mentions it.** Nothing is stored by pillar, scoped by pillar, or routed by pillar type.
The three fields are a label, a subtitle and a boolean that greys a row.

Shipped weight per pillar: **Do** ≈ the whole app; **Track** ≈ 6,500 LOC across four modules;
**Reflect** = one screen (`JournalScreen.kt`, 244) + one repository (`JournalRepository.kt`, 95) +
one entity; **Plan** = a greyed menu row.

### Did it earn its keep

It bought two real things and one expensive thing.

Real: it gave the app a *name* and a stated purpose, and the menu sheet's comment is honest about
why Plan is listed ("so the menu says what the app is *for* rather than only what it currently
does"). And it gave ADR 0039 the argument that killed the Record pillar — "a pillar that owns 'data
input' owns the whole app" is a genuinely good reason, and ADR 0040's self-reversal (set aside *by
the author who proposed it*) is the healthiest artefact in the repo.

Expensive: **ADRs 0038–0043 are six consecutive numbers written across two days, all of them about
where a feature belongs.** 0041 records a build-and-revert — the quick check-in shipped on Track in
0.9.0 and was taken off in 0.9.2, one day later. 0038 is candid that the trigger was "Track's home
had grown three rows, and every one carried a comment in the source justifying why it was there."
Three of the eight days' architectural argument went into a taxonomy whose total code footprint is
eight lines of enum in a bottom sheet.

> **Verdict: DROP the pillar model as an architectural claim; KEEP the one sentence it distils.**
> A four-item enum of navigation destinations does not need a name, an ADR family, or a placement
> rule — it needs four menu rows. The taxonomy generated two rejection ADRs, one build-and-revert,
> a six-ADR contiguous run, and a documented falsehood in three files about where the type lives,
> and returned no code leverage whatever. What is worth carrying forward is the *test* 0039 wrote
> for itself: a new top-level concept must name a stage nothing else covers **and** arrive with an
> engine, as two separately evidenced claims. That sentence is worth keeping precisely because it
> is a brake; the ontology it brakes should never have been installed.

---

## 2. The pure-JVM module split

### What it delivered

- The dependency direction is genuinely enforced. `import androidx.room.Entity` in `:core-routine`
  does not resolve, and ADR 0027 records two real defects the boundary caught that the previous
  convention had not: `SettingsRepository` leaking DataStore's return type onto every caller's
  compile classpath, and `ScreenHeader`/`FilterField` being `internal` and therefore invisible
  across the new Gradle boundary.
- The pure-JVM modules carry **335 of 945 tests (35%)** on **4,351 of 25,287 main LOC (17%)** —
  a test density roughly 2.4× the Android modules'. `:core-routine` alone is 193 tests against
  2,042 lines.

### What it did not deliver

**The emulator-free property was bought by Robolectric, not by the split.** `core-data/build.gradle.kts`
and `app/build.gradle.kts` both pull `libs.robolectric`; `core-data` sets
`unitTests { isIncludeAndroidResources = true }`. The 610 tests in the two Android modules — 65% of
the suite, including all 374 Room/migration tests and the Compose UI tests — run under
`testDebugUnitTest` on the JVM with no device. Had the project stayed one module, it would still
have had an emulator-free suite. The split bought *speed* and *enforced direction*, which are worth
having; it did not buy testability, and the CLAUDE.md framing ("the invariants are testable on the
JVM; write those tests before any UI") credits the split for Robolectric's work.

Two modules did not earn their boundary:

- **`:core-track` is 363 main LOC and 25 tests**, and a third of it is constants and a
  `formatElapsed` string helper. `CLAUDE.md` says "a pillar becomes a Gradle module when it gets an
  engine, as Track did — do not create one early, and storing text with a timestamp is not an
  engine." Read `Recording.kt` (42 lines: a step-type id, a 10-minute cap, a directory name, a
  filename function and a duration formatter) and the rule does not survive its own example. Track's
  actual engine is `:core-audio`.
- **`:core-ui` is 501 lines and has zero tests.** It exists to make one header and one set of row
  metrics visible across the boundary that the split itself created (ADR 0027 says so explicitly).
  It is a module solving a problem modularity introduced.

> **Verdict: KEEP WITH CHANGES.** Keep exactly one seam: a pure-Kotlin module holding the rules
> (what `:core-routine` and `:core-audio` are), and everything Android on the other side of it.
> That seam is real, the compiler enforces it, and `:core-routine`'s 193 tests against 2,042 lines
> are the payoff. Drop the per-pillar modules — `:core-track` at 363 lines is a folder wearing a
> build file, and `:core-ui` is pure overhead from over-splitting. Do not claim the split buys
> emulator-free testing; adopt Robolectric on day one and say so, because that is what actually
> produced 945 device-free tests. Two modules, not eight.

---

## 3. "Core measures; plugins judge" (ADR 0043)

### Where it was applied

Four source files cite the rule by name, and all four are honest applications:

- `core-api/.../Microphone.kt:11` — the mic hands out signal, never a verdict.
- `core-audio/.../PitchTracker.kt:40` — f0 is reported; whether it is in tune "is the business of
  whoever asked".
- `core-track/.../Recording.kt:14` — "What is heard in it is computed on read and never stored."
- `app/.../ui/track/RecordingAnalysis.kt:24` — the judging code, correctly in `:app`, not in core.

The second-order consequence is the valuable one and is stated in the ADR itself: *nothing derived
is ever stored*, so tuning a formula re-grades the whole history instead of leaving today's verdict
frozen into every past row. That is a real data-model discipline with a real payoff, and it is
visible in the schema — `Occurrence` stores `boost` and `boosted_at`, not a score.

### Where it leaks

`core-routine/.../priority/ScoreCalculator.kt` is a judgement living in core: it weights importance
against overdue-ness against a decaying boost, and its own KDoc argues a product position ("there
are deliberately **no absolute priority integers**: they require a global consistency the user will
never maintain"). `LoadCalculator` is the same shape. Neither is a measurement by 0043's own test —
both need a domain word ("priority", "load") to describe them. The rule was not applied to the code
that predates it; 0043 was raised 2026-09-17, after `:core-routine` existed.

That same file also carries a documented code/comment contradiction: `BOOST_DECAY_HOURS = 24.0` is
labelled "~3 day half-life", where `24·ln2 ≈ 17 hours`. The KDoc names the open issue (#3) rather
than fixing it.

> **Verdict: KEEP, and restate it as the data rule it actually is.** "Store facts, compute
> judgements on read" is one sentence, needs no pillar vocabulary to state, is checkable in review,
> and its payoff (the history re-grades when the formula changes) is concrete. The "core/plugin"
> framing is the weak half — it made the rule sound like it was about module boundaries, which is
> why `ScoreCalculator` sits inside core unchallenged. Write it as a storage rule, not a placement
> rule, and it applies everywhere including to a single-module app.

---

## 4. Plugins as separate apps, discovered at runtime (ADR 0052)

### The machinery

| Where | main LOC | test LOC |
|---|---|---|
| `:core-api` — `WireDeclaration` (387), `Microphone` (106), `RoutineHost` (94), `WireSchedule` (89), `StepRun` (79), `WireRun` (70), `Version` (61), `PluginMark` (61), `PluginManifest` (47), `StepPresentation` (28) | **1,022** | **722** (all of `:core-api`'s tests) |
| `:core-data/plugin/` — `PluginRegistry` (281), `WireMetrics` (213), `HostCalls` (194), `LoopRoutineHost` (135), `PluginDeclarationReader` (107), `WireDiscovery` (104), `AndroidPluginPackages` (99), `ColorSlots` (64), `AndroidPluginProviders` (28) | **1,225** | **1,489** (`PluginHostTest` 588, `WireMetricsTest` 325, `HostCallsTest` 282, `WireDiscoveryTest` 151, `PluginDeclarationReaderTest` 143) |
| `:app` — `StepRunnerScreen` (140), `PluginHomeScreen` (82), plus plugin sections of `SettingsScreen`/`AppMenuSheet` | ~**300** | `SettingsPluginsTest` 187 |

Counting `:core-ui`'s `PluginUi.kt` (84), `PluginMarkGlyph.kt` (58) and `StepRunner.kt` (31),
`:app`'s `LoopHostProvider.kt` (66), and ~40 manifest lines: **≈2,670 production LOC (10.6% of all
production Kotlin) and 2,922 test LOC across 14 files and 174 `@Test` functions (18% of the entire
suite) exist solely because a plugin is a separate APK** — about 5,600 lines. On top of that:
**22 plugin ADRs** (0052–0059, 0061, 0062, 0064–0069, 0076 and the constraint ADRs they cite), and
a published contract — `docs/plugin/WIRE.md` 354 lines, `MANIFEST.md` 148, `STYLEGUIDE.md` 98,
`README.md` 50, plus `docs/PLUGINS.md` 213: **863 lines / ~8,600 words, 25–30 printed pages, that a
third-party author must read**, with no library to compile against and no validator to run ("the
validator a plugin author runs is the app", ADR 0069).

`PluginRegistry` is 281 lines of which roughly half is KDoc, and it lives in **`:core-data`**, not
`:app` — `CLAUDE.md`'s architecture block attributes plugin discovery to `:app`, and that is the
second documented falsehood found in this inventory. Discovery runs `queryIntentActivities` plus an
XML parse per candidate on every foregrounding, twice at cold launch by design (ADR 0064), and a
`byPackage` miss triggers a whole extra pass before answering null.

### How many plugins exist: zero, and zero that *could* exist

Two were built (the ear trainer, the dual n-back), both **inside** the repo as ordinary Gradle
modules, and both were **extracted out** on 2026-09-19/20. Neither extracted repo declares
`dev.jqln.loop.action.PLUGIN` and neither has a declaration resource, so **the shipped host cannot
discover either of them** — a fact ADR 0076 states in writing.

The ordering is the finding. Commit `e46fb47` ("Dual N-Back leaves the repository, and Loop ships no
plugins at all") says plainly that it was taken **out of order** — "#20's stage 6 before the stage 4
it was meant to follow: with the plugin unregistered from `:app`, Loop runs no plugin until the wire
works" — and notes the suite dropped by 77 tests that "now run nowhere". **Stage 4, the wire itself,
then landed across roughly ten commits after its last consumer was already gone.** Every line of the
seam was written against no caller.

The maintenance record is a steady retreat, all of it after the consumers left: ADR 0069 deleted the
author-facing library (`Plugin`, `PluginExporter`, `StepType`, `StepHistory`, `LoopApi`,
`PluginContract`) once a survey found them reachable only from each other and from `PluginContract`'s
own fake; ADR 0076 deleted three of five wire `call()` verbs for having no caller and left a fourth
admitting it has none; issue #22 deleted the entire `Speech` capability because the extracted plugin
was its only user. Two declared XML elements (`<routine-template>`, `<goal-template>`) are still
published in the contract and parsed by nothing.

The extraction itself was expensive in ways the repo records: the git history was rewritten to carry
the ear trainer's commits away (ADR 0060 forbade the rewrite, was deleted, and 0067 replaced it);
`DEPENDENCIES.md` lost the Bravura font; `docs/PERMISSIONS.md` lost the `RECORD_AUDIO` justification
it had been carrying; `docs/ACTION_VOCAB.md` lost a gesture; `docs/PLUGINS.md:102` records that the
plugin had already collided with core on both DataStore `settings` and `feedback.jsonl`.

**At the moment the repo was killed, the host shipped a complete plugin platform with zero installed
and zero installable plugins, and `fastlane/.../full_description.txt` still carries a paragraph
headed "Plugins are separate apps" promising runtime discovery over a published contract.**

> **Verdict: DROP for a rebuild; KEEP the wire document as a reference artefact.** A runtime-
> discovered, cross-APK, permission-negotiating, separately-versioned plugin platform is a
> reasonable thing to build once there are third-party plugin authors. There were none, and both
> first-party plugins were written as in-repo modules and then *paid* to leave. The seam cost
> ~5,600 lines, 22 ADRs, 863 lines of published contract, its own semver scheme (`Wire.VERSION`,
> ADR 0055), a permission pair (ADR 0068), a history rewrite and a deleted ADR — and it was written
> **after** its last consumer was deliberately removed from the build, which is the whole diagnosis
> in one sentence. The load-bearing premise (0053 → 0052: separate APKs are the only way to keep a
> plugin's permissions off Loop) is sound and justifies the *shape* a plugin must take; it does not
> justify 2,670 lines of host that discovers nothing and re-queries the package manager on every
> foregrounding to get back an empty list. The in-repo module boundary the two plugins already had
> was doing the job. Rebuild with feature modules; reach for process isolation the day a stranger
> asks for it.
>
> The one thing worth carrying: `WireDeclaration.kt` (387 lines) is *pure JVM*, so declaration
> validation — the whole of what the host decides about a plugin before touching it — is testable
> with no device. That is a genuinely good seam design and it is reusable for any
> untrusted-manifest problem. Keep the file as a pattern, not the platform.

---

## 5. Definitions vs occurrences (`Task`/`TaskLink`/`Schedule` vs `Occurrence`)

This is the one architectural claim the code honours completely and the one that unambiguously
earned its keep.

`Occurrence.kt` (200 lines, of which ~120 are KDoc arguing the model) is the clearest file in the
repo. The separation is enforced at the schema level and the reasons are recorded at the point of
enforcement:

- `display_name`, `estimated_minutes` and `optional` are **snapshots taken at materialization time,
  never back-filled** — editing a definition tomorrow cannot alter last week's record.
- The references to `task` and `task_link` are **deliberately not foreign keys**, with the reason in
  the file: Room enables `PRAGMA foreign_keys`, so an enforced reference would either block
  `DELETE FROM task` while history exists or cascade the history away with it. "Completion history
  outlives the definitions it came from."
- `snoozed_from` stores where the run *came from*, not where it went, so the column does not repeat
  `due_at`, undo is exact, and the log carries a real fact.
- `closed_reason` exists because `SKIPPED` was written by four paths and only one of them meant the
  user did not do something — "counting them together would make 'how often do I skip things' wrong
  rather than merely imprecise."

ADR 0022 states the leverage plainly: "Almost every rule elsewhere in the engine is downstream of
this one."

> **Verdict: KEEP, unchanged, and port it first.** This is the load-bearing model. It is the reason
> the cascade, the schedule write-back, undo, dedup and the analytics story all work at all, and
> every one of its non-obvious choices (no FKs, snapshot columns, store-the-origin snooze,
> discriminated skip reasons) is a decision that would be got wrong on a first attempt and only
> discovered months later when the history read wrong. Port `Occurrence.kt` and ADRs 0010, 0015,
> 0019 and 0022 verbatim.

---

## 6. What would cost weeks to re-derive

Ranked by re-derivation cost, not by line count.

1. **`core-routine/occurrence/CompletionCascade.kt` — 336 lines, 646 lines of test, and the single
   most valuable file in the repo.** Completing one occurrence can close its subtree, satisfy
   *shared* work in other routines via the dedup key, and roll parents up — and each of those can
   re-trigger the others, so it is implemented as a **worklist run to a fixpoint**, not a fixed
   sequence of passes. It computes a whole `CascadePlan` before writing anything, which is what
   makes undo exact. The reverse direction (`reverting`) is harder than the forward one and needs
   `satisfiedBy` precisely because the forward pass can discover siblings by key but a reversal must
   reach only the ones *this* completion satisfied. Nobody gets this right from a blank page. The
   646-line test file is the specification.

2. **`core-routine/schedule/` — 616 lines, 942 lines of test.** `RRuleEngine` expands RFC 5545 in
   **floating local time and binds the zone only afterwards**, which is the one detail that makes
   "every day at 08:00" survive a DST boundary where the interval is 23 or 25 hours. Month-end
   (`BYMONTHDAY=31`, `BYMONTHDAY=-1`) is why the library is a dependency at all. `NextDueCalculator`
   (177 lines, 352 of test) and the 04:00 day boundary (ADR 0011) are the rest. Calendar recurrence
   is a classic multi-week sinkhole and this is a solved instance of it.

3. **`core-audio/` — 672 lines, 625 lines of test, zero Android imports.** YIN f0 estimation
   (`PitchTracker`, 183), WAV read/write (157), PCM (127), onset detection (78), a frame clock (88),
   RMS level (39). DSP that is correct *and* JVM-testable against synthetic signals
   (`core-testing/TestSignals.kt`) is days to weeks, and the pure-JVM property is what makes it
   verifiable at all.

4. **`core-data/Migrations.kt` and `core-data/schemas/*.json` — 12 migrations, 13 exported
   schemas.** Not re-derivable in the abstract, but the *pattern* is: exported schemas in VCS as the
   input to every future migration test, and migrations that do real data work
   (`MIGRATION_11_12` rewrites `SCALE_1_5` answers to `SCALE_1_10` and moves the observations first).
   Worth reading before writing migration #1 in the new repo.

5. **`core-api/WireDeclaration.kt` + `WireValidatorTest.kt` — 387 + 385 lines.** Even with the
   plugin platform dropped, this is a well-shaped answer to "validate an untrusted declaration with
   no I/O, so the whole judgement is unit-testable".

6. **The ADR corpus, selectively.** Not the 75, but the ~20 that encode a fact about the world
   rather than a house rule: 0001 (schedules float in local time), 0009, 0010, 0011 (the day ends at
   04:00), 0014 (store the raw RRULE), 0015, 0017, 0018, 0019, 0020, 0021, 0022, 0023, 0024 (the
   definition graph is a DAG), 0034, 0047 (a snooze moves the run, not the rule). These are the
   sentences that took eight days of building to find. The other ~55 are process, taxonomy, or
   decisions about a plugin platform that will not exist.

---

## 7. Verdict table

| Claim | Verdict | One line |
|---|---|---|
| Four pillars (Plan/Do/Track/Reflect) | **DROP** | Eight lines of menu enum, three docs wrong about where it lives, six ADRs of placement argument, zero code leverage. Keep only 0039's two-claims test as a brake. |
| Plan as a declared-but-unbuilt pillar | **DROP** | A greyed menu row is not architecture. Ship the menu row if it helps; do not model it. |
| Pure-JVM module split (8 modules) | **KEEP WITH CHANGES** | Reduce to one rules module + Android. The compiler-enforced direction is real; `:core-track` (363 LOC) and `:core-ui` (0 tests) are not. |
| "The split buys emulator-free tests" | **DROP the claim** | Robolectric buys it. 610 of 945 tests are in the Android modules and still need no device. |
| Core measures; plugins judge | **KEEP, restated** | "Store facts, compute judgements on read" is the durable half. The placement half let `ScoreCalculator` sit in core unchallenged. |
| Plugins as separately installed apps (0052) | **DROP** | ~5,600 LOC, 22 ADRs, 863 lines of contract, a history rewrite and a deleted ADR — written *after* its last consumer was removed from the build, and discovering zero plugins at kill time. |
| The wire declaration validator | **KEEP as a pattern** | Pure-JVM validation of an untrusted manifest, fully unit-tested. Reusable without the platform. |
| Definitions vs occurrences (0022) | **KEEP, port first** | The load-bearing model; every other engine rule is downstream. Snapshot columns and the deliberate absence of FKs are the non-obvious parts. |
| The cascade, the schedule engine, `core-audio` | **KEEP verbatim** | The only three things here that cost weeks rather than days. |
| ADR-per-decision as practised | **KEEP WITH CHANGES** | All 75 were extracted from SPEC.md on days 7–8; the "same commit as the code" rule never actually ran. 44% of all Markdown ever written was later deleted. |

---

## What this means for the next repo

- **Port four things and re-derive nothing else**: `Occurrence` and its no-foreign-keys/snapshot
  model, `CompletionCascade` with its 646-line test file, the schedule engine's floating-local-time
  expansion, and `core-audio`. Together that is ~3,700 lines that cost most of the eight days.
- **Two modules, not eight** — one pure-Kotlin rules module and one Android side — and adopt
  Robolectric on day one, because that, not the module graph, is what made 945 tests run without a
  device.
- **Do not install a top-level ontology.** The pillar model produced two rejection ADRs, a
  build-and-revert, a six-ADR contiguous run and a documented falsehood in three files, for eight
  lines of enum. Name screens; do not classify them.
- **Do not build a platform after removing its last consumer.** The wire's ten commits landed after
  Dual N-Back left the build; 18% of the test suite and 10.6% of production code now serve a seam
  that discovers nothing, while the store copy still advertises it. If a seam cannot name a caller
  it does not also ship, it is not a seam yet.
- **Decide the ADR question on this evidence**: the corpus was written in one retrospective day, the
  "same commit as the code" rule never got to run, and nearly half of all prose written was later
  deleted. About twenty of the seventy-five encode a fact about the world; the rest encode a house
  rule or a platform that will not exist. Budget for twenty.
