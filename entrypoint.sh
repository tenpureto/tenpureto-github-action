#!/usr/bin/env bash

set -euo pipefail

case "$1" in
    propagate)
        # This is a workaround for https://github.com/github/hub/issues/2149
        mkdir -p ~/.config
        echo "github.com:"                    >> ~/.config/hub
        echo "- user: github-actions"         >> ~/.config/hub
        echo "  oauth_token: ${GITHUB_TOKEN}" >> ~/.config/hub
        echo "  protocol: https"              >> ~/.config/hub
        tenpureto template propagate-changes \
            --template https://github.com/${GITHUB_REPOSITORY}.git  \
            --branch ${GITHUB_REF#refs/heads/} \
            --pull-request \
            $([[ -z "${PULL_REQUEST_LABEL}" ]] && true || echo "--pull-request-label ${PULL_REQUEST_LABEL}") \
            --pull-request-assignee ${GITHUB_ACTOR} \
            --unattended
esac
