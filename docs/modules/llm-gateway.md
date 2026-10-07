# Module 09 - Enterprise LLM gateway architecture (cost & accuracy routing)

> Advanced track, concept module. No new code ships in this repository. You read this, then
> prompt Claude Code against the HK estate and against real GitHub projects you fetch and verify.
> The house rules still hold: no credentials in the session, dummy data only, sanitise anything you
> paste, a person signs off anything that touches price, weight, quantity or money.

## 1. Why HK cares

The `/hk` lenses do not all carry the same cost or the same risk, yet today they'd all hit the same
model. Look at the spread:

- `orient`, `check`, `support answer` are mostly structured bookkeeping - cheap, low blast radius.
- `sql`, `review`, `debug`, `brd spec` touch the exact things the **Review standards** call blockers:
  price, metal weight, quantity, money, cross-company logic. Getting these wrong is expensive.

An **LLM gateway** is a single front door for all of HK's model calls - the lenses today, and any LLM
features the Gati apps grow later. It does four jobs: **route** each call to the right model tier,
**control cost** (cache, budgets), **protect accuracy** (strong model plus a verification pass on
high-risk calls), and **enforce the hard rules centrally** (block credentials, keep dummy data,
sanitise logs) so each individual call site can't quietly break them.

The point is not "use a cheaper model everywhere". It is: match model strength to task risk, and put
the guardrails somewhere the caller can't skip.

## 2. Core concepts

```
   CALLERS                      GATEWAY                                   PROVIDERS
   -------                      -------                                   ---------
   /hk lenses  ----\     +-----------------------------+         +--> small model
   Gati app LLM     \    | ROUTER  risk/complexity ->  |--------/     (orient, check,
   features ---------+-->|         model tier          |              support answer)
                         |                             |         +--> strong model
                         | GUARDRAILS  block secrets,  |--------/     (sql, review, debug,
                         |   PII, non-dummy data;      |              brd spec  +  verify pass)
                         |   sanitise logs             |         +--> specialised / fallback
                         |                             |--------/     (on failure or low
                         | CACHE + BUDGET  per lens    |              confidence)
                         |                             |
                         | OBSERVABILITY  cost +       |
                         |   accuracy per route        |
                         +-----------------------------+
```

- **Routing.** Decide the model per call from task complexity and risk. Low-risk, structured work ->
  small model. Price/weight/money/cross-company -> strong model, and don't downgrade it.
- **Cost controls.** Cache repeated calls (the same schema pack read many times), set per-lens token
  budgets, and measure spend per route so the expensive lenses are visible.
- **Accuracy.** Route high-risk calls to the strong model *and* add a verification step. HK already
  has one: the `check` lens re-opens five claims and rejects an output with two wrong. That is a
  verification gate the gateway can make mandatory for blocker-domain work.
- **Guardrails at the gateway.** Centralise the hard rules: refuse a call that would send a
  credential or real client/pricing data, redact it from logs. A rule enforced at the gateway can't
  be forgotten by one caller.
- **Observability.** Cost and accuracy per route, so routing can be tuned with evidence instead of
  guesses.

## 3. Mapped to the HK estate

A routing table built straight from the lens list and the **Review standards** risk levels. This is
the artifact to produce in the exercise.

| Lens | Tier | Why (from Review standards) |
|---|---|---|
| `orient` | small | Bookkeeping; writes `CLAUDE.md` only, no calculation. |
| `check` | small | Re-reads and compares; it *is* the verification step. |
| `support answer` | small | Matches text to a library entry; never changes master data. |
| `schema` | small/strong | Structured, but a wrong **Traps** note misleads every later `sql`. |
| `brd` | small/strong | Summarises notes; `brd spec` names `table.column` and needs care. |
| `sql` | **strong** | Price/weight/money and cross-company joins - blocker domain. |
| `endpoint` | **strong** | Writes code behind a human-approved plan. |
| `test` | **strong** | Known-answer totals must be exactly right. |
| `debug` | **strong** | Root-cause on price/quantity errors; wrong fix is costly. |
| `review` | **strong** | The last gate before merge; misses here reach main. |

Guardrails, mapped to the repo's hard rules: block any call carrying the read-only password or a
connection string (already blocked from being read); refuse real client, pricing, stone or order
data (dummy only); sanitise pasted logs before they reach a provider (the `debug` lens already
requires this).

## 4. Prompt these against the estate

Work in pairs. You are designing the gateway, not building it.

- "Read `.claude/skills/hk/SKILL.md` and the `## Review standards` in `CLAUDE.md`. Produce a routing
  table: each lens -> small or strong model -> one-line reason tied to a risk level."
- "Design the guardrail layer. List exactly what it blocks or redacts before a call leaves HK, each
  tied to a hard rule in `CLAUDE.md`."
- "Which lenses must a verification pass be mandatory for, and what would that pass check? Tie it to
  the `check` lens."

## 5. GitHub examples to fetch and verify

Ask Claude to fetch each README and map its features onto the router / guardrail / observability
boxes above. Confirm each repo is current and read the licence. Evidence or nothing.

- `github.com/BerriAI/litellm` - one API over many providers, with a router and budgets; map its
  routing strategies to the lens table.
- `github.com/Portkey-AI/gateway` - gateway with guardrails, caching and fallbacks; map its guardrail
  config to HK's hard rules.
- `github.com/lm-sys/RouteLLM` - learned cost/accuracy routing between a cheap and a strong model;
  compare to the by-risk table.
- Also worth a look: Kong AI Gateway, Cloudflare AI Gateway, OpenRouter - compare managed vs
  self-hosted trade-offs.

## 6. Where a person decides

- The spend ceiling and which lenses may ever run on the cheap model - never the blocker domains
  (price, weight, quantity, money, cross-company) without sign-off.
- What counts as "accurate enough" to skip the verification pass.
- The gateway enforces the hard rules; it does not replace the human sign-off on any price, grading,
  order or master-data action. You design the routing; a person still owns the decision.
