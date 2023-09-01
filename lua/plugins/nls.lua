local nls = require("null-ls")

local fmt = nls.builtins.formatting
local dgs = nls.builtins.diagnostics
local cda = nls.builtins.code_actions
local hover = nls.builtins.hover

nls.setup({
  debug = false,
  sources = {
    fmt.eslint.with({ filetypes = { "javascript", "typescript", "typescriptreact" } }),
    fmt.prettier.with({ filetypes = { "javascript", "typescript", "typescriptreact", "css" } }),
    fmt.fixjson.with({ extra_args = { "--write", "--indent", "2" } }),
    fmt.stylua.with({ extra_args = { "--indent-type=Spaces", "--indent-width=2" } }),

    dgs.eslint,
    dgs.jsonlint,
    dgs.stylelint,
    dgs.yamllint,
    dgs.luacheck,

    dgs.write_good.with({ filetypes = { "markdown" } }),
    -- dgs.commitlint.with({ extra_args = { "--config=" .. os.getenv("HOME") .. "/.config/commitlint.config.js" } }),
    dgs.codespell,

    cda.eslint,

    hover.dictionary,
  },
})
