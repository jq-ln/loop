# Which architectural decisions the code honours, and which were aspirational

Type: research
Status: open

## Question

Inventory `../old_loop`'s 43,488 lines of Kotlin against the architecture `CLAUDE.md` claims for
it. For each claim: does the code actually honour it, and did it earn its keep?

- **The four pillars** (Plan, Do, Track, Reflect). Plan is declared in `:core-api` and nothing
  else. Did the pillar model do any real work, or did it mostly generate arguments — ADR 0039 and
  ADR 0040 exist to reject a fifth pillar twice.
- **The pure-JVM module split** (`:core-api`, `:core-routine`, `:core-track`, `:core-audio`,
  `:core-testing`). Enforced by the Gradle graph rather than convention. Did it deliver the
  emulator-free testability it promised? What is the actual test count and coverage per module?
- **"Core measures; plugins judge."** Find where the line was applied, and where it was argued
  about. Does any code violate it?
- **Plugins as separate apps discovered at runtime** (ADR 0052). How much machinery does this cost,
  how many plugins actually exist, and did the seam pay for itself?
- **Definitions vs occurrences** (`Task`/`Schedule` vs `Occurrence`).

For each: keep, keep-with-changes, or drop — with the reason. Note anything that would cost weeks
to re-derive from scratch.
