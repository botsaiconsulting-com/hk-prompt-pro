# HK Supreme: PromptPro training repository

A small, self-contained copy of the kind of estate the HK Designs Software team works on, built for the one-day PromptPro Claude Code session and for testing the `/hk` command before it. Every name, price and order in it is fictional.

| Folder | What it is |
|---|---|
| `.claude/` | The `/hk` skill, the `hk-reviewer` agent, the team settings file, and an optional hook |
| `db/` | Three dummy Gati-style company databases (`HK_SURAT`, `HK_INDIA_A`, `HK_INDIA_B`) as scripted SQL, plus SQL tests |
| `legacy/sap/` | An SAP-era report to rebuild for Gati |
| `legacy/gati-handwritten/` | The team's first hand-written Gati version of that report |
| `src/api/` | .NET 8 API with xUnit tests |
| `src/web/` | React app (Vite, Vitest) with one legacy jQuery screen |
| `support/` | Gati known-issues library and sample tickets |
| `templates/` | The BRD and technical-spec format |
| `exercises/` | One task card per session, and their inputs |
| `context/`, `sql/`, `docs/`, `artefacts/` | Where `/hk` writes its outputs |

## Before you start

You need Git for Windows, Node.js 20 or later, the .NET 8 SDK, `sqlcmd`, Claude Code, and access to the training SQL Server instance.

1. In PowerShell, set the training server and the read-only password the facilitator gives you, in the same terminal you start Claude Code from:

   ```powershell
   $env:SQLCMDSERVER   = "<training server>,<port>"     # localhost,14330 for a laptop test
   $env:SQLCMDPASSWORD = "<read-only password>"
   ```

2. Check the connection: `sqlcmd -U hk_training_ro -C -Q "SELECT name FROM sys.databases"`
3. Build and test once:

   ```powershell
   dotnet test src/api/HK.Supreme.sln
   cd src/web; npm install; npm test; cd ../..
   ```

4. Start Claude Code in this folder (`claude`), type `/` and check that `/hk` is listed, then run `/hk orient .`.

## The guardrails in this repository

- You connect only as `hk_training_ro`, which can read and cannot write.
- `.claude/settings.json` asks before `sqlcmd` commands, blocks reading the files that hold connection details, blocks force-pushes and Docker, and switches off bypass and auto modes. These rules make Claude ask or stop; the read-only login is what actually prevents a write.
- Every change goes on a branch and gets a human review before it merges.

## Running the apps

- API: `dotnet run --project src/api/HK.Supreme.Api` (listens on `http://localhost:5080`)
- Web: `cd src/web; npm run dev`, then open `http://localhost:5173`. The legacy screen is at `/legacy/order-entry.html`.

## Setting up the training database

See `db/README.md`. For a laptop test, in PowerShell: copy `.env.example` to `.env` and set the passwords, then `docker compose up -d` and `docker compose exec sql bash /db/load.sh`.

