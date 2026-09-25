# Write the kit into this repo

Type: task
Status: resolved
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
`README.md`, `CONTEXT.md`, `docs/agents/issue-tracker.md`, the salvage list (13) and
`ARCHITECTURE.md` (18) — and the count is reported in the final commit message.

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

## Amendment after ticket 16

16 supplies finished text for four artifacts, one recipe line, and one repair. The transcription rule
applies to all of it: copy, do not compose.

- **`.gitignore`** at the repo root, ported verbatim from `../old_loop` — 14 lines, including the two
  comments that carry their own reasoning. It does not exist in this repo, and it is the mechanism with
  the best record in 03's entire table (held at **+1 day**; the prose statement of the same rule at
  **−5 days**). It is not a `*.md` file, so it spends no budget headroom.
- **An entry-rule block in `.githooks/pre-commit`**, verbatim, joining the identity guard, 17's two
  caps, 11's budget and path checks, and 19's citation grep. Two pattern classes — home-anchored
  filesystem paths (widened to the tilde forms) and personal-domain email addresses — over
  `git grep --cached` on the whole index, perimeter **every tracked path with no exclusions**.
- **A matching extension to `.githooks/pre-push`**, verbatim, inside the existing range loop: the same
  two classes per commit, since `--no-verify` is not answerable at commit time and content in an
  intermediate commit is published exactly as tree content is.
- **A `## What may not enter the repo` section for `CLAUDE.md`**, verbatim, adjacent to 11's
  `## What may be written`. Two sections, not one merged section, because they govern **two different
  perimeters** and the headings are where a reader learns that. Count unchanged at **8, headroom 4**.
- **One line for the `just start` recipe** that 10 owns: assert `core.hooksPath` is `.githooks` and
  refuse otherwise. `core.hooksPath` is not cloned, so a fresh clone is unprotected until someone types
  a `git config`; `just start` is already mandatory and already refusing, so this costs no artifact.

**The repair, same shape as 11's dead reference and left here for the same reason.** 16 untracks
`research/02-issues-raw.json`, so its two live citations must go: the markdown link at
`issues/02-issue-lifecycle.md:26` and the raw-evidence line at `research/02-issue-lifecycle.md:8`. The
research file already states its counts self-containedly, so both are deletions rather than rewrites.

**Three properties of the hook text that must survive transcription**, because each is load-bearing and
each looks like an accident:

1. **It prints path, line and class — never the matched text.** The redaction is `cut -d: -f1,2` on
   git's own output, not a sed over content that could miss. A hook that echoes the string writes the
   banned data into scrollback, CI logs and the session transcript.
2. **The patterns do not match their own text.** `/Users/[A-Za-z]` contains `/Users/` followed by `[`.
   ADR 0070's version carried two permanent "expected hits" because the rule quoted its own before-half
   and had to except itself; this one needs no exception to stay at zero. Reformatting the patterns
   could break this silently.
3. **The comment stating the install budget is not decoration.** A check joins the hook only if it
   reports zero on the tree as it stands — which is what makes whole-index checking safe, since any hit
   is then content that commit introduced. Verified zero for both classes at resolution; **re-verify
   after the rewrite 14 performs**, because that is when it stops being true or stays true.

**No exception mechanism, deliberately** — no trailer, no override string, no allowlist. A wrong pattern
is edited by the repository's owner in a commit that says why, the same knob-shape 11 gave the cap of 12.

## Note after ticket 21: there is no ownership table

21 resolved by refusing the artifact, so **three instructions in this ticket are retracted** and
must not be executed as written:

- **"Wire the ownership table"** (this ticket's fourth bullet). There is no table. An agent
  transcribing that bullet would invent the artifact 21 refused.
- **"The ownership table gains a row for `GOALS.md` owned by the human"** (from 15).
- **"The ownership table gains a row for `PROCEDURE.md` owned by the human"** (from 17's amendment,
  under *Two placement consequences* — the second consequence in that paragraph, about `CLAUDE.md`
  losing its how-to-run-things prose, **stands**).

Nothing is lost by the retraction and no replacement text is owed: `GOALS.md` and `PROCEDURE.md`
already state their own bounds verbatim, in the paragraph between the H1 and the first H2, and that
paragraph *is* the ownership declaration. `docs/agents/issue-tracker.md` already conforms as it
stands. Ownership is expressed by each file about itself; `just owns` generates the index by reading
those paragraphs, so the index cannot disagree with its sources.

**Four artifacts to install, all transcribed verbatim from 21's answer:**

1. **The `just owns` recipe**, making the day-one justfile six recipes: `start`, `check`, `land`,
   `goals`, `adr`, `owns`.
2. **A declaration check in `.githooks/pre-commit`**, placed **after** 11's path-resolution block
   because it reuses that block's `$touched` and `governed()`. Extend `pre-push` in kind, as with
   17's and 11's checks.
3. **`CLAUDE.md`'s own declaration paragraph**, immediately after its H1. It states that `CLAUDE.md`
   is the **residual owner** — it owns whatever no other file owns — which is what makes 11's
   eviction rule executable at 2am instead of producing a new file.
4. **An amended second paragraph of `## What may be written`**, replacing the one 11 confirmed. It
   adds the `Folded: <claim> -> <file>` trailer, the residual-owner fallback, and the one clause of
   the old table worth keeping: *where a document disagrees with the code, the code wins and the
   document is a bug.*

**One repair on transcription.** 11's confirmed `## What may be written` text reads *"The kit landed
with 9"*. 11's own later correction sets the day-one count at **8, headroom 4**. Transcribing
verbatim lands the wrong number, so correct it to 8 — and the final pass reports the real landed
count in the commit message regardless.

**A new commit trailer to know about.** `Folded: <claim> -> <file>`, owed only on a commit that folds
a claim because the cap refused a file. At 8 of 12 it cannot fire on day one; it exists so that
`git log --grep='^Folded:'` later says whether the cap is mis-sized. It joins `Oversized:` (17) as
the kit's second trailer, and like it, has no exception mechanism.

## Amendment after ticket 18

18 resolves last of the nine and **declares this ticket unblocked**. It supplies finished text for two
artifacts and retires a word. The transcription rule applies as everywhere else: copy, do not compose.

**The kit's word is `ARCHITECTURE.md`, and "sketch" is retired.** It named a drawing — a description —
and 18's whole finding is that the file is not one but a set of constraints. Both file lists above are
written in the old word; the live one is corrected, and the superseded nine-file list under *Amendment
after ticket 11* is left as written, like every other superseded passage here.

**Two artifacts to install, both transcribed verbatim from 18's answer:**

1. **`ARCHITECTURE.md`** at the repo root — 40 lines, six sections, **with no line cap**. The absence
   is a decision, not an oversight: per-document ceilings exist only for the always-loaded set, and 11
   declined on principle to invent one after 07 showed the usual number to be unmeasured folklore. 13
   inherited 60 anyway and landed at 62, which is what inventing one costs. Do not add a ≤ *n*-line
   check beside the others for this file.
2. **A `pre-commit` block**, verbatim, joining the identity guard, 17's two caps, 11's two checks,
   19's citation grep, 21's declaration check and 16's entry-rule block. It fires **once in this
   repo's life** — on the commit that adds the first Kotlin source file — reads the staged copy, so
   writing the sections and adding the code in one commit is allowed, and checks **presence, never
   quality**. 18 places it in `pre-commit` only and specifies no `pre-push` twin; unlike 17's, 11's,
   21's and 16's checks, this one is not extended in kind. Do not helpfully add one.

**`ARCHITECTURE.md` needs no declaration paragraph written here.** 21 requires the text between the H1
and the first H2 to say what the file owns; 18 wrote it rather than leaving it to this ticket, so it
arrives inside the verbatim block. It also flags its own weak point — *"Exactly one pure-Kotlin module
holds the engine"* is the line closest to the structural fact 11 bans — and that flag is 18's to hold,
not something transcription should soften.

**One claim is routed here rather than authored here.** 18 declined to duplicate the **module/plugin
disambiguation** and left it where 13 put it: `CONTEXT.md`. Module is a Gradle build unit; plugin is a
separately installed app. 18 uses the words correctly and states the distinction nowhere, so one claim
keeps one owner.

**The count is unchanged at 8, headroom 4.** `ARCHITECTURE.md` *is* the eighth file — the entry the
earlier lists call "the sketch (18)" — not a ninth. 11 is confirmed rather than amended on this point.

### Two input defects, raised rather than drafted around

This ticket's own rule is that where a resolved ticket's answer does not carry finished text, that is a
defect in this ticket's inputs. Two of the day-one eight have none, and checking 18 is what surfaced
them:

- **`CONTEXT.md`** has exactly one entry and two explicit non-entries. The entry is the module/plugin
  disambiguation above, which survives only as a clause inside 13's routing sentence, not as confirmed
  file text. The non-entries are 12's refusal of "bake-off" and "trial". No ticket supplies an H1, a
  declaration paragraph, or any further term — and 21's check refuses a governed file without one.
- **`README.md`** is authored by no ticket at all. 13 does not mention it; 21's only two mentions say
  what it is *not* asked to do, and one of them — *"`README.md`'s opening is a pitch to a stranger and
  declares nothing; it passes, and is left as a pitch"* — exempts a file that does not exist. Every
  other reference across the nine is to the first repo's README, quoted as evidence, or to
  `docs/adr/README.md`, which 11 forbids.

Both are counted in the day-one eight and both are reported in the final commit message, so neither can
be quietly dropped. Drafting them here is what this ticket exists to refuse.

## Answer

AFK session, 2026-09-24, resolved in one pass and committed to `main` as `33abe66`, with one
follow-up correction as `c22e6e4`. Two decisions were put to the user and both recommendations were
accepted; everything else followed from the nine resolved tickets or from measurement against this
tree. No conclusion here was composed from a gist.

**The kit landed at 7 standing-claim files of 12, headroom 5** — `GOALS.md`, `PROCEDURE.md`,
`SALVAGE.md`, `ARCHITECTURE.md`, `CLAUDE.md`, `CONTEXT.md`, `docs/agents/issue-tracker.md` — and the
count is in the commit message, as 11 required. The day-one estimate was 8. `README.md` is the
difference, and it is now [Write the README](22-the-readme.md) rather than a file drafted here.

### What was transcribed, and verified as transcribed

Each block was extracted from its ticket programmatically, and where the block is a whole file it
was diffed against the written file rather than proofread by eye.

| Artifact | Source | Result |
|---|---|---|
| `GOALS.md` | 15 | byte-identical, 39 of 40 lines |
| `ARCHITECTURE.md` | 18 | byte-identical, 42 lines, no cap |
| `.gitignore` | 16 | byte-identical, 15 lines |
| `pre-commit` entry rule | 16 | verbatim |
| `pre-push` entry extension | 16 | verbatim, inside the existing range loop |
| `pre-commit` budget and path checks | 11 | verbatim |
| `pre-commit` declaration check | 21 | verbatim, after 11's path block as specified |
| `owns` recipe | 21 | verbatim |
| `adr` recipe | 11 | verbatim, widened per 19 |
| the `core.hooksPath` assertion | 16 | verbatim |
| `CLAUDE.md` declaration paragraph | 21 | verbatim |
| `## What may be written` | 11 + 21 | 21's amendment substituted for 11's second paragraph |
| `## What may not enter the repo` | 16 | verbatim |
| `PROCEDURE.md` | 17 + 10 | 17's text with 10's two amendments, 59 of 60 lines |
| `SALVAGE.md` | 13 + 12 | 13's text with 12's two entries, 62 lines |

Two line counts in the tickets' prose are wrong against their own blocks, and the blocks govern: 18
says `ARCHITECTURE.md` is 40 lines and its block is 42; 16 says `.gitignore` is 14 and its block is
15. Neither file has a cap, so nothing turns on it. 12's arithmetic was exact: `SALVAGE.md` landed
at 62.

**`SALVAGE.md`'s ceiling is lifted to 65**, which 12 handed to this ticket as its call, on 12's
recommendation and on the user's recorded input that the 60 exists to clamp always-loaded files.
`PROCEDURE.md` stays at 60. Nothing was trimmed.

### Where mechanism was implemented rather than transcribed

The transcription rule binds *conclusions*. Several tickets specified a mechanism precisely without
writing the shell for it, and writing it is this ticket's stated job — placement and mechanism.
Those: 17's worktree cap and size cap, 19's citation grep, 13's line-cap check, 15 and 17's
edited-alone hook, and the `start` / `claim` / `land` / `drop` / `goals` recipes. Each is
implemented to the letter of the ticket that specified it, and each names that ticket in a comment.

**The edited-alone hook fires on modification, not on the commit that adds the file.** There is no
goal to change before `GOALS.md` exists, and the kit had to land in one commit. That is the shape of
11's budget check, which fires only on an add, and of 18's gate, which reads the staged copy — an
existing pattern rather than an exception invented for the landing.

**The justfile has eight recipes, not six.** 10 says it grows from four to six by adding `claim` and
`drop`; 21 says six by adding `adr` and `owns`. Each count was written without the other. The union
is `start`, `claim`, `check`, `land`, `drop`, `goals`, `adr`, `owns`.

### Five corrections to the inputs, argued rather than applied quietly

1. **The commit-size cap is in `.githooks/commit-msg`, not `pre-commit`.** 17 and this ticket both
   place it in `pre-commit`, which cannot work: `pre-commit` runs before the message exists.
   Measured rather than reasoned — on a second commit `pre-commit` reads the *previous* commit's
   message out of `COMMIT_EDITMSG`, so a cap checked there is satisfiable by an earlier commit's
   trailer. That is a check passing on stale data, which is worse than no check and is exactly the
   class this map has spent itself cataloguing. `commit-msg` receives the message as `$1` while the
   index is still staged, so both halves of the rule are available at one moment. `pre-push` carries
   the per-commit twin.

2. **19's citation pattern is dropped and replaced.** 19 specifies `ADR ?[0-9]{4}`, taken from the
   first repo's forensics. Three measured objections: under 10's date-and-slug naming this repo's
   ADRs carry no number, so the pattern **cannot match a citation of any ADR that will ever exist
   here**; it reports 179 hits on the archive references in `.scratch/`, failing 16's install
   budget; and it matches the ADR number quoted inside 16's own verbatim hook comment, so it would
   have to except itself — the defect 16 states it was designed to avoid. Installed instead:
   `docs/adr/[0-9A-Za-z]`, which matches a reference to a file *under* `docs/adr/` and not the bare
   directory `CLAUDE.md` names. It is self-safe the way 16's patterns are, covers both halves of
   19's direction rule in one line, and reports zero outside `.scratch/`. `.scratch/` is excluded
   because every reference there is to the **first** repo's ADR files, quoted as evidence in a dated
   record, pointing at nothing this repo can delete.

3. **11's path-check token filter is narrowed to skip placeholders and absolute paths.** As written
   it refused `docs/agents/issue-tracker.md` on eight tokens — `.scratch/<effort>/map.md` and its
   siblings — which are a naming convention, not a claim about this tree, in the one file this
   ticket was told to leave as it stands. The filter already skipped `*` and `?` for that reason;
   angle brackets join them, and so do absolute paths, which a governed document has no business
   citing. **The cost is stated in the hook**: 11's worked example, the generated `domain.md`,
   asserted `src/<context>/docs/adr/` and `CONTEXT-MAP.md`; under this filter the first is skipped
   and only the second fires. The defect is still caught, by one token instead of two. 11's claim to
   have checked this file found one dead reference and missed eight.

4. **Two stale claims in 11's confirmed `CLAUDE.md` text.** *"The kit landed with 9"* became 8,
   which 21 flagged for repair here; the real landed count of 7 is in the commit message. And 11's
   **ADRs are leaves** paragraph is restated in 19's confirmed words as the direction rule, dropping
   *"its number never reused"* — which 10 established has no referent under date-and-slug naming,
   and which 19 rewrote without handing back replacement `CLAUDE.md` text.

5. **The merge denial fired on the session that installed it**, and was narrowed in `c22e6e4`. Its
   first pattern matched the raw command string, so a command whose heredoc merely wrote the words
   into a document was refused — and that refusal blocked the command that would have fixed it.
   Narrowed to a command position rather than excepted, per 16. Testing then found two more defects
   reading had not: a word boundary caught `merge-base`, which the landing recipe itself runs, and a
   backtick was wrongly treated as a command position. Eleven cases now behave as specified. This is
   the kit's first piece of evidence about itself, and it says the coarse version of a harness-side
   rule is the one that gets switched off.

### The two input defects, and how each was settled

Both were raised to the user rather than papered over, which is what this ticket exists to do.

- **`CONTEXT.md` had no confirmed text and could not be omitted.** Three confirmed files cite it in
  backticks — `GOALS.md`, `ARCHITECTURE.md` and `CLAUDE.md` — so 11's own path check refuses the kit
  without it. The user chose to have it written to its forced minimum here: an H1, a declaration
  paragraph derived from what those three files already say it owns, and 13's one confirmed entry,
  the module/plugin disambiguation. 12's two refusals are honoured — neither *bake-off* nor *trial*
  appears. **This is the one place this ticket authored prose**, and it is labelled as such.
- **`README.md` is authored by no ticket at all.** 21's only substantive mention exempts a file that
  did not exist. It is cited by nothing, so it blocks nothing, and a pitch to a stranger about the
  author's own work is not transcribable from a post-mortem. Deferred; the count drops to 7 and the
  commit says so.

### The undeclared blocker

16's install budget is that a check joins the hook only if it reports zero on the tree as it stands.
The entry rule reported **17 home-path hits, every one in
`.scratch/post-mortem/research/02-issues-raw.json`** — so the kit's headline mechanism could not be
installed while that file was indexed, and this ticket does not list 14 as a blocker. Split on the
user's decision, along the line 16 itself draws: the **untrack** is 16's own decision and is
reversible, so it happened here, the file moved to `../old_loop-issues-raw.json`; the **history
excision** is the irreversible instrument 16 and 17 both reserve as the owner's gesture, and remains
ticket 14's.

Two repairs followed, both deletions, as 16 specified: the markdown link at
`issues/02-issue-lifecycle.md:26` and the raw-evidence line at `research/02-issue-lifecycle.md:8`.
11's repair also landed — the five triage role strings folded into `docs/agents/issue-tracker.md`'s
`Status:` bullet, and the `triage-labels.md` citation deleted. One line, one owner, no new file.

### Two additions with no ticket behind them, both minimal

- **`docs/adr/.gitkeep`.** 11's confirmed `CLAUDE.md` text cites `docs/adr/` in backticks and the
  path check reads the working tree, so without a tracked placeholder the kit passes here and fails
  on a fresh clone. Not a `*.md` file; spends no headroom.
- **`.claude/deny-merge.py`.** 17 specifies a `PreToolUse` deny rule; the settings file holds both a
  `permissions.deny` list and a hook calling this script, because a prefix match is evaded by a
  compound command and the script reads the whole command string.

### The final pass

Every content check reports zero on the tree as it stands, which is what makes whole-index checking
safe. `pre-commit` exits 0 on the landing commit with all ten of its blocks live.

| | |
|---|---|
| Standing-claim files | **7 of 12**, headroom 5 |
| `GOALS.md` | 39 / 40 hard |
| `PROCEDURE.md` | 59 / 60 hard |
| `SALVAGE.md` | 62 / 65 hard |
| `CLAUDE.md` | 80 / 200 guidance |
| `ARCHITECTURE.md`, `CONTEXT.md` | no cap, by decision |
| Home-path class | 0 tree-wide |
| Personal-email class | 0 tree-wide |
| ADR-citation class | 0 outside `.scratch/` |

`PROCEDURE.md` was checked against its inherited condition — it earns its ceiling only by pointing
at mechanisms rather than restating them. It names the hook, the harness and the command file, and
describes none of them. `CLAUDE.md` carries no *how to run things* prose, per 17's rule that a
recipe deleting no prose has not earned its place; the eight recipes are the command surface and
`just --list` is their index.

### Limits, and what is not here

- **19 specifies a hard line cap on an ADR body and no enforcement point for it.** Not invented
  here. The scaffold states the number; nothing checks it. Raised rather than drafted around, the
  same as the two file defects.
- **21's 2am worked example is not installed.** The claim it walks through — git's default cleanup
  silently strips a subject beginning with `#` — is real and costly, but 21 used it to demonstrate
  the residual owner, not to instruct that it be written. It is the human's to add, and under 21's
  answer that is a two-line edit with no trailer owed.
- **The size cap is bypassable by `--amend`**, which sees an empty staged diff. The `pre-push` twin
  catches it before anything leaves the machine, which is where 16 already puts the answer to
  `--no-verify`.
- **`check` ships empty**, by 17's decision, so the local gate proves nothing until the rebuild
  decides the toolchain. The landing recipe shells out to the review command and tolerates its
  failure rather than blocking, since the review returns no pass and no fail by design.
- **Nothing here was run end to end.** The hooks were exercised against real staged content and the
  denial against real payloads, but no worktree was opened, no ticket landed through the recipe, and
  no ADR written. The rebuild's first ticket is where the recipes are actually tested.
