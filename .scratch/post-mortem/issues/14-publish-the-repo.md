# Publish this repo once the namespace frees

Type: task
Status: open

## Question

AFK once unblocked externally. This repo is local-only because `jq-ln/loop` is still held by the
repo being destroyed. When the old remote is gone:

- Create the GitHub remote at the same name and push `main`.
- Decide whether the map and its tickets migrate from `.scratch/` to GitHub Issues, or stay as
  files. The local tracker works; GitHub gives native dependency edges and a visual frontier, which
  the local one fakes with a `Blocked by:` line. If they migrate, `docs/agents/issue-tracker.md` is
  replaced with the GitHub flavour in the same change, and any resolved tickets keep their answers.
- Confirm `../old_loop` is intact on disk as the archive, since every salvage citation resolves
  against it.

Record in the answer: the remote URL, which tracker won, and where the archive lives.
