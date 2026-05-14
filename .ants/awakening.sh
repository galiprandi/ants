#!/bin/bash
set -e

# Configure agent identity
git config --global user.name "${BOT_NAME:-"🐜 Anonymous Ant"}"
git config --global user.email "${BOT_EMAIL:-"ant@arms.dev"}"
git config --global --add safe.directory /workspace/repo

echo "[ants] Starting 🐜 ${BOT_NAME}..."

# 1. Clone target repository
git clone "https://${GITHUB_TOKEN}@${REPO_URL#https://}" repo
cd repo

# 2. Sync (Ritual of initiation)
git fetch origin

# 3. Use SYSTEM_PROMPT directly (already concatenated from wake.sh)
FULL_PROMPT="$SYSTEM_PROMPT"

# 4. Execute OpenCode
export AI_API_KEY="$AI_API_KEY"
export AI_PROVIDER="${AI_PROVIDER:-anthropic}"
export AI_MODEL="${AI_MODEL:-claude-3.5-sonnet}"

opencode \
    --prompt "$FULL_PROMPT" \
    --auto-commit \
    --max-iterations "${MAX_ITERATIONS:-15}" \
    --working-dir .

# 5. Push and Pull Request (Carol chooses branch during work)
if [ -n "$(git status --porcelain)" ]; then
    echo "[ants] Changes detected, pushing to origin..."
    CURRENT_BRANCH=$(git branch --show-current)
    git push -u origin "$CURRENT_BRANCH"

    export GH_TOKEN="$GITHUB_TOKEN"
    gh pr create \
        --title "ants-evolution: ${CURRENT_BRANCH}" \
        --body "Automated evolution by **${BOT_NAME}**.\n\n> $SYSTEM_PROMPT" \
        --head "$CURRENT_BRANCH" || echo "PR already exists."
else
    echo "[ants] No changes were made by the agent."
fi