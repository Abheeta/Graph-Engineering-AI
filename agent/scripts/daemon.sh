#!/bin/bash
set -u

mkdir -p queue logs

while true; do
  if [ -s queue/rebuild_requests ]; then
    mv queue/rebuild_requests queue/processing
    ./scripts/rebuild.sh
    ./scripts/test_affected.sh queue/processing > logs/results.txt
    rm queue/processing
  fi
  sleep 10
done
