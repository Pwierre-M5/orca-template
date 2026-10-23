#!/usr/bin/env bash
# Règles de branche partagées par pre-commit et pre-push.
# Format : <type>/<id>-<slug>, id Linear (pwi-25) ou id court Orca (t042).
BRANCH_REGEX='^(feat|fix|refactor|docs|test|chore)/([a-z]+-[0-9]+|t[0-9]+)-[a-z0-9]+(-[a-z0-9]+)*$'
BRANCH_EXCEPTIONS='^chore/bootstrap-gouvernance$'
PROTECTED_REGEX='^(main|master)$'

check_branch() {
  local b="$1" slug
  if [[ "$b" =~ $PROTECTED_REGEX ]]; then
    echo "Refusé : aucun commit ni push direct sur '$b'. Créez une branche de tâche." >&2
    return 1
  fi
  [[ "$b" =~ $BRANCH_EXCEPTIONS ]] && return 0
  if ! [[ "$b" =~ $BRANCH_REGEX ]]; then
    echo "Refusé : '$b' ne respecte pas <type>/<id>-<slug> (ex. feat/pwi-25-responsive)." >&2
    return 1
  fi
  slug="${b#*/}"; slug="${slug#*-}"; [[ "$slug" =~ ^[0-9]+- ]] && slug="${slug#*-}"
  if (( ${#slug} > 40 )); then
    echo "Refusé : slug de plus de 40 caractères dans '$b'." >&2
    return 1
  fi
  return 0
}
