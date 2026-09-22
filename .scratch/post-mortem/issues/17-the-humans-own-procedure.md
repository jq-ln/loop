# The human's own procedure

Type: grilling
Status: resolved
Blocked by: 09, 15

## Question

Surfaced in ticket 08 and covered by none of the seven research findings, which are all about rules
for agents: *"it is just as important to start the next attempt with a procedure document for myself
as it is to have procedures for the agents."*

The named causes are the material. In `../old_loop` the user was not reading as much of the code as
they should have been; the building process was scattershot; the pace quickened as the project went;
and oversight of code and test quality was thin. The result was an author who could not account for
their own system — the four pillars were an 8-line enum while three documents claimed a `:core-api`
type, and this was not discovered until a post-mortem inventory.

- **What does the human commit to doing, and when?** Reading before merging, or reading on a
  cadence, or reading by sampling. Name the thing precisely enough that skipping it is visible.
- **The pace problem.** Agents produce faster than a human reads, and the gap compounds silently.
  Is the answer a rate limit, a comprehension gate, or an accepted debt that gets paid down on a
  schedule?
- **Quality oversight.** Test quality specifically: `../old_loop` had 945 tests and 23% of its
  Kotlin was written and later deleted. What does the human check that an agent cannot check for
  itself?
- **Does this document bind or advise?** A procedure for yourself has no reviewer. Ticket 03's
  finding — rules attached to an artifact the work must touch anyway held, rules standing over the
  work broke in minutes — was measured on agents. Does it transfer, and if it does, what artifact
  does the human's procedure attach to?
- **Where it lives**, given it is read by a human and not loaded into every agent session, and given
  the budget ticket 11 sets.

Blocked by 09 because a process-caused death and a scope-caused death imply different documents
here: under the first this is the load-bearing file, under the second it is a short checklist and
the real answer is smaller ambitions.

## Amendment after ticket 09

**This is the kit's load-bearing document.** 17 anticipated that a process-caused death made it
load-bearing and a scope-caused death made it a short checklist whose real answer is smaller
ambitions. 09 found neither: the root cause is that no destination existed, and the *proximate* cause
is breadth outrunning comprehension. The document governing what the human reads is therefore the
kit's main defence, and "smaller ambitions" is a line inside it rather than a replacement for it.

**It owns the pace question whole.** The map's fog patch on agent output outpacing human reading is
cleared into this ticket rather than becoming its own. The gap is one question; splitting the human's
commitment from the agent-side limit that enforces it guarantees two half-answers needing
reconciliation later, which is exactly the day-8 repair work ticket 05 measured. Specify the human's
choice here — rate limit, comprehension gate, or scheduled debt — and let ticket 10 wire whatever
enforces it.

**Being load-bearing buys no exemption.** 11's constraint applies, and so does the ordered pair of
tests: the comprehension criterion first, then 03's latency test. The second is the real difficulty
and this ticket already names it — a procedure for yourself has no reviewer, so what artifact does it
attach to? Resolve that rather than deferring it; an unattached procedure of principle is the rule
class that broke in 15 minutes 33 seconds.

Blocked by 15 as well as 09.

## Amendment after ticket 15

15 decided that **only the repository's owner edits `GOALS.md`**, and the user's own response to
that decision is this ticket's sharpest input: *"the goals are only good if I keep myself to a
standard."*

15 states the **attachment** and leaves the **discipline** here. Already decided, and not this
ticket's to revisit: the file is edited alone in a commit touching nothing else (mechanically
checkable); a deletion carries the `grep` re-check list in its commit message; the trigger for
revisiting the goals is an ADR that cannot name one, not a calendar.

What lands here:

- **The cadence of re-reading `GOALS.md`**, given 08 rejected re-reading as the *mechanism* but the
  file still needs to be a live object rather than a founding document.
- **The honesty problem**, which is the real difficulty and is this ticket's own question in
  concentrated form. The three rules above are all checkable. *"Did you re-examine the goal, or
  reword it to fit what you had already built?"* is not checkable by anything, and the goals file
  is worth nothing if the answer is the second. A procedure for yourself has no reviewer; here is
  the exact place that bites.
- **A candidate reading-time check**: if every ADR cites the same goal, the citation rule has
  degraded into a stamp. 15 explicitly declined to make this a mechanism — it is a thing a human
  notices while reading — so it belongs in this document or nowhere.

## Answer

HITL session, 2026-09-22. Six rounds of grilling, eighteen questions, every recommendation put to
the user. One was **corrected by the user** (Q11: the size cap conflated a 3,000-line commit with a
3,000-line branch, which are different failures with different fixes and different attachment
points) and one line of enquiry was **opened by the user** (whether `code-review` covers doc-code
drift, and when review should run at all). No new evidence gathered beyond reading the `code-review`
skill and this repo's existing `.githooks`; tickets 03, 05, 06, 08, 09 and 15 are the evidence.

### The thesis

**Where a commitment can become a step in a command I already run, it stops being a commitment.**

That is the whole method, and it is the only honest answer to *a procedure for yourself has no
reviewer*. Ticket 03 measured the alternative: rules standing over the work broke in minutes, and
one was later defeated by citing its own violations. So this ticket spends its effort converting as
much of the human's discipline as possible into hooks, harness denials and `just` recipes, and
`PROCEDURE.md` is what is left over after that conversion — deliberately small, and explicit about
which of its clauses have teeth.

### The gate, and the pace question it swallows

**The commitment is a comprehension gate at the merge**: nothing lands until the human has read its
diff and can say what it does without opening it again. Of 09's three candidate shapes, a rate limit
is a number standing over the work with nothing to attach to, and accepted debt is what `../old_loop`
ran — its payment arrived as a post-mortem inventory, after death.

The gate answers the pace question **without a second rule**. Throughput is capped by reading,
because unread work cannot land. The decisive property is that the gap stops being silent: unread
work does not vanish into `main`, it accumulates as unmerged worktrees, and `git worktree list` is
the debt meter. `../old_loop`'s gap compounded invisibly for exactly the opposite reason.

**The cap is three worktrees, and it is enforced at the wall, not the door.** Git has no hook on
`git worktree add`, which turns out to be an advantage: the check belongs in `.githooks/pre-commit`
alongside the identity guard, where it enforces the *state* rather than the act. A fourth worktree
may be opened; nothing in it can commit until one of the other three has been read and landed. That
rides on the commit — the artifact the work must touch anyway, the only rule class in 03's table
with a clean record — and `pre-push` already exists as the `--no-verify` backstop.

The door is `just start <ticket>`, and it binds **agents** more than the human: worktree creation is
primarily agent-driven, so the sanctioned command is where the cap is usually felt, and the hook
catches the bypass.

### The attachment: the merge is the human's gesture

This is the ticket's hardest half, and the answer is the same shape 15 found for `GOALS.md`: locate
the one mechanically-identifiable act that only the human performs.

**No agent performs a merge.** Enforced harness-side by a `PreToolUse` deny rule in
`.claude/settings.json`, so an agent that tries is refused by the tooling rather than by its own good
intentions. The merge commit is then the human's signature that the diff was read — no new artifact,
no checklist, no field to fill. `../old_loop` reached for this instinct exactly once, in #50, holding
the publication flip as *"the owner's gesture, not an agent's"*, and never generalised it.

Stated limit, and it is in the file: this makes the gate **visible and attributable**, not **true**.

### What the human checks that an agent cannot

Two things, and only two, because a third would be a second code review costing comprehension
instead of protecting it.

1. **Should this exist at all.** An agent checks a change against its ticket and never asks whether
   the ticket should have been written. 23% of all Kotlin written in `../old_loop` was later
   deleted; a plugin subsystem was built on day 3 and removed on day 7. Under 15's citation rule the
   question now has a form — name the goal, and what it ruled out.
2. **Break the code and watch a test go red.** One test per merge. Test quality is the one dimension
   where the agent's signal is self-referential: it wrote the test and the code together, and a
   vacuous test is green. 945 tests did not prevent any of the above.

The second is **deliberately left unenforced** and listed under the no-teeth heading. The tempting
move — have `just land` prompt for which test was broken and record the answer — produces a field
that accepts any string, and therefore a green record whether or not the act occurred. That record
would be worse than nothing, because it looks like verification. `just land` displays the reminder
and asks for no input; a reminder that demands no answer cannot degrade into a false one.

### The honesty problem

15 handed this over as the place a procedure-for-yourself bites: *"did you re-examine the goal, or
reword it to fit what you had already built?"* It is not checkable, and the answer does not pretend
otherwise. It does two things instead.

**A timing fingerprint.** Because `GOALS.md` is edited alone in its own dated commit, a goal edited
*after* the work it justifies is visible in `git log`. So: when an ADR cites a goal whose last edit
postdates the branch's first commit, the ADR must say so. This does not detect dishonesty; it
removes the **silence**. The rewording failure stops being invisible and becomes something that
requires actively writing a false line to conceal, which is a materially different act.

**Keeping the honest answer cheap.** 15's escape hatch — *if a decision is right and no goal covers
it, bring it here* — is what makes rewording unattractive, and it only holds while amending the
goals is a two-minute act rather than a confession. This is a design pressure, not a mechanism, and
it is stated in the file as one.

The residue gets one sentence, first person, under a heading that says outright that nothing checks
it. Mixing checkable and uncheckable rules without marking which is which is how `../old_loop`'s
prose rules died quietly.

### `GOALS.md` stays live without a cadence

**No re-read cadence.** 08 rejected re-reading as the mechanism and the calendar trigger is the
class that never held in `../old_loop`; the only triggers that survived were event-attached. 15's
citation field already forces the read at the moment it is needed, and the file is ≤ 40 lines, so a
scheduled re-read would add an obligation that pays for nothing — a direct failure of 09's
comprehension criterion.

The stamp check 15 declined to mechanise (*if every ADR cites the same goal, the rule has degraded*)
lands here as a **reading-time noticing**, under the no-teeth heading. It gains one **instrument**:
`just goals` prints `GOALS.md` beside the distribution of goal citations across the ADRs. An
instrument gates nothing and fails nothing, so it is not subject to the latency test; it exists only
to make degradation impossible not to see at the moment the human is already looking.

### Smaller ambitions, correctly split

09 said *"smaller ambitions"* is a line inside this document. It is two lines, because **the
unreadable commit and the overgrown branch are different failures** — this correction came from the
user and reversed the agent's recommendation.

- **The commit is the unit of reading.** A single 3,000-line commit is an atomicity failure: one
  indivisible thing nobody can read. **Cap: 300 changed lines**, enforced in `.githooks/pre-commit`,
  overridden by an `Oversized: <reason>` commit-message trailer. The trailer is 06's **null
  artifact** finding landing for the first time — `../old_loop` grew a precedent chain seven deep
  because a rule had no way to record a considered exception, so the exceptions became prose
  arguments. Here the override is legal, dated, and reads back in `git log` forever. The count
  excludes a short literal generated-paths list kept **in the hook**, because a rule that fires on
  the Gradle scaffolding commit trains the human to type the trailer reflexively, which destroys the
  signal it exists to carry.
- **The branch owes conformance, not size.** A 3,000-line branch across twelve well-shaped commits
  is cheap to read and a line cap would refuse it for no reason. The branch's risk is **breadth**,
  which is 09's proximate cause exactly: `../old_loop` died at 106 files and 640 cross-references,
  one per 12.8 lines, not at any line count. So `just land` compares the branch's touched paths
  against the ticket's **declared file list** and stops on an undeclared path. 06 proved the
  mechanism — zero violations wherever a declared list existed, and it existed in only 10 of 41
  tickets. Landing anyway records the stray paths in the merge commit.

Both numbers are stated **in the file** as knobs with no evidence behind them, with the overrides
named as the data that tunes them. 07's finding obliges this: the 200-line figure became folklore by
being repeated without that sentence attached.

### Doc-code drift, and why review cannot catch it

The gate reads work as it arrives and would have passed every commit that produced the `:core-api`
defect, because each document was accurate on the day it was written. Ticket 04 found three
documents asserting a module type against an 8-line enum, undiscovered until a post-mortem
inventory.

**The defect class is killed at entry rather than checked for: a document may not assert a
structural fact the source already asserts about itself.** No document names a module type, a layer
boundary, a file layout, or a count of anything; a document that wants to point at structure points
at a path. This passes the comprehension criterion by subtraction and needs no attachment, being an
entry rule rather than an ongoing obligation. **The rule itself is routed to ticket 11**, which owns
what may be written; what stays here is the paired noticing — *a document just told me something
about the code, go look*.

`code-review` cannot substitute for this, and the user's question about it surfaced a real hazard
worth recording. Its Standards axis asks *does the code violate a documented standard?* In the
`:core-api` case the **document** was wrong and the code was fine, so the review would have reported
a code violation and sent the human to change working code to match a false claim. **It would have
made that defect worse, confidently.** The two are complementary rather than redundant — likewise
its Spec axis on scope creep, which is the judgement version of the mechanical file-list check.

### When review runs

**Once per branch, immediately before the merge, as an unskippable step inside `just land`.**
Branch-level is what the skill does by construction (three-dot diff against the merge-base). It is
not a discipline because it is not a decision: making it conditional would put the choice in the
hands of the person most motivated to skip it, on the day they are most motivated to skip it, and
`../old_loop` already ran the conditional version — its style gate ran after the push (#83). It
costs nothing the human would otherwise spend: two axes, parallel subagents, 400 words each.

06's three round-multipliers are each answered:

- **A fix mandatorily reopened a round** → a fix re-reviews the fix, not the branch.
- **Fixes regressed against undocumented standards** (#101 rounds 3–6 enforcing a 634-column rule no
  file states) → a Standards finding that cannot cite a file and a rule is **advisory, never
  blocking**. Baseline smells are judgement calls by the skill's own terms.
- **The reviewed artifact drifted to prose about the change** → the reviewed artifact is the diff of
  declared files; commit prose is not reviewed.

**The exit condition is the human's**, which is forced anyway once merging is the human's gesture.
The load-bearing constraint, stated in the file: **the review is an input to my reading, not a
substitute for it.** It returns no pass and no fail, and `just land` shows the diff either way. A
green report is precisely what would license skipping the gate.

### The justfile

The command surface, introduced by the user in round 2, carrying a structural rule: **if a command
is worth documenting, it is a recipe, not a line of prose.** It clears the comprehension criterion by
**subtraction** — it does not add an artifact to read, it evacuates *how to run things* out of
`CLAUDE.md` into a file that is self-describing (`just --list`) and that cannot silently rot, since a
stale recipe fails loudly where stale prose merely misleads. `../old_loop` spent review rounds 3–6 of
#101 enforcing a 634-column rule **no file stated**; an executable command surface is where that rule
would have lived. It is also the agents' door, not only the human's.

Day-one recipes: `just start <ticket>`, `just check`, `just land`, `just goals`. **`just check` ships
empty** — deciding what it runs means deciding the toolchain, which is the rebuild's business. Growth
rule: a recipe earns its place by being run twice **and** by deleting prose when it lands; a recipe
that adds to the corpus instead of subtracting from it fails the same test the budget guards.

Per the map's *decide first, write once*, this ticket decides the recipes and the rules; ticket 20
authors the files.

### The file's bounds

**`PROCEDURE.md` at the repo root, first person, ≤ 60 lines hard** (57 as written). 09 called this
the kit's load-bearing document and said being load-bearing buys no exemption; the 60 over
`GOALS.md`'s 40 is because it indexes more distinct objects, and it is an **input to ticket 11**, not
a negotiation with it.

The structural rule matters more than the number: **it never restates a mechanism that exists
elsewhere, it points at it.** The cap lives in `pre-commit`, the merge denial in
`.claude/settings.json`, the commands in the `justfile`. `PROCEDURE.md` says what was committed to
and where each part is enforced. This is 15's objection to `CLAUDE.md` copying the goals, applied
reflexively: one claim, one owner. It explicitly does not own the goals, the agent protocol, or the
commands.

**The `GOALS.md` hook extends to cover it**: edited alone, in a commit touching nothing else, by the
human only. Loosening one's own procedure becomes a dated, isolated, visible act — the honesty
fingerprint turned on the procedure itself, which is the document most likely to be quietly relaxed
on a bad day. First person for 15's reason: a file only one person may edit, stating commitments
that person holds, reads false in the passive voice.

### The file, confirmed verbatim

```markdown
# Procedure

My own working rules. `GOALS.md` outranks this file; `CLAUDE.md` owns how agents work; the
`justfile` owns the commands. This file says what I have committed to and where each part is
enforced. It never restates a mechanism that lives somewhere else.

Only I edit this file, and only in a commit that touches nothing else.

## The gate

Nothing merges until I have read its diff and can say what it does without opening it again.

Work I have not read does not disappear into `main`. It waits as an unmerged worktree, so the gap
is always visible. At most **three** worktrees exist at once; past that, `.githooks/pre-commit`
refuses to commit anywhere until I have read one and landed it. My reading speed is the project's
throughput, deliberately.

**Merging is mine.** No agent performs a merge, and the harness denies it. The merge commit is my
signature that I read the diff.

## What I check that an agent cannot

- **Should this exist at all.** An agent checks a change against its ticket and never asks whether
  the ticket should have been written. Under `GOALS.md` that question has a form: name the goal,
  and name what it ruled out.
- **Break the code and watch a test go red.** One test per merge. A suite written alongside the
  code it tests is green whether or not it asserts anything.

## What runs without me

`just start` opens a worktree and refuses at the cap. `just check` is the local gate. `just land`
shows me the diff and the diffstat, runs the review, compares the branch against its declared file
list, takes the version decision, and merges. `just goals` prints `GOALS.md` beside the goal
citations across the ADRs.

The review is an **input to my reading, not a substitute for it**. It returns no pass and no fail,
I see the diff either way, and a Standards finding that cannot cite a file and a rule is advisory.
A fix re-reviews the fix, not the branch.

A commit over **300 changed lines** is refused unless it carries an `Oversized: <reason>` trailer.
Landing outside the declared file list records the stray paths in the merge commit. Both numbers
are knobs with no evidence behind them; the overrides are the data that tunes them.

If a command is worth documenting it is a recipe, not prose, and a recipe that deletes no prose
when it lands has not earned its place.

## Resting on nothing but me

Nothing checks these, and saying so is the point: a file that mixes the two teaches me to trust
the wrong half.

- **Did I re-examine the goal, or reword it to fit what I had already built?** A goal edited after
  the work it justifies is visible in `git log`, and an ADR citing it has to say so. That removes
  the silence, not the temptation. Bringing a missing goal here must stay a two-minute act; the
  day it feels like a confession is the day I start rewording.
- **If every recent ADR cites the same goal**, the citation rule has become a stamp.
- **A document just told me something about the code.** Go look.
```

### Both tests, applied to this ticket's own mechanisms

09 requires the ordered pair — comprehension first, then 03's latency test — and being load-bearing
buys no exemption.

| Mechanism | Comprehension | Latency (what it rides on) |
|---|---|---|
| Worktree cap | Passes: caps the unread backlog, adds nothing to read | `pre-commit`, plus `pre-push` backstop |
| Merge is the human's | Passes: no new artifact; an existing act becomes the assertion | `.claude/settings.json` harness denial |
| 300-line commit cap | Passes: bounds the unit of reading | `pre-commit`; override is a commit trailer |
| File-list conformance | Passes: bounds breadth, consumes a list 10 owns anyway | `just land` |
| Review before land | Passes: reduces what must be read closely | a step inside `just land` |
| `just goals` | Instrument, not a rule — exempt by construction | — |
| `PROCEDURE.md` itself | Passes only because it indexes rather than restates | edited-alone hook, extended from `GOALS.md` |
| The three noticings | **Fail the latency test, and are labelled as failing it** | nothing |

The last row is the honest one. Three clauses rest on nothing, they are in a section that says so,
and that is the most this ticket can deliver.

### Consequences for other tickets

- **10** gains two fixed inputs. The **declared file list must be machine-readable**, because the
  comprehension gate now diffs the branch against it; and the **version decision is taken last, at
  merge time, inside `just land`** — the human's ordering gesture. 06 found eight live counters
  under three incompatible regimes and 18 issues arguing no bump was owed; a worktree cannot collide
  over a number it never touches. 10 still owns the mechanism.
- **11** gains three. `PROCEDURE.md` ≤ 60 lines as a fixed input alongside `GOALS.md`'s 40. The
  **justfile is exempt from a prose budget** — it counts as a file but is not prose, and it exists to
  subtract prose. And the **doc-code entry rule** above is routed to 11 to own outright: no document
  asserts a structural fact the source asserts about itself.
- **20** gains the artifacts: `PROCEDURE.md` verbatim; the `pre-commit` additions (worktree cap,
  commit-size cap with its generated-paths exclusion list); the `.claude/settings.json` deny rule on
  agent merges; the day-one `justfile`; and the extension of the edited-alone hook to cover both
  `GOALS.md` and `PROCEDURE.md`.
- **19** is unaffected in charter but now has a dependant: the goal-citation timing rule and
  `just goals` both presume ADRs exist. If 19 decides against an ADR practice, the timing fingerprint
  needs a new carrier and this ticket's honesty answer weakens.
- **16** is untouched; the entry rule it owns is about what may not enter the repo, which is
  orthogonal to the structural-claim rule routed to 11.
