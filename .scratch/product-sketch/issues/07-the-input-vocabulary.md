# The input vocabulary: which actions exist, and which gesture means what

Type: prototype
Status: open
Blocked by: 06

## Question

The first repo had a `docs/ACTION_VOCAB.md` and nothing in this repo owns that claim. The scope
boundary is already set by the map: the **vocabulary** is decidable at a desk and is this ticket's
business; the **feel** — thresholds, animation, discoverability — needs a device and is out of scope.

- **What is the full set of acts on a work item?** Candidates from the first repo's model: complete,
  complete off-list, skip with a reason, snooze, dismiss, reopen, boost, start a timer. Each one that
  survives must name the state it writes. `closed_reason` exists because `SKIPPED` was written by four
  paths and only one meant the user did not do something — so a vocabulary that collapses them makes
  *"how often do I skip things"* wrong rather than merely imprecise.
- **Which acts are reversible, and is reversal exact?** The cascade computes a whole plan before
  writing anything, which is what makes undo exact, and reversal must reach only what this completion
  satisfied. Whatever the gesture is, undo is a real guarantee here and should be spent deliberately.
- **One gesture, one meaning, everywhere.** A swipe that completes on Today and dismisses on Tickets
  is the defect this ticket exists to prevent. The output is a table of gesture to meaning that holds
  across every surface, including the ones ticket 06 names.
- **What is reachable without a gesture?** Gestures are undiscoverable and this app has exactly one
  user, who will know them. That argues for gestures as accelerators over an always-visible path, not
  instead of one.
- **What does entering a thing look like?** Filing is the act the tracker analogy makes central, and
  the first repo's creation paths always wrote a daily schedule with no way to opt out. Ticket 01
  decides whether unscheduled is creatable; this one decides how many taps it costs.
