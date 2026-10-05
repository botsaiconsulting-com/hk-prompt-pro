# Optional hook (second layer, after the day)

`block-destructive-sql.ps1` blocks any `sqlcmd`, `Invoke-Sqlcmd`, `osql`, `bcp` or `sqlpackage` command that contains a write keyword, or that does not name the read-only login with `-U hk_training_ro` (which also closes the Windows-authentication route on a laptop with its own SQL Server). It fails closed: if it cannot read the command, it blocks.

To turn it on, merge `settings.hooks.example.json` into `.claude/settings.json`. It reads only the command line, not a script passed with `-i`, so the read-only login stays the real wall. Dry-run it on a Windows laptop before relying on it.
