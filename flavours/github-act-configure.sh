#!/bin/sh
# Assuming this script is called after create-runner.sh with the pot setup

# Source the configuration file if it exists
CONFIG_FILE="/root/github-config"
if [ -f "$CONFIG_FILE" ]; then
    . "$CONFIG_FILE"
    cat "$CONFIG_FILE"
fi

CHERIBSD_BUILD_ID="${CHERIBSD_BUILD_ID:-$(uname -a | grep -iEo "releng/\w{1,}.\w{1,}" | cut -d "/" -f 2)}"
# Configure the runner
cd /root/runner || return 1
GODEBUG="asyncpreemptoff=1" /usr/local64/bin/github-act-runner configure \
    --url "${GITHUB_URL}" \
    --token "${GITHUB_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --labels cheribsd,"cheribsd-${CHERIBSD_BUILD_ID}" \
    --unattended

echo "GitHub Actions runner configured for ${RUNNER_NAME}"
