# Publish this repo once the namespace frees

Type: task
Status: open
Blocked by: 16

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

Ticket 08 changed this ticket's standing. **Public from the first commit is now a decided
constraint**, held as a goal in its own right rather than an assumption: the user's work needs to be
public. So this is not a nicety to be taken when convenient — the old repo paid publication's full
cost (ADR 0067's irreversible history rewrite) and collected none of its benefit, because the flip
was never taken before the remote died. Two consequences:

- **Blocked by 16.** The entry rule must be mechanical and passing before the push, not after. This
  repo already has three commits, so "commit zero" has been missed in the strict sense; ticket 16
  must say what that costs and whether this history is clean enough to publish as it stands.
- This repo's tracker lives in `.scratch/` and goes public with the repo. Whichever tracker wins,
  the issue bodies are public text — `../old_loop` leaked owner data in six issue bodies.

## Note after ticket 13

13 changed two of this ticket's premises.

**The third bullet is superseded.** Salvage citations no longer resolve against `../old_loop`. 13
found the archive unciteable on the budget's own terms — every backticked path in a governed document
must resolve on disk, and an archive path resolves on one machine — so `SALVAGE.md` states its
conclusions self-containedly and its evidence lives in `.scratch/post-mortem/`, which is tracked here
and goes public with the repo. Confirming the archive is intact is still worth doing; nothing in the
kit depends on it.

**The tracker question gains a constraint it did not have.** `SALVAGE.md` is a governed document
citing `.scratch/post-mortem/`, so migrating the map and its tickets to GitHub Issues would break a
governed document's path check, not merely relocate some prose. Either the research files stay as
files when the tickets move, or `SALVAGE.md` is rewritten in the same change. The native dependency
edges and the visual frontier are still the argument for migrating; this is a cost on the other side
that was not visible when this ticket was written.
