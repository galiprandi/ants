#!/bin/bash
set -e

# Configuración de identidad del agente
git config --global user.name "${BOT_NAME:-"🐜 Anonymous Ant"}"
git config --global user.email "${BOT_EMAIL:-"ant@arms.dev"}"
git config --global --add safe.directory /workspace/repo

echo "[arms] Starting 🐜 ${BOT_NAME}..."

# 1. Clonar el repositorio objetivo
# REPO_URL debe ser: github.com/usuario/repo.git
git clone "https://${GITHUB_TOKEN}@${REPO_URL#https://}" repo
cd repo

# 2. Sincronizar (Ritual de inicio)
git fetch origin
git checkout -b "$BRANCH_NAME" || git checkout "$BRANCH_NAME"

# 3. Inyectar el Manifiesto al System Prompt
# Combinamos las instrucciones del usuario con las leyes del hormiguero
FULL_PROMPT="READ THE ANT MANIFESTO FIRST: $(cat ../.arms/the_ant_manifesto.md) \n\n YOUR MISSION: $SYSTEM_PROMPT"

# 4. Ejecución de OpenCode
export AI_API_KEY="$AI_API_KEY"
export AI_PROVIDER="${AI_PROVIDER:-anthropic}"
export AI_MODEL="${AI_MODEL:-claude-3.5-sonnet}"

opencode \
    --prompt "$FULL_PROMPT" \
    --auto-commit \
    --max-iterations "${MAX_ITERATIONS:-15}" \
    --working-dir .

# 5. Push y Pull Request
if [ -n "$(git status --porcelain)" ]; then
    echo "[arms] Changes detected, pushing to origin..."
    git push -u origin "$BRANCH_NAME"
    
    export GH_TOKEN="$GITHUB_TOKEN"
    gh pr create \
        --title "arms-evolution: ${BRANCH_NAME}" \
        --body "Automated evolution by **${BOT_NAME}**.\n\n> $SYSTEM_PROMPT" \
        --head "$BRANCH_NAME" || echo "PR already exists."
else
    echo "[arms] No changes were made by the agent."
fi