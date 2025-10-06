# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration written in Lua, using lazy.nvim as the plugin manager. The setup is designed as a full-featured IDE with support for multiple programming languages including TypeScript/JavaScript (both Node.js and Deno), Rust, Go, Python, Solidity, C/C++, C#, and Lua.

**Note**: This configuration uses Neovim 0.11+ and the new `vim.lsp.config` API instead of the deprecated `require('lspconfig')` framework.

## Architecture

The configuration follows a modular structure:

- **init.lua**: Entry point that requires settings, keybindings, and plugins
- **lua/settings.lua**: Editor options, autocmds, and global settings
- **lua/keybindings.lua**: All keybindings and mappings
- **lua/plugins.lua**: Plugin declarations using lazy.nvim
- **lua/plugins/**: Individual plugin configurations

### Plugin Management

The codebase uses lazy.nvim for plugin management. Plugins are declared in `lua/plugins.lua` with their configurations in `lua/plugins/*.lua` files. lazy.nvim automatically bootstraps itself on first run.

### Language Server Configuration

LSP setup is centralized in `lua/plugins/nvim-lspconfig.lua` using the new Neovim 0.11+ `vim.lsp.config` API. Key patterns:

- **New API**: Uses `vim.lsp.config.server_name = {}` instead of `require('lspconfig').server_name.setup({})`
- **Root markers**: Uses `root_markers` array instead of `lspconfig.util.root_pattern()`
- **Multi-runtime JavaScript/TypeScript**: Uses root markers to distinguish between ts_ls (Node.js projects with package-lock.json/yarn-lock.json) and denols (Deno projects with deno.lock/deno.jsonc)
- **Custom commands**: TypeScript and Go have custom `:OrganizeImports` commands
- **Python virtual environments**: Pyright is configured to use `./.venv/bin/python` relative to project root
- **Solidity**: Configured for both Hardhat and Foundry projects
- **Server activation**: All servers are enabled via `vim.lsp.enable()` call at the end of the file

### Formatting & Linting

- **Formatting**: Handled by conform.nvim (`lua/plugins/conform.lua`) with format-on-save and format-after-save for slow formatters. Python uses `uv run black`, TypeScript/Deno uses `deno fmt`, Solidity uses `forge fmt`.
- **Linting**: Managed by nvim-lint (`lua/plugins/nvim-lint.lua`) with automatic detection of Deno vs Node.js projects via file presence checks

### Key Features

- **Debugging**: DAP setup with vscode-js-debug for JavaScript/TypeScript
- **AI Integration**: Avante plugin configured with Ollama (qwen2.5-coder:14b model at localhost:11434)
- **Git**: Integration via vim-fugitive and gitsigns with extensive keybindings for staging, diffing, and hunk navigation
- **File Navigation**: Telescope with fzf-native extension, nvim-tree for file explorer
- **Tmux Integration**: vim-tmux-navigator for seamless pane navigation

## Common Development Tasks

### Testing Neovim Configuration

```bash
nvim --headless -c "Lazy! sync" -c "qa"  # Install/update plugins
nvim +checkhealth                         # Verify installation and dependencies
```

### Modifying LSP Configuration

When adding/modifying language servers in `lua/plugins/nvim-lspconfig.lua`:
1. Define configuration using `vim.lsp.config.server_name = {}` syntax
2. Include required fields: `cmd`, `capabilities`, and `filetypes`
3. Use `root_markers` array (not `root_dir` function) to detect project root
4. Set appropriate filetypes to avoid conflicts (especially for JS/TS)
5. Add the server name to the `vim.lsp.enable()` call at the end of the file

### Adding Formatters/Linters

- Add formatter to `formatters_by_ft` in conform.lua
- Add linter to `linters_by_ft` in nvim-lint.lua
- For custom formatters, define them in the `formatters` table (see forge, deno, black examples)

## Important Configuration Details

- **Leader key**: Space (`<Space>`)
- **Diagnostic displays**: Virtual text is disabled; diagnostics appear in floating windows on CursorHold
- **Undo persistence**: Stored in `~/.config/nvim/undodir`
- **Tab width**: Default 2 spaces (4 for Solidity, C#, Java, Python, Rust, PHP)
- **Python dependency management**: Uses `uv` for running black formatter
