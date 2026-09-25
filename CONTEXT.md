# Context

What a term means in this project. It does not own the goals (`GOALS.md`), the shape of the
repository (`ARCHITECTURE.md`), how agents work (`CLAUDE.md`), or what to port from the first Loop
repo (`SALVAGE.md`).

A term earns an entry when it is already in use and has been mistaken for something else. Where a
term is renamed, this file notes the former name, so an ADR written under the old word still reads.

## Terms

- **Module** — a Gradle build unit. The first Loop repo had eight, and *module* was also its early
  word for a plugin, which is why both first-party plugins were written as in-repo modules and then
  extracted to become plugins. The two are disambiguated here because the words did both jobs in
  the same history.
- **Plugin** — a separately installed app. Separate APKs are the point: a vendored plugin produces
  one merged manifest, so a plugin needing a permission would make Loop declare it.
