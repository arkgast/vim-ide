local lspconfig = require("lspconfig")

local map = vim.keymap.set
local api = vim.api
local lsp = vim.lsp

-- config
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    map('n', 'gD', lsp.buf.declaration, opts)
    map('n', 'gd', lsp.buf.definition, opts)
    map("n", "gi", lsp.buf.implementation, opts)
    map("n", 'gr', vim.lsp.buf.references, opts)
    map('n', 'gt', vim.lsp.buf.type_definition, opts)
    map("n", "ga", lsp.buf.code_action)
    map("n", "<leader>oi", ":OrganizeImports<CR>", opts)
    map("n", "<leader>rn", lsp.buf.rename, opts)
    map("n", "<leader>q", lsp.diagnostic.set_loclist, opts)
    map('n', '<leader>i', vim.lsp.buf.hover, opts)
    map('n', '<C-i>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>=', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

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

-- python
lspconfig.pyright.setup({
  on_attach = on_attach,
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
  on_attach = on_attach,
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
