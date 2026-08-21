# Tiny Graph Agent

A deliberately small learning project inspired by the graph-building workflow:
- deterministic judge
- rulebook
- queue rebuilt from disk
- Claude worker loop
- independent reviewers
- cheap checks inside the loop
- optional expensive check outside it
- serialized rebuild daemon

## What it does

It converts small Markdown source files into normalized Markdown outputs.

The rulebook says:
- preserve the source title, or use the filename if missing
- include `## Summary`
- include `## Details`
- never invent facts
- use ISO dates (`YYYY-MM-DD`) when dates appear
- flag missing titles with `TODO(agent): ...`

The `judge.sh` script checks the output mechanically.

## Folder

```text
agent/
├── source/
├── output/
├── rules/
├── scripts/
└── logs/
```

## Prerequisites

Run this in Git Bash (or WSL) because the scripts are Bash scripts.

You also need the Claude CLI available as `claude`.

## Try the judge first

```bash
cd agent
./scripts/judge.sh output/known_good.md
cp output/known_good.md /tmp/broken.md
sed -i 's/## Summary//' /tmp/broken.md
./scripts/judge.sh /tmp/broken.md
```

The first command should print `PASS`; the broken file should print `FAIL: missing section`.

## Run one worker batch

```bash
./scripts/run.sh
```

Then inspect:

```bash
ls output/
cat logs/failed.txt
```

The queue is based only on whether an output file exists, so deleting an output makes that item pending again.

## Run until complete

```bash
while [ -n "$(./scripts/queue.sh)" ]; do
  ./scripts/run.sh
done
```

## Review

```bash
./scripts/review.sh output/item1.md
```

This launches two fresh Claude sessions and compares their findings.

## Model choice

The example uses Sonnet for high-volume workers and Opus for disagreement resolution/review. Change the model names if your installed Claude CLI uses different model identifiers.

This is intentionally tiny. The point is to learn the architecture, not to build a production agent framework.
