local lspconfig = require("lspconfig")

local lsp = vim.lsp

local map = vim.keymap.set

local opts = { noremap = true, silent = true }
map("n", "<leader>e", vim.diagnostic.open_float, opts)
map("n", "<leader>l", vim.diagnostic.setloclist, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)

-- settings
vim.diagnostic.config({
  virtual_text = false,
})

-- functions
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params({}),
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        -- you can modify the log message / level (or ignore it completely)
        vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      -- don't apply results if buffer is unloaded or has been modified
      if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("silent noautocmd update")
        end)
      end
    end)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function null_ls_on_attach(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        async_formatting(bufnr)
      end,
    })
  end
end

-- setup lsp
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", lsp.buf.declaration, bufopts)
  map("n", "gd", lsp.buf.definition, bufopts)
  map("n", "gi", lsp.buf.implementation, bufopts)
  map("n", "<C-i>", lsp.buf.signature_help, bufopts)
  map("n", "<leader>i", lsp.buf.hover, bufopts)
  map("n", "<leader>f", lsp.buf.formatting, bufopts)
  map("n", "<leader>rn", lsp.buf.rename, bufopts)
  map("n", "<leader>r", ":Telescope lsp_references<CR>", bufopts)
  map("n", "<leader>oi", ":OrganizeImports<CR>", bufopts)

  null_ls_on_attach(client, bufnr)
end

local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})

lspconfig.solc.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
