# Publish this repo once the namespace frees

Type: task
Status: claimed
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

## Note after ticket 16

**Unblocked, with a verdict better than this ticket expected and one act owed first.**

16 measured the whole history: across all 17 commits, both checked classes report zero hits and every
author and committer line is clean, **excluding one file**. The repository's entire content exposure is
`research/02-issues-raw.json` — 857 KB of raw `gh` output, 72% of the repo by bytes, read by nobody,
holding all 49 home-anchored path instances plus a device model and a profile id.

**"Commit zero has been missed" therefore costs one history rewrite, and the rewrite is free.** The
one-time irreversible instrument is only spent once SHAs are *published*; this repo has no remote, one
branch, no tags and no blame anyone depends on. The old repo spent it at 195 SHAs with a live remote.
This one does not spend it at all.

**Owed before the remote is created**, and owed to the human — a history rewrite is exactly the class
17 reserved as the human's gesture, so no agent performs it:

1. Untrack the dump and move it beside `../old_loop`.
2. Excise the path from all 17 commits (`filter-repo --invert-paths`); it has been tracked since
   `9571165`, so it is in 16 of them and untracking alone would publish it forever by object id.
3. Re-run the install budget afterwards: both pattern classes must report zero, or it did not work.

**The tracker question gains its third constraint, and this one is a requirement rather than a price.**
16's perimeter is every tracked path, so under the local tracker every issue body passes the same
mechanical check as every other file. That **closes by construction** the hole the old repo could not
reach — #76 recorded that an issue never passes through a commit, which is why six bodies leaked.
Migrating to GitHub Issues reopens it permanently. 16 does not decide the tracker; it states the
requirement and leaves the decision here:

> Issue bodies pass the same mechanical check as every other tracked path. A tracker that cannot offer
> one does not satisfy the entry rule.

Read together with 13's constraint — `SALVAGE.md` cites `.scratch/post-mortem/`, so migrating breaks a
governed document's path check — two independent constraints now point the same way, and the native
dependency edges are the only argument on the other side.

## Answer

**Prepared and proven; the two acts that remain are the owner's.** The rewrite and the first public
push are the class 16 and 17 reserve to the human, so this ticket stays claimed until the remote URL
exists to record.

**The ticket expected one blocker and a first push meets three.** Simulated by feeding `pre-push` the
ref line of a first push — no remote, so the range is every commit on `main`:

| Class | Commits | Cause |
|---|---|---|
| Home-anchored path | 21 | All 357 hits in the dump, `9571165` to `9c49087`. 16's verdict holds exactly. |
| Size cap | 10 | Every one predates `33abe66`, which installed the cap. Excising the dump leaves `9571165` near 1,150 lines, still over. |
| Path does not resolve | 2 | `CLAUDE.md`'s archive pointer, in `33abe66` and `dcf9bb6`. |

**The third was a bug in the twin hooks, not in history.** `pre-commit` resolved backticked paths with
`[ -e ]` against the disk, where `../old_loop` exists; `pre-push` resolves against the tree, where it
does not. So a path 13 ruled unciteable — resolves on one machine — passed every commit and would have
failed only at publication. Fixed at `570947a`: `pre-commit` resolves against the index, and the
archive name in `CLAUDE.md` is un-backticked.

**Decisions, all the human's, all as recommended:**

- **The pre-cap commits get `Oversized:` trailers in the same rewrite**, rather than a hook scoped to
  its install commit or a `--no-verify` on the one push that matters. The rewrite is free and
  happening anyway; afterwards every published commit passes the hook as written. Each trailer says
  it was recorded by this rewrite — the null-record shape, owed because the cap demands an act.
- **The two historical `CLAUDE.md` versions are corrected in the rewrite**, matched by original blob
  id, not by content: ticket 16 quotes the same sentence verbatim and is a dated record.
- **Only `main` is pushed.** The prototype branches stay local; `v0.0.1` is not pushed, since 10
  says no version counter exists on day one. The tag is left in place, not deleted.
- **The tracker stays local.** 13's constraint and 16's requirement both point that way; native
  dependency edges were the only argument against. `docs/agents/issue-tracker.md` is unchanged.

**Proven on a throwaway clone** of `570947a` with all refs: `pre-push` exits 0 on a simulated first
push; the dump's blob and path are absent from every commit; the HEAD tree is byte-identical; the
backticked form is gone from all 41 `CLAUDE.md` versions and ticket 16's quotation intact in all 46;
14 `Oversized:` trailers, 4 existing plus 10 added; one identity on every author and committer line.

**The archive**: `../old_loop` is intact, 242 commits, its `origin` remote dead. The untracked dump sits
beside it and its `git hash-object` matches the committed blob, so after the rewrite that file is the
only copy and is known good.

### The owner's checklist

1. From the repo root, with nothing uncommitted, run the script below (`git filter-repo --force`
   rewrites every ref in place and prunes the dump's objects).
2. Re-run the simulated push; it must exit 0:
   `echo "refs/heads/main $(git rev-parse main) refs/heads/main $(printf '0%.0s' $(seq 40))" | sh .githooks/pre-push`
3. `gh repo create jq-ln/loop --public --source . --remote origin`, then `git push -u origin main`
   — the hook runs for real here.
4. Report the URL; the session that resolves this records it and closes the ticket.

```sh
# Ticket 14: the one pre-publication history rewrite. Run from the repo root.
set -e
git filter-repo --force \
  --invert-paths --path .scratch/post-mortem/research/02-issues-raw.json \
  --blob-callback '
if blob.original_id in (b"048ad87ca0c57052a600d9533e6e896fb75ec30a", b"b798c2b8e7014125277a8779afdc6fe60a5f1107"):
    blob.data = blob.data.replace(b"`../old_loop` is where", b"The archive at ../old_loop is where")
' \
  --commit-callback '
over = {
  b"a354a869abd5139fcc083cd5177b716be6abd16e", b"279095a70799956d26ca191f817a3ee86593362b",
  b"589326026bf44c1703aa991462b492202881aaac", b"e6f7aa1773518adf454d4a09cbbb724daae8af6b",
  b"bd9e6769c08723932f8dee8a361d602dcef2aa97", b"fa0096f4b5c27b8d8b8024ff9e7be0042d3b76f9",
  b"13b813d06fcd878836d6d2b650216612cc93613e", b"7cfeaa13686e8b51b1a7cdb5ccd2c28803240d3d",
  b"ab3517fa5d963ec5512b856f6e53c8de6f3016a2", b"9571165fdc7b7b9c8d8ad656072ee5d39acf9f6f",
}
if commit.original_id in over:
    commit.message = commit.message.rstrip(b"\n") + b"\nOversized: predates the cap; recorded by the pre-publication rewrite, ticket 14\n"
'
```
