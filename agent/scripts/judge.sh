#!/bin/bash
# judge.sh <file>
FILE="$1"

[ -n "$FILE" ] || { echo "FAIL: no file"; exit 1; }
[ -s "$FILE" ] || { echo "FAIL: empty"; exit 1; }

grep -q '^## Summary[[:space:]]*$' "$FILE" || {
  echo "FAIL: missing section: Summary"
  exit 1
}

grep -q '^## Details[[:space:]]*$' "$FILE" || {
  echo "FAIL: missing section: Details"
  exit 1
}

if grep -q '^```' "$FILE"; then
  echo "FAIL: output wrapped in code fence"
  exit 1
fi

echo "PASS"
exit 0
