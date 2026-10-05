# Dummy Gati-style training databases

Three SQL Server databases that mirror the shape of HK Designs' post-SAP estate. Every customer, style, price and order is fictional.

| Database | Company | Notes |
|---|---|---|
| `HK_SURAT` | Surat Unit (training), plus an inactive Training Test Company | Has `usp_ArchiveCompany` |
| `HK_INDIA_A` | India Unit A (training) | |
| `HK_INDIA_B` | India Unit B (training) | |

Each folder holds the scripted objects, one file per object, in load order: `tables/`, `views/`, `procedures/`, `seed/`.

## Load (Docker, for testing on a laptop)

In PowerShell (in Git Bash, prefix the last command with `MSYS_NO_PATHCONV=1`, or Git Bash rewrites `/db/load.sh` into a Windows path):

```powershell
copy .env.example .env          # then set the three passwords in .env
docker compose up -d
docker compose exec sql bash /db/load.sh
```

The instance listens on `localhost,14330`. Participants and Claude connect only as `hk_training_ro`.

## Load (SQL Server Express on a training VM)

Run as an administrator, in this order: `00_create_databases.sql`; then for each company folder, every file in `tables/`, `views/`, `procedures/`, `seed/` against its database; then `security/create_readonly_login.sql` with `-v RO_PASSWORD="..."`. Example for one file:

```
sqlcmd -S <server> -U <admin> -C -b -d HK_SURAT -i db\company-surat\tables\01_Company.sql
```

Do not load the schema onto trainee laptops. On a local SQL Server Express or LocalDB install the laptop user is an administrator, so Windows authentication gets past the read-only login.

## Tests

`db/tests/*.test.sql` are known-answer tests that print `PASS` or `FAIL`. Run them with the read-only login:

```powershell
$env:SQLCMDSERVER = "localhost,14330"; $env:SQLCMDPASSWORD = "<read-only password>"
& "$env:ProgramFiles\Git\bin\bash.exe" db/tests/run-sql-tests.sh
```

Use Git Bash's `bash.exe` as shown: a plain `bash` in PowerShell can start WSL instead, which does not see `sqlcmd` or your variables.
