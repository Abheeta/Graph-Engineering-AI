# Rulebook

## Output format
- One output file per input.
- Keep the input filename.
- Output must be Markdown.
- Do not wrap the whole output in a code fence.

## Content
- Preserve the source title when it exists.
- If the source has no title, use the filename as the title and add `TODO(agent): missing source title`.
- Every output must contain `## Summary`.
- Every output must contain `## Details`.
- Do not invent facts that are absent from the source.

## Conventions
- Dates must use `YYYY-MM-DD`.
- Keep the source's facts concise.
- Do not add a References section unless the source has references.

## Edge cases
- If the source is empty, do not create an output; report the problem.
- If the source is missing a title, continue after flagging it.
- If the source is over 5000 words, split processing at top-level headings.

## When you cannot proceed
Write `TODO(agent): <reason>` in place and continue where possible.
