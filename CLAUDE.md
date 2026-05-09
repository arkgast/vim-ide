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
- **Root markers**: Uses `root_markers` array with `.git` as fallback for better project detection. No dependency on `lspconfig.util` — root resolution uses built-in `vim.fs.root` when a function form is required.
- **Workspace required**: Most servers set `workspace_required = true` so they don't attach to single files outside a project root.
- **Multi-runtime JavaScript/TypeScript**: Disambiguates via root detection:
  - `ts_ls`: uses a `root_dir` function that returns nil if a Deno marker is found, otherwise resolves `package.json` / `tsconfig.json` / `jsconfig.json` / `.git`
  - `denols`: `root_markers = { "deno.json", "deno.jsonc", "deno.lock" }`
  - `denols` also installs a per-client `textDocument/publishDiagnostics` handler that filters TS error 2686 ("React must be in scope") for Preact/Fresh projects
- **Custom commands**: TypeScript and Go have custom `:OrganizeImports` commands
- **Python**: Improved Pyright configuration with better root detection and analysis settings
- **Rust**: Enhanced rust-analyzer with `cargo.allFeatures` enabled
- **Go**: Extended filetypes to include `gomod`, `gowork`, `gotmpl`
- **Solidity**: Configured for both Hardhat and Foundry projects
- **C/C++**: clangd configured to detect `compile_commands.json`, `compile_flags.txt`
- **Server activation**: All servers are enabled via `vim.lsp.enable()` call at the end of the file
- **Inlay Hints**: Configured for all supported language servers (TypeScript, Deno, Go, Python, C/C++, Lua) with automatic enabling on LspAttach
- **Codelens**: Configured for Go and Lua language servers with auto-refresh on buffer enter, cursor hold, and insert leave events

### Formatting & Linting

- **Formatting**: Handled by conform.nvim (`lua/plugins/conform.lua`) with format-on-save and format-after-save for slow formatters. Python uses `uv run black`, TypeScript/Deno uses `deno fmt`, Solidity uses `forge fmt`, Nginx uses `nginxfmt` (installed via `pip3 install nginxfmt` in setup.sh).
- **Linting**: Managed by nvim-lint (`lua/plugins/nvim-lint.lua`) with automatic detection of Deno vs Node.js projects via file presence checks

### Key Features

- **Treesitter**: Comprehensive syntax tree parsing with:
  - Advanced text objects (select, swap, move functions/classes/parameters/etc.)
  - Smart refactoring (highlight definitions, smart rename, navigation)
  - Context awareness (shows current function/class at top of window)
  - Rainbow delimiters for nested code visualization
  - Auto-tagging for HTML/JSX files
  - Treesitter-based folding
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
- **Tab width**: Default 2 spaces (4 for Solidity, C#, Java, Python, Rust, PHP). Nginx and Make use literal tabs (`noexpandtab`) with width 4.
- **Python dependency management**: Uses `uv` for running black formatter

## Treesitter Keybindings

### Text Object Selection (Visual/Operator-pending mode)
- `af`/`if`: Select outer/inner function
- `ac`/`ic`: Select outer/inner class
- `ai`/`ii`: Select outer/inner conditional
- `al`/`il`: Select outer/inner loop
- `aa`/`ia`: Select outer/inner parameter
- `ab`/`ib`: Select outer/inner block
- `aF`/`iF`: Select outer/inner call
- `a/`/`i/`: Select outer/inner comment

### Text Object Movement
- `]f`/`[f`: Next/previous function start
- `]c`/`[c`: Next/previous class start
- `]a`/`[a`: Next/previous parameter
- `]i`/`[i`: Next/previous conditional
- `]l`/`[l`: Next/previous loop
- `]s`/`[s`: Next/previous scope
- Capital letters (e.g., `]F`, `[F`) jump to end instead of start

### Text Object Swapping
- `<leader>sp`: Swap parameter with next
- `<leader>sP`: Swap parameter with previous
- `<leader>sf`: Swap function with next
- `<leader>sF`: Swap function with previous

### Refactoring
- `grr`: Smart rename (treesitter scope-aware)
- `gnd`: Go to definition (treesitter)
- `gnD`: List all definitions
- `gO`: List definitions as TOC
- `]r`/`[r`: Next/previous reference

### Peeking Definitions
- `<leader>pf`: Peek function definition
- `<leader>pc`: Peek class definition

### Incremental Selection
- `<CR>`: Init/expand selection
- `<S-CR>`: Expand scope
- `<BS>`: Shrink selection

## LSP Keybindings

### Core LSP Actions
- `gD`: Go to declaration
- `gd`: Go to definition
- `gi`: Go to implementation
- `gr`: Show references
- `gt`: Go to type definition
- `ga`: Show code actions
- `<leader>oi`: Organize imports (TypeScript/JavaScript/Go/Python)
- `<leader>rn`: Rename symbol
- `<leader>i`: Show hover information
- `<C-i>`: Show signature help
- `<leader>=`: Format buffer (async)
- `<leader>e`: Open diagnostic float
- `<leader>l`: Set diagnostic loclist
- `[d`: Go to previous diagnostic
- `]d`: Go to next diagnostic

### Inlay Hints
- `<leader>th`: Toggle inlay hints for current buffer

**Note**: Inlay hints are initialized but disabled by default when an LSP server attaches. Use `<leader>th` to toggle them on/off. Supported servers include:
- **TypeScript/JavaScript (ts_ls)**: Parameter names, types, return types, enum values, property types, variable types
- **Deno (denols)**: Parameter names, types, return types, enum values, property types, variable types
- **Go (gopls)**: Variable types, literal field names, literal types, constant values, type parameters, parameter names, range variable types
- **Python (pyright)**: Variable types, return types, call argument names, parameter types
- **C/C++ (clangd)**: Designators, parameter names, deduced types
- **Lua (lua_ls)**: Parameter names, parameter types, variable types, semicolons, array indices

### Codelens
- `<leader>cl`: Run codelens action under cursor
- `<leader>cL`: Refresh codelens

**Note**: Codelens are automatically refreshed on buffer enter, cursor hold, and insert leave events. Supported servers:
- **Go (gopls)**: Generate, regenerate cgo, tidy, upgrade dependency, vendor, gc details
- **Lua (lua_ls)**: Various Lua-specific code lenses

### Organize Imports
- `<leader>oi`: Organize imports (keybinding)
- `:OrganizeImports`: Organize imports (command)

**Supported Languages**:
- **TypeScript/JavaScript (ts_ls)**: Uses `_typescript.organizeImports` command to sort and remove unused imports
- **Go (gopls)**: Uses `source.organizeImports` code action to organize imports with goimports logic
- **Python (pyright)**: Uses `pyright.organizeimports` command to organize Python imports

The organize imports function automatically detects the current buffer's filetype and calls the appropriate language server command.

## Session Manager Keybindings

Capital `S` prefix is used to avoid clash with treesitter swap mappings on `<leader>s{p,P,f,F}`.

- `<leader>Sl`: Load last session
- `<leader>Ss`: Save current session
- `<leader>Sd`: Delete session

## Rust Cargo.toml Keybindings (crates.nvim)

**Note**: crates.nvim now uses an in-process LSP server for all functionality (completion, hover, code actions). The deprecated null_ls and cmp source integrations have been removed.

When editing `Cargo.toml` files, the following keybindings are available:

### Show Information
- `K`: Show crate popup with info
- `gd`: Show versions popup
- `<leader>ct`: Toggle crates.nvim
- `<leader>cr`: Reload crates information

### Version Popups
- `<leader>cv`: Show versions popup
- `<leader>cf`: Show features popup
- `<leader>cd`: Show dependencies popup

### Update Crates
- `<leader>cu`: Update crate under cursor (normal) / selected crates (visual)
- `<leader>ca`: Update all crates
- `<leader>cU`: Upgrade crate under cursor (normal) / selected crates (visual)
- `<leader>cA`: Upgrade all crates

### External Links
- `<leader>cH`: Open homepage
- `<leader>cR`: Open repository
- `<leader>cD`: Open documentation
- `<leader>cC`: Open crates.io

### Crate Manipulation
- `<leader>ce`: Expand plain crate to inline table
- `<leader>cE`: Extract crate into table

**Note**: Update keeps version requirements (e.g., `^1.0` → `^1.2`), while upgrade changes to latest version (e.g., `^1.0` → `^2.0`).

## Rust Development (rustaceanvim)

rustaceanvim is the modern successor to rust-tools.nvim with enhanced rust-analyzer integration.

### Rust-Specific Actions
- `<leader>ra`: Show code actions (grouped intelligently)
- `<leader>rd`: Show debuggables (debug targets)
- `<leader>rr`: Show runnables (run targets)
- `<leader>rt`: Show testables (test targets)
- `<leader>re`: Explain error under cursor
- `<leader>rc`: Open Cargo.toml
- `<leader>rp`: Go to parent module
- `<leader>rm`: Expand macro under cursor
- `<leader>rh`: Hover actions
- `J`: Join lines (Rust-aware)

### Features
- **Inlay Hints**: Shows type hints, parameter names, and chaining hints inline
- **Clippy Integration**: Runs clippy with `--all` and `-W clippy::all` flags
- **Proc Macros**: Full procedural macro support
- **Experimental Diagnostics**: Enhanced error detection
- **DAP Integration**: Debugging via codelldb (install via Mason)
- **Grouped Code Actions**: Intelligent grouping of rust-analyzer actions
- **Macro Expansion**: View expanded macros in popup
- **Error Explanations**: Detailed rustc error explanations

### Configuration
rust-analyzer is configured via rustaceanvim (not nvim-lspconfig):
- Clippy as default checker
- Cargo `allFeatures` disabled — Anchor's `idl-build` feature would pull in IDL codegen that references bare `solana_program`, causing `cargo check` to fail with E0433 inside rust-analyzer (Anchor itself warns against adding `solana-program` as a direct dep)
- Proc macro support enabled (required for Anchor's `#[program]`, `#[derive(Accounts)]`, `declare_id!`)
- Inlay hints customized for readability
- Experimental diagnostics disabled (rust-analyzer's experimental type checker false-positives on Anchor macro expansion; real errors still come from cargo check via checkOnSave)
- `diagnostics.disabled` includes `unresolved-extern-crate` and `unresolved-macro-call` — Anchor's `#[program]` macro emits paths through `anchor_lang::solana_program` re-export which RA's name resolver can't follow; cargo check resolves them correctly
- Separate target dir (`cargo.targetDir = true`) so rust-analyzer doesn't clobber `anchor build` / `cargo build-sbf` cache
- `files.excludeDirs` skips `.anchor`, `target`, `test-ledger`, `node_modules`, `dist`

## Anchor / Solana Development

Helper module at `lua/plugins/anchor.lua` (loaded from `init.lua`). Activates keymaps in any buffer whose path is inside an `Anchor.toml` workspace. Commands run in a horizontal terminal split (cwd switched to the Anchor root).

### Keymaps (`<leader>A` prefix)

Anchor lifecycle:
- `<leader>Ab`: `anchor build`
- `<leader>AB`: `anchor build --no-idl`
- `<leader>At`: `anchor test`
- `<leader>AT`: `anchor test --skip-local-validator`
- `<leader>Ad`: `anchor deploy` (localnet)
- `<leader>AD`: `anchor deploy --provider.cluster devnet`
- `<leader>Ac`: `anchor clean`
- `<leader>Ak`: `anchor keys list`
- `<leader>As`: `anchor keys sync`
- `<leader>Ai`: Pick an IDL JSON from `target/idl/` and open it

Solana CLI:
- `<leader>Av`: Start `solana-test-validator --reset` in a terminal
- `<leader>Al`: Tail `solana logs`
- `<leader>Aa`: Show wallet address
- `<leader>Ax`: Show balance

### User Commands
- `:AnchorBuild`, `:AnchorTest`, `:AnchorIdl`
- `:AnchorDeploy [localnet|devnet|testnet|mainnet]`
- `:SolanaValidator`, `:SolanaLogs`

### Toolchain
Installed via `setup.sh`:
- Solana CLI from `release.anza.xyz` (Anza fork — current upstream)
- Anchor via `avm` (Anchor Version Manager); `avm install latest && avm use latest`
