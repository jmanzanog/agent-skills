#!/bin/bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="$HOME"

echo -e "\033[1;33m--- Agent Skills Sync ---\033[0m"

# 1. Update from GitHub if possible
if [ -d "$REPO_ROOT/.git" ]; then
    echo -e "\033[0;36mChecking for updates in repository...\033[0m"
    cd "$REPO_ROOT"
    git pull origin main
fi

# 2. Sync folders to Home
FOLDERS=("agent" "opencode" "gemini" "cursor")

for folder in "${FOLDERS[@]}"; do
    SRC="$REPO_ROOT/$folder"
    
    if [ "$folder" == "cursor" ]; then
        DEST="$USER_HOME/.cursor-skills"
    else
        DEST="$USER_HOME/.$folder"
    fi
    
    if [ -d "$SRC" ]; then
        echo -e "\033[0;36mSyncing $folder config to $DEST...\033[0m"
        mkdir -p "$DEST"
        cp -R "$SRC/"* "$DEST/"
    fi
done

echo -e "\n\033[0;32mSuccess! Your global AI skills are updated and in sync.\033[0m"
echo "Note: For Cursor, copy .cursorrules from ~/.cursor-skills to your project root."
