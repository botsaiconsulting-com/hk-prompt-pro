#!/usr/bin/env bash
# Makes the copy handed to participants: main and every review/* branch, without the facilitator/ folder,
# with a fresh history. Run from anywhere inside the private test repository (Git Bash on Windows):
#
#   bash scripts/make-participant-copy.sh ../hk-participant
set -euo pipefail
SRC=$(git rev-parse --show-toplevel)
DEST=${1:?usage: make-participant-copy.sh <new folder>}
if [ -e "$DEST" ]; then echo "$DEST already exists; choose a new folder." >&2; exit 1; fi

mkdir -p "$DEST"
DEST=$(cd "$DEST" && pwd)
git -C "$SRC" archive main | tar -x -C "$DEST"
rm -rf "$DEST/facilitator"
sed -i.bak '/<!-- facilitator -->/,/<!-- \/facilitator -->/d' "$DEST/README.md" && rm -f "$DEST/README.md.bak"
sed -i.bak '/"Read(\/facilitator\/\*\*)",/d' "$DEST/.claude/settings.json" && rm -f "$DEST/.claude/settings.json.bak"

cd "$DEST"
git init -q -b main
git add -A
git commit -q -m "HK Supreme training repository (participant copy)"

for b in $(git -C "$SRC" for-each-ref --format='%(refname:short)' 'refs/heads/review/'); do
  git switch -q -c "$b" main
  git -C "$SRC" diff main "$b" -- . ':(exclude)facilitator' | git apply --index
  git commit -q -m "$(git -C "$SRC" log -1 --format=%s "$b")"
  git switch -q main
done

echo "Participant copy ready at $DEST"
git branch --list
