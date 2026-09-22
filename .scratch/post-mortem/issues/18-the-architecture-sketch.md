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
