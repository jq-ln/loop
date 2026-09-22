# The human's own procedure

Type: grilling
Status: open
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
