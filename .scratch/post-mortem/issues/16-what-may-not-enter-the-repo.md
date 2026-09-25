# What may not enter the repo, checked mechanically from commit zero

Type: grilling
Status: resolved

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

## Note after ticket 19

A third check arrives at the shared enforcement point, and one of 16's own boundaries is now in
question. 19 bans **citations of an ADR** — nothing outside `docs/adr/` may reference an ADR number,
and no ADR may reference another — enforced by a `pre-commit` grep for `ADR ?[0-9]{4}`. That is an
entry rule by any reading: a thing that may not enter the repo, refused at the commit that
introduces it. It joins 11's budget check and 17's two caps beside the identity guard, and ticket 20
installs it with them.

Two things worth knowing when this ticket designs its mechanism:

- **The perimeter question is live.** 19's ban reaches **code comments** — the largest single source
  of ADR citations in the old repo, 142 of 366 — and resolves them by having the comment state the
  claim rather than point at where it is argued. If 16's perimeter is documents only, this check sits
  outside it while sharing its enforcement point, which is exactly the "one wrapping the other" shape
  11's note warned against. If 16's perimeter is the whole tree, 19's rule is a clause of 16's.
- **The known gap is the same shape as 16's escape hatch.** The grep catches the *form*, not the act:
  a citation phrased as a bare ADR title passes it. 19 accepted that limit explicitly rather than
  widening the pattern, on the grounds that a fuzzy check is worse than a stated gap. If 16 reaches a
  different answer on #107's by-name exception, the two should at least be inconsistent on purpose.

## Answer

Everything below was measured against this tree before it was decided. The headline reframes the
ticket: **the old repo's four structural checks report a clean tree while a home-anchored backup
path, a device model and a device profile id sit in a tracked file.** They are not quoted here, for
the reason this ticket keeps rediscovering. The pattern set failed, not the mechanism — the
old check covered `/Users/` and `/home/` and never the tilde form, which is where **31 of the 49**
path instances in this repo actually are.

The second headline is the verdict the ticket was blocking on. Across all 17 commits' content, both
checked classes report **zero hits excluding one file**, and identity is clean on every author and
committer line. The entire content exposure of this repository is `research/02-issues-raw.json`.

### The perimeter: every tracked path, no exclusions

16's perimeter is the whole tree. `.scratch/` is **inside** it, though it sits outside 11's budget
perimeter, and the reason the two differ is the point: what earns `.scratch/` its budget exclusion is
that it holds *dated records rather than standing claims* — a fact about claim-hood that says nothing
whatsoever about a home path. A tilde path in a dated record discloses exactly what one in `CLAUDE.md`
discloses. Every real instance in this repo is in `.scratch/`, which settles it empirically rather
than by argument.

So the shared enforcement point holds **three checks across two perimeters**: 16 and 19 are tree-wide,
11 is standing-claim-only. Stated here so nobody later reads one as wrapping another — the shape 11's
note warned against. 19's ADR-citation ban is tree-wide and therefore consistent with this perimeter,
but a citation is not personal data and **19's rule stays 19's**; it is not absorbed as a clause of
16.

### The list: four classes, two of them checked by pattern

1. **Commit identity** — author and committer, read from `git var` so that `-c` and environment
   overrides are seen. Installed 2026-09-22 and holding across all 17 commits.
2. **Home-anchored filesystem paths** — `/Users/<user>`, `/home/<user>`, **and the tilde forms**
   `~/Documents`, `~/Desktop`, `~/Downloads`, `~/Library`, `~/Projects`. The widening to tilde is the
   single highest-value correction in this ticket: without it the check passes on a tree containing
   the backup paths, which is precisely what the old repo's version did.
3. **Personal-domain email addresses** — `@icloud`, `@gmail`, `@me`, `@hotmail`, `@outlook`, `@yahoo`.
   Measured: **zero hits even with the dump included.** The five `icloud.com` occurrences there are
   bare domain names inside the old repo's own check commands, not addresses. This class has never
   been violated in this repo and is carried as a standing guard, not a repair.
4. **Generated and tool output** — by `.gitignore`, which **does not exist in this repo**. 03's table
   is unambiguous: the `.gitignore` held at **+1 day** latency, the prose statement of the same rule
   at **−5 days**. This is the cheapest item on the list and its absence was the only live gap in the
   mechanism set.

**On the rule, off the check: device and owner-environment details** — a phone model, a profile id, a
backup location, a dated pull inventory. ADR 0070's *"text is not checkable"* binds, and a fuzzy
pattern here is the shape 19 rejected on principle. This clause rests on 17's reading gate and on
nothing else, and is labelled that way in the text — the third clause in the kit to carry that label
honestly.

### Deliberately not on the list: the author's identity

The owner's name appears **348 times** in tracked files. 346 are the GitHub API's `"name"` field on
the `author` object — the public profile name. One is `Copyright 2025-2026 <name>`, which a licence
*requires*: a legal name is the entire point of a copyright line. The handle (`jq-ln`, `jqln`) is
inside the mandated noreply address itself and inside the package namespace `dev.jqln.loop`.

A name check therefore fires 348 times on day one and **every hit is correct as written**. That is
the hook being disabled in frustration, in week one, from the list's own contents.

The distinguishing test, stated as a boundary rather than left as an omission:

> The rule bans data disclosing **the machine or the private environment**. It does not ban data
> **identifying the author**, because publication is the goal and identification is what publication
> is.

### The false-positive budget is a command, not a feeling

> **A check is installed only if it reports zero hits on the tree as it stands at the moment of
> installation.**

Testable at install time, never degrades, and it converts the ticket's open question into something
runnable. A pattern that cannot reach zero is narrowed or dropped, and what it would have caught goes
to the reading gate. **Verified for both pattern classes: zero, with the dump excluded.**

This budget also makes whole-index checking safe. The normal objection — an innocent commit refused
for a file it never touched — is impossible by construction: the tree is clean when the check lands,
so any hit is content that this commit introduced.

### `research/02-issues-raw.json`, and the publish verdict

The dump is 857 KB — **72% of the repository by bytes** — read by nobody, and it holds all 49 path
instances, the device model and the profile id. It is tool output by the old repo's own definition: an
unreviewed API dump that arrived in a commit about something else.

**Decision: untrack it and keep it on disk outside the repo**, beside `../old_loop`. The seven
research findings are read, written and clean, and they stay.

Untracking does not unpublish it. The dump has been present since `9571165`, so it is in **16 of the
17 commits**, reachable by object id through the API forever once the remote exists. Which produces
the verdict:

> **Missing commit zero costs one history rewrite, and nothing else — and the rewrite is free.**

The rewrite is the one-time irreversible instrument only once SHAs are *published*. This repo has **no
remote, one branch, no tags, 17 commits, and no blame anyone depends on**. `filter-repo --invert-paths`
on a single path costs a rerun of the hooks. The old repo spent the instrument at 195 SHAs with a live
remote; this repo does not spend it at all. **That retires 14's blocker.**

Two conditions on the act, both belonging to the human: a history rewrite is exactly the class 17
reserved as *the human's gesture*, so no agent performs it; and afterwards the install budget is
re-run as verification — both classes must report zero, or it did not work.

### What the check reads, and what it prints

`git grep --cached` over the whole index at `pre-commit` — the index is what is being committed. The
alternative, checking only the staged diff, misses content that entered before the check existed, and
after the rewrite nothing has.

On a hit the hook prints **path, line and class — never the matched text**. This is the ticket's own
lesson landing for the third time: its first draft quoted the `docs/BUILD.md` path verbatim, the old
repo's `.gitignore` rule did not, and a hook that echoes the string writes the banned data into
terminal scrollback, CI logs and the session transcript. The redaction is structural — `cut -d: -f1,2`
on git's own output — not a sed over content that could miss.

One further property, verified rather than asserted: **the hook's own pattern text does not match its
own patterns.** ADR 0070's version had two standing "expected hits" because the rule quoted its own
before-half and had to except itself. Here `/Users/[A-Za-z]` contains `/Users/` followed by `[`, so
the rule is clean against itself by construction and needs no exception to stay at zero.

### The tracker half: answered by the perimeter, with a consequence for 14

No separate check. Under a tree-wide perimeter every issue body is a tracked file and passes exactly
the check every other path passes.

That is worth stating for what it closes. The old repo's tracker leaked in six bodies and #76 recorded
why: *an issue never passes through a commit*, so no hook could reach it. **This repo's local tracker
closes that hole by construction, and it was free.** Migrating to GitHub Issues would reopen it
permanently.

16 does not decide the tracker; it states the requirement and 14 applies it:

> **Issue bodies pass the same mechanical check as every other tracked path.** A tracker that cannot
> offer one does not satisfy the entry rule.

Said plainly: this will refuse GitHub Issues unless 14 finds a mechanical check for remote bodies.
It now joins 13's constraint on the same decision from the other side — `SALVAGE.md` cites
`.scratch/post-mortem/`, so migrating also breaks a governed document's path check. Two independent
constraints, same direction, neither of them a veto issued by this ticket.

### The escape hatch: there is none

#107 accepted *the owner's own data* by name. Since the name was never banned, no exception is needed
— the case that motivated the question dissolves rather than being carved out.

**No declared exception exists.** An exception list is a second artifact to read plus a per-instance
judgement an agent will imitate rather than apply. When a genuine case arrives, **the rule is edited**
— by the human, in a commit that says why — which is the identical knob-shape 11 gave the cap of 12,
and those commits are the data that tunes the pattern set.

This answers 19's request to be inconsistent on purpose rather than by accident: **19 has a stated gap
and no exception; 16 has no gap and no exception.** Different shapes, both deliberate.

### Delivery and bypass

- **Delivery.** `core.hooksPath` is not cloned, so a fresh clone is unprotected until someone types a
  `git config`. `just start` asserts it and refuses otherwise. 10 already made `just start` mandatory
  and already refusing, so this costs no new artifact and rides on a command the work must pass
  through anyway — 03's clean-record class.
- **Bypass.** `--no-verify` remains unanswerable at commit time, and that is acceptable: `pre-push`
  re-runs the **content** checks over every commit in the pushed range, as it already does for
  identity. Nothing reaches the remote unchecked, and the remote is what publication means.

### Placement

A second section in `CLAUDE.md`, `## What may not enter the repo`, adjacent to 11's
`## What may be written`, pointing at the hook and never restating the patterns. **No new file**;
the day-one count stays at 8 with headroom 4.

Two sections rather than one merged section, because two perimeters — and the section headings are
where a reader learns that. Merging them would re-blur exactly what this ticket separated.

### Out of scope: the pre-`git init` checklist

The ticket asked which parts must be true before `git init` and what checklist makes that happen. This
repo has already missed it and the cost is priced above at one free rewrite. A checklist for a
repository that does not yet exist is an artifact for a future effort, and writing it against an
unchosen next project is the F-Droid failure one layer down — the same reason 10 declined to fix a
version cadence.

**Out of scope**, recorded as such on the map. The one residue that is genuinely this repo's is a
sentence, not an artifact: *the hook is installed before the first commit, not after it* — and Q6's
`just start` assertion is the only ongoing mechanism it needs.

### The contamination hazard

Nothing further is owed mechanically, and one thing is owed in writing.

The `<user>` redaction is **already practised 8 times across 3 files and is nowhere declared** — a
working convention with no owner, which is how `docs/DEVICE.md`'s paths went stale in the old repo. It
becomes one line in the `CLAUDE.md` section: *a quotation from the archive is redacted at the point of
quoting, and the form is `<user>`.*

A `PreToolUse` deny on reads under `../old_loop` is **refused**, though 20 installs that machinery for
merges anyway. 13 deliberately kept the port pointers that send sessions into the archive, and a rule
that breaks the kit's own salvage path fails 09's comprehension test. The residue stays with 17's
reading gate, labelled as resting on nothing.

### Both tests, applied to this ticket's own mechanisms

09's ordered pair: comprehension first, then 03's latency test.

| Mechanism | Comprehension | Latency (what it rides on) |
|---|---|---|
| Identity guard | Passes: instrument, adds nothing to read | `pre-commit` + `pre-push`; installed, holding |
| Two pattern classes | Passes: instrument, adds nothing to read | `pre-commit`, on the commit that introduces the text |
| `.gitignore` | Passes by subtraction: removes a class of file | the mechanism with the best record in 03's table |
| Zero-hit install budget | Passes: a command, not a document | the act of installing a check |
| Path/line-only reporting | Passes: shrinks what the hook emits | the hook's own output |
| `just start` hooks assertion | Passes: no new artifact; a line in a recipe that must run | `just start`, already mandatory and already refusing |
| Device details, unchecked | Passes: no new artifact | **nothing** — 17's reading gate, labelled as such |
| Redaction convention | Passes: names a practice that already exists | the act of quoting; unenforced by design |
| The `CLAUDE.md` section | Passes only because it points at the hook rather than restating it | the always-loaded file |

The row that would have failed is the one not written: a device-detail pattern. Not because it cannot
reach zero — once the dump is untracked, no device detail remains anywhere in the tree — but because
**the class has no enumerable form**. A device model is any of thousands of strings, a backup location
is arbitrary prose, and a profile id is a two-word phrase no pattern separates from ordinary text.
That is ADR 0070's *"text is not checkable"* stated precisely: the class is defined by meaning, not by
form, and this ticket's budget can only ever bind on form.

### The text, confirmed

**`.gitignore`** at the repo root, ported verbatim from `../old_loop` — 14 lines, including the two
comments that carry their own reasoning. It is not a `*.md` file, so it spends no budget headroom.

```gitignore
*.iml
.gradle/
local.properties
.idea/
.DS_Store
build/
captures/
.externalNativeBuild
.cxx

# Personal Claude Code permissions; shared config would be .claude/settings.json.
.claude/settings.local.json

# Tool output. The compiler writes errors/ and sessions/ here; neither is ours.
.kotlin/
```

**`.githooks/pre-commit`**, joining the identity guard, 17's two caps, 11's budget and path checks,
and 19's citation grep:

```sh
# ---- Entry rule (ticket 16) -----------------------------------------------
# What may not enter the repo. The perimeter is every tracked path with no
# exclusions — .scratch/ included, because what makes a dated record safe for
# 11's budget does nothing about a home path.
#
# These patterns were installed only because they report ZERO hits on the tree
# as it stands. Any hit is therefore content this commit introduced. If a
# pattern cannot reach zero, narrow it or drop it. Do not add an exception:
# there are none, by decision. If a pattern is wrong, the pattern is edited,
# by the repository's owner, in a commit that says why.
#
# It prints the path, the line and the class, never the matched text: a hook
# that echoes the string writes the banned data into scrollback, CI logs and
# the session transcript. The redaction is `cut`, not a sed over content.
#
# The patterns do not match their own text here — /Users/[A-Za-z] contains
# "/Users/" followed by "[", not a letter. ADR 0070's version had to except
# itself; this one does not.

entry_check() {
    class=$1
    pattern=$2
    hits=$(git grep --cached -nIE -e "$pattern" -- . 2>/dev/null || true)
    if [ -n "$hits" ]; then
        printf '\n  Blocked: %s\n' "$class"
        printf '%s\n' "$hits" | cut -d: -f1,2 | sed 's/^/    /'
        return 1
    fi
    return 0
}

entry_fail=0
entry_check 'home-anchored filesystem path' \
    '/Users/[A-Za-z]|/home/[A-Za-z]|~/(Documents|Desktop|Downloads|Library|Projects)/' || entry_fail=1
entry_check 'personal-domain email address' \
    '[A-Za-z0-9._%+-]+@(icloud|gmail|me|hotmail|outlook|yahoo)\.(com|co\.uk)' || entry_fail=1

if [ "$entry_fail" -eq 1 ]; then
    cat <<'MSG'

  This repo is public from its first commit. Nothing here can be edited out
  later, only excised by rewriting history, and that instrument is cheap only
  while the repo is unpublished.

  Redact it. The form is <user>. Do not add an exception; there are none.

  Only the path and line are shown above -- the hook does not print what it
  matched. Open the file.

MSG
    exit 1
fi
```

**`.githooks/pre-push`**, extended in kind, inside the existing loop over the pushed range:

```sh
    for sha in $range; do
        for spec in \
            'home-anchored filesystem path=/Users/[A-Za-z]|/home/[A-Za-z]|~/(Documents|Desktop|Downloads|Library|Projects)/' \
            'personal-domain email address=[A-Za-z0-9._%+-]+@(icloud|gmail|me|hotmail|outlook|yahoo)\.(com|co\.uk)'
        do
            class=${spec%%=*}
            pattern=${spec#*=}
            hits=$(git grep -nIE -e "$pattern" "$sha" -- 2>/dev/null || true)
            if [ -n "$hits" ]; then
                printf '  Blocked: %s in %s\n' "$class" "$(git show -s --format='%h %s' "$sha")"
                printf '%s\n' "$hits" | cut -d: -f1,2,3 | sed 's/^/    /'
                status=1
            fi
        done
    done
```

Each tree costs 0.064s measured, so a full-history push of this repo costs about a second — the same
per-commit shape the identity backstop already uses.

**`CLAUDE.md`**, a section beside 11's `## What may be written`:

```markdown
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
`../old_loop` is where the identity error in this repo's first three commits came from, and reading it
is how that error propagates.

**Device and owner-environment details** — a phone model, a profile id, where a backup lives — are
refused by this rule and checked by nobody. Text is not checkable. This clause rests on the reading
gate in `PROCEDURE.md` and on nothing else.
```

**The `just start` assertion**, one line folded into the recipe 10 owns:

```just
    @test "$(git config core.hooksPath)" = ".githooks" || \
        { echo "core.hooksPath is not .githooks -- run: git config core.hooksPath .githooks"; exit 1; }
```

### Consequences for other tickets

- **14 is unblocked**, and gains two things. The **rewrite before the first push**: untrack
  `research/02-issues-raw.json`, move it beside `../old_loop`, excise the path from all 17 commits
  with `filter-repo`, then re-run the install budget. The human performs it. And the **tracker
  requirement**: issue bodies pass the same mechanical check as every other tracked path, which
  refuses GitHub Issues unless 14 finds a check for remote bodies.
- **20 gains** `.gitignore` verbatim; the `pre-commit` entry block and `pre-push` extension verbatim;
  the `CLAUDE.md` section verbatim; and the `just start` assertion line. Count unchanged at 8,
  headroom 4 — `.gitignore` is not a standing-claim file.
- **20 owes one repair**, the same shape as 11's dead reference and left here for the same reason:
  two live citations of the dump must go — `issues/02-issue-lifecycle.md:26`'s markdown link and
  `research/02-issue-lifecycle.md:8`'s raw-evidence line. The research file already states its counts
  self-containedly, so both are deletions rather than rewrites.
- **19** gets its inconsistency stated on purpose: 19 has a stated gap and no exception, 16 has no gap
  and no exception.
- **11's perimeter is untouched** and is now explicitly a *different* perimeter from 16's, not a
  narrower reading of the same one.
- **The map's Out of scope** gains the pre-`git init` checklist.
