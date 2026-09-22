# Collisions, version confusion, and extra review rounds under the worktree model

Type: research
Status: resolved

## Question

`../old_loop` ran a worktree → commit → rebase → review → merge → teardown model with several
agent sessions in parallel. The human reports three symptoms; find their instances and their
mechanism.

- **Collisions.** CLAUDE.md records that on 2026-09-20 three sessions worked one checkout and
  interleaved across five files. After worktrees were adopted, find the collisions that *still*
  happened at merge time. How accurate were the tickets' declared owned-files / must-not-touch
  lists, and what did they miss?
- **Versioning confusion.** The repo runs inverted pre-1.0 semver (breaking bumps *minor*), across
  `versionName` + `versionCode`, `Wire.VERSION`, `PluginManifest.version`, Room `version` and export
  `formatVersion`, with "bump in the same commit" on top. Find every commit that got a version
  wrong, corrected one, or argued about one.
- **Unnecessary review rounds.** The review gate is a loop, and `main` moves while a review sits
  with the human. Find branches that needed multiple rounds and classify each round: did it catch
  something real, or did it exist because the branch had rebased underneath the reviewer?

For each symptom, name the mechanism rather than the incident.

## Answer

Full findings: [research\/06-merge-and-review-forensics.md](../research/06-merge-and-review-forensics.md)

**Caveat that reframes the ticket**: the whole protocol was written in the repo's last ~36 hours and governed only 41 commits. It was never observed steady-state. **Collisions**: 14 concurrent-branch pairs shared a file, concentrated in `CHANGELOG.md`, `app/build.gradle.kts` and `CLAUDE.md` — global *registries* a worktree cannot isolate and no ticket can declare off-limits. Declared file lists worked where they existed (zero file-level violations) but only 10 of 41 tickets had one. **Versioning**: eight live counters under three incompatible regimes; the dominant cost is adjudication, not error — 18 issues spend a paragraph arguing no bump is owed, via a precedent chain seven deep. A rule with no null artifact grows case law. **Review rounds — the stated hypothesis is mostly wrong**: exactly one round across nine multi-round tickets existed because `main` moved, and it was substantive. The real generators are that a fix mandatorily reopens a round, that fixes regress against undocumented standards (#101 rounds 3–6 enforcing a 634-column rule no file states), and that the reviewed artifact is prose *about* the change — commit messages, outside the covered test entirely.
