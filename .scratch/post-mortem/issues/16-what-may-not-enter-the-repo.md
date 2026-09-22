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
- **The escape hatch.** #107 accepted the owner's own data in seven bodies by name. Is there a
  declared exception, or does an exception mean the rule was wrong?
