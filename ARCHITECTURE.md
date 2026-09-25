# Architecture

What must stay true of this repository's shape, and what it costs to change each one. It does not
own what gets built next, the terms (`CONTEXT.md`), or what to port from the first Loop repo
(`SALVAGE.md`).

Nothing here describes the code. Every line is a constraint, which the code can violate but cannot
contradict. Changing one takes an ADR, written in the commit that makes the change.

## The seam

Exactly one pure-Kotlin module holds the engine; everything Android sits on the other side of it.
The compiler enforces the direction, and that is the whole of what the seam buys. A second engine
module needs an ADR.

The first Loop repo had eight build units. One was 363 lines, a third of it constants and a
duration formatter; another was 501 lines with no tests, existing only to make a header visible
across a boundary the split had just created. Evidence: `.scratch/post-mortem/`.

## Device-free tests

The suite runs on the JVM, with Robolectric for the Android side, from the first test.

That, and not the seam above, is what buys a device-free suite: 610 of the first repo's 945 tests
lived in its Android modules and needed no device. Remove Robolectric and those 610 fail; remove
the seam and none do.

## Plugin plumbing

Built when the first plugin that uses it ships in the same release, and not before. Building it
earlier needs an ADR naming that plugin. `SALVAGE.md`'s first prohibition is why.

## The first shippable slice

The smallest thing that can be in a user's hands, and what is deliberately left out of it. What each
part does is `PRODUCT.md`'s; this section says which parts exist.

**Work, Today, metrics, and principles as the only thing work can cite.** The destinations are Today,
Goals and Metrics. In it:

- Definitions and runs, routines with ordered steps, the schedule engine and the completion cascade.
- Today with every row it holds, `Offered` and its search field included, and the whole gesture
  vocabulary on it, snooze and defer included.
- A time of day as a notification, the silent opt-out, and the permission ask. A run snoozed to a
  part of the day notifies there.
- Metrics, fed by questions and by direct entry, each viewed as its line chart.
- Principles, as the only thing a definition can cite, so the first commitment requires creating
  one. Goals holds principles and nothing else, and a principle's detail lists what cites it.
- Revisions, with a principle's wording as their only subject and no Revise to make them in: a
  rename writes one.
- Notes, the day's included. Until Revise exists, the day's note is where *the measurement was not
  possible* is written down.

There is no onboarding. The first capture is the first act.

**In a user's hands** means a local build on the author's phone, run beside the first Loop until it
holds a week of real routines, then a hard stop. No channel is assumed.

**The second slice** is the *Not built* line that evidence names: a day's note naming an absence and
confirmed against the run log, or a falsifier `PRODUCT.md` pre-registers firing. Not a date and not a
feature count. Two tests the slice cannot run in the app are run by hand in the session that reads
the device's data: whether the uncited work in `Offered` grows for two weeks without a pause, and
what share of newly scheduled definitions carry a time of day.

**What the port changes.** `SALVAGE.md` says to read the ported engine before changing it. The slice
changes it in the places below, and each change is an ADR in the commit that makes it:

- The definition/occurrence split ports with `task` and `occurrence` renamed to definition and run,
  in schema and prose alike.
- The run's own note moves into the one kind of note, if it moves rather than being added beside it.
- The definition repository ports without its delete. A definition is abandoned, never deleted.
- The schedule engine ports without `AFTER_ROUTINE`. Its job is a prerequisite's, not a schedule's.
- Check-in questions port without their staged commit. Every answer writes as it is entered.
- Notifications port without the schedule's `remind` flag, since a time of day is the request, and
  with `USE_EXACT_ALARM` chosen over `SCHEDULE_EXACT_ALARM`, so no one is sent into system settings.

Two further changes need no ADR: `SCALE_1_5` is not ported, since nothing was ever recorded on it,
and snooze offers parts of the day to runs with no time of day, which the first Loop could not snooze
at all.

## Not built

One line each: what is not built, and that building it needs an ADR. The ADR that authorises one of
these deletes its line in the same commit, and lists whatever of that thing it still leaves unbuilt.
An entry graduates to a non-goal in `GOALS.md` only when a reader of the goals might plausibly have
built it. Refusals are not absences, and live in `PRODUCT.md`.

- Goals: satisfaction, targets and verdicts, and bringing in a breakdown made outside the app.
- Prerequisites, together with the long-blocked flag, which is the only thing that reports them.
- Revise, and every flag it raises.
- Revisions of anything but a principle's wording.
- A language model inside the app.
- A widget.
- Marking a run done from the notification.
- Any chart but one line per metric; a yes-or-no strip is the first to reconsider.
- A timer.
- A cadence on a step that repeats monthly.
- Gestures on any surface but Today.
- A destination for the backlog, which is the remedy if `Offered` fails.
- The ear trainer.
