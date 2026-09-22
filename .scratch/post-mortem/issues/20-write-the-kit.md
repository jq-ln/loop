# Write the kit into this repo

Type: task
Status: open
Blocked by: 10, 11, 12, 13, 16, 17, 18, 19

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
