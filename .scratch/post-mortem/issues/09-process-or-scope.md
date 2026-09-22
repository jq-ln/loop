# Was it the process, or was it the scope?

Type: grilling
Status: resolved
Blocked by: 08

## Question

The pivotal ticket. Two accounts of the death, and the kit is different under each.

**Process**: the machinery ate the project. Rules bred rules, reviews bred findings, findings bred
issues, and the documentation describing the work overtook the work. Under this reading a leaner,
better-bounded process saves the next attempt.

**Scope**: 43,488 lines in eight days was the anomaly. The process grew because that much surface
cannot be held in view any other way, and the machinery was a symptom. Under this reading a leaner
process on the same scope fails identically, and the lesson is about how much to build before
shipping anything.

They are not exclusive, and the useful answer is probably a weighting with a mechanism attached —
but a weighting that was decided rather than assumed. Use tickets 01, 02 and 05 as the evidence,
and 08 as the check against experience.

The user has explicitly consented to a finding that contradicts the framing this effort began with.
If the evidence says scope, say scope. If the honest answer is that this map is a process review
and not a post-mortem, rename it on the map and say why.

## Answer

HITL session, 2026-09-22. Four rounds of grilling, ten decisions, every recommendation put to the
user and accepted as stated. No new evidence was gathered: 01, 02 and 05 are the evidence and 08 is
the check against experience. Reading 11, 12, 13 and 17 in full mid-session corrected two of the
agent's own recommendations — 11 had already been re-chartered by its own amendment, and the pace
question was already a bullet inside 17 — both corrections are reflected below.

### The verdict: three layers, not a weighting

09 asked for a weighting with a mechanism attached. A weighting is not the honest shape of the
answer. Neither named account is the root; both are effects of a single absence, and they sit at
different depths.

**Root: there was no destination.** No goals, vision or principles file existed anywhere in
`../old_loop`; `ROADMAP.md` said *"Deliberately not built"*; the `CLAUDE.md` ownership table assigned
an owner to every kind of claim and had no row for the project's goals; the only goal-shaped sentence
in the repo — #64's *"Loop is finished, and submitted to F-Droid"* — stated the means as the end.
This is 08's structural finding, carried forward unchanged.

**Proximate: breadth outran comprehension.** *"I no longer knew what was happening under the hood."*
Caught in the act by 04 — the four pillars are an 8-line enum at `AppMenuSheet.kt:153` and three
documents assert a `:core-api` type — and undiscovered until an inventory ran at post-mortem. 05
locates the anomaly precisely: breadth, not volume. 106 files, 640 cross-references, one per 12.8
lines, and real domain logic only 6,470 net lines of 30,545.

**Third-order: the process volume.** Real triage (08), adopted *because* the repo was already
unwieldy, which then became a second comprehension load in its own right — the tracker holding 107k
words against the repo's 90k (01), 54% of it existing only because the process could observe itself
(02). 05's numbers stand untouched; only their causal direction moves.

**Why this beats both accounts 09 offered.** Scope-primary and process-primary each explain a
quantity and neither explains a *direction*: 23% of all Kotlin written was later deleted, a plugin
subsystem was built on day 3 and removed on day 7, and F-Droid propagated through four ADRs before
being recognised as arbitrary. That is not too much surface and it is not rules breeding rules. It is
work aimed at nothing it could be checked against, which is the root above. The three-layer account
keeps every finding rather than choosing between them, and it confirms the kit's ordering is already
correct: goals first (15), comprehension second (17), leanness third (11).

### What 09 outputs: a criterion, not a mechanism

09 does not design the mechanism that would have caught this by day 3. It states the criterion every
downstream ticket must satisfy, and leaves the mechanisms to the tickets that own them — designing
them here would make 09 the map's second pivotal ticket and starve 17.

> **The comprehension criterion.** Every kit rule must reduce the human's comprehension load. A rule
> that adds an artifact to read is net-negative unless it pays for itself.

**Two tests now gate every kit rule, and they are ordered.** Comprehension first — should this rule
exist? — then 03's latency test — can it be made to hold, by attaching to an artifact the work must
touch anyway? The order is load-bearing: asking latency first invites a well-attached rule that
should never have been written, which describes most of the 76 ADRs, each locally justified and true
when written. Ordering also makes failure legible, since *"passes comprehension, has nothing to
attach to"* is actionable where a single conflated test only returns no.

### Consequences, recorded where they belong

1. **The map is a post-mortem and is not renamed; its Destination is amended.** The title is already
   agnostic and survives. The word *"process"* in the Destination named only the third-order cause,
   and the Destination is load-bearing because every session orients to it before choosing a ticket.
   A map whose stated destination under-describes its own findings is the `:core-api` defect again.
2. **Superseded gists are corrected on the map; ticket bodies stay immutable.** Tickets are dated
   evidence, and rewriting them would destroy what this map is most valuable for — the gap between
   what the evidence showed and what the experience was. But an index carrying a wrong gist is worse
   than useless. 05's line is amended with a pointer to what overturned its causal reading; its body
   is untouched. This is now the standing rule for the map.
3. **11 keeps its existing amendment and gains the criterion.** The re-charter from length to count,
   reference density and conflict already happened in 11's body after 05 and 07. 09 adds only the
   ordered pair of tests, which 11 must apply to its own enforcement mechanism.
4. **17 is the kit's load-bearing document, and owns the pace question whole.** 17 anticipated that a
   process death made it load-bearing and a scope death made it a short checklist; under a
   comprehension proximate cause it is load-bearing, and *"smaller ambitions"* is a line inside it
   rather than a replacement for it. It is not exempt from 11's constraint or 03's latency test, and
   that tension is 17's to resolve. The fog patch on agent output outpacing human reading is cleared
   into 17 rather than becoming its own ticket: the gap is one question, and splitting the human's
   side from the agent-side limit guarantees two half-answers needing reconciliation — which is
   precisely the day-8 repair work 05 measured.
5. **12 survives with its default inverted.** Prototypes are among the few artifacts that reduce
   comprehension load, because they answer a question and are deleted rather than staying to be
   cross-referenced. So the mechanism stands; what falls is bake-off as the default. It becomes the
   justified exception, and under 15's citation rule it must name the goal the choice serves, which
   disqualifies most candidates by itself. The day-3 plugin subsystem deleted on day 7 is exactly
   what a two-hour bake-off would have pre-empted.
6. **18 must require the rebuild to name its first shippable slice.** *Build less before shipping*
   follows from the proximate cause but collides with product scope being out of scope. The kit
   mandates that the rebuild state its smallest shippable thing and what is deliberately excluded
   from it, without stating what that is — the same shape 18 already has for the sketch. It attaches
   to the sketch because that is the one artifact the rebuild must produce before writing code, and
   therefore the only place a breadth constraint can attach early enough to matter. The old repo
   never sketched at all, and two of its four pillars were never built.
7. **15 becomes a blocker of 11, 12, 13 and 17.** If the root cause is that nothing existed to check
   decisions against, no ticket that writes a rule may resolve before the artifact rules get checked
   against exists. 15 is already unblocked and claimable now. 11 and 17 are
   deliberately left unordered against each other: a budget set before knowing what the load-bearing
   document needs will be wrong, and whichever resolves second can adjust — forcing an order only
   decides arbitrarily which one gets to be wrong.
