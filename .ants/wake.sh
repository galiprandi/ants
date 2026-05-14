#!/bin/bash

# Script to wake ants from folder path
# Usage: ./.ants/wake.sh .ants/carol

ANT_PATH="$1"

if [ -z "$ANT_PATH" ]; then
    echo "❌ Error: You must specify the ant folder path"
    echo "Usage: ./.ants/wake.sh .ants/carol"
    exit 1
fi

if [ ! -d "$ANT_PATH" ]; then
    echo "❌ Error: Folder \"$ANT_PATH\" not found"
    exit 1
fi

# Load .env file if it exists
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

# Extract ant name from folder
ANT_NAME=$(basename "$ANT_PATH")

# Read brain.md and instinct.md
BRAIN=""
if [ -f "$ANT_PATH/brain.md" ]; then
    BRAIN=$(cat "$ANT_PATH/brain.md")
fi

INSTINCT=""
if [ -f ".ants/pheromones/instinct.md" ]; then
    INSTINCT=$(cat ".ants/pheromones/instinct.md")
fi

# Concatenate instinct + brain
SYSTEM_PROMPT="ANT INSTINCT (ABSOLUTE PRIORITY): $INSTINCT\n\n\nYOUR BRAIN (IDENTITY): $BRAIN"

echo "🌅 Waking ant: $ANT_NAME"
echo " Folder: $ANT_PATH"
echo ""

# Check required environment variables
if [ -z "$GITHUB_TOKEN" ]; then
    echo "⚠️  Warning: GITHUB_TOKEN is not configured"
fi

if [ -z "$AI_API_KEY" ]; then
    echo "⚠️  Warning: AI_API_KEY is not configured"
fi

if [ -z "$REPO_URL" ]; then
    echo "⚠️  Warning: REPO_URL is not configured"
fi

# Launch container
docker run --rm \
  -e GITHUB_TOKEN="${GITHUB_TOKEN}" \
  -e REPO_URL="${REPO_URL}" \
  -e AI_API_KEY="${AI_API_KEY}" \
  -e AI_PROVIDER="${AI_PROVIDER}" \
  -e AI_MODEL="${AI_MODEL}" \
  -e SYSTEM_PROMPT="$SYSTEM_PROMPT" \
  -e BOT_NAME="$ANT_NAME" \
  ants
