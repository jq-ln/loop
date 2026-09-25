# Today: what is on it, and how is it ordered?

Type: prototype
Status: open
Blocked by: 01, 03

## Question

The app opens to Today. G1 makes this the load-bearing decision in the sketch — an app used every day
is mostly this screen, and everything else is reachable from it. The first repo's answer was Do →
Today, where Do was *"≈ the whole app"*, and its Today query carried overdue pending roots forward
alongside the day's fresh ones.

This is a prototype ticket because it is a *how should it look* question, and the prototype is
throwaway: the artifact is linked from the answer and does not survive into the repo.

- **What is on it?** Everything due today is the obvious answer and probably wrong: the charting
  hypothesis is Today as *due plus unblocked and worth doing* — the frontier reading — in one list
  rather than two screens. Test that against a real day with a routine, a deferred one-off and a
  standing goal in flight.
- **How is it ordered, and is the order computed or chosen?** The first repo had a `ScoreCalculator`
  weighting importance against overdue-ness against a decaying boost, and its own KDoc argued there
  are *deliberately no absolute priority integers, because they require a global consistency the user
  will never maintain*. That argument survives the rewrite; the score may not.
- **What does a missed thing look like?** *The work-item model* settled that an untouched day closes
  as a recorded skip rather than being carried silently, so the miss is a fact and Today is where it
  becomes visible or invisible. A list that grows a tail of yesterdays is the failure mode that makes
  a tracker unpleasant to open, and the decision is now Today's alone: the record exists either way.
- **Where does unscheduled work show, and does the backlog get opened?** *The work-item model* made
  unscheduled the default for capture, and left this as a constraint rather than a question: **if
  Today has nowhere to show unscheduled work, unscheduled must not be the capture default.** A
  backlog nothing opens is what G1 rules out, and this ticket owns the call.
- **How does a routine's step tree appear?** A run tree is nested and a list is flat. Whether
  Today shows roots, leaves, or a root that expands changes what a tap means.
- **What is the second screen?** Today plus Tickets plus whatever ticket 04 and 05 leave standing is
  already four destinations, and the first repo shipped four menu rows with one of them greyed out.
  Name the navigation, do not classify it.
