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
        tenpureto template propagate-branch-changes \
            --template https://github.com/${GITHUB_REPOSITORY}.git  \
            --branch ${GITHUB_REF#refs/heads/} \
            --pull-request \
            --pull-request-label ${AUTOMERGE_LABEL} \
            --pull-request-assignee ${GITHUB_ACTOR} \
            --unattended \
            --debug
esac
