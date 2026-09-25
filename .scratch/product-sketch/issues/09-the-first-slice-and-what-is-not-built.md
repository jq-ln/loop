# The first shippable slice, and what is deliberately not built

Type: grilling
Status: open
Blocked by: 03, 04, 05, 06, 07, 11, 13

## Question

The destination. `ARCHITECTURE.md` defines the slice as *"the smallest thing that can be in a user's
hands, and what is deliberately left out of it"*, ships both sections marked `**Unwritten.**`, and
`.githooks/pre-commit` refuses the commit that adds the first `.kt` file while either one is. This
ticket writes both, and the map's own damp is that every earlier answer must trace a line to one of
them.

Settled while charting: a **beachhead**, not a thin replacement — one concept end to end that the
author would genuinely use daily, with a long *not built* list — and the user is the author, who is
currently running the first Loop and will not switch to something worse.

- **What is the smallest daily-usable app?** The candidate is work items plus Today, with goals,
  observability and reflection all deferred. If no slice can be named that the author would actually
  use daily without those, that is evidence about the model and it should be recorded rather than
  worked around.
- **What does "in a user's hands" mean when it is not on a store?** `GOALS.md` N1 forbids assuming a
  channel, so the slice is defined by being installed and lived with, not by being released.
- **Every deferral is priced at one ADR.** The unbuilt list is consumable: the ADR that authorises an
  entry deletes its line in the same commit. Known candidates already: an in-app language model,
  migration from the first Loop, the plugin platform, `core-audio`, and whatever tickets 04 and 05
  leave standing. Each is one line saying what is not built and that building it needs an ADR.
- **What is the trigger for the second slice?** Not a date and not a feature count. `SALVAGE.md`
  describes the loop that worked: live with it on a phone and keep the loop that reports back.
- **Does anything here belong in `GOALS.md` instead?** An unbuilt entry graduates to a non-goal only
  when a reader of the goals might plausibly have built it. That file is the human's alone and is
  edited in a commit touching nothing else, so this ticket names candidates and never writes them.
