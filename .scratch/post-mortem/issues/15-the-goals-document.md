# The goals document, and the citation rule that gives it teeth

Type: grilling
Status: resolved

## Question

Decided in ticket 08: the kit's first file states this project's goals, it outranks the ownership
table, and **every ADR cites the goal it serves** — an ADR that cannot name one is rejected. The old
repo had no goals file and no owner for one; its ownership table covered every kind of claim in the
project except this, and that omission is what let F-Droid stand unexamined for eight days while
propagating four ADRs deep into the module graph.

What remains is the content and the shape.

- **What are the goals?** Two are already on the record and in tension: Loop is built primarily for
  the user's own use, *and* the user's work needs to be public to get a foothold in the community
  and the industry. A goals file that only states the first cannot check a publication decision; one
  that only states the second is a lie about why the app exists. Both, with their priority, or a
  different framing entirely.
- **What does a goal have to look like to be citable?** "Loop is finished, and submitted to F-Droid"
  was the old repo's only goal-shaped sentence and it states a means as an end. A goal that names an
  artifact or a channel cannot invalidate a decision about that artifact or channel.
- **What is out of bounds?** The file must be short enough to be re-read often (ticket 08 rejected
  re-reading as the *mechanism*, but it is still a property the file needs) and stable enough that
  citations do not rot. What kinds of claim belong to other owners.
- **The citation rule's failure mode.** A rule that every ADR cite a goal can degrade into every ADR
  citing the same goal ritually. Is there a check, or is ritual citation an acceptable cost given
  ticket 03's evidence that attached rules are the only ones that hold?
- **Non-goals.** The old repo's plugin scope creep and its F-Droid target were both things the user
  did not want on reflection. Does the file carry explicit non-goals, and does a decision have to
  clear those too?

## Answer

HITL session, 2026-09-22. Four rounds of grilling; every recommendation put to the user and accepted
as stated. No new evidence gathered — tickets 03, 08 and 09 are the evidence. The file below is the
ticket's real output and was confirmed verbatim, per the decision in Q9.

### The goals: two ends, two objects, one tie-break

The tension the ticket names — built for my own use *versus* work that must be public — is partly an
artifact of treating both as claims on the same object. They are not. **G1 governs the app; G2
governs the repository.** Most decisions are checked against exactly one of them, which is what keeps
the citation rule from degrading into a stamp.

The tie-break is the sentence that would have killed F-Droid on day one: **G1 wins wherever
publication would change what the app is; G2 wins on how the repository is kept.** F-Droid was
adopted in service of the second and changed the first, four ADRs deep, with nothing to check it
against.

*"The author can account for the system"* was considered as a third goal and **rejected**. Ticket 09
ranked protected comprehension as the second of three *means*, not an end. A means in the goals file
becomes citable, and then nearly every process ADR cites it — ritual citation arriving on day one.
It stays in ticket 17.

### What makes a sentence citable as a goal

**The invalidation test: a sentence is a goal only if you can name a plausible decision it would rule
out.** The old repo's `"Loop is finished, and submitted to F-Droid"` failed not by vagueness but by
naming a **channel** — a goal that names an artifact, channel, technology or format can only ratify
decisions about it, never invalidate them.

Corollaries, both in the file: a goal names a state of affairs for a person, never a thing the
project ships or a place it ships to; a goal satisfiable only one way is a means wearing a goal's
clothes. The test is made permanent rather than applied once — each goal carries its own "rules out"
clause, so a future goal that cannot get one written under it is not a goal.

### Non-goals bind, and they have an exit rule

Two entry constraints: a non-goal is written when something is **actually rejected**, and only when a
reasonable person reading the goals **might plausibly have built it**. Non-goals close gaps the goals
leave open; they do not enumerate the complement of the project. This is the same seeding discipline
ticket 16 uses, for the same reason.

The exit rule is what gives them teeth: **a decision contradicting a non-goal is rejected unless the
same commit deletes the non-goal.** Reversal stays legal but becomes visible, and the rule rides on
an artifact the work must touch anyway — the only rule class in ticket 03's table with a clean
compliance record.

**Day-one seed: exactly one, N1, and the rest belong to the rebuild.** "No plugin subsystem" is a
real rejection from the old repo but it is *product scope*, which this map rules out; writing it here
would decide the rebuild's scope through the back door. N1 — shipping through any particular store or
channel — is admissible because it is about how the work reaches people, which is G2's territory, and
because it closes precisely the gap G2 leaves open. Ticket 18 already requires the rebuild to state
what its first shippable slice deliberately excludes; those exclusions are non-goal candidates by
construction, and that is where the rest enter.

### The citation rule, and its two failure modes

**Ritual citation.** Rejected both "accept it as a cost" and "say how the decision serves the goal"
in favour of the stronger form: **every ADR names the goal it serves *and what that goal ruled out*
— the alternative that lost because of it.** This is the invalidation test applied at citation time,
so the kit carries one concept rather than two. An ADR that cannot name a rejected alternative is
either not a decision or is citing the wrong goal. It adds a field to an artifact that already
exists rather than an artifact to read (comprehension criterion), and rides on the ADR (latency
test). Limit stated plainly: a template field makes **presence** mechanically checkable and quality
not at all — ADR 0070's *"Text is not checkable"* still binds. No aggregate "are all citations the
same goal?" check is added; that is a thing a human notices while reading, and it is recorded as a
candidate line for ticket 17, not as a mechanism here.

The escape hatch is load-bearing and is in the file: *if a decision is right and no goal covers it,
that is a fact about this file — bring it here.* Without it the rule quietly pressures every decision
to be bent into serving an existing goal, which is how a goals file becomes a rubber stamp.

**Citation rot.** Ticket 08 accepted three candidate defects for F-Droid; the third was that *nothing
forced a re-check when it propagated four ADRs deep*. A citation rule creates the propagation and
does nothing about the re-check, so:

- **Stable ids, never reused** (`G1`, `G2`, `N1`). The one rule class in the old repo with a perfect
  record was exactly this shape — ADR numbers, 76 files, zero duplicates, reversed ADRs deleted and
  their numbers left as gaps.
- **Wording may be sharpened freely; identity changes only by deletion.**
- **The commit that deletes or supersedes a goal lists every ADR citing it and states whether each
  citation survives.** `grep -rl 'G2' docs/` is the whole mechanism, so the list is cheap to produce
  and its absence is visible in the diff. This is precisely the operation nobody was ever forced to
  perform on F-Droid.

### The file's bounds

`GOALS.md` at the repo root, **≤ 40 lines, hard** — goals with ids, the tie-break, non-goals, the
citation rule. That ceiling is an **input to ticket 11**, which inherits it rather than re-deriving
it. Explicit non-ownership is stated *in the file*, because that is what stops the drift that took
`CLAUDE.md` from 194 to 244 lines in 2h52m: it does not own definitions (`CONTEXT.md` is a glossary
by declaration), what gets built next, or how the work is done.

Rank, expressed as two lines rather than a ceremony: the ownership table gains a row for `GOALS.md`
owned by the human, and `GOALS.md` carries one sentence saying it wins where any document conflicts
with it. **`CLAUDE.md` links to it and does not copy it** — copying gives one claim two owners, and
the ADR template's citation field forces the read at the moment it is needed, so the goals arrive
attached rather than always-loaded.

### Only the human edits it — and what that obliges

Accepted, and the user's own observation on it is recorded as this ticket's main hand-off: *"the
goals are only good if I keep myself to a standard."* A rule only the human can apply, with no
reviewer, is the class that broke in 15 minutes 33 seconds. **Ticket 15 states the attachment;
ticket 17 owns the discipline.**

The attachment, because it is mechanical and it is this file's business:

1. **`GOALS.md` is edited alone** — a commit touching it touches nothing else. A hook, not a
   principle: a commit whose diff includes `GOALS.md` and any other path fails. Every goal change
   becomes a visible, isolated, dated act, and this is the artifact the human's rule attaches to.
   The repo already carries a commit-identity guard (`675f38e`), so the enforcement point exists.
2. **A deletion or supersession carries the `grep` re-check list in that commit's message.**
3. **The trigger for revisiting the goals is an ADR that cannot name one** — not a calendar. When the
   citation field cannot be filled, either the decision is unjustified or the goals are incomplete,
   and deciding which is the human's. An event-attached trigger is the only kind the old repo kept.

Recorded as input to ticket 17: the cadence of re-reading, and the honesty problem underneath it —
the three rules above are checkable, but *"did you re-examine the goal, or reword it to fit what you
had already built"* is not.

### The file, confirmed verbatim

```markdown
# Goals

This file outranks every other document in this repo. Where another document conflicts with it,
this one wins. It does not own definitions (`CONTEXT.md`), what gets built next, or how the work
is done — those have their own owners.

Only the repository's owner edits this file, and only in a commit that touches nothing else.

## Goals

**G1 — Loop is an app I use every day.**
Rules out anything I would have to be talked into using, and any decision that makes the app worse
to live with in exchange for something else.

**G2 — My work here is legible to people who might hire me or build with me.**
Rules out a private repository, a history I cannot explain, and a cleanup deferred to the end.

**When they collide**: G1 wins wherever publication would change what the app is. G2 wins on how
the repository is kept.

## Non-goals

A non-goal is written when something is actually rejected, and only when someone reading the goals
above might plausibly have built it. A decision that contradicts a non-goal is rejected unless the
same commit deletes the non-goal.

**N1 — Shipping through any particular store or channel.**
G2 is about the work being legible, not about it being distributed. No decision here may assume a
channel.

## Citing a goal

Every ADR names the goal it serves and what that goal ruled out. An ADR that can name neither is
rejected. If a decision is right and no goal covers it, that is a fact about this file — bring it
here.

Goal ids are never reused. Wording may be sharpened at any time; identity changes only by deletion,
and the commit that deletes a goal lists every ADR citing it and states whether each citation
survives.
```

Written in the first person deliberately: a file only one person may edit, stating ends that person
holds, reads false in the passive voice, and the agents reading it are better served by an
unambiguous author than by a document pretending to have none.

### Consequences for other tickets

- **11** inherits `GOALS.md` ≤ 40 lines as a fixed input, and gains the `GOALS.md`-edited-alone hook
  as a worked example of a budget-adjacent rule with a real artifact to attach to.
- **17** receives the cadence and the honesty problem, and the "all citations name the same goal"
  observation as a candidate reading-time check.
- **18** is where the rebuild's deliberate exclusions become non-goal candidates; N1 is the only seed
  this map writes.
- **13** is unblocked; its salvage entries are now checkable against `GOALS.md`, per its own
  amendment.
- **New ticket 19**: whether this repo keeps an ADR practice at all. 15's citation rule presupposes
  a carrier; if there are no ADRs, the rule has nothing to ride on. Graduated from fog.
- **New ticket 20**: the task ticket that writes the kit into this repo. Placement, the hook, the
  ownership-table row and the `CLAUDE.md` link — not authorship, which happened here.
