local rt = require("rust-tools")

rt.setup({
  tools = {
    inlay_hints = {
      only_current_line = true,
    },
    hover_actions = {
      auto_focus = true,
    },
  },
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>i", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "ga", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
