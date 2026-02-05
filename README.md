# Agent Skills Repository

This repository contains my global *Skills* and *Workflows* for AI agents (Antigravity, OpenCode, Gemini, Cursor).

## Structure

*   `agent/`: Configuration for Antigravity (`.agent`).
*   `opencode/`: Configuration for OpenCode (`.opencode`).
*   `gemini/`: Configuration for Gemini Agents (`.gemini`).
*   `cursor/`: Configuration template for Cursor (`.cursorrules`).

## Installation

Clone this repository and run the installation script appropriate for your operating system. This will copy the configurations to your `$HOME` directory.

### Windows (PowerShell)
```powershell
./install.ps1
```

### Linux / macOS (Bash)
```bash
chmod +x install.sh
./install.sh
```

## How to use in Cursor

Unlike Antigravity or OpenCode, Cursor primarily uses a `.cursorrules` file in the project root.
1. Run the installation script.
2. Copy the `.cursorrules` file from `~/.cursor-skills/.cursorrules` to your project root.
3. You can now use "virtual commands" in Cursor Chat or Composer:
   - Type `/review` to trigger a DDD code review.
   - Type `/commit` to trigger the Smart Commit flow.

## Maintenance

1.  Edit the skills in this repository.
2.  Commit and push to GitHub.
3.  Run the `install` script again to apply changes to your local environment.
