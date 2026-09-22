# The human's own procedure

Type: grilling
Status: open
Blocked by: 09

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
