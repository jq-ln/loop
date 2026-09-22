# What the evidence actually says about document length and adherence

Type: research
Status: resolved

## Question

Two claims are about to become an enforced constraint in this repo. Establish what primary sources
actually support, and where the claims outrun the evidence.

1. **"Keep `CLAUDE.md` under ~200 lines"** — is this published Anthropic guidance, and if so what
   is the stated reason? Quote it precisely and cite it. If the number is folklore rather than
   guidance, say so plainly.
2. **"Instruction adherence drops as instruction length grows"** and the broader "length correlates
   negatively with accuracy" — find the real work behind this: context degradation / "lost in the
   middle" findings, instruction-following evaluations at varying prompt length, published guidance
   on agent instruction files. Distinguish *adherence to instructions* from *accuracy on a task*;
   they are different claims and may have different evidence.
3. Does any of it generalise beyond the top-level instruction file — to ADRs, style guides,
   reference docs an agent reads on demand? A document loaded every session and a document opened
   when relevant have different cost profiles; find out whether the evidence distinguishes them.

Use high-trust primary sources. The output decides whether ticket 11's budget is a principled
number or a superstition, so a well-cited "the evidence is thinner than the claim" is a good result.

## Answer

Full findings: [research\/07-doc-length-and-adherence.md](../research/07-doc-length-and-adherence.md)

The 200-line figure is **real published Anthropic guidance**, verbatim at https://code.claude.com/docs/en/memory — but it arrives with no measurement: no evaluation, no curve, no threshold. "Length hurts accuracy" is well evidenced (Lost in the Middle, Same Task More Tokens, Context Rot) but every one of those measures **retrieval and reasoning accuracy, not instruction adherence**. The only study measuring adherence directly (IFScale, arXiv 2507.11538) scales instruction *count*, not document length, and shows near-ceiling compliance at the scale a real CLAUDE.md occupies. So the exact proposition ticket 11 was chartered to enforce has no published measurement behind it. Better evidenced: **dilution and conflict** — contradictory rules are picked between arbitrarily, and emphasising many lines means none stands out. Length is a proxy for the real defect. The sources do distinguish always-loaded (~200) from on-demand (~500); an aggregate corpus ceiling counting both alike has no source. Trap: 200 lines is a hard cutoff only for auto-memory `MEMORY.md`; `CLAUDE.md` loads in full up to 4 MiB.
