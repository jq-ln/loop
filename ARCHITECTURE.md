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

**Unwritten.** The smallest thing that can be in a user's hands, and what is deliberately left out
of it. Due before the first line of Kotlin.

## Not built

**Unwritten.** One line each: what is not built, and that building it needs an ADR. The ADR that
authorises one of these deletes its line in the same commit. An entry graduates to a non-goal in
`GOALS.md` only when a reader of the goals might plausibly have built it.
