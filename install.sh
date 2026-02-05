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
    if [ "$folder" == "cursor" ]; then
        # 2.1 Sync CursorRules Template
        SRC_RULES="$REPO_ROOT/cursor/.cursorrules"
        DEST_RULES_DIR="$USER_HOME/.cursor-skills"
        if [ -f "$SRC_RULES" ]; then
            echo -e "\033[0;36mSyncing CursorRules template to $DEST_RULES_DIR...\033[0m"
            mkdir -p "$DEST_RULES_DIR"
            cp "$SRC_RULES" "$DEST_RULES_DIR/"
        fi

        # 2.2 Sync Cursor Native Skills
        SRC_SKILLS="$REPO_ROOT/cursor/skills-cursor"
        DEST_SKILLS="$USER_HOME/.cursor/skills-cursor"
        if [ -d "$SRC_SKILLS" ]; then
            echo -e "\033[0;36mSyncing Cursor Native Skills to $DEST_SKILLS...\033[0m"
            mkdir -p "$DEST_SKILLS"
            cp -R "$SRC_SKILLS/"* "$DEST_SKILLS/"
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
echo "Note: For Cursor, you can now use /code-review and /smart-commit in Chat."
echo "Note 2: You can also copy .cursorrules from ~/.cursor-skills to your project root."
