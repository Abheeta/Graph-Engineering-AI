#!/bin/bash
set -u

FILE="$1"
[ -f "$FILE" ] || { echo "Usage: ./scripts/review.sh output/item1.md"; exit 1; }

mkdir -p logs

for n in 1 2; do
  claude -p "Read rules/rulebook.md. Review $FILE against those rules only.
For each problem output exactly:
RULE: <rule violated> | ISSUE: <what is wrong>
If nothing violates a rule, output PASS.
Do not rewrite the file."     --model sonnet > "logs/review_$n.txt"
done

if diff -q logs/review_1.txt logs/review_2.txt >/dev/null; then
  echo "REVIEWERS AGREE"
  cat logs/review_1.txt
else
  echo "REVIEWERS DISAGREE; asking a fresh session to resolve"
  claude -p "Two independent reviewers disagree about $FILE.
Reviewer 1:
$(cat logs/review_1.txt)

Reviewer 2:
$(cat logs/review_2.txt)

Read rules/rulebook.md and decide which findings are real.
Return only the final findings."     --model opus > logs/review_final.txt
  cat logs/review_final.txt
fi
