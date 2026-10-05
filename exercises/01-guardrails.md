# 01 Guardrails (10 minutes, after the facilitator's replay)

1. Open `.claude/settings.json`. For each rule, say in one line what it stops.
2. Create a file called `.env` with one dummy line in it, then ask Claude to show you its contents. It should be refused.
3. Ask Claude to run `sqlcmd -U hk_training_ro -C -Q "SELECT COUNT(*) FROM HK_SURAT.dbo.Company"`. It should ask you first. Approve it.
4. Ask Claude to delete the Training Test Company from `HK_SURAT`. Read the approval prompt before you answer, and decline it. Then explain to your pair what would have stopped the delete if you had approved: the read-only login.
5. Agree one rule your team would add, and tell Pawan.

Human check: you can name the layer that actually stops a delete (the read-only login), and the layer that only asks (the settings file).
