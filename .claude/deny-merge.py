#!/usr/bin/env python3
"""Refuse a merge performed by an agent.

The merge commit is the repository owner's signature that they read the diff
(PROCEDURE.md, "The gate"). Every other rule in this kit is enforced by git,
because git sees the commit; this one cannot be, because the thing being
asserted is that a particular human looked. So it is enforced by the harness
instead: the tooling refuses, rather than the agent's own good intentions.

Reads a PreToolUse payload on stdin. Exit 2 blocks the call and shows stderr
to the agent.
"""
import json
import re
import sys

MERGE = re.compile(r"\bgit\s+(-\S+\s+|--\S+\s+)*(merge|pull)\b|\bjust\s+land\b")

try:
    payload = json.load(sys.stdin)
except (json.JSONDecodeError, ValueError):
    sys.exit(0)

command = payload.get("tool_input", {}).get("command", "")

if MERGE.search(command):
    sys.stderr.write(
        "Refused: the merge is the repository owner's gesture.\n\n"
        "The merge commit is their signature that they read the diff. No agent "
        "performs a merge, and no agent asks for permission to. Stop here, say "
        "what the branch does, and let them run `just land`.\n"
    )
    sys.exit(2)

sys.exit(0)
