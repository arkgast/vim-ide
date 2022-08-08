local nls = require("null-ls")

local fmt = nls.builtins.formatting
local dgs = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

nls.setup({
  debug = false,
  sources = {
    fmt.prettier,
    fmt.eslint,
    fmt.stylua.with({ extra_args = { "--indent-type=Spaces", "--indent-width=2" } }),

    dgs.eslint,
    dgs.selene,

    cda.eslint,
  },
})
