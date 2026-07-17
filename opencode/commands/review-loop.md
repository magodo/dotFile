---
description: Implement a task, then iterate with the code-reviewer subagent until approved
agent: build
---

Implement the following task, then run a review loop until the reviewer approves.

TASK:
$ARGUMENTS

Review loop:
1. Invoke the `code-reviewer` subagent via the task tool. Pass it the full current `git diff` plus a short summary of what you changed (the subagent has no memory of prior rounds, so include the complete context every time).
2. If the reviewer's verdict is `VERDICT: APPROVED`, stop — the task is done.
3. If the verdict is `VERDICT: CHANGES_REQUESTED`, address every `[BLOCKING]` issue. For any point you disagree with, either fix it or record a one-line justification for why it is out of scope — never silently ignore it.
4. Re-run the review with the updated diff.
5. Repeat until `VERDICT: APPROVED` or you reach 5 rounds. If you hit 5 rounds without approval, stop and summarize the remaining disagreements for me to decide.

Do not consider the task complete until the reviewer approves or the 5-round cap is reached.
