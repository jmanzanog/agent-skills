# Agent Skills Repository

This repository contains my global *Skills* and *Workflows* for AI agents (Antigravity, OpenCode, Gemini).

## Structure

*   `agent/`: Configuration for Antigravity (`.agent`).
*   `opencode/`: Configuration for OpenCode (`.opencode`).
*   `gemini/`: Configuration for Gemini Agents (`.gemini`), including `GEMINI.md` (System Prompt) and `settings.json`.

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

## Maintenance

1.  Edit the skills in this repository.
2.  Commit and push to GitHub.
3.  Run the `install` script again to apply changes to your local environment.
