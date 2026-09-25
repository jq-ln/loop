# Do goals serve principles, rather than a single topmost goal?

Type: grilling
Status: resolved

## Question

Raised by the author after *What a goal is* resolved, and it amends that ticket rather than
reopening it — the precedent *The goal-to-work edge* set with dormancy, so each decision keeps one
home.

02 settled that every goal names a parent, that the parent defaults to **the root**, and that the
root is **the single exemption from admissibility**: no satisfaction condition, can never be
satisfied, *"its job is orientation, not closure"*. The author's proposal is that the top of the
tree should not be one thing. Goals should serve **principles**, plural — a set of standing
commitments that goals are filed under.

### The proposal is cheaper than it first reads

It is not another layer. 02's root is *already* a principle: a thing that orients, never closes,
and is exempt from the rule every other goal obeys. The concept exists; it is a singleton with an
exemption bolted to it.

02 gives the reason the root has no name: *"It gets no user-facing label: there is exactly one, and
a category name above a singleton is furniture."* Inverted, that is an argument for this proposal —
once there is more than one, the label stops being furniture and becomes the thing the human chose.
Nothing is filed one level deeper than it is today, and **an exemption becomes an ordinary kind**,
which is usually the direction a model improves in.

### What it buys that a singleton cannot

Under one root, *"is this principle being served?"* is vacuous: every goal reaches the root by
construction, as 02 says outright. Under several it becomes computable, and it is the most valuable
thing this app could say — **a principle with nothing under it is a principle you are not serving**.
That is the distance between stated values and committed work, and no other entity in the model can
produce it.

That is the engine claim. The stage claim is orientation, which nothing else covers, because every
other entity in the model closes and a principle never does. Both need to survive the grilling, not
just be asserted here.

### A worked example, which the app does not ship

To make the questions concrete only. **No principle is hard-coded, and the app ships none.** The set
is authored by the human, and this example is one plausible set among many:

the five **yamas** — non-violence, truthfulness, non-stealing, right use of energy,
non-possessiveness. (They are Patanjali's, and Jainism's five vows; Buddhism's near-parallel is the
five precepts. Named precisely because this repo is public and G2 is about work being legible.)

The example is doing one job: showing a set that is small, stable, non-overlapping, and impossible
to ever tick — which is the shape the proposal needs to hold, and which a set of five self-authored
life ambitions might not.

## Settle

- **Does it pass the two-claims test?** `SALVAGE.md` refuses a new top-level concept that cannot
  separately evidence a stage nothing else covers **and** an engine. Both are argued above. The
  engine's load-bearing half is the unserved-principle predicate; if that prompt would be ignored in
  practice, the concept is a taxonomy and the first repo's eight-line menu enum is what it becomes.

- **What replaces "defaults to the root"?** This is the real cost, and it contradicts 02 directly.
  That default is deliberate — *"filing never blocks on deciding where a thing hangs"* — and it is
  the same reasoning that put the citation gate at commitment rather than capture. Remove the
  singleton and there is no default left. The candidate: goals with no principle land in an
  **unassigned pile that is not itself a principle**, so root-adjacency survives meaning exactly
  what 02 said it meant, *filed without deciding what it serves*, except it is now a real statement
  rather than a structural accident. Same shape as the uncited backlog for work, and the same
  falsifier is available.

- **May a goal serve several principles?** A goal plausibly serves two at once. The cost here is
  smaller than it first appears, and the reason is 03's own refusal rule: **a prerequisite naming a
  principle is dead on arrival**, for the same reason one naming the root was — it can never be
  satisfied. So no node above a goal can ever be blocked, multi-parenting at this level never
  creates an ambiguous inheritance path, and 03's rule holds unchanged. The edge table's first row
  changes shape without changing behaviour. The remaining cost is the unserved signal: a goal filed
  under four principles serves all four, and the emptier a principle can be kept the more the signal
  is worth.

- **May a goal cite several goals?** This is the question that reaches 03's engine, and it is where
  the structural cost actually lands. Blocking **inherits down the citation tree**, so a definition
  citing two goals with one of them blocked has no unambiguous answer today.

  Worked through, the semantics have to be **AND**: a goal is *purpose*, not readiness, so work
  serving both A and B is legitimately doable for B's sake while A waits — blocked only if every
  citation path is blocked. But that is precisely the leak. Under AND, **adding a second unblocked
  citation becomes a way to unblock work**, so a goal-level prerequisite stops meaning *this is not
  ready* and starts meaning *this is not ready via this parent*, which is not what anyone means by
  it. A DAG here quietly makes goal-level prerequisites advisory.

  So: single-parent on goal→goal keeps them meaningful. If this goes multi-parent anyway, the honest
  move is to **refuse goal-level prerequisites outright** and let only definitions carry them,
  rather than shipping a rule that can be routed around.

  **That fallback is conditional on the multi-parent branch and is not an improvement single-parent
  also wants.** Recorded explicitly because this session first suggested otherwise and was corrected:
  the leak *was* the second citation path, so under a tree there is exactly one path and nothing to
  route around. The derivation is conditional on the DAG and says nothing about the tree.

  **Goal-level prerequisites earn their place, and the reason is one a definition-level prerequisite
  cannot reach: they outlive the absence of work.** A prerequisite on an undecomposed sub-goal means
  every definition later filed under it is **born blocked**. Definition-level cannot express that,
  because those definitions do not exist yet — and 02 established that the undecomposed goal is the
  most common state and the one that rots. Dropping them would mean "nothing under B2 is startable
  until B1 is satisfied" is inexpressible until B2's work has already been enumerated, which is
  backwards: the decomposition is the thing the prerequisite is waiting for.

  The objection this answers — *purposes do not become ready* — is true and is not what the mechanic
  claims. It never makes a goal actionable; goals are never actionable in this model, being satisfied
  by predicates. It says *work under this purpose is not yet startable*, and delivers that by
  inheriting downward, which is why 03 made it inherit rather than making goals startable. Read that
  way the mechanic is uniform: a prerequisite always says "not yet startable", and on a goal it says
  it about a set rather than about one item.

  The asymmetry is what makes the split clean, and it is worth stating because it looks like a
  contradiction: the **step** edge has been a many-parent DAG all along and is entirely unaffected,
  because a step edge carries no readiness. Re-derived from the live database for this ticket —
  29 `task_link` rows over 26 distinct children, of which **three have two parents each**, and
  nothing about that is leaky. It is specifically *readiness inherited through a many-parent edge*
  that breaks.

  Both bullets above are the session that resolved *The goal-to-work edge* arguing against its own
  ticket's shape annotation, unprompted. 03's headline survives either answer — the decomposition
  edge is still the citation edge read backwards, which is as true of a DAG as of a tree.

- **Where does work hang?** 02 required every definition to cite a goal, defaulting to the root, and
  read the two piles differently: *"goals on the root are unexamined, work on the root is life."*
  That second pile needs a home. Can a definition cite a principle directly, or only a goal?

- **Are principles mutable, and is there a cap?** If they are free to create and easy to churn, the
  top level becomes a filing drawer, everything ends up served by something, and the unserved signal
  goes quiet — the root rebuilt with extra steps. Goals are meant to be created and culled
  constantly; principles should be nearly immutable. Does a principle get 02's `abandoned`, or does
  a life change mean editing one in place?

- **Does a principle get a screen?** *Observability* named one chart kind and put the rest in *what
  is not built*; the same discipline applies. Name the smallest thing that serves the unserved
  predicate.

- **What does it cost on day one?** The root was *"created once at setup, unreachable by the user"*
  and needed no authoring. Principles must be written before the app does anything, which is real
  G1 friction and lands in the map's fog entry for onboarding and the empty state.

- **Is `principle` the word?** It is the author's, and it has to survive `CONTEXT.md`'s bar and the
  map's rule that no concept from the developer analogy enters the documents untested. This one is
  not from the analogy, which is a point in its favour.

## The evidence this ticket needs before it is grilled

**The author writes down the principles he would actually enter.** If the list is one, this is a
rename with extra machinery. If it is four or five and they differ in kind, the case is settled from
G1 alone.

That test exists because the proposal's stated reason is not admissible evidence here. *"Applies to
a wide range of philosophies, religions, and secular viewpoints"* is generality for users who do not
exist: `GOALS.md` N1 rules out any channel, G1 is an app the author uses every day, and the plugin
platform is what generality-for-nobody cost this project last time — 5,600 lines discovering zero
plugins. The idea may well be right. It has to be right for one person, and that is checkable today.

## What this ticket would spend

- **02's root section**, amended — the exemption becomes a kind, and the default parent is replaced.
- **03's edge table**, if a goal may serve more than one principle.
- **A `CONTEXT.md` entry**, which [12](12-the-vocabulary-and-adr-register.md) now owns.
- Possibly an **ADR**: an exemption becoming a kind is hard to reverse once work is filed under it.

## Evidence

**The list, as the author wrote it**, in answer to the gate this ticket pre-committed to. Four, each
a proposition followed by the one thing he would file under it today:

1. *The intellect must be sharpened* — write one mini essay a week
2. *We live in an aesthetic universe* — reach improvisational fluency in Django-style jazz on violin
3. *I inhabit a body* — diagnose and address all notable weaknesses and pains that impede daily life
4. *The spiritual and material must be balanced* — maintain a meditation practice

Four, differing in kind — intellect, aesthetics, body, spirit — non-overlapping, and none of them
tickable. That is the shape the ticket said would settle it from G1 alone, so adoption was never put
back to the author as a question. He added one qualification, and it is load-bearing rather than
incidental: the list is *"quick and dirty"*, he expects to refine and add within weeks or months, and
the hope is that honest use lets the principles **mature and settle into a solid form**. That is
answered under *Change*, below, and it improves the falsifier the session had proposed.

**The 1:1 pairing in that list is an artifact of the question, not data.** The session asked for a
goal beside each principle, so the list cannot be read as evidence that every principle is served.
The probe that would have fixed this was dropped rather than re-asked, because the engine as finally
stated does not rest on it.

### One re-derivation, and it holds

The ticket's only live-data claim, checked against the preserved database rather than the ticket:
`task_link` holds **29 rows over 26 distinct children, of which exactly three carry two parents**
(child ids 17, 18, 23). Confirmed exactly as written. Recorded because this map has found a stale
survey in almost every ticket that carried one, and this is the counter-example: the step edge really
has been a many-parent DAG in production and really has caused nothing, so the asymmetry the answer
below leans on is measured rather than asserted.

## Answer

**Adopted. The top of the tree is a set of principles, and 02's root is deleted rather than kept
above them** — keeping it would reintroduce the vacuous predicate one layer up, which is the whole
thing the proposal buys. The exemption becomes a kind. The citation structure becomes a forest.

### The two claims, and the engine is not the one this ticket argued

**Stage: orientation.** Every other entity in the model closes — a goal satisfies or is abandoned, a
definition runs, a target resolves to a verdict. A principle never closes. 02 had already carved that
behaviour out as an exemption bolted to a singleton; naming it as a kind is the model improving in
the direction it usually improves in.

**Engine: *is this principle being served?*** — and the ticket overstated its own case by resting
this on the unserved predicate, *a principle with nothing under it*. That is the **degenerate** case.
The common case is a principle whose subtree is **entirely dormant or stalled**, and every flag that
detects it already exists: 02's family-specific dormancy, 03's amendment counting only actionable
time, 05's `stalled`. The principle-level answer is a **roll-up of flags already specified**, which is
precisely 02's own move for satisfaction — the same predicate evaluated one level up, no new
machinery. Under a singleton root the roll-up is the whole app and says nothing. Under four it
partitions the app into four answers, and the distance between stated values and committed work is
the one thing no other entity in this model can produce.

That also disposes of this ticket's own taxonomy test — *"if that prompt would be ignored in
practice, the concept is a taxonomy"* — **mechanically rather than by promise**. The prompt lands in
`Revise` and therefore inherits 05's **dismissal with a dated reason**. It cannot be silently
ignored; it can only be dismissed on the record. That is the difference between an engine and an
eight-line menu enum, and it costs nothing, because 05 already built the dismissal to give the
revision log a consumer from day one.

### Only one of the four entries is a goal

The evidence's sharpest finding, and it is about the model rather than about the list. Classified
against 02's admissibility rule and 04's rule 3, read from those tickets rather than from the map:

| # | The entry | What it is |
|---|---|---|
| 1 | write one mini essay a week | a **definition** on a weekly schedule |
| 2 | improvisational fluency in Django-style jazz on violin | a **terminal declared goal** — the only clean goal in the list |
| 3 | diagnose and address all notable weaknesses and pains | a goal that **never closes**; standing with no metric, so 02 refuses it as written |
| 4 | maintain a meditation practice | a **definition** on a daily schedule |

1 and 4 are standing practices, and 02 refuses a standing goal without a metric precisely because it
is *"a routine wearing a hat."* Nor can a metric rescue them: *"did it on N days this week"* is the
exact predicate 04's rule 3 refuses — *"a predicate is computed over the values actually recorded,
and may never be a function of the days with no value"* — moved to the run-log family and flagged as
an ADR **after the post-mortem**. 3 is standing too and needs a real reading, a pain or mobility
metric, before it is admissible at all.

**Half of what the author would enter on day one is work, not goals.** That is what makes the next
section a finding rather than a preference.

### Work hangs on a principle directly

**A definition cites a goal *or* a principle.** 02's citation target widens; nothing else about the
gate changes, and it still sits at commitment rather than capture.

The alternative — permit only goals, and invent an intermediate goal above each standing practice —
is refused, and not on tidiness grounds. **It destroys the engine.** Under it every principle
acquires a goal above its work *by construction*, so every principle is served by construction, and
the unserved reading goes silent on day one: the same vacuity as the singleton root, reached by
filing convention instead of by structure. It also requires inventing exactly the entity 02 refuses.
The third option — amend 02 to admit a standing goal over a run-log predicate — is real work, and 04
already sequenced it after the post-mortem; pulling it forward is not this map's business.

02's two piles survive with their readings intact. *"Goals on the root are unexamined, work on the
root is life"* becomes **work under a principle is that principle being lived**, partitioned four
ways instead of pooled once — which is strictly more informative, and is the roll-up's main fuel.
03 needs no new rule: **a prerequisite naming a principle is refused at creation**, for the same
reason one naming the root was, so a definition citing a principle simply has an unblockable parent.

A consequence, taken deliberately: a principle served **only** by standing practice and never by a
goal is **not flagged**. The app can detect it and will not say it. It is a nag, which G1 rules out
on the author's own stance that the user is trusted or owns the consequences; and structurally it
would smuggle the refused option back in through the flag list, since a prompt demanding a goal above
every practice manufactures invented goals. A principle served by a standing practice is being
served. The practice going dormant is caught one level down, and that is the only honest signal here.

### One principle per node, and the citation edge stays a tree

**Single parent throughout, no default.** Four reasons, in order of weight: it keeps the unserved
reading meaning something, which is the engine; it is one rule for the whole citation edge rather
than a tree with a special case bolted to its top; being made to answer *which of these four is this
really for* once, at filing, is the same mindfulness 02 bought with the citation gate; and a node
that genuinely serves two principles is usually two nodes. Falsifier: **repeatedly re-filing the
same goal between two principles** means the tree is wrong at this level and it should become a DAG
there and nowhere else.

**Goal→goal stays a tree, and goal-level prerequisites survive.** Settled independently of the
principle question, because the derivation does not depend on what sits at the top. Under a DAG the
semantics have to be AND — work serving A and B is legitimately doable for B's sake while A waits —
and that is the leak: **adding a second unblocked citation becomes a way to unblock work**, so a
prerequisite stops meaning *this is not ready* and starts meaning *this is not ready via this
parent*. Under a tree there is one path and nothing to route around.

Goal-level prerequisites then earn their keep on a claim a definition-level one cannot reach:
**they outlive the absence of work.** A prerequisite on an undecomposed sub-goal means every
definition later filed under it is **born blocked**, and 02 established the undecomposed goal is both
the commonest state and the one that rots. The objection — *purposes do not become ready* — is true
and is not what the mechanic claims: it never makes a goal actionable, it says *work under this
purpose is not yet startable*, and delivers that by inheriting downward, which is why 03 made it
inherit rather than making goals startable.

**The step edge is untouched and stays a many-parent DAG** — the 29 / 26 / 3 re-derived above. It is
specifically *readiness inherited through a many-parent edge* that breaks; a step edge carries no
readiness, which is why three two-parent children have sat in production causing nothing.

### Change: wording is free, identity is an act

The author's own remark — that the list is quick and dirty and will be refined and added to — is the
thing this ticket was written to fear: *"if they are free to create and easy to churn, the top level
becomes a filing drawer, everything ends up served by something, and the unserved signal goes quiet."*
It splits three ways and needs **no new concept for any of them**.

- **Wording is free, and revising it is already a verb.** 05's `revision` is *"a dated attested
  change whose subject is a goal, a definition or a target."* **`principle` becomes a fourth
  subject.** Refinement then becomes the revision log's most reliable fuel rather than an untracked
  edit. This is the same split `GOALS.md` makes about itself: wording sharpened at any time, identity
  changed only by deletion.
- **Adding is the dangerous half**, because nobody adds an *empty* principle — they add one to house
  a goal that fits nothing, and that single act is how the signal dies. So: **a principle is created
  as its own act and cannot be created inline from the filing flow.** This is deliberately the
  opposite of 02, which permits creating a metric inline from the goal screen. Different rule because
  different failure: the metric gate protects the predicate's computability, the principle gate
  protects the unserved reading, and inline creation is exactly what kills the latter.
- **Dropping one is 02's `abandoned`, never a delete.** Same state, same finality; the subtree
  survives having lost its citation. `satisfied` is unavailable to a principle by construction, which
  is the stage claim restated as a state machine.

**No cap and no immutability rule**, on the author's stance that the user is trusted or owns the
consequences of not taking the principles seriously, and on the hope that honest use is itself how
one learns what is important and what is superfluous. **That hope is a prediction, and the revision
log measures it**: if principles are to *mature and settle into a solid form*, then **the frequency
of principle revisions must decay**. If it has not decayed after a year of honest use, the maturation
hypothesis is false and the flexibility is churn. Recorded as the primary falsifier, because it tests
the actual claim; the session's own proposal — **a principle created on the same day as the first
node filed under it, twice over** — is kept beside it as the cheaper filing-drawer detector.

### What replaces the default parent

Nothing does. 02's default existed so *"filing never blocks on deciding where a thing hangs"*, and
with the singleton gone there is no default left. Goals with no principle land in an **unassigned
pile that is not itself a principle**, so 02's root-adjacency prompt survives meaning exactly what it
meant — *filed without deciding what it serves* — except it is now a real statement rather than a
structural accident. Uncited work stays where 07 put it, in `Offered`, whose two exits are unchanged;
the only difference is that the set of things it can be committed to has widened.

**Day one is zero principles with everything unassigned.** The ticket's last bullet feared real G1
friction from having to author principles before the app does anything, and the unassigned pile
absorbs it entirely: the app ships with none, the root-adjacency prompt is the whole empty state, and
nothing at setup asks for authoring. The onboarding question stays in the map's fog where it already
sits, with this as the note it inherits.

### Surface, and the word

**No fifth destination.** 06 settled four and 04 set the discipline of naming the smallest thing that
serves the predicate. Principles are the **top level of the Goals screen**; the prompt is a flag in
`Revise`, **`unserved`**, joining 05's assembly. 02 refused the root a label because *"a category
name above a singleton is furniture"* — inverted, named rows at the top are the least furniture
possible, because the labels are the thing the human chose.

**The word is `principle`.** It collides with nothing live: `commitment` is refused, 02 having
recorded it *"half-spent by the human's own procedure"* and having spent the rest of it on *gated at
commitment*; `pillar` is spent twice, on the first repo's four and on 04's metric; `value` is vague
and reads as self-help; `area` names the failure mode, which is a bucket. The decisive argument is
the evidence's own grammar: the author wrote four **propositions** — *the intellect must be
sharpened*, *I inhabit a body* — not four buckets. `area` is the word for a bucket; `principle` is
the word for a proposition one holds and can fail to serve. It is also not from the developer
analogy, which this map requires of anything reaching the documents.

## What this spends

Amendments are recorded here rather than by editing the tickets they touch, on the precedent
*The goal-to-work edge* set with dormancy: each decision keeps one home.

- **02's root section.** The exemption becomes a kind; the root is deleted; the default parent is
  replaced by the unassigned pile.
- **02's citation rule.** A definition cites a goal **or a principle**. The gate stays at commitment.
- **02's dormancy table.** Gains the principle-level roll-up, whose evidence is its subtree's — the
  same rule the declared family already has.
- **03's edge table.** Changes in wording, not in shape: the citation row reads *definition or goal →
  goal or principle*, a forest, single parent, no default. The refusal of a prerequisite naming the
  root becomes a refusal of one naming a principle. Its headline survives untouched — the
  decomposition edge is still the citation edge read backwards.
- **05's `revision`.** Gains `principle` as a fourth subject.
- **05's flag assembly.** Gains `unserved`.
- **12's charter.** Widened from register-only to register-plus-one-write, for the ADR below.
- **A `CONTEXT.md` entry** for `principle`, which 12 owns.

## The ADR, and why it is not deferred

An ADR is owed. It is hard to reverse — once work is filed under a set of principles, collapsing back
to a singleton is a migration; it is a real trade-off — 02's zero-friction default parent given up to
buy a predicate that can fail; and it is surprising to a reader of the schema, for whom the root's
nullable parent and its admissibility bypass simply are not there.

**The moment is ticket 12, not port time**, and the session's first answer was the other way round
and wrong. 01's rename and 05's `occurrence.note` are genuinely undecidable until port time — 05's is
explicitly conditional on how the single-`note` decision lands — whereas this one is fully decided
now and nothing at port time can change it. Bundling it with them borrows their deferral without
their reason. Against that, 12 records the direct evidence: the old repo's *"ADR in the same commit
as the code, never a follow-up"* **broke in 1d 7h and left two decisions permanently unrecorded when
the repo was killed.** A deferred ADR is a lost one, and catching that is why 12 exists.

`docs/adr/` sits outside the standing-claim perimeter, so the write costs nothing against the 12-file
cap, and *decide first, write once* is satisfied rather than violated — the deciding is done and this
is the one write. It cites **G1** and names no path.

## What this does not decide

- **Onboarding and the empty state.** Stays in the map's fog, now carrying the note that day one is
  zero principles with everything unassigned.
- **`N` for the roll-up.** 02 left its dormancy `N` as a knob tuned by use; the principle-level
  roll-up inherits that and adds no second number.
- **Whether a standing goal over a run-log predicate is admissible.** 04 owns it, after the
  post-mortem. This ticket's evidence is a third argument for taking it up — two of four entries want
  that shape — and no reason to take it up here.
