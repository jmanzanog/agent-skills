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

# 2. Sync Folders
FOLDERS=("agent" "opencode" "gemini" "cursor")

for folder in "${FOLDERS[@]}"; do
    if [ "$folder" == "cursor" ]; then
        # 2.1 Sync Cursor Commands (Global)
        SRC_COMMANDS="$REPO_ROOT/cursor/commands"
        DEST_COMMANDS="$USER_HOME/.cursor/commands"
        if [ -d "$SRC_COMMANDS" ]; then
            echo -e "\033[0;36mSyncing Global Cursor Commands...\033[0m"
            mkdir -p "$DEST_COMMANDS"
            cp -R "$SRC_COMMANDS/"* "$DEST_COMMANDS/"
        fi

        # 2.2 Sync CursorRules Template
        SRC_RULES="$REPO_ROOT/cursor/.cursorrules"
        DEST_RULES_DIR="$USER_HOME/.cursor-skills"
        if [ -f "$SRC_RULES" ]; then
            echo -e "\033[0;36mSyncing .cursorrules template to ~/.cursor-skills...\033[0m"
            mkdir -p "$DEST_RULES_DIR"
            cp "$SRC_RULES" "$DEST_RULES_DIR/"
        fi
    else
        SRC="$REPO_ROOT/$folder"
        DEST="$USER_HOME/.$folder"
        if [ -d "$SRC" ]; then
            echo -e "\033[0;36mSyncing .$folder to user home...\033[0m"
            mkdir -p "$DEST"
            cp -R "$SRC/"* "$DEST/"
        fi
    fi
done

echo -e "\n\033[0;32mSuccess! Your global AI skills are updated and in sync.\033[0m"
echo "Note: For Cursor, you can now use /review and /commit in Chat globally."
