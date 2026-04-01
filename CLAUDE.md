# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using Lua, built on [lazy.nvim](https://github.com/folke/lazy.nvim) with ~72 plugins. The goal is a productive IDE-like experience for daily development.

## Development Commands

- `nvim` — launch and validate changes interactively (no automated test suite)
- `just --list` — list available helper tasks
- `just prepare_deps` — install OS-level dependencies (Linux/macOS)
- `bash tools/upgrade_config.sh` — upgrade config tooling (review before running)

## Architecture

### Entry Point Flow

```
init.vim
  └── lua/init.lua          # version check, platform detection, clipboard, lazy.nvim bootstrap
        ├── setup.lua        # vim options, leader key (`;`), Python path detection
        ├── custom_filetype.lua
        ├── plugins/         # lazy.nvim loads all files in this directory
        ├── my_utils.lua
        ├── themes.lua
        ├── keymap.lua       # core keybindings
        └── autocommands.lua
```

### Plugin Directory (`lua/plugins/`)

Each file is a lazy.nvim plugin spec table. Key files:

| File | Responsibility |
|---|---|
| `lsp.lua` | LSP server setup via nvim-lspconfig |
| `nvim-cmp.lua` / `blink.cmp.lua` | Completion engines |
| `snips.lua` | LuaSnip snippet engine |
| `copilot.lua` | AI inline suggestions + codecompanion.nvim chat |
| `navigator.lua` | Telescope fuzzy finder |
| `formatter.lua` | Code formatting |
| `layout.lua` | neo-tree, trouble, window layout |
| `mason.lua` | LSP/tool installer |
| `legacy.lua` | Older plugin configs kept for reference |

### AI Integration

- **codecompanion.nvim** — chat/inline strategy, uses `AIDOKI_AUTH_TOKEN` env var with an OpenAI-compatible API (`https://api.aidoki.cn`). Enabled only when the env var is set.
- **copilot** — currently disabled (`enabled = false`) for both `github/copilot.vim` and `zbirenbaum/copilot.lua` because the Copilot subscription is inactive.

### Key Conventions

- Leader key: `;`
- 2-space indentation throughout Lua code
- Plugin enable/disable logic uses helper functions at the top of `copilot.lua` (checking file existence or env vars) — follow this pattern for conditional plugins
- Formatter/linter presets live in `resources/` (clang-format, yapf, pycodestyle)
- Snippets: `snips/` (snipmate + vscode formats); file templates in `templates/`

## Reference

- `CHEATSHEET.md` — full keybinding reference for all plugins
- `docs/vim.md` — additional usage notes
