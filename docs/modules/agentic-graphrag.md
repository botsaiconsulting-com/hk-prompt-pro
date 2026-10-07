# Module 07 - Agentic GraphRAG (knowledge graphs + vectors)

> Advanced track, concept module. No new code ships in this repository. You read this, then
> prompt Claude Code against the HK estate and against real GitHub projects you fetch and verify.
> The house rules still hold: evidence or nothing, cite `file:line` or `table.column`, unresolved
> beats inferred.

## 1. Why HK cares

HK's knowledge about this estate is split into two shapes.

- **Graph-shaped facts.** Tables, primary and foreign keys, the joins a report uses, the SAP-to-Gati
  renames, and the fact that the same concept lives under different column names in `HK_SURAT`,
  `HK_INDIA_A` and `HK_INDIA_B`. This is exactly what `/hk schema` writes into
  `context/schema/<domain>.md`: a **Keys and relationships** section, an **Across the three companies**
  table, and a **Traps** section (for example a production sales price sitting next to an actual
  selling price). Relationships are the point; a keyword search flattens them.
- **Text-shaped facts.** The known-issues library (`support/known-issues.md`), the tickets under
  `support/tickets/`, and the BRDs under `docs/brd/`. These are written in the user's words
  ("export cuts off", "weight still shows the old value"). Meaning matters more than structure; a
  join query can't find them.

Keyword search misses the joins. Pure vector search misses the relationships. **GraphRAG uses both:
a knowledge graph for the structure and a vector index for the text, with an agent that decides which
to use for a given question.** It is, roughly, what `/hk schema` + `/hk support` would be if their
outputs were a queryable graph and vector store instead of markdown you re-read on every run.

## 2. Core concepts

```
  INGEST                          RETRIEVE                       ANSWER
  ------                          --------                       ------
  context/schema/*.md  --build--> [ KNOWLEDGE GRAPH ]
     tables, keys, FKs            nodes:  Table, Column,   \
     cross-company map            Company, KnownIssue,      \   graph traversal
     SAP->Gati renames            Report, Screen            |  (follow FK / rename /
                                  edges:  JOINS_ON,         |   touches edges)
                                          RENAMED_FROM,     |          +
                                          EQUIVALENT_IN,    |-> AGENT -> cited answer
                                          TOUCHES           |   (picks graph, vector,  (table.column
  support/known-issues.md -embed-> [ VECTOR INDEX ]        |    or both; composes      + file:line +
  support/tickets/*.md             chunks of ticket /      /    from what it found)     KI-id)
  docs/brd/*.md                    symptom / BRD text      /   vector top-k
                                                              (semantic match on
                                                               the user's words)
```

- **Knowledge graph.** Nodes are entities (a table, a column, a company database, a known-issue, a
  report, a screen). Edges are relationships (`SalesOrderLine` **JOINS_ON** `SalesOrder`; Gati
  `Customer` **RENAMED_FROM** SAP `KNA1`; `HK_INDIA_A.Customer` **EQUIVALENT_IN**
  `HK_SURAT.Customer`; KI-002 **TOUCHES** the bag movement screen). Retrieval is graph traversal:
  start at a node, follow edges.
- **Vector index.** Text is split into chunks, embedded, and retrieved by semantic nearness. "export
  cuts off" finds KI-001 even though those words aren't in the entry's title.
- **Agentic retrieval.** An agent plans the lookup: decompose the question, hit the graph for
  structure, hit the vectors for wording, maybe loop, then compose a cited answer. This is the
  difference from plain RAG, which does one vector lookup and stops.

## 3. Mapped to the HK estate

A worked question: **"Why does the hand-written monthly sales report give a different total from the
SAP report?"** (the same reconciliation from card 02).

1. **Graph** surfaces that the report reads `SalesOrderLine`, that there are two price-like columns,
   and the **Traps** edge warning that a production sales price is not the actual selling price.
2. **Graph** surfaces the **EQUIVALENT_IN** edges so the three company databases line up on one
   `company` column.
3. **Vector** surfaces any ticket or known-issue phrased around "wrong total" or "price looks off".
4. **Agent** composes: the hand-written version joined the wrong price column; here is the
   `table.column`, here is the trap, here is the related ticket.

Every claim still carries `table.column` or `KI-id`. A referenced-but-not-found node is a finding,
not a fact - same rule as the `/hk` spine.

## 4. Prompt these against the estate

Work in pairs. You are designing, not building.

- "Read `context/schema/orders.md` and `support/known-issues.md`. Propose a node-and-edge model:
  one table of node types, one table of edge types, each with the `file`/`table.column` it comes
  from. Mark anything you had to assume."
- "For the question 'which price column should the monthly sales report use', list the exact graph
  edges and the exact support entries a GraphRAG retriever would need to surface to answer it with
  citations."
- "Where would a pure vector search beat the graph on this estate, and where would the graph beat
  vectors? Give one concrete HK example of each."

## 5. GitHub examples to fetch and verify

Ask Claude to fetch each README and map its vocabulary onto the HK model above. Treat these as
starting points - confirm the repo is current and read the licence before borrowing anything. The
evidence-or-nothing rule applies to libraries too.

- `github.com/microsoft/graphrag` - map its *entities / relationships / communities* to HK tables,
  FKs and the cross-company grouping.
- `github.com/neo4j/neo4j-graphrag-python` - graph store plus retrievers; map its retriever types to
  "graph traversal" vs "vector top-k" above.
- `github.com/run-llama/llama_index` - the property-graph index; map it to the ingest column.
- `github.com/langchain-ai/langchain` - compare its RAG chains against the *agentic* loop.

## 6. Where a person decides

- What is the source of truth for a contested fact (the schema pack, the live DB, or a BRD).
- Whether a graph edge is real or assumed - the same organisational facts `/hk orient` refuses to
  guess (which database is authoritative, which columns the SAP move renamed).
- Nothing here runs against a database. If a design needs live counts to validate, that is a
  read-only query with the training login, run only when asked.
