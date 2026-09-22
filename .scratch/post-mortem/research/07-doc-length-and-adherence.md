# What the evidence actually says about document length and adherence

Type: research findings
Ticket: `.scratch/post-mortem/issues/07-doc-length-and-adherence.md`
Researched: 2026-09-22

Sources are primary where one exists: Anthropic's published Claude Code documentation and
engineering blog for the guidance claims, peer-reviewed or arXiv work for the empirical ones, and
the locally installed `mattpocock-skills` plugin as a secondary source. Every claim below carries
the URL it came from.

---

## 1. Is "keep `CLAUDE.md` under ~200 lines" published Anthropic guidance?

**Yes. It is published guidance, stated as a target, with a stated two-part reason — and it is
published without any supporting measurement.**

The exact line, from the Claude Code memory documentation, under **Write effective instructions**:

> **Size**: target under 200 lines per CLAUDE.md file. Longer files consume more context and reduce
> adherence. If your instructions are growing large, use path-scoped rules so instructions load only
> when Claude works with matching files. You can also split content into imports for organization,
> though imported files still load and enter the context window at launch.

— https://code.claude.com/docs/en/memory (the older `docs.claude.com/en/docs/claude-code/memory`
URL 301-redirects here)

The same page repeats it in its troubleshooting section, and there the modality is weaker:

> Files over 200 lines consume more context and **may** reduce adherence. Claude Code skips a file
> over 4 MiB. Use path-scoped rules to load instructions only when Claude works with matching files,
> or trim content that isn't needed in every session. Splitting into `@path` imports helps
> organization but doesn't reduce context, since imported files load at launch.

— https://code.claude.com/docs/en/memory

Two more first-party statements from the same doc bound what the number means:

> Both are loaded at the start of every conversation. Claude treats them as context, not enforced
> configuration. To block an action regardless of what Claude decides, use a PreToolUse hook
> instead. **The more specific and concise your instructions, the more consistently Claude follows
> them.**

> This limit applies only to `MEMORY.md`. Claude Code loads a CLAUDE.md file of up to 4 MiB in full
> and skips a larger file. **Shorter files produce better adherence.**

— https://code.claude.com/docs/en/memory

Note the 200 is *not* a mechanism anywhere for `CLAUDE.md`: the file is loaded in full up to 4 MiB.
The only place 200 lines is an actual hard cutoff is auto memory: "The first 200 lines of
`MEMORY.md`, or the first 25KB, whichever comes first, are loaded at the start of every
conversation." (same page). The `CLAUDE.md` 200 is advice; the `MEMORY.md` 200 is enforcement. They
are easy to conflate and they are different facts.

**The best-practices page gives the same advice with no number at all**, which is the more
defensible form:

> CLAUDE.md is loaded every session, so only include things that apply broadly. For domain knowledge
> or workflows that are only relevant sometimes, use skills instead. Claude loads them on demand
> without bloating every conversation.
>
> Keep it concise. For each line, ask: *"Would removing this cause Claude to make mistakes?"* If not,
> cut it. **Bloated CLAUDE.md files cause Claude to ignore your actual instructions!**

> **The over-specified CLAUDE.md.** If your CLAUDE.md is too long, Claude ignores half of it because
> important rules get lost in the noise. **Fix**: Ruthlessly prune. If Claude already does something
> correctly without the instruction, delete it or convert it to a hook.

> If Claude keeps doing something you don't want despite having a rule against it, the file is
> probably too long and the rule is getting lost.

> If Claude keeps skipping one instruction, add emphasis such as "IMPORTANT" to that line alone. If
> you emphasize many lines, none of them stands out.

— https://code.claude.com/docs/en/best-practices

**Verdict on the number.** 200 is real published Anthropic guidance, not community folklore — the
folklore is downstream of it, not the other way round. But it is published as a round target with a
plausibility argument and **no cited evaluation, no measured curve, and no threshold effect**. The
docs themselves hedge it ("may reduce adherence") in one of the two places it appears. Nothing
Anthropic publishes shows an adherence difference between a 150-line and a 250-line `CLAUDE.md`.
Treat 200 as *a defensible convention with an authoritative source*, not as a measured cliff. Its
real force is the per-line test from the best-practices page — "would removing this cause Claude to
make mistakes?" — which is a rule the number merely summarises.

The secondary source agrees and declines to give a number. The local
`mattpocock-skills:writing-for-agents` skill names the failure mode but never quantifies it:

> **Sprawl** is the failure mode here: a document simply too long, even when every line is live and
> unique. Attention thins across the excess, and every extra line is one more to keep relevant. The
> cure is the ladder: disclose reference behind pointers, and split by branch or sequence so each
> path carries only what it needs.

> **Context load** is the cost of always-loaded material on the agent's window: an `AGENTS.md` line,
> a skill description, anything sitting in context every turn, spending tokens and attention whether
> or not it fires.

— `/Users/<user>/.claude/plugins/cache/claude-plugins-official/mattpocock-skills/1.2.3/skills/productivity/writing-for-agents/SKILL.md`

---

## 2. "Instruction adherence drops as instruction length grows"

The ticket is right that this splits into two claims. They have **different evidence of different
strength**, and the strong evidence is on the claim the budget is *not* really about.

### 2a. Accuracy on a task degrades with context length — well evidenced

- **Liu et al., "Lost in the Middle: How Language Models Use Long Contexts"** (arXiv 2307.03172,
  TACL 2024). Abstract, verbatim: "We analyze the performance of language models on two tasks that
  require identifying relevant information in their input contexts: multi-document question
  answering and key-value retrieval. We find that performance can degrade significantly when
  changing the position of relevant information… performance is often highest when relevant
  information occurs at the beginning or end of the input context, and significantly degrades when
  models must access relevant information in the middle of long contexts, even for explicitly
  long-context models." — https://arxiv.org/abs/2307.03172

  **This is a retrieval/QA accuracy result, not an instruction-following result.** It is routinely
  cited as if it were the latter. It is the single most-miscited paper in this area, and the
  "30% drop for instructions buried in the middle" figure circulating in blog posts is not a
  finding of this paper about instructions.

- **Levy, Jacoby & Goldberg, "Same Task, More Tokens: the Impact of Input Length on the Reasoning
  Performance of Large Language Models"** (ACL 2024; arXiv 2402.14848). Holds the task constant and
  pads the input, isolating length from difficulty; finds "a notable degradation in LLMs' reasoning
  performance at much shorter input lengths than their technical maximum," well before the context
  limit. — https://arxiv.org/abs/2402.14848 · https://aclanthology.org/2024.acl-long.818/

- **Chroma, "Context Rot: How Increasing Input Tokens Impacts LLM Performance"** (July 2025,
  18 models incl. Claude 4, GPT-4.1, Gemini 2.5, Qwen3). "Models do not use their context
  uniformly; their performance grows increasingly unreliable as input length grows," including on
  trivial tasks like replicating repeated words. — https://www.trychroma.com/research/context-rot
  **Caveat: a vendor technical report, not peer-reviewed**, from a company selling retrieval
  infrastructure. Its results are replicable (toolkit at
  https://github.com/chroma-core/context-rot) but it should be cited as corroboration, not as the
  load-bearing source.

- **Anthropic's own framing**, from *Effective context engineering for AI agents*: "as the number of
  tokens in the context window increases, the model's ability to accurately recall information from
  that context decreases"; "LLMs have an 'attention budget' that they draw on when parsing large
  volumes of context"; and the honest hedge, "models remain highly capable at longer contexts but
  may show reduced precision for information retrieval and long-range reasoning compared to their
  performance on shorter contexts."
  — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

  Note that Anthropic's own advice here is explicitly *not* "shorter is better": "minimal does not
  necessarily mean short; you still need to give the agent sufficient information up front" (same
  page).

### 2b. Adherence to instructions degrades as instructions multiply — evidenced, but at densities far above any sane `CLAUDE.md`

The one paper that measures the actual claim:

- **Jaroslawicz, Whiting, Shah & Maamari, "How Many Instructions Can LLMs Follow at Once?"**
  (IFScale, arXiv 2507.11538, 2025). 20 models, seven providers; a business-report task with
  keyword-inclusion instructions scaled **from 10 to 500 simultaneous instructions**.
  — https://arxiv.org/abs/2507.11538 · https://distylai.github.io/IFScale/

  Findings relevant here:
  - Best models are at or near **100% at 10 instructions** and "even the best frontier models only
    achieve 68% accuracy at the max density of 500 instructions" (gemini-2.5-pro 68.9%, o3 62.8%).
  - **Three degradation patterns**: *threshold decay* (near-perfect until a critical density, then
    rising variance — o3, gemini-2.5-pro), *linear decay* (steady decline — gpt-4.1,
    claude-3.7-sonnet), *exponential decay* (rapid early loss then stabilisation — gpt-4o,
    llama-4-scout).
  - Reasoning models "maintain near-perfect performance through 150 or more instructions before
    declining." Weaker models degrade from much lower densities.
  - A **primacy bias**: earlier instructions are complied with more reliably than later ones, an
    effect most pronounced at middling densities and washing out into uniform failure at extreme
    ones.

  **The crucial limitation for this ticket**: IFScale scales *instruction count*, not *document
  length*, and does not separate the two — token length is not manipulated as an independent
  variable. So it cannot tell you whether a 200-line file beats a 400-line file at equal instruction
  count, and it says nothing about what happens at the 20–60 distinct-rule scale a real `CLAUDE.md`
  occupies. At that scale its own data shows near-ceiling compliance.

### What this means for the composite claim

The ticket's phrasing — "length correlates negatively with accuracy" — is two claims welded
together, and the weld is where the folklore is:

| Claim | Evidence | Strength |
|---|---|---|
| Long *context* degrades retrieval and reasoning accuracy | Liu 2023, Levy 2024, Chroma 2025, Anthropic | Strong, replicated, peer-reviewed in part |
| *Many* instructions degrade per-instruction compliance | IFScale 2025 | Good, but demonstrated at 100–500 instructions |
| *A longer instruction file* degrades compliance with its own rules, at the 100–400-line scale | **None found** | **Asserted by Anthropic docs, not measured anywhere public** |
| **200 lines specifically** is where this begins | **None found** | **A round number in a doc** |

Every step of the reasoning is individually plausible — a `CLAUDE.md` is both context and
instructions, and both are known to degrade with volume. But the specific claim the budget would
enforce is the third row, and it has no published measurement behind it. That is the honest answer
this ticket asked for.

A second-order effect is better evidenced than the first-order one and probably matters more in
practice: **conflict and dilution**, not length. Anthropic's memory doc: "if two rules contradict
each other, Claude may pick one arbitrarily." Best practices: "If you emphasize many lines, none of
them stands out." A long file is a *proxy* for an inconsistent, redundant, low-signal file, and the
proxy is what the guidance is really reaching for.

---

## 3. Does it generalise beyond the always-loaded top-level file?

**No — and the primary sources are unusually explicit that it does not.** The distinction the ticket
draws is exactly the distinction Anthropic's architecture is built on.

- Best practices: "CLAUDE.md is loaded every session, so only include things that apply broadly. For
  domain knowledge or workflows that are only relevant sometimes, use skills instead. **Claude loads
  them on demand without bloating every conversation.**"
  — https://code.claude.com/docs/en/best-practices

- Memory doc, on `.claude/rules/`: "Rules load into context every session or when matching files are
  opened. For task-specific instructions that don't need to be in context all the time, use skills
  instead, which only load when you invoke them or when Claude determines they're relevant."
  Path-scoped rules "only load into context when Claude works with matching files, reducing noise and
  saving context space." — https://code.claude.com/docs/en/memory

- And the trap worth writing down: **imports do not help.** "Splitting into `@path` imports helps
  organization but doesn't reduce context, since imported files load at launch." A `CLAUDE.md` that
  gets under 200 lines by `@`-importing four files has not reduced anything. Only a *pointer the
  agent may decline to follow* (a skill, a path-scoped rule, a plain prose "read X when you touch Y")
  buys context back. — https://code.claude.com/docs/en/memory

- Agent Skills: "Progressive disclosure is the core design principle that makes Agent Skills flexible
  and scalable." Level one is metadata — "just enough information for Claude to know when each skill
  should be used without loading all of it into context"; level two is the full `SKILL.md`, read only
  "if Claude thinks the skill is relevant"; level three is linked files it "can choose to navigate
  and discover only as needed." Consequence: "the amount of context that can be bundled into a skill
  is effectively unbounded."
  — https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills

- **On-demand material still gets a budget, just a looser one.** The skills doc: "Keep `SKILL.md`
  under 500 lines. Move detailed reference material to separate files." And the reason, which is the
  sharpest sentence found in this whole search: "Once a skill loads, its content stays in context
  across turns, so **every line is a recurring token cost**." It also tells you to "apply the same
  conciseness test you would for CLAUDE.md content."
  — https://code.claude.com/docs/en/skills

- Anthropic's just-in-time model, for the general case: "agents built with the 'just in time'
  approach maintain lightweight identifiers (file paths, stored queries, web links, etc.) and use
  these references to dynamically load data into context at runtime using tools."
  — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

- The secondary source states the same two-budget model directly, and adds the part the Anthropic
  docs leave implicit — that pushing material behind a pointer moves the cost onto the human, and
  that **the pointer's wording, not its target, decides whether the material is ever reached**: "A
  must-have target behind a weakly worded pointer is a variance bug: sharpen the wording first, and
  inline the material only if sharpening fails."
  — `mattpocock-skills/1.2.3/skills/productivity/writing-for-agents/SKILL.md`

**So the cost profiles really are different, and the published numbers reflect it**: ~200 lines for
the thing loaded every session, ~500 lines for the thing loaded when relevant, effectively unbounded
for the thing behind a second pointer. An ADR, a style guide, a reference doc opened on demand is
governed by the 500-line figure at worst and by nothing at all if it sits a level deeper. **A
corpus-wide line budget that counts always-loaded and on-demand documents the same way has no
support in any source found.** The old repo's 8,191 Markdown lines are not per se evidence of an
adherence problem; its 247-line `CLAUDE.md` is the only file the 200 figure actually speaks to.

What the evidence does *not* support is the reverse comfort, either: an on-demand doc is free only
while it stays unread. Once read it is in context for the rest of the session, and the ADR corpus's
real cost is that a session that reads six ADRs has paid for six ADRs.

---

## What this means for the next repo

- **`CLAUDE.md` ≤ 200 lines is defensible and citable** — https://code.claude.com/docs/en/memory
  says exactly that, in those words. Adopt it, cite the URL beside it, and describe it as
  *Anthropic's published target*, never as a measured threshold. The old repo's file was 247 lines,
  so the budget bites immediately and honestly.
- **Do not claim the empirical backing it doesn't have.** No published study measures adherence
  against instruction-file length at the 100–400-line scale. If the kit states a reason, state the
  documented one — always-loaded material spends context and attention every turn, and a long file
  dilutes emphasis and invites contradiction — not a fabricated accuracy curve.
- **Two budgets, not one, because the cost profiles genuinely differ**: **200 lines** for anything
  loaded every session (`CLAUDE.md` plus any unconditional rules file — count them *together*, since
  they concatenate), and **500 lines** for any single document opened on demand, from
  https://code.claude.com/docs/en/skills. An aggregate corpus ceiling has no source; if the kit wants
  one it is a local policy against sprawl and cognitive load, and must be labelled as invention.
- **The enforceable rule that beats both numbers**, and the one to put in front of an agent at 2am
  when the budget is hit: *for each line, would removing it cause a mistake?* — cut it if not, and
  when the cut is disputed, the eviction order is (1) anything derivable from the code or the
  environment, (2) anything only some sessions need, which becomes an on-demand doc behind a
  sharply-worded pointer, (3) anything duplicated elsewhere. Source:
  https://code.claude.com/docs/en/best-practices.
- **`@`-imports are not a compliance strategy.** A `CLAUDE.md` trimmed to 190 lines by importing
  three files has changed nothing — imported files load at launch. Only pointers the agent may
  decline to follow (skills, path-scoped rules, prose references) actually reduce the per-session
  load, and ticket 11's enforcement check must count imports against the budget or it measures
  nothing.
