# Criteria

This file outranks every other document in this repo. Where another document conflicts with it,
this one wins. It does not own definitions (`CONTEXT.md`), what gets built next, or how the work
is done — those have their own owners.

Only the repository's owner edits this file, and only in a commit that touches nothing else.

## Criteria

**C1 — Loop is an app I use every day.**
Rules out anything I would have to be talked into using, and any decision that makes the app worse
to live with in exchange for something else.

**C2 — My work here is legible to people who might hire me or build with me.**
Rules out a private repository, a history I cannot explain, and a cleanup deferred to the end.

**When they collide**: C1 wins wherever publication would change what the app is. C2 wins on how
the repository is kept.

## Exclusions

An exclusion is written when something is actually rejected, and only when someone reading the
criteria above might plausibly have built it. A decision that contradicts an exclusion is rejected
unless the same commit deletes the exclusion.

**E1 — Shipping through any particular store or channel.**
C2 is about the work being legible, not about it being distributed. No decision here may assume a
channel.

## Citing a criterion

Every ADR names the criterion it serves and what that criterion ruled out. An ADR that can name
neither is rejected. If a decision is right and no criterion covers it, that is a fact about this
file — bring it here.

Criterion ids are never reused. Wording may be sharpened at any time; identity changes only by
deletion, and the commit that deletes a criterion lists every ADR citing it and states whether each
citation survives.
