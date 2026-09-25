# Does Reflect survive its own test?

Type: grilling
Status: open
Blocked by: 04

## Question

Reflect is the concept in the analogy with the weakest warrant. In the first repo it was one screen
(244 lines), one repository (95) and one entity — `journal_entry` is `id / body / written_at /
edited_at` — and the repo's own boundary note says prose *"has no comparable form"* and is excluded
from Track. `SALVAGE.md`'s prohibition names this case almost verbatim: **storing text with a
timestamp is not an engine.**

The analogy calls it a devlog, which is a genuinely useful thing in a repository. This ticket asks
whether it is a useful thing in this app, or whether it is a text box that survived because it was
easy to build.

- **What does it do that a note on a work item does not?** The occurrence model already carries a
  `note`. If reflection attaches to a thing that happened, it may be a field rather than a concept.
- **What stage does it cover?** Under the two-claims test it must name a stage nothing else covers.
  The candidate is *looking back over a period and drawing a conclusion* — which is a real act, and is
  also what ticket 04's charts are for. If the two overlap, one of them is the feature.
- **Does it have an engine, or can it acquire one?** The honest answer may be no, and a concept with
  a real stage and no engine is exactly the case `SALVAGE.md` says to refuse. A screen that is refused
  as a *concept* may still ship as a *screen*, which the post-mortem's advice — name screens, do not
  classify them — permits without cost.
- **The one piece of evidence in its favour.** `SALVAGE.md` records that the first repo's real
  decisions came from an in-app note appended to a file on the device and read beside the occurrence
  log. That is reflection doing load-bearing work — but for the *developer*, not the user, and those
  are different products. Whether the author's two roles are the same user here is the question under
  the question.
