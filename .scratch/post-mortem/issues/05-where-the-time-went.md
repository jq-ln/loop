# Where 242 commits of effort actually went

Type: research
Status: resolved

## Question

Partition the work in `../old_loop` by what it touched.

- Of 242 commits, how many touched app/test code, how many touched only process artifacts
  (`CLAUDE.md`, `docs/`, ADRs, `.github/`, tracker docs), and how many touched both?
- Same split by lines changed, and by commit over time. Is there a crossover point where process
  work overtakes product work?
- Cadence: commits per day across the eight days, and the shape of the last two days versus the
  first two.
- 43,488 lines of Kotlin in eight days by one person with agents. Break that down — generated
  boilerplate, tests, real logic, UI — enough to judge whether the *scope* was the anomaly.

This ticket exists to make a specific competing hypothesis testable: that the process machinery was
a symptom of holding too much surface in view, not the disease. Report what the numbers support,
including if they support the opposite.

## Answer

Full findings: [research\/05-where-the-time-went.md](../research/05-where-the-time-went.md)

The scope-as-cause hypothesis is **supported for days 1–5 and refuted for days 6–8**: Kotlin stopped growing (38,195 on day 4 → 43,488 on day 8, shrinking 577 on the last day) while process work tripled. Not a symptom — a second disease arriving after the first stopped. Day 8 alone is 76 commits (31% of the project), 46 touching no code, near-uniformly citation and contradiction repair. The mechanism the numbers point at is **count × reference density** (106 files, 640 cross-references, one per 12.8 lines), not length — ADRs average 23 lines. Real domain logic is only 6,470 net lines of 30,545 (tests 45.8%, UI 29.8%); the scope anomaly is breadth, not volume. 23% of all Kotlin written was later deleted, including a plugin subsystem built day 3 and removed day 7.
