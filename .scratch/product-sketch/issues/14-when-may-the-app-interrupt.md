# When is the app allowed to interrupt?

Type: grilling
Status: resolved

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

## Re-derived from source, 2026-09-25

Per the map's standing practice. The counts hold; **the headline reading does not**, and the
correction is this map's third data shape in its purest form — *a count of an act taken, read as
evidence about the act, without checking the act was offered.*

1. **`remind` is `0` on all 16 schedules. It was offered on one of them.** The toggle is drawn only
   when the schedule has a `time_of_day` **and** its mode is not `AFTER_ROUTINE`
   (`app/src/main/java/dev/<user>/loop/ui/design/RoutineDetailScreen.kt`, with the reason in a
   comment: *"A reminder needs a moment to remind at"*). Exactly **one of the 16 has a time of day**.
   So fifteen of the sixteen never displayed the switch, and the ticket's *"had reminders available,
   per schedule, and declined them every time"* is **n = 1, not n = 16**. The controlled experiment
   this ticket claimed to have does not exist.

2. **What was declined fifteen times is the prerequisite, not the reminder.** The time field is
   offered in every mode but `AFTER_ROUTINE`, and **none** of the 16 is that mode. The author was
   asked "at what time?" on all sixteen and answered once. That is still evidence, and it is a
   *different* claim: the work is not time-anchored, so there is mostly nothing to interrupt **at**.

3. **It is not a dead field.** Exact alarm re-armed after each firing and on boot, its own
   notification channel, the `POST_NOTIFICATIONS` request inline on the switch, an explicit
   `USE_EXACT_ALARM` chosen over `SCHEDULE_EXACT_ALARM` to avoid a system-settings trip, a
   `docs/PERMISSIONS.md` row, a repository, a DAO query and two test files. The capability was built
   through, which is what makes the single decline worth anything at all.

4. **Not a window the feature did not exist in** — the fourth shape, checked and cleared. Reminders
   landed 2026-09-16 19:25; the baseline runs 09-15 to 09-24. It existed for eight of the ten days
   and for all but the first day's authoring.

5. **"The single timed definition" names two different fields, and the ticket picked the wrong
   one.** `schedule.time_of_day` is non-null on exactly one row — `Take pills`, 720 minutes, 12:00
   local. `task.timed` is `1` on exactly one row too, and it is **`Leg stretches`**, a step timer.
   Two ones, two fields, two rows, and they are not the same row.

6. **The n = 1 case has a perfect record without a reminder.** Once its schedule settled, `Take
   pills` is `DONE` on 09-18, 19, 20, 21, 22 and 23 — six for six, `PENDING` on the pull day, the
   two rows before that both machine skips. A 12:00 reminder *"unless it is already done"* would
   have fired on **three** of those six days (done 16:52, 13:22, 12:07 local) and stayed silent on
   the other three (11:13, 11:37, 10:03). The sharpest case for a notification is also a case that
   did not need one — but the three firings are real, and two of them are late enough that the
   reminder would have been the reason it happened before the day ended.

## Answer

**The app notifies, and it ships in the first slice.** The charting hypothesis was *no*, and it does
not merely lose — **the evidence it rested on never existed.** A time of day *is* a request for a
notification, there is no second switch, and the whole decision is one sentence in `PRODUCT.md` with
a boundary beside it.

### The hypothesis died of its own third shape, twice over

The ticket claimed a controlled experiment: `remind` is `0` on all 16 schedules, so the author
declined reminders sixteen times. **It is not `0` because they were declined. It is `0` because it
was never offered.**

- The switch is drawn only for a schedule that **already has a time of day** and is not
  `AFTER_ROUTINE`. Exactly **one of 16** has a time of day, so fifteen never displayed it. That is
  n = 1, not n = 16 — the map's third shape, *a count of an act taken read as evidence about the
  act, without checking the act was offered*.
- The correction was still wrong. The app requests `POST_NOTIFICATIONS` in exactly **two** places:
  the remind switch itself, and starting a countdown. `occurrence_timing` holds **zero rows**, so
  the second was never reached either, and **the app almost certainly never once asked for
  notification permission** in ten days of daily use. A reminder that could not be delivered is not
  a reminder declined. **n = 0.**
- The path to one reminder was **five steps**: set a time, find a switch below the schedule editor,
  flip it, grant a permission, wait a day. The author took step one, once — and then stopped setting
  times, because a time bought nothing. *The 1-of-16 is the consequence of the defect, not evidence
  about the feature.*

The limit of this: the database cannot record OS permission state. What is proven is that both
in-app request paths were unreached, not that the grant never happened by some other route.

**A sixth stale-survey shape, and it is a refinement of the third rather than a new one: checking
that the act was offered is recursive.** The first pass here checked the offer and moved 16 to 1;
only checking the *offer's own entrance* moved 1 to 0. The tell is that the feature is fully built —
exact alarm re-armed on boot, its own channel, a repository, a DAO query, two test files, a
`docs/PERMISSIONS.md` row — because a capability nobody reached looks exactly like a capability
nobody wanted, and the more finished it is the more convincing the zero.

### What was decided

1. **The unit of the question is unsolicited origination.** Noise *inside* an act the user started
   is not an interruption — the countdown bell is the end of a thing that was asked for. In-app
   flags are already settled by 05.
2. **A time of day is a notification at it. The two switches collapse.** There is no `remind` flag;
   setting a time is how a notification is asked for, with a per-definition **silent** opt-out for
   the rare thing that wants a time and no sound. The archive's separate flag was a second door in
   front of a feature whose entire failure was being behind a door — and its migration test asserted
   the default in so many words: *"nothing starts notifying on its own."*
3. **No time means due *that day*, and nothing fires.** True for the fifteen definitions that never
   wanted one, and it is what the archive already said: *"an untimed one is due that day, and the
   day break is not a deadline anybody set."*
4. **The permission is asked the first time a time of day is set** — not at setup, not at first
   firing. 13 settled that day one is zero principles with everything unassigned, so a setup-time ask
   requests a capability with nothing to use it on; and an ask at firing time arrives when the phone
   is not in hand. Under 2 there is exactly one moment to attach it to, and it is the moment the
   intention is expressed.
5. **The app notifies about a moment you chose, and never about a judgement it formed.** This is the
   boundary, and it goes in `PRODUCT.md` beside the notification. A run at 12:00 is the user's
   moment. `stalled`, `dormant` and `unserved` are the app's opinions and wait in `Revise` until
   someone goes there. **This is what keeps 05 intact**: its refusal of a reflection cadence is not
   an exception to this decision, it is the same rule applied to the other side of the line.
6. **It fires once per run, is silent if the run is already done, clears when the run closes, and
   never repeats.** A notification that keeps asking has become the app's judgement that you should
   have done it, which rule 5 refuses. 01 already makes an untouched day a recorded skip and 06
   already makes a miss a line on Today; it does not also need to be a live demand.
7. **The notification opens the item and carries no acts.** 07's rule is one meaning per gesture
   everywhere — absent on a surface is allowed, *different* is not — and a notification is a fourth
   surface to keep in sync. **This amends 07**, which enumerated surfaces before one existed: the
   amendment is that a surface may carry *no* acts at all. **Done-from-the-shade is the first
   unbuilt line** this decision expects to spend.
8. **Today's order is untouched.** 06 settled that the order is the structure's and there is no
   score; a 12:00 notification does not make time the list's order. A thing with a time sits where
   its structure puts it.
9. **A badge is refused by rule 5** — a standing count of what is outstanding is the app's judgement,
   permanently displayed. **A widget is not refused, merely not built**: it is display, not demand.
   Both are lines in *what is not built*.

### What a time of day is now worth

Dropping the field was the tempting consequence of a refusal and would have been the expensive
mistake. It has **four** consumers, and only one of them was the reminder:

- the **notification's moment** (this ticket);
- the **wall-clock anchor of the recurrence**, which is what carries a series across a DST
  transition, in the ported schedule engine;
- the **gate on sub-day snooze** — the archive offers hour-sized presets only where
  `timeOfDay != null`, because *"pushing it an hour would change nothing visible"* otherwise. This is
  the mechanism behind 07's finding that snooze was unofferable on 34 of 64 root runs, and it means
  **01's `snooze`, "moves a run inside its day", has nothing to move against unless something carries
  a time**;
- the **line on the row**.

So the collapse in 2 does not merely keep the field, it repairs `snooze`: under the archive's shape a
time was worth having only if you also found the switch, and under this one a time is worth having on
its own.

### Adopted provisionally, with the test named

The evidence base is **zero** — nobody has ever experienced a Loop notification, the author included
— so this is adopted on 06's terms rather than asserted.

- **The test**: the share of newly scheduled definitions that carry a time of day. That is the exact
  behaviour that produced the 1-of-16, so it is the one that would be recognised if it recurred —
  this time *after* notifications demonstrably work.
- **The hard stop**: Loop's notifications turned off at the OS level, or the silent opt-out taken
  systematically rather than occasionally.
- **The remedy**: the notification is cut and *what is not built* gains the line this ticket would
  otherwise have written. The field survives the cut, on the strength of its other three consumers.
- *Not* the test: "a notification is never acted on". `Take pills` was six for six **without** one,
  so done-anyway is the normal case and proves nothing either way.

### What this spends

- **09** gains: notifications in the first slice — the field, the firing, the permission ask; and
  three lines for *what is not built* — **done-from-the-shade**, **a widget**, **a badge** (the last
  refused by rule 5 rather than deferred).
- **12** gains the **`timed` disambiguation**. The archive uses the word for *has a time of day* and
  for *has a stopwatch*, live, in the same package. Under 2 the first is not a property at all, so
  the word is left to the stopwatch or retired from both — settled before any Kotlin is written.
- **One ADR owed at port time**, not now, matching how 01 and 05 handled theirs: the archive chose
  `USE_EXACT_ALARM` over `SCHEDULE_EXACT_ALARM` to avoid sending the user into system settings, and
  that trade-off is what a future reader would otherwise wonder about. The decision *that the app
  notifies* needs no ADR — `PRODUCT.md` states it outright.
- **Amends this ticket's own re-derivation**: correction 1 stops at n = 1 and is superseded by n = 0
  above.
- **Amends 07** as in 7. **Leaves 05 and 06 intact**, by rules 5 and 8 respectively.
