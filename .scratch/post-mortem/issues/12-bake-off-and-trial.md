# The protocol for choosing between two designs

Type: grilling
Status: open
Blocked by: 09, 15

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

## Amendment after ticket 09

The mechanism survives the verdict; its default inverts.

Prototypes are among the few artifacts that *reduce* comprehension load: they answer a question and
are then deleted, rather than staying to be cross-referenced. So bake-off is kept — but **as the
justified exception, not the default**. This ticket's own line, "most decisions should just be made",
is promoted from caveat to rule.

Under 15's citation rule a bake-off must name the goal the choice serves, which disqualifies most
candidates by itself. Settle what clears that bar. The old repo's plugin subsystem — built day 3,
deleted day 7 — is the worked example of a decision a two-hour bake-off would have pre-empted, and
is the standard to calibrate the trigger against.

Blocked by 15 as well as 09: the citation rule is the trigger's main filter.
