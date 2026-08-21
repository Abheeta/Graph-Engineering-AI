#!/bin/bash
# Rebuild the queue from disk every time.
for f in source/*.md; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  [ -f "output/$name" ] || echo "$f"
done
