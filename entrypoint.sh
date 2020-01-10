#!/usr/bin/env bash

set -euo pipefail

case "$1" in
    propagate)
        ARGS=(--template "https://github.com/${GITHUB_REPOSITORY}.git" --branch "${GITHUB_REF#refs/heads/}" --pull-request --unattended)
        if [[ ! -z "${PULL_REQUEST_LABEL}" ]]; then
            ARGS+=(--pull-request-label "${PULL_REQUEST_LABEL}")
        fi
        if [[ "$(hub api "/users/${GITHUB_ACTOR}" | jq -r .type)" = "User" ]]; then
            ARGS+=(--pull-request-assignee "${GITHUB_ACTOR}")
        fi
        echo Running tenpureto template propagate-changes "${ARGS[@]}"
        tenpureto template propagate-changes "${ARGS[@]}"
esac
