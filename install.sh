#!/bin/bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="$HOME"

echo "Installing Agent Skills from: $REPO_ROOT"
echo "Target: $USER_HOME"

# 1. Install .agent
AGENT_SRC="$REPO_ROOT/agent"
AGENT_DEST="$USER_HOME/.agent"
if [ -d "$AGENT_SRC" ]; then
    echo "Syncing .agent..."
    mkdir -p "$AGENT_DEST"
    cp -R "$AGENT_SRC/"* "$AGENT_DEST/"
fi

# 2. Install .opencode
OPENCODE_SRC="$REPO_ROOT/opencode"
OPENCODE_DEST="$USER_HOME/.opencode"
if [ -d "$OPENCODE_SRC" ]; then
    echo "Syncing .opencode..."
    mkdir -p "$OPENCODE_DEST"
    cp -R "$OPENCODE_SRC/"* "$OPENCODE_DEST/"
fi

echo "Installation Complete! Skills are now available globally."
echo "Restart your IDE/Agent to pick up changes."
