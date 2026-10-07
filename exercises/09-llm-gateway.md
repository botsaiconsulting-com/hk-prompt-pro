# 09 Enterprise LLM gateway - cost & accuracy routing (Advanced track)

Read `docs/modules/llm-gateway.md` first. No code ships from this card: you design HK's model front
door and compare with real gateways. Work in pairs. The hard rules still hold - no credentials, dummy
data only, sanitise anything pasted.

1. Ask Claude: "Read `.claude/skills/hk/SKILL.md` and the `## Review standards` in `CLAUDE.md`. Produce
   a routing table: each lens -> small or strong model -> one-line reason tied to a risk level."
   Compare it with the table in the module and defend any difference.
2. For each lens you routed to the small model, ask your pair: what goes wrong if it were silently
   downgraded on a blocker-domain run (price, weight, quantity, money, cross-company)? Which lenses can
   you say must never be cheap?
3. Design the guardrail layer. Ask Claude to list exactly what the gateway blocks or redacts before a
   call leaves HK, each tied to a hard rule in `CLAUDE.md` (credentials, dummy data, sanitised logs).
4. Decide where a verification pass is mandatory, and tie it to the `check` lens - what would that pass
   re-check before a blocker-domain answer is trusted?
5. Ask Claude to fetch the `github.com/BerriAI/litellm` README and map its router and budget features
   onto your table, then the `github.com/Portkey-AI/gateway` README onto your guardrail layer. Note
   what each does that your design missed.
6. Write your routing table and guardrail list to `docs/modules/gateway-design.md`.

Human check: you can name the lenses that must never be routed to the cheap model and why (the blocker
list), and one rule the gateway enforces that the model itself can't be trusted to keep.
