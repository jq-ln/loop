# The command surface. If a command is worth documenting it is a recipe, not a
# line of prose, and a recipe that deletes no prose when it lands has not
# earned its place. `just --list` is the index; this file is outside the
# standing-claim budget because it is not prose.

set shell := ["bash", "-uc"]

_default:
    @just --list --unsorted

# Open a worktree for a ticket, after every check that is cheaper at the door.
start ticket:
    #!/usr/bin/env bash
    set -euo pipefail

    # core.hooksPath is not cloned, so a fresh clone is unprotected until
    # someone types a git config. This recipe is mandatory, so it is where the
    # assertion costs no artifact (ticket 16).
    test "$(git config core.hooksPath)" = ".githooks" || \
        { echo "core.hooksPath is not .githooks -- run: git config core.hooksPath .githooks"; exit 1; }

    file=$(ls .scratch/*/issues/{{ticket}}*.md .scratch/*/issues/*{{ticket}}*.md 2>/dev/null | head -1)
    test -n "$file" || { echo "no ticket file matching {{ticket}}"; exit 1; }

    # The declared file list, or no worktree. 31 of the first repo's 41 tickets
    # declared nothing, and tickets charted without the section kept merging
    # even after the rule landed. A list three commands read is a list that
    # gets written (ticket 10).
    files=$(awk '/^## Files/{f=1;next} f&&/^## /{exit} f&&/^```/{next} f&&NF{print}' "$file")
    test -n "$files" || { echo "$file has no ## Files block -- declare the files this ticket claims"; exit 1; }

    # The claim unit is the whole file. Git enforces files and nothing enforces
    # paragraphs, so two tickets that want the same file serialise.
    while read -r path; do
        for other in $(git worktree list --porcelain | awk '/^branch /{sub(/^branch refs\/heads\//,"");print}'); do
            of=$(ls .scratch/*/issues/*"${other#ticket-}"*.md 2>/dev/null | head -1) || true
            test -n "${of:-}" || continue
            if awk '/^## Files/{f=1;next} f&&/^## /{exit} f&&NF{print}' "$of" | grep -qxF "$path"; then
                echo "$path is claimed by $other ($of)"; exit 1
            fi
        done
    done <<< "$files"

    just _cap

    # ADRs citing a claimed path, surfaced automatically. Not a gate, just
    # output while the worktree opens (ticket 19).
    if [ -d docs/adr ]; then
        while read -r path; do
            grep -rls -- "$path" docs/adr/ 2>/dev/null | while read -r adr; do
                printf '  prior decision: %s\n' "$(sed -n '1s/^# //p' "$adr")"
            done
        done <<< "$files"
    fi

    branch="ticket-{{ticket}}"
    git worktree add "../loop-$branch" -b "$branch"
    sed -i '' 's/^Status: open$/Status: claimed/' "$file" 2>/dev/null || true
    echo "claimed $file on $branch"

# Widen this ticket's declared file list mid-ticket, with a dated record.
claim path:
    #!/usr/bin/env bash
    set -euo pipefail
    branch=$(git rev-parse --abbrev-ref HEAD)
    file=$(ls .scratch/*/issues/*"${branch#ticket-}"*.md 2>/dev/null | head -1)
    test -n "$file" || { echo "no ticket file for $branch"; exit 1; }

    for other in $(git worktree list --porcelain | awk '/^branch /{sub(/^branch refs\/heads\//,"");print}'); do
        test "$other" != "$branch" || continue
        of=$(ls .scratch/*/issues/*"${other#ticket-}"*.md 2>/dev/null | head -1) || true
        test -n "${of:-}" || continue
        if awk '/^## Files/{f=1;next} f&&/^## /{exit} f&&NF{print}' "$of" | grep -qxF "{{path}}"; then
            echo "{{path}} is claimed by $other -- revert and wait"; exit 1
        fi
    done

    # A rule with no way to record a considered exception does not stop the
    # exception, it grows case law. The frequency of these lines is the
    # evidence that the claim unit or the ceiling is wrong (ticket 10).
    printf '\n## Claim widened %s\n\n- `%s`\n' "$(date +%F)" "{{path}}" >> "$file"
    echo "claimed {{path}}"

# Empty by decision: what it runs means deciding the toolchain, which is the
# rebuild's business, not this kit's.
# The local gate.
check:
    @echo "nothing to run yet"

# The composite gesture. Merging is the human's; no agent runs this.
land:
    #!/usr/bin/env bash
    set -euo pipefail
    branch=$(git rev-parse --abbrev-ref HEAD)
    base=$(git merge-base main "$branch")

    git --no-pager diff --stat "$base..$branch"
    git --no-pager diff "$base..$branch"

    # Once per branch, immediately before the merge, unskippable. It returns no
    # pass and no fail: it is an input to my reading, not a substitute for it,
    # and a green report is what would license skipping the gate (ticket 17).
    claude -p "/code-review $base" || true

    file=$(ls .scratch/*/issues/*"${branch#ticket-}"*.md 2>/dev/null | head -1)
    declared=$(awk '/^## Files/{f=1;next} f&&/^## /{exit} f&&NF{print}' "$file" | tr -d '`')
    stray=''
    for touched in $(git diff --name-only "$base..$branch"); do
        echo "$declared" | grep -q "^${touched}$" && continue
        echo "$declared" | while read -r d; do case "$touched" in "$d"*) exit 3;; esac; done || continue
        stray="$stray $touched"
    done
    test -z "$stray" || echo "  stray paths, recorded in the merge commit:$stray"

    echo
    echo "  Break the code and watch a test go red. One test per merge."
    echo
    read -r -p "  Merge $branch? [y/N] " ok
    test "$ok" = y || exit 1
    msg="Merge $branch"
    if [ -n "$stray" ]; then
        msg="$msg"$'\n\n'"Stray paths outside the declared list:$stray"
    fi
    git checkout main
    git merge --no-ff "$branch" -m "$msg"

# Remove a worktree that will not land and release its claim.
drop ticket:
    #!/usr/bin/env bash
    set -euo pipefail
    branch="ticket-{{ticket}}"
    git worktree remove "../loop-$branch" --force
    git branch -D "$branch"
    file=$(ls .scratch/*/issues/{{ticket}}*.md 2>/dev/null | head -1)
    test -z "${file:-}" || sed -i '' 's/^Status: claimed$/Status: open/' "$file"
    echo "dropped $branch"

# An instrument: it gates nothing. If every recent ADR cites the same goal,
# the citation rule has become a stamp.
# GOALS.md beside the distribution of goal citations across the ADRs.
goals:
    @cat GOALS.md
    @echo
    @echo "  Goal citations across the ADRs:"
    @grep -rhoE '^Goal: G[0-9]+' docs/adr/ 2>/dev/null | sort | uniq -c | sed 's/^/   /' || echo "    none yet"

# No argument prints the corpus, because discovery is recognition and
# recognition needs a skimmable list -- and the length of this listing is the
# instrument that says the bar is mis-sized. It is generated from the
# directory, so it is not a file and cannot go stale.
# Find ADRs: no argument lists them, `new <slug>` scaffolds one, else search.
adr *args:
    #!/usr/bin/env bash
    set -uo pipefail
    mkdir -p docs/adr
    case "${1:-}" in
      "")
        find docs/adr -name '*.md' | sort | while read -r f; do
            printf '%s  %s  %s\n' "$(basename "$f" | cut -c1-10)" "$(sed -n '1s/^# //p' "$f")" "$f"
        done
        ;;
      new)
        test -n "${2:-}" || { echo "usage: just adr new <slug>"; exit 1; }
        out="docs/adr/$(date +%F)-$2.md"
        test ! -e "$out" || { echo "$out exists"; exit 1; }
        {
          printf '# %s\n\n' '<the decision, stated as a decision and not as a topic>'
          printf 'Goal: %s\n' '<the goal this serves, and what that goal ruled out.'
          printf '%s\n' 'If the goal was edited after the work it justifies, say so.>'
          printf 'Affected paths: %s\n\n' '<every path this decision binds, or nothing>'
          printf '%s\n' '<Why, in the past tense, against the world as it was on this date.'
          printf '%s\n' 'A dated record, never edited: superseded means deleted. Twenty'
          printf '%s\n' 'lines is not austere.>'
        } > "$out"
        echo "$out"
        ;;
      *)
        # Path first, then text. The path case is what `just start` consumes.
        grep -rls -- "$1" docs/adr/ 2>/dev/null | sort | while read -r f; do
            printf '%s  %s\n' "$f" "$(sed -n '1s/^# //p' "$f")"
        done
        ;;
    esac

# The count is generated, never written down. CLAUDE.md said the kit landed
# with 8 on a tree that has never held more than 7, and no .md has ever been
# deleted -- so it was wrong on the day it was typed, not drifted into. A
# number in prose has no way to be wrong out loud. The cap is read out of the
# hook that enforces it rather than repeated here, so there is exactly one
# place to turn it.
# What each file owns, and how much of the cap is spent. Both generated.
owns:
    #!/usr/bin/env bash
    set -uo pipefail
    governed=$(git ls-files \
        | grep -E '^([^/]+|docs/.+|\.claude/.+)\.md$' | grep -vE '^docs/adr/' | sort)
    while read -r f; do
        test -n "$f" || continue
        printf '\n%s\n' "$f"
        awk '/^# /{h=1;next} h&&/^## /{exit} h&&NF{p=1;print "    " $0;next} h&&p{exit}' "$f"
    done <<< "$governed"
    printf '\n  %s of %s standing-claim files.\n' \
        "$(printf '%s\n' "$governed" | grep -c .)" \
        "$(sed -n 's/^CAP=\([0-9]*\)$/\1/p' .githooks/pre-commit)"

# The stall made visible at the moment it costs something.
# The worktree cap, shared by `start` and the pre-commit hook.
_cap:
    #!/usr/bin/env bash
    set -euo pipefail
    n=$(( $(git worktree list --porcelain | grep -c '^worktree ') - 1 ))
    test "$n" -le 3 || {
        echo "  Blocked: $n worktrees other than the main one, cap is 3"
        git worktree list | tail -n +2 | while read -r _p sha branch; do
            printf '    %-24s %-16s %s\n' "${branch:-detached}" \
                "$(git log -1 --format=%cr "$sha" 2>/dev/null)" \
                "$(git log -1 --format=%s "$sha" 2>/dev/null | cut -c1-48)"
        done
        echo "  Read one and land it, or just drop <ticket>."
        exit 1
    }
