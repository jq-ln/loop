# Write the kit into this repo

Type: task
Status: open
Blocked by: 10, 11, 12, 13, 16, 17, 18, 19, 21

## Question

AFK, mostly. The map's Notes carry execution: *"the final task tickets write the kit into this
repo, because a post-mortem whose output is agreement has already failed once."* This is that
ticket, and its job is **placement and mechanism, not authorship** — every conclusion it writes
was decided in the ticket that owns it, and composing from gists rather than transcribing from
answers is the `:core-api` defect in miniature.

Ticket 15 already settled its own file word for word; expect the other rule-writing tickets to do
the same. Where a ticket's answer does not carry finished text, that is a defect in this ticket's
inputs and should be raised rather than papered over by drafting here.

- **Transcribe** each resolved ticket's confirmed text into its file. `GOALS.md` is fixed at ≤ 40
  lines and is already written verbatim in ticket 15's answer.
- **Install the mechanisms.** The `GOALS.md`-edited-alone hook (a commit whose diff includes
  `GOALS.md` and any other path fails), ticket 16's entry checks, and whatever 10, 11 and 19
  specify. The repo's existing commit-identity guard (`675f38e`) is the precedent and probably the
  enforcement point.
- **Wire the ownership table**: a row for `GOALS.md` owned by the human, and the one sentence in
  `GOALS.md` asserting it wins where any document conflicts with it.
- **Link, never copy.** `CLAUDE.md` references `GOALS.md` rather than restating it; one claim, one
  owner.
- **Check the result against the budget** ticket 11 sets, as a whole corpus, before the final
  commit. A kit that violates its own budget on the day it lands has already lost.

## Amendment after ticket 17

17 supplies finished text and four mechanisms. Its answer carries `PROCEDURE.md` verbatim (57
lines), so the transcription rule applies to it exactly as to `GOALS.md`: copy it, do not compose
from the gist.

**The artifacts to install:**

- **`PROCEDURE.md`** at the repo root, transcribed verbatim from 17's answer.
- **Two additions to `.githooks/pre-commit`**, joining the identity guard: a **worktree cap** (more
  than three worktrees other than the main one fails the commit, wherever it is made) and a
  **commit-size cap** (over 300 changed lines fails unless the message carries an
  `Oversized: <reason>` trailer). The size count excludes a short literal generated-paths list kept
  **in the hook itself** — 17 is explicit that a rule firing on the Gradle scaffolding commit trains
  the human to type the trailer reflexively and destroys the signal. `pre-push` is the existing
  `--no-verify` backstop and should be extended in kind.
- **A `PreToolUse` deny rule in `.claude/settings.json`** on agent-performed merges. This is 17's
  attachment — *the merge is the human's gesture* — and it is the only mechanism in the kit enforced
  harness-side rather than by git. No `.claude/` directory exists in this repo yet.
- **The day-one `justfile`**: `just start <ticket>`, `just check`, `just land`, `just goals`.
  `just check` ships **empty** by decision: its contents mean deciding the toolchain, which is the
  rebuild's business. `just land` is the composite gesture — show the diff and diffstat, run the
  review once, compare touched paths against the declared file list (shape owned by ticket 10), take
  the version decision (also 10), then merge. It also displays the break-a-test reminder, which takes
  **no input** — a field accepting any string is the failure class 17 spent a section rejecting.

**The edited-alone hook covers two files, not one.** 17 extends 15's mechanism to `PROCEDURE.md`, so
the check is that a commit whose diff includes either governed path and any other path fails.

**Two placement consequences.** The ownership table gains a row for `PROCEDURE.md` owned by the
human, alongside `GOALS.md`'s. And `CLAUDE.md` should lose whatever *how to run things* prose it
would otherwise have carried, because 17's rule is that a command worth documenting is a recipe —
a recipe that deletes no prose when it lands has not earned its place, and this ticket is where that
deletion actually happens.

One inherited check for the final pass: `PROCEDURE.md` earns its 60-line ceiling only by pointing at
mechanisms rather than restating them. If transcription leaves it describing what the hook does, the
hook and the file now both own that claim, and the kit has shipped the `:core-api` defect on day one.

## Amendment after ticket 11

11 supplies finished text for four artifacts and one repair. The transcription rule applies to all
of it: copy, do not compose.

- **A `## What may be written` section for `CLAUDE.md`**, transcribed verbatim. It points at the
  hook rather than restating it, and that is the only reason it passes its own comprehension test —
  if transcription leaves it describing what the check does, the hook and the file both own that
  claim and the kit has shipped the `:core-api` defect on day one, exactly as 17 warned for
  `PROCEDURE.md`.
- **Two additions to `.githooks/pre-commit`**, verbatim, joining the identity guard and 17's worktree
  and commit-size caps: a **corpus budget** firing only on commits that add a standing-claim file
  (cap 12, perimeter root `*.md` / `docs/**.md` / `.claude/**.md`, excluding `.scratch/`,
  `docs/adr/`, the justfile and generated files), and a **path-resolution check** on every governed
  file the commit touches. `pre-push` is extended in kind, as with 17's caps.
- **A `just adr <term>` recipe** in the day-one justfile, alongside `start`, `check`, `land` and
  `goals`.
- **A `Prior art:` field on the ADR template**, beside 15's goal citation — subject to 19, which owns
  whether the template exists at all.
- **The repair, which blocks the path check**: `docs/agents/issue-tracker.md:10` cites
  `triage-labels.md`, which does not exist in this repo. Create it — it is one of the expected nine —
  or delete the citation. Found by 11 while fixing the perimeter, and left for this ticket
  deliberately: it is the first thing the new check would refuse.

**The final pass now has a number.** The landed kit must be **≤ 12 standing-claim files, expected 9**
— `GOALS.md`, `PROCEDURE.md`, `CLAUDE.md`, `README.md`, `CONTEXT.md`,
`docs/agents/issue-tracker.md`, `docs/agents/triage-labels.md`, the salvage list (13) and the sketch
(18) — and the count is reported in the final commit message. A kit that lands at 12 has spent its
headroom before the rebuild starts and that fact should be visible, not discovered later.

## Note after ticket 11's correction: setup is not run

`/setup-matt-pocock-skills` is **not** run for this repo; 11's correction records why. The work it
would have done is this ticket's, and it is three steps:

1. **Leave `docs/agents/issue-tracker.md` as it stands.** It is already byte-identical to the skill's
   local-tracker template, and it is the file the skills actually read.
2. **Fold the five triage role strings into its `Status:` bullet and delete the `triage-labels.md`
   citation** (`docs/agents/issue-tracker.md:10`). That is the dead-reference repair: one line, one
   owner, no new file, and the path check passes.
3. **Write no `docs/agents/domain.md`.** Keep setup's `## Agent skills` block shape in `CLAUDE.md` —
   it is the discovery surface the skills expect — but point it at `CONTEXT.md` and `docs/adr/`
   directly rather than at a middleman document. Whatever domain.md would have said about consuming
   ADRs is owned by 11 (ADRs are leaves) and 19 (whether they exist at all), and a generated file
   saying otherwise would put the kit in conflict with itself on day one.

**The expected day-one count is 8, headroom 4** — `GOALS.md`, `PROCEDURE.md`, `CLAUDE.md`,
`README.md`, `CONTEXT.md`, `docs/agents/issue-tracker.md`, the salvage list (13), the sketch (18) —
and the count is reported in the final commit message.

If a later effort enables `/triage` or `/to-tickets`, running setup then is the fix, and its output
is edited on landing like any other draft.

## Note after ticket 12

12 resolved by **refusing to write a protocol**, so this ticket authors nothing new for it. Two
consequences for the files this ticket writes, and one instruction about a refusal.

**`SALVAGE.md` carries twelve entries, not ten, and the ceiling is this ticket's call.** 12 adds two
to the "Carry this" half, drafted verbatim in its answer: the device loop (a two-profile phone, the
on-device note file read beside the occurrence log, and the `-wal`/`-shm` pull procedure), and the
fidelity tax a rough variant charges before it can be judged. 13's draft is **54 lines** against a
hard 60 — note that 13's own prose says "~45 lines", which is stale against its own draft, and the
draft governs. The two entries are 8 lines, so the file lands at **62**.

12 does not hold 13's say over its file's bounds and does not claim it. The input that decides it is
the user's, recorded in 12 on 2026-09-24: *the 60-line rule was chosen arbitrarily, the reason there
is a cap at all is to clamp lines in files that are always loaded, and genuinely necessary context
should not be left out to avoid an arbitrary line limit.* `SALVAGE.md` is not always-loaded, its 60
was inherited from `PROCEDURE.md` rather than derived, and it is the one file in the kit that
shrinks. **Recommendation: lift `SALVAGE.md` to 65 and leave `PROCEDURE.md` at 60.** Trimming at
authorship is the alternative; dropping either entry is not, since the first is why the device
procedure exists at all and the second is the only warning the rebuild gets.

**The first entry is consumed by the commit that writes `docs/DEVICE.md`.** That file is not written
now — there is no device — and when it is, it takes a budget slot on its merits. The day-one count
of 8 is unchanged.

**Two instructions about what 12 refused**, so this ticket does not helpfully restore them:

- **Neither "bake-off" nor "trial" enters `CONTEXT.md`.** 12's body instructed that both be adopted
  into the glossary; its answer refuses, because a glossary entry for a mechanism the kit does not
  have is a standing claim with no referent. The salvage entries state the facts without the words.
- **Nothing about variants enters `PROCEDURE.md` or `CLAUDE.md`**, and no debug entry point is
  mentioned to 18. Both were considered and declined in the resolution, not overlooked.
