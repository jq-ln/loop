# Where 242 commits of effort actually went

Type: research
Status: open

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
