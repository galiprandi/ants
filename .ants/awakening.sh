#!/bin/bash
ANT_NAME=$1

if [ -z "$ANT_NAME" ]; then
    echo "Error: ANT_NAME parameter is required"
    echo "Usage: $0 <ant-name>"
    exit 1
fi

# Load .env file
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi

# Load brain.md as prompt if PROMPT not set
if [ -z "$PROMPT" ] && [ -f .ants/$ANT_NAME/brain.md ]; then
    PROMPT=$(cat .ants/$ANT_NAME/brain.md)
fi

echo "[ants] Starting ${ANT_NAME}..."

# Create temp directory if it doesn't exist
mkdir -p /tmp/ants

# Create a mktemp directory for the ant
ANT_DIR=$(mktemp -d /tmp/ants/ant-XXXXXXXX)
echo "[ants] Working in $ANT_DIR"

# Configure agent identity
git config --global user.name "${ANT_NAME:-"🐜 Anonymous Ant"}"
git config --global user.email "${BOT_EMAIL:-"ant@arms.dev"}"
git config --global --add safe.directory /workspace/anthill


# Configure git credentials for push (gh cli and opencode detect GITHUB_TOKEN automatically)
export GITHUB_TOKEN="$GITHUB_TOKEN"
git config --global credential.helper '!f() { echo "username=x-access-token"; echo "password=${GITHUB_TOKEN}"; }; f'

# Clone repository
rm -rf $ANT_DIR/ants
git clone https://github.com/galiprandi/ants.git $ANT_DIR

# Work in mounted repository
cd $ANT_DIR

echo "$PROMPT"

echo "[ants] Awakening complete!"

opencode run "$PROMPT" -m "$MODEL" --dir .
