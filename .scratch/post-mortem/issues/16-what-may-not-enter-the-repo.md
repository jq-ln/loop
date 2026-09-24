# What may not enter the repo, checked mechanically from commit zero

Type: grilling
Status: open

## Question

Decided in ticket 08: this repo is public from the first commit, which makes the entry rule
mandatory rather than optional — there is never a scrub available, and the one-time history rewrite
that saved `../old_loop` (ADR 0067, 195 SHAs, ear-trainer blame destroyed) would already be spent.
The check is **mechanical, from commit zero**, and its list is seeded from the old repo's actual
instances rather than from imagination.

This ticket settles the list, the mechanism, and the ordering against the first commit.

- **The list.** The old repo's real instances, per ADR 0070 and the remediation commits: identity on
  the commit object (a personal email on the author *and* committer line of all 190 commits);
  absolute paths containing a username (one in `docs/BUILD.md`, redacted here — this ticket's
  first draft quoted it verbatim, which is the rule failing inside its own statement); device and
  owner details (`docs/DEVICE.md` — twelve owner references, backup paths, a dated pull inventory);
  tool output (four tracked `.kotlin/errors/*.log`); and six places where sessions wrote device
  details and real-data inspection into *issues*. What else, and what is deliberately not on the
  list?
- **Commit zero.** The largest instance was a `git config` that had to be right before the first
  commit or not at all. Which parts of this must be true before `git init`, and what is the
  checklist that makes that happen?
- **The mechanism.** `../old_loop` reached `pre-push` + CI with six structural checks (#76,
  `8f5ac62`) on day seven. ADR 0070 concedes *"Text is not checkable."* So: which checks are
  genuinely structural, what does the hook do on a hit, and what is the false-positive budget before
  the hook gets disabled in frustration?
- **The tracker half.** This repo's issues live in `.scratch/` and go public with it. The old repo's
  tracker leaked in six places and its issue bodies were never mechanically checked.
- **Config is not authoritative, and this is measured, not hypothetical.** All three of this
  repo's first commits carry the owner's personal address as author *and* committer, stamped
  2026-09-22 08:19-08:28 — a full day after `~/.gitconfig` was corrected to the noreply address on
  2026-09-21 09:55. The cause, recovered from the session transcript: an agent session working in
  `../old_loop` ran `git -c user.name="..." -c user.email="<the personal address>" commit` for each
  one, overriding a correct config per invocation. It had been reading a repo whose history and 106
  issue bodies are saturated with that address, and matched what it saw.

  Two consequences for this ticket. First, **no check that reads configuration can work** — the
  check must run against the resulting commit object, which means a hook, and a hook is the only
  artifact the commit must pass through anyway (ticket 03's test). Second, **the archive is a
  contamination source**: every session that reads `../old_loop` to resolve a salvage citation is
  reading the exact strings this rule exists to keep out, and will pattern-match them as correct.
  That is a standing hazard for the length of this map, not a one-off.

  These three commits were corrected in the 2026-09-22 rewrite; the hazard was not.

**A minimal guard is already installed** (2026-09-22, `.githooks/pre-commit` + `.githooks/pre-push`,
enabled with `core.hooksPath`). It checks the commit identity and nothing else, reading `git var`
rather than `git config`. It exists so the repo is not unprotected while this ticket is open; it
does not pre-empt any decision here. Still undecided and still this ticket's: the content list,
whether the tracker half needs its own check, the false-positive budget, how a fresh clone gets the
hooks without a manual `git config`, and whether `--no-verify` should be answerable at all.

- **The escape hatch.** #107 accepted the owner's own data in seven bodies by name. Is there a
  declared exception, or does an exception mean the rule was wrong?

## Note after ticket 11

Orthogonal in charter, shared in enforcement point. 16 owns what may not **enter** the repo; 11 owns
what may be **claimed** in a document. Both land as checks in `.githooks/pre-commit` alongside the
identity guard and 17's two caps, and ticket 20 installs them together — worth knowing when this
ticket designs its mechanism, so the two are shaped to sit side by side rather than one wrapping the
other.

## Note after ticket 13

A small mitigation of the standing contamination hazard, not a solution. 13 decided that salvage
provenance resolves to `.scratch/post-mortem/` in this repo rather than to the archive, so a session
following a salvage citation now reads this repo's research files instead of opening `../old_loop`.
That narrows how often a session has the saturated strings in front of it; it does not close the
hazard, since the research files quote the archive and the rebuild's port pointers send sessions into
it deliberately.
