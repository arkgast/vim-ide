local dap, dapui = require("dap"), require("dapui")

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    open_on_start = true,
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "breakpoints",
      "stacks",
      "watches",
    },
    width = 40,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    open_on_start = true,
    elements = { "repl" },
    height = 10,
    position = "bottom", -- Can be "bottom" or "top"
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- keymaps
vim.keymap.set("n", "<leader>b", function()
  dap.toggle_breakpoint()
end)

vim.keymap.set("n", "<leader>dc", function()
  dap.continue()
end)

vim.keymap.set("n", "<leader>dss", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<leader>dsi", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<leader>dso", function()
  require("dap").step_out()
end)
vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.open()
end)
vim.keymap.set("n", "<leader>dl", function()
  require("dap").run_last()
end)

vim.keymap.set("n", "<leader>dd", dap.clear_breakpoints)

-- dap.restart()
-- dap.terminate()
-- dap.up()
-- dap.down()
