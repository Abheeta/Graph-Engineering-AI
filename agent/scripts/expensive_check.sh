#!/bin/bash
# Simulated expensive workspace check.
# In a real project this could be a full compiler/test/build.
set -u

errors=0

for f in output/*.md; do
  [ -f "$f" ] || continue
  if ! ./scripts/judge.sh "$f" >/dev/null; then
    echo "$f: judge failure"
    errors=$((errors + 1))
  fi
done

echo "expensive_check: $errors failure(s)"
exit "$errors"
