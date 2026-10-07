# 08 Distributed multi-agent state & memory (Advanced track)

Read `docs/modules/multi-agent-memory.md` first. No code ships from this card: you make the memory
model this repository already lives in explicit, then compare with real frameworks. Work in pairs.

1. Ask Claude: "Read `.claude/skills/hk/SKILL.md`. List every file the lenses read and write. For each
   one, give the scope (session / repo / team), the agent that writes it, and the agents that read it."
   Check the list against the lens descriptions.
2. Name the stores out loud: which file is team memory, which are long-term repo facts, which is the
   episodic log. (Answers are in the module's diagram - confirm them from the files, don't take them on
   trust.)
3. The conflict: two pairs run `/hk orient .` at the same time. Ask Claude to describe the exact state
   conflict on `CLAUDE.md` and a resolution that loses neither pair's facts. What actually arbitrates
   the write?
4. The hand-off: the `hk-reviewer` subagent (`.claude/agents/hk-reviewer.md`) can only flag an
   "edit outside the plan" if the plan is part of the state it receives. Ask Claude to design the
   smallest hand-off record carrying plan, branch and task between agents.
5. Ask Claude to fetch the `github.com/langchain-ai/langgraph` README and map its checkpointer /
   persistence onto the branch-plus-review "lock", and its state graph onto `plan -> endpoint -> test
   -> review`. Where does it not fit?
6. Write your memory model and findings to `docs/modules/memory-design.md`.

Human check: you can name the file that is the team's long-term memory, the file that is the episodic
log, and the thing that actually arbitrates a conflicting write (the branch + human review, not the
agent).
