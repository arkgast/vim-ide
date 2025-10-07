local map = vim.keymap.set
local api = vim.api
local lsp = vim.lsp

-- functions
-- typescript
local function ts_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { api.nvim_buf_get_name(0) },
    title = "",
  }
  lsp.buf.execute_command(params)
end

-- go
local function go_imports(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
  vim.lsp.buf.format({ async = false })
end

-- config
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    map("n", "gD", lsp.buf.declaration, opts)
    map("n", "gd", lsp.buf.definition, opts)
    map("n", "gi", lsp.buf.implementation, opts)
    map("n", "gr", lsp.buf.references, opts)
    map("n", "gt", lsp.buf.type_definition, opts)
    map("n", "ga", lsp.buf.code_action)
    map("n", "<leader>oi", ":OrganizeImports<CR>", opts)
    map("n", "<leader>rn", lsp.buf.rename, opts)
    map("n", "<leader>i", lsp.buf.hover, opts)
    map("n", "<C-i>", lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>=", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Language servers setup
-- typescript
vim.lsp.config.ts_ls = {
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  commands = {
    OrganizeImports = {
      ts_imports,
      description = "Organize TS Imports",
    },
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
}

vim.lsp.config.denols = {
  capabilities = capabilities,
  cmd = { "deno", "lsp" },
  root_markers = { "deno.json", "deno.jsonc", "deno.lock" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
}

vim.lsp.config.tailwindcss = {
  capabilities = capabilities,
  cmd = { "tailwindcss-language-server", "--stdio" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", ".git" },
  filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
}

-- go
vim.lsp.config.gopls = {
  capabilities = capabilities,
  cmd = { "gopls" },
  root_markers = { "go.mod", "go.work", ".git" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  commands = {
    OrganizeImports = {
      go_imports,
      description = "Organize Go Imports",
    },
  },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
}

-- python
vim.lsp.config.pyright = {
  capabilities = capabilities,
  cmd = { "pyright-langserver", "--stdio" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json", ".git" },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
}

-- solidity
vim.lsp.config.solidity = {
  capabilities = capabilities,
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", ".git" },
  settings = {
    solidity = {
      includePath = {
        "node_modules",
        "lib",
        "contracts",
        "test",
        "script",
        "src",
      },
      compilerOptimization = {
        enabled = true,
        runs = 200,
      },
    },
  },
  filetypes = { "solidity" },
}

-- clangd
vim.lsp.config.clangd = {
  capabilities = capabilities,
  cmd = { "clangd" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}

-- c#
vim.lsp.config.csharp_ls = {
  capabilities = capabilities,
  cmd = { "csharp-ls" },
  root_markers = { "*.sln", "*.csproj", ".git" },
  filetypes = { "cs" },
}

-- lua
vim.lsp.config.lua_ls = {
  capabilities = capabilities,
  cmd = { "lua-language-server" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = false, -- Use stylua via conform.nvim instead
      },
    },
  },
  filetypes = { "lua" },
}

-- Enable all configured language servers
-- Note: rust_analyzer is configured via rustaceanvim plugin
vim.lsp.enable({
  "ts_ls",
  "denols",
  "tailwindcss",
  "gopls",
  "pyright",
  "solidity",
  "clangd",
  "csharp_ls",
  "lua_ls",
})
