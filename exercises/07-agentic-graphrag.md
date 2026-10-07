# 07 Agentic GraphRAG - knowledge graphs + vectors (Advanced track)

Read `docs/modules/agentic-graphrag.md` first. No code ships from this card: you design against the
HK estate and compare with real projects. Work in pairs.

1. Open `context/schema/orders.md` (run `/hk schema orders` first if it is not there) and
   `support/known-issues.md`. Ask Claude: "Propose a node-and-edge model where tables, columns,
   companies and known-issues are nodes. Give me one table of node types and one of edge types, each
   row citing the `file` or `table.column` it came from, and mark anything assumed."
2. Pick the card-02 question - which price column the monthly sales report must use. Ask Claude which
   exact graph edges and which support entries a GraphRAG retriever would have to surface to answer it
   with citations. Check each `table.column` and `KI-id` it names is real.
3. Ask Claude for one HK question where a pure vector search beats the graph, and one where the graph
   beats vectors. Say why in your own words.
4. Ask Claude to fetch the `github.com/microsoft/graphrag` README and map its entities / relationships
   / communities onto your node-and-edge model from step 1. Where does it not fit the HK estate?
5. Write your model and findings to `docs/modules/graphrag-design.md`. Nothing runs against a
   database.

Human check: you can name one fact the graph gives that vectors can't (a cross-company column mapping
or an FK join) and one the vectors give that the graph can't (a ticket in the user's words), and every
node your model claims points at a real `table.column` or `KI-id`.
