# The goals document, and the citation rule that gives it teeth

Type: grilling
Status: open

## Question

Decided in ticket 08: the kit's first file states this project's goals, it outranks the ownership
table, and **every ADR cites the goal it serves** — an ADR that cannot name one is rejected. The old
repo had no goals file and no owner for one; its ownership table covered every kind of claim in the
project except this, and that omission is what let F-Droid stand unexamined for eight days while
propagating four ADRs deep into the module graph.

What remains is the content and the shape.

- **What are the goals?** Two are already on the record and in tension: Loop is built primarily for
  the user's own use, *and* the user's work needs to be public to get a foothold in the community
  and the industry. A goals file that only states the first cannot check a publication decision; one
  that only states the second is a lie about why the app exists. Both, with their priority, or a
  different framing entirely.
- **What does a goal have to look like to be citable?** "Loop is finished, and submitted to F-Droid"
  was the old repo's only goal-shaped sentence and it states a means as an end. A goal that names an
  artifact or a channel cannot invalidate a decision about that artifact or channel.
- **What is out of bounds?** The file must be short enough to be re-read often (ticket 08 rejected
  re-reading as the *mechanism*, but it is still a property the file needs) and stable enough that
  citations do not rot. What kinds of claim belong to other owners.
- **The citation rule's failure mode.** A rule that every ADR cite a goal can degrade into every ADR
  citing the same goal ritually. Is there a check, or is ritual citation an acceptable cost given
  ticket 03's evidence that attached rules are the only ones that hold?
- **Non-goals.** The old repo's plugin scope creep and its F-Droid target were both things the user
  did not want on reflection. Does the file carry explicit non-goals, and does a decision have to
  clear those too?
