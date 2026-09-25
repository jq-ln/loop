# When is the app allowed to interrupt?

Type: grilling
Status: open

## Question

Graduated from the map's fog by [Today: what is on it, and how is it ordered?](06-today.md), which
was the answer it was waiting on. Today is now settled, so what the app would interrupt you *about*
is known, and the question is whether it ever does.

The charting hypothesis is **no**, and it is a stronger hypothesis than it looks, because the
evidence is an unused affordance rather than an absent one.

- **The first repo built it and never once turned it on.** Every schedule carries a `remind` flag and
  it is `0` on **all 16** in the preserved database, across ten days of daily use by the author. That
  is the map's third failure shape in its mildest form — a field that was built, is written, and has
  no consumer the user ever asked for — and it is the closest thing to a controlled experiment this
  map has: the author had reminders available, per schedule, and declined them every time.
- **G1 cuts both ways and must be argued, not assumed.** *An app I use every day* is the goal, and a
  notification is the standard instrument for making that true. But it is also the instrument most
  likely to make an app *worse to live with*, which the same goal rules out — and an app whose daily
  path already works with no network has no reason to reach for the phone's attention machinery
  first.
- **Reflection has already declined one.** [Does Reflect survive its own test?](05-does-reflect-survive.md)
  made reflection **signal-driven with a manual entrance and refused a cadence**, reasoning that a
  weekly prompt firing regardless records failures that were travel. That is a worked case of the app
  choosing *not* to interrupt on a schedule, and whatever this ticket decides should be consistent
  with it rather than an exception to it.
- **The run side is the harder half.** A schedule that fires whether or not the last run was done
  already records the skip, so a reminder buys nothing the record does not already have. The case
  for one is `Take pills` at 12:00 — the single timed definition in the entire database — where the
  cost of being late is real and outside the app. Whether *one* genuinely time-critical definition
  earns a notification mechanism is the sharpest form of this question.
- **If the answer is no, it is a line in *what is not built* and it must say what would buy it back.**
  A refusal with no falsifier is a preference; the map's standing practice is to name the evidence
  that would reverse it.
