#!/bin/bash
set -u

BATCH="${BATCH:-2}"
mkdir -p output logs

./scripts/queue.sh | head -n "$BATCH" | while read -r f; do
  name=$(basename "$f")
  echo "Processing $f"

claude -p "Read rules/rulebook.md. Process $f. Write the final Markdown result to output/$name." \
  --model sonnet \
  --permission-mode acceptEdits
  
  if ./scripts/judge.sh "output/$name"; then
    echo "$name PASS" >> logs/results.txt
  else
    echo "$name FAIL" >> logs/failed.txt
  fi
done
