#!/usr/bin/env bash
# Runs every db/tests/*.test.sql against the training instance with the READ-ONLY login.
# Each test file prints lines that start with PASS or FAIL. Exit code 1 if any FAIL or error.
#
# sqlcmd reads the server and password from SQLCMDSERVER and SQLCMDPASSWORD. Run it with Git Bash:
#   bash db/tests/run-sql-tests.sh
set -uo pipefail
SERVER=${SQLCMDSERVER:-localhost,14330}
LOGIN=${HK_SQL_LOGIN:-hk_training_ro}
cd "$(dirname "$0")"
fail=0
for f in *.test.sql; do
  if ! out=$(sqlcmd -S "$SERVER" -U "$LOGIN" -C -h -1 -W -b -i "$f" 2>&1); then
    echo "ERROR $f"; echo "$out"; fail=1; continue
  fi
  echo "$out" | grep -E '^(PASS|FAIL)' | sed "s|^|$f: |"
  if echo "$out" | grep -q '^FAIL'; then fail=1; fi
done
exit $fail
