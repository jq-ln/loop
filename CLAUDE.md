# Agents

How agents work in this repo, and whatever no other file owns. `GOALS.md` outranks this file;
`PROCEDURE.md` is the human's own; the `justfile` owns the commands. `just owns` prints what each
file owns, generated from the files themselves.

## Agent skills

- `docs/agents/issue-tracker.md` — where issues, specs, maps and tickets live, and how they are
  stored.
- `CONTEXT.md` — the glossary. What a term means in this project.
- `docs/adr/` — dated records of decisions, never edited. Nothing cites one; find them with
  `just adr`.

## How work is claimed

A ticket claims **whole files**. There are no sub-file claims: git enforces files and nothing
enforces paragraphs, so a region claim is a rule with nothing to attach to, and two tickets that
want the same file serialise instead.

The claim is the `## Files` block in the ticket, one repo-rooted path or directory prefix per line.
`just start` refuses to open a worktree for a ticket without one, and refuses when the list
intersects a live worktree's. To widen the list mid-ticket, run `just claim <path>`: it re-checks
the intersection and leaves a dated record in the ticket. Do not widen it by editing the block.

If `just claim` refuses, the path belongs to another worktree. Revert the edits and wait; that is
the expensive case, and it is the only feedback that says the claim unit is too coarse.

## What may be written

**Standing-claim files are capped at 12.** The perimeter is root `*.md`, `docs/**.md` and
`.claude/**.md`. Outside it: `.scratch/` (dated records), `docs/adr/`, the justfile, generated
files. `just owns` counts what is spent against the cap, and `.githooks/pre-commit` refuses the
commit that would exceed it. A standing rule may not live in `.scratch/`.

**When the cap is reached, the document is not written.** Find the file that already owns that kind
of claim and fold the claim into it; `just owns` prints what each file owns, and if nothing owns it,
this file does. The commit that folds carries a `Folded: <claim> -> <file>` trailer, and how often
that trailer appears is the evidence that the cap is mis-sized. Do not raise the cap: only the
repository's owner does that.

**Where a document disagrees with the code, the code wins and the document is a bug.** This is the
one row of the old repo's ownership table that was never wrong, and it is stated here rather than in
an index because the code has no declaration paragraph to generate one from.

**No document asserts a structural fact the source asserts about itself.** No module type, no layer
boundary, no file layout, no count of anything. A document that points at structure points at a
path, in backticks, and the hook checks that the path resolves.

**Citation has a direction.** An ADR may cite upward (`GOALS.md`) and outward (file paths).
Nothing may cite an ADR, and an ADR may not cite another ADR — not a document, not another ADR,
not a code comment. A standing document that needs an ADR's conclusion owns that claim itself, and
a code comment states the claim instead of pointing at it. Find one with `just adr`. A superseded
ADR is deleted, and the commit that deletes it says what replaced it.

`GOALS.md` is 40 lines, `PROCEDURE.md` 60, this file 200. The first two are hard. The 200 is
published guidance with no measurement behind it, and is carried as guidance.

## What may not enter the repo

**This repo is public from its first commit.** There is no scrub available later: nothing here can be
edited out, only excised by rewriting history, and that instrument is cheap only while the repo is
unpublished.

Two classes are refused mechanically — home-anchored filesystem paths and personal-domain email
addresses — on **every tracked path, with no exclusions**, `.scratch/` included. `.githooks/pre-commit`
holds the patterns and refuses the commit; `pre-push` re-checks every commit in the pushed range. The
hook reports the path and the line and never the text it matched. Generated and tool output is kept
out by `.gitignore`.

**There are no exceptions.** If a pattern is wrong, the pattern is edited — by the repository's owner,
in a commit that says why.

**A quotation from the archive is redacted at the point of quoting, and the form is `<user>`.**
The archive at ../old_loop is where the identity error in this repo's first three commits came from, and reading it
is how that error propagates.

**Device and owner-environment details** — a phone model, a profile id, where a backup lives — are
refused by this rule and checked by nobody. Text is not checkable. This clause rests on the reading
gate in `PROCEDURE.md` and on nothing else.
