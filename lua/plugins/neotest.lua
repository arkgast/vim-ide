require("neotest").setup({
  adapters = {
    require("neotest-jest")({
      jestCommand = "npx jest --",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),
    require("neotest-vitest"),
    require("rustaceanvim.neotest"),
    require("neotest-plenary"),
  },
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = { enabled = false },
  icons = {
    running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  },
})

local neotest = require("neotest")
local map = vim.keymap.set
map("n", "<leader>Tt", function()
  neotest.run.run()
end, { desc = "Test nearest" })
map("n", "<leader>Tf", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Test file" })
map("n", "<leader>Td", function()
  neotest.run.run({ strategy = "dap" })
end, { desc = "Debug nearest test" })
map("n", "<leader>Ts", function()
  neotest.summary.toggle()
end, { desc = "Toggle test summary" })
map("n", "<leader>To", function()
  neotest.output.open({ enter = true, auto_close = true })
end, { desc = "Test output" })
map("n", "<leader>TO", function()
  neotest.output_panel.toggle()
end, { desc = "Toggle output panel" })
map("n", "<leader>Tw", function()
  neotest.watch.toggle(vim.fn.expand("%"))
end, { desc = "Toggle watch file" })
map("n", "<leader>Tx", function()
  neotest.run.stop()
end, { desc = "Stop running test" })
