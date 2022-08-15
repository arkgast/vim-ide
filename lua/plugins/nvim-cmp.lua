local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if (cmp.visible()) then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if (cmp.visible()) then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping(function(fallback)
      if (cmp.visible()) then
        cmp.confirm()
      else
        fallback()
      end
    end, { "i", "s" })
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
    end
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
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  })
})
