# The protocol for choosing between two designs

Type: grilling
Status: open
Blocked by: 09

## Question

This repo needs a standing protocol for feature exploration. The term "A/B testing" was rejected
while charting: Loop is single-user, offline, has no `INTERNET` permission and no telemetry, so it
has no cohorts, no metric and no n. The term imports promises the setup cannot keep, and the old
repo has three separate migrations recording what a word carrying the wrong promise costs.

Two named mechanisms, both wanted:

- **Bake-off** — two rough variants built and judged side by side, immediately, by the user.
  Cheap, qualitative, the default. This is the `prototype` skill run twice.
- **Trial** — one variant lived with for a period, then the other, then a decision. For features
  where only use over time can tell, at the cost of the user's memory being the instrument.

Settle: what triggers each; how a bake-off is set up so two variants can exist without the
coordination protocol from ticket 10 fighting it; what a trial's period is and what is recorded
during it so memory is not the only instrument; how the losing variant is disposed of; where the
decision is written down and whether it earns an ADR. And which questions deserve neither — the
cost of a bake-off is real and most decisions should just be made.

Adopt the two terms into the repo's glossary as part of resolving this.
