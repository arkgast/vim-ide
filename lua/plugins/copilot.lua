require("copilot").setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>",
    },
    layout = {
      position = "bottom", -- | top | left | right | horizontal | vertical
      ratio = 0.4,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<C-k>",
      accept_word = false,
      accept_line = false,
      next = "<C-]>",
      prev = "<C-[>",
      dismiss = "<C-,>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = true,
    gitrebase = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

local copilot_enabled = false

vim.cmd("Copilot disable")
vim.api.nvim_create_user_command("ToggleCopilot", function()
  if copilot_enabled then
    vim.cmd("Copilot disable")
    copilot_enabled = false
  else
    vim.cmd("Copilot enable")
    copilot_enabled = true
  end
end, {})
