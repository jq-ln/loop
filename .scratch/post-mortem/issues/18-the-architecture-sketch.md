# The architecture sketch the rebuild must produce on day one

Type: grilling
Status: open
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
