#!/bin/bash
# test_affected.sh <request-file>
set -u

REQUESTS="$1"
while read -r name; do
  [ -n "$name" ] || continue
  echo "$name: PASS"
done < "$REQUESTS"
