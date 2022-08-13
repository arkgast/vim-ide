local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if (cmp.visible()) then
        cmp.select_next_item()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if (cmp.visible()) then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping(function(fallback)
      if (cmp.visible()) then
        cmp.confirm()
      end
    end)
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
    }),
  },
  sources = {
    { name = "nvim_lsp", max_item_count = 10 }
  }
})
