local lspconfig = require("lspconfig")

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
    map("n", "gr", vim.lsp.buf.references, opts)
    -- map('n', 'gt', vim.lsp.buf.type_definition, opts)
    map("n", "ga", lsp.buf.code_action)
    map("n", "<leader>oi", ":OrganizeImports<CR>", opts)
    map("n", "<leader>rn", lsp.buf.rename, opts)
    map("n", "<leader>i", vim.lsp.buf.hover, opts)
    map("n", "<C-i>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>=", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Language servers setup
-- typescript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      ts_imports,
      description = "Organize TS Imports",
    },
  },
})

-- rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- go
lspconfig.gopls.setup({
  capabilities = capabilities,
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
})

-- python
lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- solidity
lspconfig.solc.setup({
  capabilities = capabilities,
})

-- c#
lspconfig.csharp_ls.setup({
  capabilities = capabilities,
})

-- lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})
