# HK Supreme training repository

Training copy of an HK Designs Software team codebase, with dummy data only. Used in PromptPro with the `/hk` command.

- `src/web`: React front end (Vite). `src/web/legacy`: one legacy jQuery screen.
- `src/api`: .NET 8 API (`HK.Supreme.sln`), with xUnit tests.
- `db/`: scripted SQL objects for the three company databases, one file per object. `db/tests`: SQL known-answer tests.
- `legacy/sap`: an SAP-era report being rebuilt for Gati. `legacy/gati-handwritten`: the team's first hand-written Gati version.
- `support/known-issues.md`: the Gati known-issues library. `templates/brd.md`: the team's BRD and spec format.

Database access: the training instance named in the `SQLCMDSERVER` environment variable (`localhost,14330` for a laptop test), read-only login `hk_training_ro`. The password is in `SQLCMDPASSWORD`; never ask for it, print it or write it to a file. Always pass the login explicitly:

    sqlcmd -U hk_training_ro -C -d HK_SURAT -i <file.sql>

Never change data or schema. Never use Docker, an administrator login or Windows authentication against any database.

Run `/hk orient .` to add the `## Working at HK` section below.
