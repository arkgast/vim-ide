local crates = require("crates")

crates.setup({
  -- General settings
  smart_insert = true, -- Smart insert crates
  autoload = true, -- Autoload crate info
  autoupdate = true, -- Auto update when editing
  loading_indicator = true, -- Show loading indicator
  date_format = "%Y-%m-%d", -- Date format for crate info
  thousands_separator = ",",
  notification_title = "crates.nvim",
  max_parallel_requests = 80,
  expand_crate_moves_cursor = true,
  insert_closing_quote = true, -- Auto insert closing quote

  -- Completion configuration (modern API)
  completion = {
    crates = {
      enabled = true, -- Enable crate name completion
      max_results = 8,
      min_chars = 3,
    },
  },

  -- Enable LSP features (replaces null_ls and cmp source)
  lsp = {
    enabled = true, -- Enable in-process language server
    on_attach = function(client, bufnr)
      -- LSP keybindings for Cargo.toml
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "K", crates.show_crate_popup, opts)
      vim.keymap.set("n", "gd", crates.show_versions_popup, opts)
    end,
    actions = true, -- Enable code actions
    completion = true, -- Enable LSP completion
    hover = true, -- Enable hover documentation
  },

  -- Virtual text configuration
  text = {
    loading = "   Loading...",
    version = "   %s",
    prerelease = "   %s",
    yanked = "   %s yanked",
    nomatch = "   Not found",
    upgrade = "   %s",
    error = "   Error fetching crate",
  },

  -- Highlight groups
  highlight = {
    loading = "CratesNvimLoading",
    version = "CratesNvimVersion",
    prerelease = "CratesNvimPreRelease",
    yanked = "CratesNvimYanked",
    nomatch = "CratesNvimNoMatch",
    upgrade = "CratesNvimUpgrade",
    error = "CratesNvimError",
  },

  -- Popup configuration
  popup = {
    autofocus = true,
    hide_on_select = false,
    copy_register = '"',
    style = "minimal",
    border = "rounded",
    show_version_date = true,
    show_dependency_version = true,
    max_height = 30,
    min_width = 20,
    padding = 1,
    text = {
      title = " %s ",
      pill_left = "",
      pill_right = "",
      description = "%s",
      created_label = " created        ",
      created = "%s",
      updated_label = " updated        ",
      updated = "%s",
      downloads_label = " downloads      ",
      downloads = "%s",
      homepage_label = " homepage       ",
      homepage = "%s",
      repository_label = " repository     ",
      repository = "%s",
      documentation_label = " documentation  ",
      documentation = "%s",
      crates_io_label = " crates.io      ",
      crates_io = "%s",
      categories_label = " categories     ",
      keywords_label = " keywords       ",
      version = "  %s",
      prerelease = " %s",
      yanked = " %s yanked",
      version_date = "  %s",
      feature = "  %s",
      enabled = " ✓ %s",
      transitive = " ~ %s",
      normal_dependencies_title = " Dependencies ",
      build_dependencies_title = " Build dependencies ",
      dev_dependencies_title = " Dev dependencies ",
      dependency = "  %s",
      optional = "  ? %s",
      dependency_version = "  %s",
      loading = " ",
    },
  },
})

-- Keybindings for Cargo.toml
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CratesNvimKeymaps", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    local opts = { buffer = true, silent = true }

    -- Show information
    vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
    vim.keymap.set("n", "<leader>cr", crates.reload, opts)

    -- Show popups
    vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
    vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
    vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

    -- Update crates
    vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
    vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
    vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)

    -- Upgrade crates
    vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
    vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
    vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

    -- Open external links
    vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
    vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
    vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
    vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)

    -- Expand/collapse crates
    vim.keymap.set("n", "<leader>ce", crates.expand_plain_crate_to_inline_table, opts)
    vim.keymap.set("n", "<leader>cE", crates.extract_crate_into_table, opts)
  end,
})
