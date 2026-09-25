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

# Anchored to a COMMAND position -- the start of the string, after a shell
# separator, or just inside an `-c` payload -- rather than to a mention
# anywhere in the text. The first version matched the raw command string and
# refused a command whose heredoc merely wrote these words into a document,
# which is the "hook disabled in frustration in week one" failure this kit
# spent a ticket avoiding. Narrowed rather than excepted, per ticket 16, and
# narrowed because it fired wrongly on the commit that installed it.
#
# Stated limit: this makes the act not-an-agent's; it does not defeat an agent
# determined to evade it. A verb buried in a nested quoting construct gets
# through, and nothing here checks for that. It rests where the rest of the
# gate rests -- on the owner reading the diff.
MERGE = re.compile(
    r"""(?:^|[;&|()\n]|-c\s*['"])\s*       # a command position
        (?:[A-Za-z_]\w*=\S*\s+)*           # leading VAR=value assignments
        (?: git\s+(?:-\S+\s+|--\S+\s+)*(?:merge|pull)
          | just\s+land
        )(?![\w-])""",
    re.X,
)

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
