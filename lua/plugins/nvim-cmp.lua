local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

local function next_item(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local function prev_item(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

local function confirm_option(fallback)
  if cmp.visible() then
    cmp.confirm({ select = true })
  else
    fallback()
  end
end

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(next_item, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(next_item, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(prev_item, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(prev_item, { "i", "s" }),
    ["<CR>"] = cmp.mapping(confirm_option, { "i", "s" }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-c>c"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip", max_item_count = 10 },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  }),
})

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    cmp.setup.buffer({ sources = { { name = "crates" } } })
  end,
})
