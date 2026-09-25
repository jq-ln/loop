# Salvage

What the first Loop repo taught that nothing else here already carries. An entry earns a line only
if no ported code, no other document, and no mechanism holds the claim. The evidence for every entry
is in `.scratch/post-mortem/`, and the archive it was read from is local-only.

Adding an entry is the repository owner's. An agent deletes an entry in the commit that consumes it.

## Port these, and read them before changing them

The things that cost most of the first repo's eight days. Each carries its own reasoning beside it,
and its tests are the specification.

- **The definition/occurrence split.** Port first: every other engine rule is downstream. The
  non-obvious parts are that a finished run keeps the name it was done under while a waiting run's
  name follows a rename, that the references to definitions are deliberately not foreign keys, that
  a snooze stores where the run came from rather than where it went, and that a skip's reason is
  the app's bookkeeping, never the user's: five reasons written from seven call sites, and the
  user's own refusal is a separate status that carries no reason. The enum's header says four
  paths; the header is stale, not the enum.
- **The completion cascade.** A worklist run to a fixpoint, not a sequence of passes: completing one
  occurrence can close a subtree, satisfy shared work elsewhere by dedup key, and roll parents up,
  and each of those can re-trigger the others. The whole plan is computed before anything is
  written, which is what makes undo exact. Reversal is the harder direction and must reach only what
  this completion satisfied.
- **The schedule engine.** Recurrence expanded in floating local time with the zone bound only
  afterwards, which is the one detail that survives a 23- or 25-hour day. Month-end is why the
  dependency exists at all.
- **The audio core.** Pitch estimation, WAV and PCM, onset detection, a frame clock. No Android
  imports, verified against synthetic signals.
- **The declaration validator**, when the plugin plumbing is built: an untrusted declaration is
  validated with no I/O, so the whole judgement is unit-testable. It is the one part of the first
  repo's plugin seam that was built correctly.

## Carry this

- **Store facts; compute judgements on read.** Nothing derived is ever stored, so changing a formula
  re-grades the whole history instead of leaving today's verdict frozen into every past row. This is
  a storage rule, not a placement rule. Stated as placement it sounds like it is about boundaries,
  which is how a judgement came to sit inside the first repo's rules module unchallenged.
- **Live with it on a phone, and keep the loop that reports back.** Decisions the first repo could
  only reach by use — a 1-to-5 scale too coarse to say "a bit better than last time" — came from a
  real profile beside a test profile on one device, an in-app note appended to a file there, and a
  session that read those notes beside the occurrence log. Pull the database with its `-wal` and
  `-shm`; opening the copy with `sqlite3` checkpoints it and destroys the evidence.
- **A rough variant is usually too rough to judge.** The one time the first repo built variants side
  by side, a pass of device fixes came before the comparison meant anything, and the decision still
  was not made when that pass landed. Budget it, or the comparison measures prototype bugs.

## Do not carry these

Prohibitions, because nothing else here catches them.

- **A seam whose caller does not ship alongside it is not a seam yet.** The first repo's plugin wire
  had its last consumer deliberately removed from the build, and then ten more commits built the
  wire. At the end it was a tenth of the production code and near a fifth of the test suite,
  discovering nothing, while the store listing advertised the feature.
- **A new top-level concept must name a stage nothing else covers, and arrive with an engine** — two
  separately evidenced claims. The first repo's four-part taxonomy returned an eight-line menu enum
  for six consecutive placement decisions and a build-and-revert.
- **No document credits a structure for a property something else bought.** The first repo credited
  its module split with making the invariants testable without a device; the test runner bought
  that. Say what would fail if the structure were removed, or claim nothing.
