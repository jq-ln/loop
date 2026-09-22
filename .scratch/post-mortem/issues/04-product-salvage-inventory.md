# Which architectural decisions the code honours, and which were aspirational

Type: research
Status: resolved

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

## Answer

Full findings: [research\/04-product-salvage-inventory.md](../research/04-product-salvage-inventory.md)

**DROP the four pillars**: `Pillar` is an 8-line enum in `AppMenuSheet.kt:153` driving a menu sheet, not a `:core-api` type; three documents assert otherwise. Six ADRs, zero leverage; keep only 0039's brake. **DROP the plugin seam**: ~2,670 production lines, 174 tests (18% of the suite), 22 ADRs, 863 lines of contract — and `e46fb47` says the wire was built after its last consumer was removed. The shipped host can discover zero plugins while the store copy sells the feature. **KEEP definitions-vs-occurrences** (the one claim the code honours completely) and port `CompletionCascade`, the RRULE schedule engine and `core-audio` — weeks to re-derive each. **KEEP the pure-JVM split as two modules, not eight**: the emulator-free suite was bought by Robolectric, not the split (zero androidTest sources, 610 of 945 tests in the Android modules). All 75 ADRs were created on days 7–8 from SPEC.md, so the ADR-in-same-commit rule never ran once.
