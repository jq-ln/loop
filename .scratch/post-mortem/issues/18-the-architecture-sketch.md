# The architecture sketch the rebuild must produce on day one

Type: grilling
Status: resolved
Blocked by: 13

## Question

Decided in ticket 08 (Q11, option b): the kit **mandates** an architecture sketch as a required
day-one artifact of the rebuild, and specifies what it must cover, but does not draw it — the
content is the rebuild's business and stays out of this map's scope. Kept as its own file rather
than a section of the human's procedure (ticket 17), because one changes weekly and the other should
not; `../old_loop`'s `CLAUDE.md` going 194 → 244 lines in 2h52m is what one file owning several kinds
of claim costs.

The cause this answers: the architecture was never sketched at the start, two of the four pillars
were never built, and by day six the author could not say what was under the hood.

- **What must the sketch cover?** Candidates from ticket 04's inventory: module boundaries and how
  many there are (eight bought nothing the two Android modules did not already buy via Robolectric);
  testing seams and what they are for; what is deliberately unbuilt.
- **What must it *not* do?** The old repo's documents asserted an architecture the code never had
  and nobody noticed for eight days. A sketch that cannot be checked against the code is worse than
  none. Is there a check, and what is it attached to?
- **When does it change, and what happens to the old one?** "Even if it changes over time" was the
  user's phrasing. Overwritten, versioned, or appended — and what re-opens it.
- **Its relationship to the salvage list** (ticket 13): `CompletionCascade`, the RRULE schedule
  engine, `core-audio` and definitions-vs-occurrences are weeks each to re-derive and are binding
  inputs. Does the sketch have to account for them explicitly, or merely not contradict them?
- **Who writes it** — the human, an agent, or the human from an agent's draft — given ticket 17's
  finding that an author who did not write the architecture could not account for it.

Blocked by 13 because the salvage list is this sketch's principal input.

## Amendment after ticket 09

The sketch must require the rebuild to name its **first shippable slice**: the smallest thing that
can be in a user's hands, and what is deliberately excluded from it.

*Build less before shipping* follows from 09's proximate cause, and this is where it attaches. The
kit mandates that the rebuild state its slice; it does not state what the slice is, which would be
product scope and is out of scope for this map — the same shape this ticket already has for the
sketch itself. It belongs here because the sketch is the one artifact the rebuild must produce before
writing code, and therefore the only place a breadth constraint can attach early enough to matter.
The old repo never sketched at all, and two of its four pillars were never built.

## Amendment after ticket 15

15 settled that the kit writes exactly **one** day-one non-goal (N1, shipping through any particular
store or channel) and that everything else is seeded by the rebuild, because "no plugin subsystem"
and its kin are *product scope*, which this map rules out.

This ticket is where they enter. 09 already required the sketch to name the rebuild's smallest
shippable slice **and what is deliberately excluded from it**; 15 adds that those exclusions are
non-goal candidates by construction, and that promoting one into `GOALS.md` follows 15's entry rule
— written when something is actually rejected, and only when a reader of the goals might plausibly
have built it.

## Note after ticket 11

The sketch is **one** of the nine standing-claim files 11's budget expects on day one, inside a hard
cap of 12; wanting two is a decision against the cap and belongs in this ticket's answer.

11's doc-code entry rule bears directly on a sketch, which is the document type most tempted to
assert structure: **no document asserts a structural fact the source asserts about itself** — no
module type, no layer boundary, no file layout, no count of anything — and a document that points at
structure points at a path, which `pre-commit` checks resolves. 04's `:core-api` defect was three
documents asserting a module type against an 8-line enum, and a sketch written before the code exists
has nothing to point at yet. That tension is this ticket's to resolve: a sketch of code that does not
exist can describe intent, but the moment it names a structure it is a claim the source will
contradict.

## Note after ticket 13

13 resolved and handed this ticket the architecture half of the salvage inventory outright, so the
conclusions live here and are deliberately absent from `SALVAGE.md` — putting them in both would give
one claim two owners. Three binding inputs:

- **One rules module plus one Android side, not eight modules.** The compiler-enforced direction is
  real and worth keeping; the over-split parts are not — one module was 363 lines of which a third
  was constants and a duration formatter, and another was 501 lines with zero tests that existed only
  to make a header visible across a boundary the split itself had created.
- **Adopt the JVM test runner on day one, and say that is what buys the device-free suite.** The old
  repo credited the module split; 610 of its 945 tests lived in the Android modules and still needed
  no device. This is also an instance of `SALVAGE.md`'s third prohibition, so the sketch must not
  repeat the error while recording it.
- **Exported schemas in version control as the input to every migration test.** The pattern, not the
  twelve migrations.

**A term to disambiguate, and it is this ticket's word.** The user read "two modules, not eight" as
being about plugins, because module was the early name for them. The eight are Gradle build units in
one repo; a plugin is a separately installed app. The collision is real — both first-party plugins
were written as in-repo build units and then extracted to become plugins — so the sketch states the
distinction rather than relying on context. 13 routed it to `CONTEXT.md` via ticket 20.

**A scope input received from the user, dated 2026-09-24**: plugin plumbing is in scope for the v1.0
product. 13 recorded it without acquiring product scope, and the only consequence it took was
restoring the declaration validator as a port pointer. This ticket is where it actually bears, and
`SALVAGE.md`'s first prohibition is the test it must pass: a seam whose caller does not ship
alongside it is not a seam yet.

## Note after ticket 21

One requirement, not a decision made on this ticket's behalf. The sketch is a governed file inside
11's perimeter, so it carries a **declaration paragraph**: the text between its H1 and its first H2
says what the sketch owns, and names the file that owns what it does not. `just owns` generates the
ownership index by reading exactly that paragraph, and `.githooks/pre-commit` refuses a commit
touching a governed file that lacks one.

There is no ownership table to add a row to — 21 refused it, on the grounds that a row would be a
second owner for a claim the file already makes about itself. Write the sentence here rather than
leaving ticket 20 to compose one; 20's rule is transcription, and a ticket whose answer lacks
finished text is a defect in its inputs.

A likely boundary to state, given this ticket's own contents: the sketch owns the **shape** the
rebuild starts from, and not what gets built next (no owner in the kit — that is the rebuild's), not
the terms (`CONTEXT.md`), and not what to port (`SALVAGE.md`).

## Answer

HITL session, 2026-09-24. Three rounds of grilling, ten decisions, every recommendation put to the
user and accepted as stated. Skills: `grilling`, `domain-modeling`. No new evidence gathered — 04 is
the measurement, 13 the binding inputs, 09/11/15/17/21 the fixed constraints.

The ticket was chartered to specify a document. It resolves by deciding the document is **not a
description of anything**, which is what dissolves its central tension and renames it.

### Two corrections to this ticket's own body, both from sources that postdate it

- **The day-one count is 8, not nine.** 11's late correction dropped `docs/agents/triage-labels.md`
  (setup is not run; its five role strings fold into `issue-tracker.md`), and 21 independently reads
  "today 8 of 12". Headroom is 4. The note above ("one of the nine") was written before that
  correction and is stale.
- **13's test-runner input and `SALVAGE.md`'s third prohibition do not conflict.** The sketch must
  credit Robolectric for the device-free suite, which is a causal claim about a structure — the
  regulated class. The prohibition's positive form permits it: *say what would fail if the structure
  were removed, or claim nothing.* Removing Robolectric fails 610 tests, so the claim is payable, and
  the file pays it in those words.

### The crux: constraints, not description

As chartered the sketch violated 11's entry rule outright. *No module type, no layer boundary, no
file layout, no count of anything* — and the three binding inputs 13 handed over are a module count,
a layer boundary and a build-tool choice. Three ways out were on the table: carve an exception, make
the file a dated record exempt under 19, or change what kind of claim it makes.

**It makes constraints.** A constraint says what must stay true and what it costs to change; it names
no structure, so there is no structural fact to go stale, and the code can *violate* it but never
*contradict* it. 11's ban is then satisfied by construction rather than excepted, which matters
because that ban is the generalisation of the defect that killed the old repo's `:core-api` claim —
three documents asserting a module type against an 8-line enum.

The dated-record option lost on one point and it is worth recording: an immutable ADR is honest on
day one and false by week two, and 19's answer to a false dated record is deletion, which would take
the deliberately-unbuilt list with it. That list is the half that must survive into week six.

**The check the ticket asked for falls out rather than being invented.** 11's backticked-path check
is the sketch's honesty rail: a constraint that smuggles in a structure has to name a path, and the
path must resolve. A document about code that does not exist yet therefore cannot name code that does
not exist yet, which is exactly the property the ticket was looking for.

### What it covers: five topics, not seven

Two of the seven candidates were misrouted and go back to owners that already exist. The
**module/plugin term collision** is `CONTEXT.md`'s — 13 routed it there and then also asked the
sketch to state it, which is one claim with two owners; the sketch simply uses the words correctly.
The **exported-schema rule** rides on ported code, which is 13's own bar for not writing a line at
all.

What remains: the seam, the test runner, the plugin-plumbing timing rule, the first shippable slice,
and what is deliberately not built.

**Relationship to the salvage ports: not contradict, with one exception that is the sketch's own.**
The file names none of the five ports. It states the single property they jointly require — the
engine is pure-Kotlin and device-free, which is what makes them portable at all — and that claim
belongs here. Enumerating `CompletionCascade`, the schedule engine, `core-audio` and
definitions-vs-occurrences would put five claims under two owners, the failure 13 avoided by handing
the architecture half here in the first place.

### How a constraints file holds absence

This was the decision's unpaid bill: an unbuilt list is a description of absence. It is paid by
writing each entry **with its price** — *X is not built; building it needs an ADR* — which is not a
fact the source asserts about itself but a statement of cost, violable and not contradictable like
every other line in the file.

It is also **consumable**: the ADR that authorises the thing deletes its line in the same commit.
That is 13's deletion-rides-on-the-consuming-commit attachment, the rule class with a clean
compliance record in the old repo's own evidence. It makes the unbuilt list **the second consumable
thing in the kit**, after `SALVAGE.md`'s keep half — two documents written to shrink, against a
corpus that last time only ever grew.

**Promotion to a non-goal follows 15 and nothing new is written.** The sketch holds every exclusion;
`GOALS.md` takes only the one a reader of the goals might plausibly have built, when it is actually
rejected. 15 had already settled that the kit writes exactly one non-goal (N1) and that the rest are
the rebuild's to seed; this ticket is where they enter, and they enter here rather than there.

### Lifecycle

**Overwritten in place; the ADR that changes a constraint lands in the same commit.** No changelog
(10 already ruled none exists on day one), no versioned copies (every copy but one is false), and the
history is `git log`, which 13 established is a real archive in a repo public from the first commit.

What re-opens a constraint is an ADR and nothing else. A constraint changed silently is the
`:core-api` defect wearing this file's name.

This lands the cleanest joint in the kit: 11's *a standing document that needs an ADR's conclusion
owns that claim itself* is exactly this pair. The ADR is the dated record of why the shape changed
and dies a leaf; `ARCHITECTURE.md` carries the live constraint. Neither cites the other, so 19's
direction rule holds with no exception.

### Who writes it, and the rule not written

**An agent drafts it; the human's account of it is 17's merge gate; no new rule is written.**

`GOALS.md` and `PROCEDURE.md` are human-only, in a commit touching nothing else, because they are the
human's own commitments — what I want, and what I have promised. This file is about the code, which
is the category the gate already exists for: *nothing merges until I have read its diff and can say
what it does without opening it again*, with the merge the act no agent may perform. A rule saying
"the human writes the architecture" would be a second mechanism for a thing the gate catches, and
09's comprehension criterion refuses it.

Recorded as a refusal rather than an omission, because the ticket asked the question and the answer
is that the mechanism already exists.

### The mandate, and what makes it fire

The cause this ticket answers is *the architecture was never sketched at the start*. A mandate with
nothing to fire on is how that happens: 03 found that rules written from principle broke, the fastest
in 15 minutes 33 seconds, while rules attached to an artifact the commit must touch anyway held
perfectly.

So the kit ships the file with its three known constraints filled and two sections marked
**`**Unwritten.**`**, and `.githooks/pre-commit` **refuses a commit that adds the first `.kt` file
while either section is still unwritten.** It fires once in the repo's life, reads the staged copy so
that writing the sections and adding the code in one commit is allowed, and checks **presence, never
quality** — ADR 0070's *text is not checkable* still binds; grading the prose is the gate's job.

The marker is visible rather than an HTML comment. G2 makes this repo readable by strangers, and a
document that hides its own incompleteness from a reader while a hook knows about it is a small
instance of the defect this map exists to explain. It is also 17's habit: label the parts that rest
on nothing instead of smoothing them over.

`.kt` and not `.kts` is deliberate. A Gradle skeleton is where the seam gets expressed, and forcing
the two product decisions before the build files exist is earlier than the rule needs to bite.

### Name, location, cap

**`ARCHITECTURE.md`, at the repo root, with no line cap**, and **"sketch" is retired as the kit's
word.** It named a drawing — a description — and the whole of this ticket is the finding that the
file is not one. The map's own standing preference is that terminology is challenged before it is
adopted; this is the same move that rejected "A/B testing" in 12. `ARCHITECTURE.md` is the name a
stranger guesses, which is G2's concern; `SHAPE.md` matches 21's phrasing and has to be explained.

Root, because every other governed prose file is there and all three locations are inside 11's
perimeter, so it is not a budget question.

No cap, for 11's own stated reason: per-document ceilings exist only for the always-loaded set, and
11 declined on principle to invent one after 07 showed the usual number to be unmeasured folklore. 13
inherited 60 anyway and landed at 62, which is what inventing one costs. **The counter is recorded
rather than hidden**: the unbuilt list is the part that could grow, and it is the one part of the
file with a deletion rule already attached.

### The declaration paragraph, and one weak point

21 requires the text between H1 and the first H2 to say what the file owns and name the owners of
what it does not; `just owns` generates the index from exactly that text and `pre-commit` refuses a
governed file without it. Written here rather than left to 20, whose rule is transcription.

**The weak point, flagged rather than smoothed:** *"Exactly one pure-Kotlin module holds the engine"*
is the closest line in the file to the structural fact 11 bans. What makes it a constraint is the
price in the following sentence and the declaration paragraph's framing, not the sentence itself. The
alternative considered and declined was *"Adding a module of any kind needs an ADR"* — purely a
price, naming no shape, at the cost of no longer saying what the shape is. The shape is worth saying.

### The file, confirmed verbatim

40 lines.

```markdown
# Architecture

What must stay true of this repository's shape, and what it costs to change each one. It does not
own what gets built next, the terms (`CONTEXT.md`), or what to port from the first Loop repo
(`SALVAGE.md`).

Nothing here describes the code. Every line is a constraint, which the code can violate but cannot
contradict. Changing one takes an ADR, written in the commit that makes the change.

## The seam

Exactly one pure-Kotlin module holds the engine; everything Android sits on the other side of it.
The compiler enforces the direction, and that is the whole of what the seam buys. A second engine
module needs an ADR.

The first Loop repo had eight build units. One was 363 lines, a third of it constants and a
duration formatter; another was 501 lines with no tests, existing only to make a header visible
across a boundary the split had just created. Evidence: `.scratch/post-mortem/`.

## Device-free tests

The suite runs on the JVM, with Robolectric for the Android side, from the first test.

That, and not the seam above, is what buys a device-free suite: 610 of the first repo's 945 tests
lived in its Android modules and needed no device. Remove Robolectric and those 610 fail; remove
the seam and none do.

## Plugin plumbing

Built when the first plugin that uses it ships in the same release, and not before. Building it
earlier needs an ADR naming that plugin. `SALVAGE.md`'s first prohibition is why.

## The first shippable slice

**Unwritten.** The smallest thing that can be in a user's hands, and what is deliberately left out
of it. Due before the first line of Kotlin.

## Not built

**Unwritten.** One line each: what is not built, and that building it needs an ADR. The ADR that
authorises one of these deletes its line in the same commit. An entry graduates to a non-goal in
`GOALS.md` only when a reader of the goals might plausibly have built it.
```

### The hook, confirmed verbatim

Joins the identity guard, 17's two caps, 11's two checks and 16's four classes in
`.githooks/pre-commit`.

```sh
# ---- The architecture file is written before the code (ticket 18) --------
# Fires once in this repo's life: on the commit that adds the first Kotlin
# source file. Reads the staged copy, so writing the sections and adding the
# code in one commit is allowed. Checks presence, never quality.

if git diff --cached --name-only --diff-filter=A | grep -qE '\.kt$'; then
    if git show ":ARCHITECTURE.md" 2>/dev/null | grep -q '^\*\*Unwritten\.\*\*'; then
        printf '\n  Blocked: ARCHITECTURE.md has an unwritten section\n\n'
        git show ":ARCHITECTURE.md" | grep -n '^## ' | sed 's/^/    /'
        cat <<MSG

  Name the first shippable slice and what is deliberately not built, then
  commit the code. The first Loop repo was never sketched at the start: two
  of its four pillars were never built, and by day six nobody could say what
  was under the hood.

MSG
        exit 1
    fi
fi
```

It reports zero on the tree as it stands, which is 16's install condition, trivially: there are no
Kotlin files in this repo.

### Both tests, applied to this ticket's own mechanisms

| Mechanism | Comprehension | Latency (what it rides on) |
|---|---|---|
| `ARCHITECTURE.md` as constraints | Passes: one artifact, and it is what the old repo's absence cost eight days | — (it is a document, not a rule) |
| Constraints, never description | Passes by subtraction: removes a class of claim, and needs no exception to 11 | 11's path check, already installed |
| Unbuilt entries priced at one ADR | Passes: no new artifact; a line that deletes itself | the commit that writes the authorising ADR |
| Unwritten-section gate | Passes: adds nothing to read; speaks once, at the only moment it matters | `pre-commit`, on the commit adding the first `.kt` |
| Overwrite + same-commit ADR | Passes: no changelog, no versions, no second copy | the ADR, which must be written anyway |
| Agent drafts, human reads | Passes: writes no rule at all | 17's merge gate, already in force |

### Two refusals, recorded so they are not read as omissions

- **`PROCEDURE.md` gains nothing**, and it is at **59 lines against a hard 60** after ticket 10. The
  last line was declined, not overlooked: that file holds what the human has committed to, and this
  constraint binds agents and code.
- **`CLAUDE.md` gains nothing.** Agents are what add `.kt` files, but the hook announces itself in
  full at the one moment it matters, and `just owns` surfaces this file from its declaration
  paragraph. A line there would be a second owner for a mechanism that already speaks — 09's
  criterion, applied against the always-loaded file's own budget.

### One instance for the null-artifact fog patch, in the justifying direction

If the rebuild's considered answer to **Not built** is *nothing is deliberately unbuilt*, it must
still write something, because `**Unwritten.**` is refused by the hook — so it writes "Nothing."
That is 19's test firing again: *a null record is owed where a rule demands an act and the considered
answer is "none".* A seventh worked instance. It changes nothing about the patch's status, which
stays fog by the human's decision rather than by fogginess.

### Consequences for other tickets

- **20 writes three things verbatim**: `ARCHITECTURE.md` at the root, the `pre-commit` block above,
  and — unchanged from 13's routing — the module/plugin disambiguation in `CONTEXT.md`, which this
  ticket declined to duplicate. It also stops using "sketch": the kit's word is `ARCHITECTURE.md`.
  **20 is unblocked by this resolution**; every ticket it waits on is now resolved.
- **11 is confirmed and given a name.** Exactly one governed file, inside the day-one eight, now
  called `ARCHITECTURE.md`. The count and headroom are unchanged at 8 and 4. This ticket did not
  decide against the cap.
- **13 keeps all three architecture conclusions here and none in `SALVAGE.md`.** Its five port
  pointers are untouched and unenumerated here, so no claim has two owners.
- **15 gains a supplier, not an edit.** `GOALS.md` still ships with exactly one non-goal; the
  rebuild's exclusions live in `ARCHITECTURE.md` and are promoted one at a time under 15's existing
  entry rule.
- **19 is unaffected and load-bearing.** The lifecycle depends on the ADR practice existing: an ADR
  is the only thing that re-opens a constraint. Direction holds — the ADR cites `GOALS.md` and paths,
  and `ARCHITECTURE.md` does not cite the ADR.
- **21 is satisfied.** The declaration paragraph is written above rather than left to 20, and the
  file needs no ownership table row because there is no table.
- **17 is unaffected**, and its 59th line stays its last.
