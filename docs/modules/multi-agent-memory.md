# Module 08 - Distributed multi-agent state & memory management

> Advanced track, concept module. No new code ships in this repository. You read this, then
> prompt Claude Code against the HK estate and against real GitHub projects you fetch and verify.
> The house rules still hold: evidence or nothing, unresolved beats inferred, a person signs off any
> write that matters.

## 1. Why HK cares

This repository is already a small multi-agent system with shared memory - you just haven't named it
that way.

- There is more than one agent: the main `/hk` session and the `hk-reviewer` subagent
  (`.claude/agents/hk-reviewer.md`), which reads what the session produced and returns findings.
- The outputs are shared, persistent memory. `CLAUDE.md` (the `## Working at HK` section) is team
  memory; `context/schema/*.md` are long-term facts; `docs/reviews/`, `docs/debug/`, `docs/brd/` are
  per-task working memory; `artefacts/prompt-tests.md` is an episodic log of what was checked.
- In the workshop, many pairs work the same estate at once. That is distributed state, with real
  concurrency: two pairs can write the same file, and a schema pack can go stale after someone else
  learns a fact.

Once HK adds more lenses, more subagents and more people, those shared files behave like a
distributed memory system. The discipline the repo already enforces - branches, citations, open
questions - is a first-draft memory-management protocol. This module makes it explicit.

## 2. Core concepts

```
        AGENTS                         SHARED STORES (memory)            SCOPE / LIFETIME
        ------                         ---------------------             ----------------
   main /hk session  --writes-->  CLAUDE.md (## Working at HK) ......... team, long-lived
         |      \    --reads--->   context/schema/*.md ................. repo, long-lived (goes STALE)
         |       \   --writes-->   sql/  docs/brd/ ..................... task working memory
         |        \
   hk-reviewer ----- --reads---->  the diff + the plan ................. hand-off state
   subagent          --writes-->   docs/reviews/<branch>.md ............ task output
                     --appends->   artefacts/prompt-tests.md ........... episodic log

   WRITE PROTOCOL (how conflicting writes are arbitrated):
        plan  ->  branch  ->  human review  ->  merge
        (no agent merges to main on its own; the branch + review is the lock)
```

- **Memory scopes.** *Session* memory lives in one run's context and is gone after. *Long-term /
  repo* memory persists on disk (schema packs, known-issues). *Team* memory is shared across people
  (`CLAUDE.md`). Naming the scope tells you who may write it and how long to trust it.
- **Hand-off as a state machine.** `plan -> endpoint -> test -> review` passes artifacts forward.
  Each stage reads the previous stage's output; the reviewer needs the plan to judge "edits outside
  the plan". That is state, flowing between agents.
- **Staleness and consistency.** A schema pack written yesterday can be wrong today. The repo's rule
  "unresolved beats inferred" is a consistency policy: do not trust a cached fact you can't confirm.
- **Write arbitration.** Two agents (or two pairs) can't both be right about one file. The branch +
  human review is the lock that decides whose write wins - not the agent.

## 3. Mapped to the HK estate

A worked conflict: **two pairs run `/hk orient .` at the same time.** Both derive a `## Working at HK`
section; both try to append to `CLAUDE.md`. That is a classic distributed-write race.

- *Scope:* `CLAUDE.md` is team memory - a shared store, highest contention.
- *Resolution:* each write goes on a branch; a person merges one and reconciles the other's facts in
  review. Nobody writes team memory straight to main.
- *Staleness:* if pair A's orient captured a fact that pair B's missed, the merge is where both are
  reconciled - the memory is repaired, not silently overwritten.

A worked hand-off: `/hk review` runs in the `hk-reviewer` subagent. It can only flag "an edit outside
the approved plan" if the plan is part of the state it receives. Lose the plan from memory and the
reviewer loses a whole class of findings. Memory design changes what the system can detect.

## 4. Prompt these against the estate

Work in pairs. You are designing a memory protocol, not writing code.

- "Read `.claude/skills/hk/SKILL.md`. List every file the lenses read and write. For each, say the
  scope (session / repo / team), which agent writes it, and which agents read it."
- "Two pairs run `/hk orient` at the same time. Describe the exact state conflict and a resolution
  that loses neither pair's facts."
- "The `hk-reviewer` subagent needs the plan to catch edits-outside-the-plan. Design the smallest
  hand-off record that carries plan, branch and task between agents."

## 5. GitHub examples to fetch and verify

Ask Claude to fetch each README and map its memory/state model onto the stores above. Confirm the
repo is current and check the licence before borrowing. Evidence or nothing.

- `github.com/langchain-ai/langgraph` - map its *checkpointer / persistence* to the branch+review
  "lock", and its state graph to the `plan -> endpoint -> test -> review` hand-off.
- `github.com/letta-ai/letta` (formerly MemGPT) - map its tiered memory to session vs long-term vs
  team scopes.
- `github.com/mem0ai/mem0` - a memory layer for agents; compare to `context/schema/*.md` as durable
  recall.
- `github.com/microsoft/autogen` and `github.com/crewAIInc/crewAI` - multi-agent hand-off patterns;
  compare to the session + `hk-reviewer` split.

## 6. Where a person decides

- Who owns a contested write to team memory (`CLAUDE.md`, a schema pack) - always resolved by human
  review, never by last-writer-wins.
- When a cached fact is too stale to trust and must be re-derived from the code or a read-only query.
- No agent here writes data or schema, or merges to main alone. Shared files, branches and review are
  the enforcement; this module only makes the model you are already living in visible.
