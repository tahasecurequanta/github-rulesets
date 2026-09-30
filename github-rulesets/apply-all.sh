#!/usr/bin/env bash
# Usage: ./apply-all.sh OWNER/REPO
set -e
REPO="$1"
[ -z "$REPO" ] && { echo "Usage: $0 OWNER/REPO"; exit 1; }
for f in protect-main protect-release-branches protect-tags branch-naming commit-hygiene push-safety; do
  echo "Applying $f ..."
  gh api --method POST -H "Accept: application/vnd.github+json" \
    "/repos/$REPO/rulesets" --input "$f.json" >/dev/null && echo "  done" || echo "  FAILED (check plan/fields)"
done
