# Collisions, version confusion, and extra review rounds under the worktree model

Type: research
Status: open

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
