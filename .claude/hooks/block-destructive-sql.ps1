# PreToolUse hook: blocks a SQL tool call that writes, or that does not name the read-only login.
# Exit code 2 blocks the call. Any error inside the script also blocks (fails closed).
try {
  $payload = [Console]::In.ReadToEnd() | ConvertFrom-Json
  $cmd = [string]$payload.tool_input.command
  $sqlTool = $cmd -match '(?i)(sqlcmd|invoke-sqlcmd|osql|bcp|sqlpackage)'
  if (-not $sqlTool) { exit 0 }
  if ($cmd -match '(?i)\b(DELETE|UPDATE|INSERT|MERGE|TRUNCATE|DROP|ALTER|CREATE|GRANT|EXEC)\b') {
    [Console]::Error.WriteLine("Blocked by the team hook: this command could change data or schema. Write the SQL to a file for a person to review instead.")
    exit 2
  }
  if ($cmd -notmatch '(?i)-U\s+hk_training_ro\b') {
    [Console]::Error.WriteLine("Blocked by the team hook: SQL tools must name the read-only login with -U hk_training_ro (no Windows authentication, no other login).")
    exit 2
  }
  exit 0
} catch {
  [Console]::Error.WriteLine("Blocked by the team hook: could not check this command ($($_.Exception.Message)).")
  exit 2
}
