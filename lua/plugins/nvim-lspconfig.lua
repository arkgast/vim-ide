local map = vim.keymap.set
local api = vim.api
local lsp = vim.lsp

-- Organize imports functions for different language servers
-- TypeScript/JavaScript: Uses ts_ls execute command
local function ts_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { api.nvim_buf_get_name(0) },
    title = "",
  }
  lsp.buf.execute_command(params)
end

-- Go: Uses gopls code action for source.organizeImports
local function go_organize_imports()
  local params = lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  if not result or vim.tbl_isempty(result) then
    return
  end
  for _, res in pairs(result) do
    for _, action in pairs(res.result or {}) do
      if action.edit then
        local client = lsp.get_active_clients({ bufnr = 0 })[1]
        if client then
          lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        end
      end
    end
  end
end

-- Python: Uses Pyright's organize imports command
local function py_organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  lsp.buf.execute_command(params)
end

-- Universal organize imports function that detects filetype
local function organize_imports()
  local ft = vim.bo.filetype
  if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
    ts_organize_imports()
  elseif ft == "go" then
    go_organize_imports()
  elseif ft == "python" then
    py_organize_imports()
  else
    vim.notify("Organize imports not supported for filetype: " .. ft, vim.log.levels.WARN)
  end
end

-- config
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Enable inlay hints if supported
    -- if client and client.supports_method("textDocument/inlayHint") then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- end

    -- Enable codelens if supported
    if client and client.supports_method("textDocument/codeLens") then
      vim.lsp.codelens.refresh()
      -- Auto-refresh codelens on these events
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr }
    map("n", "gD", lsp.buf.declaration, opts)
    map("n", "gd", lsp.buf.definition, opts)
    map("n", "gi", lsp.buf.implementation, opts)
    map("n", "gr", lsp.buf.references, opts)
    map("n", "gt", lsp.buf.type_definition, opts)
    map("n", "ga", lsp.buf.code_action)
    map("n", "<leader>oi", organize_imports, opts)
    map("n", "<leader>rn", lsp.buf.rename, opts)
    map("n", "<leader>i", lsp.buf.hover, opts)
    map("n", "<C-i>", lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>=", function()
      vim.lsp.buf.format({ async = true })
    end, opts)

    -- Inlay hints toggle
    map("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, opts)

    -- Codelens actions
    if client and client.supports_method("textDocument/codeLens") then
      map("n", "<leader>cl", vim.lsp.codelens.run, opts)
      map("n", "<leader>cL", vim.lsp.codelens.refresh, opts)
    end
  end,
})

-- Language servers setup
-- typescript
vim.lsp.config.ts_ls = {
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  commands = {
    OrganizeImports = {
      ts_organize_imports,
      description = "Organize TypeScript/JavaScript Imports",
    },
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      },
    },
  },
}

vim.lsp.config.denols = {
  capabilities = capabilities,
  cmd = { "deno", "lsp" },
  root_markers = { "deno.json", "deno.jsonc", "deno.lock" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  settings = {
    deno = {
      enable = true,
      lint = true,
      unstable = true,
      inlayHints = {
        parameterNames = { enabled = "all" }, -- 'none' | 'literals' | 'all'
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
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
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      codelenses = {
        gc_details = true,
        generate = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
  commands = {
    OrganizeImports = {
      go_organize_imports,
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
  commands = {
    OrganizeImports = {
      py_organize_imports,
      description = "Organize Python Imports",
    },
  },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
    pyright = {
      inlayHints = {
        variableTypes = true,
        functionReturnTypes = true,
        callArgumentNames = true,
        parameterTypes = true,
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
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
    },
  },
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
      hint = {
        enable = true,
        setType = true,
        paramType = true,
        paramName = "All", -- 'All' | 'Literal' | 'Disable'
        semicolon = "All",
        arrayIndex = "Auto", -- 'Auto' | 'Enable' | 'Disable'
      },
      codeLens = {
        enable = true,
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

-- Create global OrganizeImports command
vim.api.nvim_create_user_command("OrganizeImports", organize_imports, {
  desc = "Organize imports for current buffer (TypeScript/JavaScript/Go/Python)",
})
