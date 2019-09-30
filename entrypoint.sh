#!/usr/bin/env bash

set -euo pipefail

case "$1" in
    propagate)
        tenpureto template propagate-changes \
            --template "https://github.com/${GITHUB_REPOSITORY}.git"  \
            --branch "${GITHUB_REF#refs/heads/}" \
            --pull-request \
            "$([[ -z "${PULL_REQUEST_LABEL}" ]] && true || echo "--pull-request-label ${PULL_REQUEST_LABEL}")" \
            --pull-request-assignee "${GITHUB_ACTOR}" \
            --unattended
esac
