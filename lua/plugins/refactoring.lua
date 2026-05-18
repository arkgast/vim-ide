require("refactoring").setup({
  prompt_func_return_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  prompt_func_param_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  show_success_message = true,
})

local map = vim.keymap.set
local r = require("refactoring")

map({ "n", "x" }, "<leader>Re", function()
  r.refactor("Extract Function")
end, { desc = "Extract function" })
map({ "n", "x" }, "<leader>Rf", function()
  r.refactor("Extract Function To File")
end, { desc = "Extract function to file" })
map({ "n", "x" }, "<leader>Rv", function()
  r.refactor("Extract Variable")
end, { desc = "Extract variable" })
map({ "n", "x" }, "<leader>Ri", function()
  r.refactor("Inline Variable")
end, { desc = "Inline variable" })
map("n", "<leader>Rb", function()
  r.refactor("Extract Block")
end, { desc = "Extract block" })
map("n", "<leader>RB", function()
  r.refactor("Extract Block To File")
end, { desc = "Extract block to file" })
map({ "n", "x" }, "<leader>RR", function()
  r.select_refactor()
end, { desc = "Refactor menu" })
