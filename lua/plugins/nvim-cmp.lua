local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
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
  sources = {
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "luasnip", max_item_count = 10 },
  }
})
