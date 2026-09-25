# Context

What a term means in this project. It does not own the goals (`GOALS.md`), the shape of the
repository (`ARCHITECTURE.md`), how agents work (`CLAUDE.md`), or what to port from the first Loop
repo (`SALVAGE.md`).

A term earns an entry when it is already in use and has been mistaken for something else. Where a
term is renamed, this file notes the former name, so an ADR written under the old word still reads.

## Terms

- **Abandoned** — the end state of anything that serves something: a goal, a principle, a
  definition. Dated, retractable, and never a delete: what sits beneath it survives and loses its
  citation. A metric serves nothing, so it is **archived** instead. The first Loop gave definitions
  an *archived* state it never used and a delete it did use, and the delete left a run pointing at
  a definition that no longer existed. Here a definition is abandoned, never archived and never
  deleted.
- **Anchor** — in the app, a snooze preset: a part of the day (*this morning*, *this afternoon*,
  *this evening*) that a run can be pushed to. Two things in the ported engine carry the same word
  and mean neither: the step edge's `cadence_anchor`, and the wall-clock anchor that holds a
  recurring schedule steady across a daylight-saving change.
- **Definition** and **run** — a definition is what could be done; a run is one materialized
  instance of it at a time. Nothing else is a kind of work. The first Loop's schema called them
  *task* and *occurrence* while its prose was told to say *run*. Here one pair of words serves
  schema and prose alike.
- **Dismiss** — two objects, two rules. Dismissing a **run** refuses it for the day and takes no
  reason, because it is the fastest negative act in the app. Dismissing a **flag** on Revise takes a
  dated reason and suppresses the flag for a window, because that reason is read back.
- **Goal** — something the user works toward that names what satisfies it; the app refuses one
  that cannot. It is not a goal in `GOALS.md`: those are standing tests every decision in this
  repository must pass, are never satisfied, and are being renamed *criteria* so that the app keeps
  the word. Until the rename lands, *goal* in a document about the repository means `GOALS.md`'s.
  Standing practices are the commonest thing mistaken for a goal: a thing done every day is a
  definition on a schedule, not a goal.
- **Metric**, **reading** and **question** — a metric is a named series: a unit, an aggregation,
  and its readings. A reading is one value in it. A question is one source that feeds a metric, and
  entering a value directly is another. In the first Loop the only way to create a metric was to
  write a question, so there the words meant one thing, and a reading was an *observation*.
- **Module** — a Gradle build unit. The first Loop repo had eight, and *module* was also its early
  word for a plugin, which is why both first-party plugins were written as in-repo modules and then
  extracted to become plugins. The two are disambiguated here because the words did both jobs in
  the same history.
- **Note** — prose with a subject, where the subject is a run, a reading, a revision, or the day. It replaces
  three separate text boxes, including the first Loop's journal, and overturns that app's rule to
  keep a run's note and a standalone entry apart.
- **Plugin** — a separately installed app. Separate APKs are the point: a vendored plugin produces
  one merged manifest, so a plugin needing a permission would make Loop declare it.
- **Prerequisite** and **blocked** — a prerequisite is an edge saying one thing cannot be started
  until another is done; blocked is the state it derives. Named to avoid **gate**, which in this
  repository already means the reading gate in `PROCEDURE.md`, the commit hook that holds back the
  first Kotlin file, and the moment a definition must cite what it serves. *Gate* stays out of the
  app's vocabulary.
- **Principle** — a proposition the user holds and can fail to serve, at the top of what work is
  for. A principle never closes: it cannot be satisfied, only abandoned. The Goals screen lists
  principles, and that is not a claim that a principle is a goal. An older record's *the root*,
  a single goal that could never be satisfied, is what principles replaced.
- **Revision** and **Revise** — a revision is a dated, attested change to something that stays in
  place: its wording, its target, its steps. Revise is the screen where one is made. Neither is the
  first Loop's **Reflect**, a pillar that held a journal and was refused as a concept, nor its
  *review*, a periodic session it never built.
- **Routine** — a definition that has ordered steps: a shape, not a category. The first Loop used
  the word for a definition in its glossary, for a tree of runs on its Today screen, and for its
  engine besides.
- **Snooze** and **defer** — a snooze pushes a run later today; a defer pushes the work to another
  day, by dismissing today's run and creating a one-off definition for that day, linked to it.
  Different objects, so different words. The first Loop used both for one thing.
- **Time of day** — an optional time on a scheduled definition. Setting one is how a notification
  is asked for; there is no separate reminder switch. The first Loop called a definition with a
  time of day **timed**, and a definition with a stopwatch timed as well. The word is retired from
  both.
