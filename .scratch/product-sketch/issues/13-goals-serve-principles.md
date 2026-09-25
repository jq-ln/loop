# Do goals serve principles, rather than a single topmost goal?

Type: grilling
Status: open

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
