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
