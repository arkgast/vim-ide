local map = vim.keymap.set
local api = vim.api
local lsp = vim.lsp

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>ll", vim.diagnostic.setloclist, opts)

local function lsp_keymaps(bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", lsp.buf.declaration, bufopts)
  map("n", "gd", lsp.buf.definition, bufopts)
  map("n", "K", lsp.buf.hover, bufopts)
  map("n", "gi", lsp.buf.implementation, bufopts)
  map("n", "<C-k>", lsp.buf.signature_help, bufopts)
  map("n", "<space>wa", lsp.buf.add_workspace_folder, bufopts)
  map("n", "<space>wr", lsp.buf.remove_workspace_folder, bufopts)
  map("n", "<space>wl", function()
    print(vim.inspect(lsp.buf.list_workspace_folders()))
  end, bufopts)
  map("n", "<space>D", lsp.buf.type_definition, bufopts)
  map("n", "<space>rn", lsp.buf.rename, bufopts)
  map("n", "<space>ca", lsp.buf.code_action, bufopts)
  map("n", "gr", lsp.buf.references, bufopts)
  map("n", "<space>f", lsp.buf.formatting, bufopts)
end

local lsp_formatting = function(bufnr)
  lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
    async = true,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end

  lsp_keymaps(bufnr)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("lspconfig").tsserver.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})

require("lspconfig").rust_analyzer.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})

require("lspconfig").sumneko_lua.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "os" },
      },
    },
  },
})

-- luasnip setup
local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})
