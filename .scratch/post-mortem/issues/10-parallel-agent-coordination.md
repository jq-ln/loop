# How parallel agent sessions coordinate

Type: grilling
Status: resolved
Blocked by: 06, 09, 15

## Question

The old model — worktree → commit → rebase → review → merge → teardown — was close to right and
produced three distinct failures. Design the protocol this repo starts with.

Work from ticket 06's mechanisms, not from the incidents. The three failures are separate problems
and may want separate answers:

- **Scope failure**: declared owned-files lists that were not accurate, so collisions surfaced at
  the merge rather than at the claim. Is the fix a better list, a coarser claim unit, a lock, or
  fewer concurrent sessions?
- **Rule failure**: versioning. Inverted pre-1.0 semver across five or six independently versioned
  things, each bumped in the same commit as its change. How much of that survives, and what is the
  simplest scheme that still tells the truth?
- **Termination failure**: review rounds caused by `main` moving under an open review rather than
  by anything found. What ends a review, what ends a *round*, and what signals a stall?

Also settle the ceiling: how many sessions may run at once, and what enforces it. The old repo used
a blocking edge to park maps (ADR 0077) — decide whether that mechanism carries over.

Consider prototyping the protocol against a replay of ticket 06's worst collision before adopting
it.

## Amendment after ticket 09

Blocked by 15 as well. 09's principle is that no ticket which writes a rule resolves before the goals
file those rules get checked against exists, and a coordination protocol is a rule — three of them,
on the ticket's own reading. It was not in the list 09 settled and is added here deliberately rather
than by inference.

The ordered tests apply. The comprehension criterion bites hardest on the **scope failure**: an
accurate owned-files list is an artifact someone has to read and maintain, so a coarser claim unit or
fewer concurrent sessions may beat a better list on this test alone. 03's latency test bites hardest
on the **versioning** rule, which in the old repo stood over the work rather than attaching to it.

## Amendment after ticket 17

Two fixed inputs. Both are consequences of 17's attachment decision — **the merge is the human's
gesture, and no agent performs one** — and neither is re-openable here; the mechanisms remain this
ticket's to design.

- **The declared file list must be machine-readable.** 17's comprehension gate diffs a branch's
  touched paths against the list at `just land` and stops on an undeclared path, so the list is no
  longer only a collision-avoidance device between concurrent sessions — it is a consumed artifact
  with a second reader. Ticket 06 measured its value already: zero file-level violations wherever a
  declared list existed, and it existed in only 10 of 41 tickets. Whatever shape this ticket gives
  it, `just land` must be able to parse it without a human in the loop.
- **The version decision is taken last, at merge time, inside `just land`.** Raised by the user
  while resolving 17 and routed here. A worktree cannot collide over a number it never touches, so
  the branch never sets a version; the human sets it at the moment of landing, which also makes the
  *order* in which tickets land the human's gate. 06 found eight live counters under three
  incompatible regimes, with the dominant cost adjudication rather than error — 18 issues spending
  a paragraph arguing no bump was owed, via a precedent chain seven deep. This ticket owns which
  counters exist and what `just land` actually does to them.

Note also that 17 closed this map's fog patch on **what the review actually reads**: the reviewed
artifact is the diff of declared files, and commit prose is not reviewed. That was filed as adjacent
to this ticket and is now decided.

## Note after ticket 11

One small input. Adding a standing-claim file is a file-list event like any other: a new governed
document appears in the branch's declared file list or trips 17's conformance check at `just land`.
11's own enforcement is earlier and independent — `pre-commit`, on the commit that creates the file —
so nothing here needs to carry the budget; this is only to say the two do not collide.

## Answer

HITL session, 2026-09-24. Three rounds of grilling, twelve questions, every recommendation put to
the user and accepted as stated. One follow-up was **opened by the user** (Q6: whether a version
bump cadence needs deciding, and whether an existing ticket can take it) and is answered as fog
rather than as a ticket. No new evidence was gathered: 06 is the evidence, and 09, 15, 11 and 17 are
the fixed inputs.

### What was already fixed, and is not re-adjudicated here

17 settled the merge half of this ticket before it was claimed: three worktrees enforced in
`pre-commit`, no agent performs a merge, review runs once per branch inside `just land`, a fix
re-reviews the fix, an uncitable Standards finding is advisory, the reviewed artifact is the diff of
declared files, and the version decision — if there is one — is taken last. 09 supplied the ordered
tests. What remained was the **mechanism**: the shape of the claim, what happens when it moves,
which registries exist at all, and what ends a branch that will not end itself.

### The claim: whole files, checked at the door

**The claim unit is the whole file. There are no sub-file claims.** 06 found the declared list had
not failed by being inaccurate — where a list existed there were zero file-level violations — it
failed by *degrading*. #55 stated the rule as *files must not overlap*; by #82 it read *"this ticket
touches only the Workflow bullet of `CLAUDE.md`"*; #91 wrote the degradation up as precedent:
*"#55 and #56 are the precedent for two tickets sharing a file by declaring their halves."* A region
claim is prose. Git enforces files and nothing enforces paragraphs, so a region claim is a rule with
no possible attachment — 03's latency test refusing it outright. Two tickets that want the same file
serialise. With a ceiling of three that cost is small, and serialising is the honest version of what
region-sharing pretended to avoid.

**The list lives in the ticket file**, as a fenced block under a fixed `## Files` heading, one
repo-rooted path or directory prefix per line. The branch is named for the ticket, so `just land`
derives the ticket file from the branch and needs no second bookkeeping artifact. This satisfies
17's fixed input — machine-readable, parsed without a human in the loop — with nothing added to the
corpus: the list was already being written in prose, and is now written in a shape a command can
read.

**`just start <ticket>` refuses when the new list intersects any live worktree's list.** This is the
ticket's stated scope failure answered directly: 06's mechanism was that *"the declaration is
written at charting time and consumed at merge time"*, so a collision that became inevitable at the
claim surfaced hours later at the merge. The check moves to the door. With a cap of three it is an
intersection of at most three short lists.

The third reader is the point. 06's scope finding had three parts and the list being **unpopulated**
was the largest — 31 of 41 tickets declared nothing, and tickets charted without the section kept
merging even after the rule landed on 2026-09-21. So: **`just start` refuses a ticket with no
`## Files` block.** A list that three commands read is a list that gets written; a list that is
optional is absent in 76% of cases, which is measured rather than supposed. The attachment is the
cheapest available — the command the work must run anyway, firing before any effort is sunk — where
the alternative, prose saying tickets *should* declare their files, is the exact class 03 measured
breaking in fifteen minutes.

### The radius moves, and that is legal

#101's declared list was widened **three times mid-ticket**, each time by the author's answer to a
review round, each with a rider that *"it is not a precedent"*. A list fixed at charting time cannot
survive a review loop licensed to discover new files, and freezing it makes `just land`'s check the
enemy of finishing the work — a check that the person it constrains is also the person who can
disable it.

**`just claim <path>` widens the declared list mid-ticket**, re-running the intersection against live
worktrees and amending the ticket file. This is 06's **null artifact** finding landing for the third
time in this kit, after 17's `Oversized:` trailer and its stray-path record in the merge commit: a
rule with no way to record a considered exception does not stop the exception, it grows case law —
seven deep, in the version rule's case. Here #101's three prose riders become three dated lines of
record, and the *frequency* of those lines is the evidence that the claim unit or the ceiling is
wrong.

**On refusal, the work reverts and waits**, and the refusal names the worktree holding the path and
its ticket. This is the expensive case — edits already made, against a file another worktree owns —
and it is deliberately harsh. Letting both proceed to a merge-time conflict is precisely what
produced 06's 14 concurrent-branch collision pairs. Splitting the overflow into a new blocked ticket
reads tidier but creates board entries as a side effect of an error path, against this map's
standing preference. The pain is the mechanism: it is the only feedback that says the claim unit is
too coarse, and `just claim`'s log is where that accumulates.

### The registries: there are none

The map's fog patch on global registries is answered for this repo, and the answer is subtraction.

**No version counters and no changelog exist on day one.** 06 found eight live counters under three
incompatible regimes, and the dominant cost was **adjudication, not error** — 18 issues spending a
paragraph arguing no bump was owed, via a precedent chain seven deep, plus four version facts
written into prose and invalidated by concurrent merges, and one case (#82 round four) where the
version edit *defeated the review gate* because taking the number after the rebase is an edit to an
already-reviewed branch. A counter exists when something outside the repo needs to tell two builds
apart. Nothing is distributed, the map's Notes forbid assuming a channel, and `CHANGELOG.md` is not
among 11's day-one eight. Every counter would therefore be pure adjudication cost against zero
measured benefit: the comprehension criterion at full strength, and the largest single subtraction
available to this ticket.

17's rule stands unamended and binds vacuously until the first counter appears. The consequence for
`PROCEDURE.md` is recorded below.

**The ADR's identity is allocated at write time and never contended: `docs/adr/YYYY-MM-DD-<slug>.md`,
not a sequence number.** 06 found an ADR-number race flagged in advance and won by neither
contender — #51's *"Take the number at merge — #48 is racing for 0066"*; #13 took 0066, #49 took
0067, #48 took 0068, #51 took 0069 — and records that the merge-order rule held **only because a
human refereed**. A monotonic number is an allocation problem identical to `versionCode`, and the
referee is the scarcest resource in this kit. Two sessions cannot collide over a name neither has to
ask for. The user raised a randomised identifier and preferred this: a date sorts, reads, and needs
no explanation.

This ticket takes only the coordination property; **19 owns whether the practice exists at all**. If
19 decides against ADRs, this dies with it at no cost. If 19 keeps them, it inherits a name it never
has to referee, and does not re-derive the registry argument. 11's adjacent decisions survive
unchanged — no index file, discovery by `just adr`, supersession by deletion — with one correction
routed to 19: *"the number left as a gap"* has no referent under date-and-slug naming, and deletion
simply leaves no trace in the filename space.

### Termination, and the branch that stops

06 mostly refuted the stated hypothesis — exactly one round across nine multi-round tickets existed
because `main` moved, and it was substantive — and 17 answered the rest. What remained unowned is
the branch that is claimed, has a worktree open, lands nothing, and silently consumes one of three
slots.

**No stall rule. An instrument instead.** A time-based trigger is the class that never held in
`../old_loop`, and *"a branch older than N days is stale"* is a number standing over the work with
nothing to attach to. Instead, at the moment the cap bites — `just start`'s refusal and
`pre-commit`'s refusal — **the message lists the live worktrees with each one's age and last
commit**. The stall becomes visible exactly when it starts costing something, to the person who can
end it. This is 17's `just goals` precedent: an instrument gates nothing and fails nothing, and is
exempt from the latency test by construction.

**`just drop <ticket>`** removes the worktree, deletes the branch, sets `Status:` back to `open` and
releases the claim. Making an abandoned worktree expensive without providing a cheap exit is how a
cap gets bypassed, and a bypassed cap is worth less than no cap. The recipe earns its place under
17's growth rule by subtracting: without it the correct action requires three commands the human
would have to be told about in prose, and the incorrect action requires none.

**ADR 0077's parking mechanism does not carry over.** Parking already exists natively in this
tracker — a `Blocked by:` line and `Status: open`. A second mechanism expressing the same state is an
artifact to read that prevents no reading, a straight comprehension-criterion failure.

### The version cadence is fog, not a ticket

Raised by the user on seeing Q6: does batching tickets per bump need a schedule, and does an existing
ticket own it?

**Batching is not a scheme to design — it falls out of the allocation rule.** If the branch never
touches a counter and the human sets the number at land, a bump necessarily covers everything landed
since the last one. What is left is a genuine cadence question — how many landings earn a bump, and
what a bump is *for* — and it cannot be stated sharply now, because it depends on what is
distributed and to whom. The map's Notes rule that out: *"No distribution channel is assumed."*
F-Droid propagated through four ADRs before being recognised as arbitrary; fixing a bump cadence
against an unchosen channel is that failure one layer down. It goes to **Not yet specified**,
replacing the global-registries patch this ticket has now answered, and blocks nothing: the kit
ships no counter, so there is nothing for a cadence to be missing from.

### `PROCEDURE.md`, amended: 59 lines against the hard 60

Two edits, drafted and counted rather than estimated. Per *decide first, write once*, this ticket
decides the text and **20 authors the file**; this is a consequence of 17, not a re-opening of it.

In **The gate**, the cap sentence gains the instrument:

> …refuses to commit anywhere until I have read one and landed it — **naming the three and how long
> each has been open, so a stalled branch is visible the moment it starts costing something.** My
> reading speed is the project's throughput, deliberately.

In **What runs without me**, the struck clause and the two new recipes:

> `just start` opens a worktree, **refuses a ticket that declares no files**, and refuses at the cap.
> `just check` is the local gate. `just land` shows me the diff and the diffstat, runs the review,
> compares the branch against its declared file list, ~~takes the version decision,~~ and merges.
> **`just drop` removes a worktree that will not land and releases its claim.** `just goals` prints
> `GOALS.md` beside the goal citations across the ADRs.

The struck clause is Q6: a procedure describing a step with no referent is the `:core-api` defect
inside the kit's own governing document, on day one. 17's structural rule is that `PROCEDURE.md`
points at mechanisms rather than restating them, and there is nothing here to point at. A
conditional phrasing — *"when a counter exists"* — would be worse: a line of a 60-line budget spent
describing an absence, which is the prose that made the old repo's documents unreadable. When the
rebuild ships a build and allocates its first counter, that ticket adds the clause back, true on the
day it is written.

**`just claim` is deliberately absent from the file.** The human never runs it; it is the agent's
mid-ticket widening, and 17's own header assigns how agents work to `CLAUDE.md`. It belongs in the
agent protocol, and the line stays as headroom.

### Vocabulary this ticket fixes

- **Claim** — a ticket's exclusive hold on whole files, declared in its `## Files` block, taken at
  `just start` and released at `just land` or `just drop`. Not a lock on a region, and not advisory.
- **Registry** — a file that holds a global counter or index, which every ticket must write and no
  ticket can declare off-limits. 06's mechanism, and this repo has none by construction.
- **Instrument** — a command or message that displays state and gates nothing. Exempt from the
  latency test because it can neither hold nor fail. 17's `just goals`, and now the cap's refusal.
- **Stall** — a worktree consuming a slot and landing nothing. Deliberately given no definition with
  a threshold in it; it is surfaced, never detected.

### Both tests, applied to this ticket's own mechanisms

| Mechanism | Comprehension | Latency (what it rides on) |
|---|---|---|
| Whole-file claim unit | Passes: removes region prose nobody can check | the file list, read by three commands |
| `## Files` required to start | Passes: the list is the artifact that replaces asking | `just start` |
| Intersection check at start | Passes: moves a merge-time surprise to claim time | `just start` |
| `just claim` widening | Passes: records an exception instead of growing case law | `just claim`, amending the ticket file |
| No counters, no changelog | Passes by subtraction: eight adjudicated numbers become none | nothing to attach to, and nothing to hold |
| Date-and-slug ADR names | Passes: removes a referee from the critical path | the filename, chosen at write time |
| Cap refusal lists worktrees | Instrument, not a rule — exempt by construction | — |
| `just drop` | Passes: makes the cheap exit cheaper than the bypass | `just drop` |

Nothing in this ticket rests on nothing. That is not a virtue of the design so much as a consequence
of 17 having already absorbed this ticket's unenforceable half.

### Consequences for other tickets

- **20 gains the artifacts.** The `## Files` block convention and its `just start` refusal; the
  intersection check; `just claim` and `just drop` as recipes; the cap refusal's worktree listing, in
  both `just start` and `.githooks/pre-commit`; the two `PROCEDURE.md` edits above, verbatim; and the
  agent-facing half — `just claim`, the whole-file rule, and the ban on region claims — in
  `CLAUDE.md`. The day-one justfile grows from four recipes to six.
- **19 gains a fixed input and a correction.** ADR identity is `docs/adr/YYYY-MM-DD-<slug>.md`,
  allocated at write time; 19 still owns whether ADRs exist. The correction: 11's *"superseded ones
  deleted, the number left as a gap"* has no referent under this naming, and 19 should restate
  supersession without it.
- **21 is unaffected but adjacent.** The ownership table it may or may not build is a governed prose
  file like any other, claimed whole; no registry exemption is available to it, which is a real
  input to its *"is the table a document at all"* question.
- **11 is unaffected.** Adding a standing-claim file remains a file-list event, as 11's own note
  said; the claim is now whole-file, which only strengthens it.
- **16 is unaffected.** Its checks and this ticket's live at different moments — entry versus claim —
  and share only `pre-commit`, where 20 installs them side by side.
