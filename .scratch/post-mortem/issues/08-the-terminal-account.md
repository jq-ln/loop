# Why it became unsalvageable

Type: grilling
Status: resolved
Blocked by: 01, 02, 03, 04, 05, 06, 07

## Question

HITL. The research has reported; the artifacts have said what they can. This ticket asks for the
one thing they cannot hold.

**First, terminal**: what specifically made it unsalvageable? There are 43,488 lines of largely
working Kotlin and an app still wanted. Killing the repo rather than pruning it was a judgement no
artifact records the reason for. A concise chronology is welcome where it serves the answer.

**Then, counterfactual**: put each research finding to the user and ask whether knowing it on day
one would have changed anything. Findings that change nothing do not become kit contents, however
true they are — this is the filter that keeps the kit small.

Do not answer either half on the user's behalf. The gap between what the evidence shows and what
the experience was is the most valuable output of this map; an agent that narrates both sides has
destroyed it.

## Answer

HITL session, 2026-09-22. Both halves answered by the user; the agent supplied evidence only. One
archive lookup ran during the session to ground two claims no research ticket covered (the personal
-information scrub, and whether the F-Droid → plugin chain is recorded); its citations are quoted
inline below.

### Terminal: what made it unsalvageable

**Unwieldiness first, then two blows.**

Days 1–5 produced an app that felt good from the user's side on a foundation its author could no
longer account for. The architecture was never sketched at the start — two of the four pillars were
never built — the pace quickened as the project went, oversight of code and test quality was thin,
and not enough of the code was actually being read. The sentence that carries this ticket is *"I no
longer knew what was happening under the hood."* Ticket 04 caught it in the act: the four pillars
are an 8-line enum in `AppMenuSheet.kt:153` driving a menu sheet, three documents assert a
`:core-api` type, and the user did not know this until the inventory ran. The documents were not
merely long; they were **wrong**, and nothing short of that inventory would have revealed it.

**The process explosion was triage, not a second disease.** This reverses ticket 05's causal
reading while leaving its numbers untouched. The user adopted `mattpocock-skills` *because* the repo
had already become unwieldy — "standing in the house of a hoarder trying to figure out how to
organize and clean up." It was also not avoidance of cutting: plugins were recognised as scope creep
and cut (Dual N-Back extracted at `e46fb47`, the ear trainer out, ADR 0059 "core ships no plugins"),
with remaining plugin work put at the very last priority; only the wire work continued, and the user
judges that possibly misguided. The failure mode is **too late**, not **wrong triage** and not
**triage was avoidance**. Process was necessary — finishing the core app first would have added to
the pile.

**Killing blow, first half: the scrub.** Making the repo public required removing personal
information, and the operation was discouraging, embarrassing and messy; the GitHub support ticket
"felt ridiculous". The archive shows why it was so expensive. The personal email was on the author
*and* committer line of the first commit `d1c31a8` (2026-09-14) and all 190 after it — day one — and
was first noticed on day six, in #19, whose opening line is *"The repo is going to be published"* and
which flags it as *"the only item on this list with a deadline."* No rule about what may not enter
the repo existed until day seven (`8f9c069`, ADR 0070), which concedes its own retrospection: *"Every
instance above arrived from a commit about something else"* and *"Editing removes nothing."* The fix
had to be structural — ADR 0067's one-time history rewrite, 195 SHAs, ear-trainer blame destroyed,
justified as *"Making this repository public turned the asset into the liability."*

**And the repo was never made public.** #37 and #50 were both still open at harvest; #50 holds the
flip as *"the owner's gesture, not an agent's"*, last touched four hours before the remote was
destroyed. The full cost of publication was paid and none of the benefit collected. The GitHub
support ticket was marked *"Optional… belt-and-braces against a miss, not a dependency"* and there is
no record it was ever filed.

**Killing blow, second half: F-Droid recognised as arbitrary.** By day 7 the user saw that F-Droid
had been chosen in the dash to ship, did not suit the actual goal, and had already propagated into
the architecture — the plugin model had drifted to separate apps, which was *expressly not* what was
wanted. Reversing it meant reworking work that had only just been done. The archive confirms the
chain and shows every link phrased as forced: F-Droid → ADR 0025 (no `INTERNET`, FOSS-only) → ADR
0053 (*"it is why ADR 0052 is the only available shape"*) → ADR 0052 (*"This follows from ADR 0053
rather than from preference"*). F-Droid itself entered as a flat declaration in the initial commit —
`CLAUDE.md` line 3, *"Single user, offline, F-Droid distribution"* — never argued, never weighed
against an alternative; ADR 0025 is retrospective and gives consequences, not a justification.

**The structural cause: there was no goals document, and no owner for one.** No goals, vision or
principles file exists anywhere in `../old_loop`. `CONTEXT.md` is a glossary by declaration,
`ROADMAP.md` says *"Deliberately not built."* The `CLAUDE.md` ownership table assigns an owner to
every kind of claim in the project and has **no row for the project's goals**. The only goal-shaped
sentence in the repo is #64's destination line — *"Loop is finished, and submitted to F-Droid"* —
which states the means as the end. F-Droid could not be recognised as arbitrary because there was
nothing to check it against. All three candidate defects were accepted: made too early, nothing to
check it against, and nothing forced a re-check when it propagated four ADRs deep.

### Decisions taken in this session

1. **The kit's first file states the project's goals**, and it outranks the ownership table. The old
   table's only structural omission is the thing that killed the project. → ticket 15.
2. **Every ADR cites the goal it serves; an ADR that cannot is rejected.** Chosen over a heavier
   "structural decisions need a re-read" ceremony and over relying on the goals file being short
   enough to re-read, on ticket 03's evidence: rules riding on an artifact the work must touch
   anyway held perfectly, rules standing over the work broke in minutes. → ticket 15.
3. **This repo is public from the first commit.** Not because publication is assumed, but because it
   is a stated goal in its own right: the user needs their work public to get a foothold in the
   community and the industry. This is the goal F-Droid was a bad proxy for, and the two questions
   turn out to be one. Publication is therefore *in* scope and **Publish this repo once the
   namespace frees** stays live.
4. **The entry rule is mechanical from commit zero.** (3) requires it: public from the first commit
   means there is never a scrub available, and the history rewrite is a one-time instrument that
   would already be spent. Seeded from the old repo's actual instances rather than from imagination
   — identity on the commit object (a `git config` that must be right *before* commit one), absolute
   paths containing a username, device and owner details, tool output. ADR 0070's concession stands:
   *"Text is not checkable"*, so the mechanical list is structural checks only. → ticket 16, which
   blocks publication.
5. **The kit has a human-facing half.** A procedure document for the human — reading the code, pace,
   oversight of code and test quality — is as important as the procedures for agents. None of the
   seven findings covers this; all seven are about rules for agents. → ticket 17.
6. **An architecture sketch is a required day-one artifact of the rebuild**, mandated by the kit but
   not drawn by this map. Its content belongs to the rebuild; what it must cover belongs here. Kept
   separate from the procedure document, because one changes weekly and the other should not — the
   old `CLAUDE.md`'s 194 → 244 regrowth in 2h52m is what one file owning too many kinds of claim
   costs. → ticket 18.

### Counterfactual: which findings would have changed day one

All seven: **yes**. The filter removed nothing, which is itself a result — "would this have changed
something?" is too weak a test, since almost any true fact changes something. Forced to three, the
user's kit carries:

- **03, rule latency** — the test every kit rule must pass before it is written down.
- **16→05, count × reference density** — 106 files and 640 cross-references, one per 12.8 lines, with
  ADRs averaging 23 lines. The corpus was not too long, it was too interconnected. Partly contradicts
  what ticket 11 was chartered to enforce.
- **13→02, self-observation** — 54% of the tracker existed only because the process could observe
  itself, with process share rising 30% → 81% while nothing was ever stale. A tracker in perfect
  health on a dying project.

The other four are archived and findable, and 12, 18 and 17 largely fall out of the three above.
**04 is a different kind of object**: not a constraint on the process but an inventory, and it enters
the kit as a binding input to the rebuild rather than as a rule. Noted for ticket 13.

Supplementary constraint from Q12: constraints on prose must be **tighter and mechanical where
possible** — input to ticket 11.
