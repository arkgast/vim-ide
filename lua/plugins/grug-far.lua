require("grug-far").setup({
  headerMaxWidth = 80,
  windowCreationCommand = "vsplit",
})

local map = vim.keymap.set
map("n", "<leader>fR", function()
  require("grug-far").open()
end, { desc = "Find/replace (grug-far)" })
map("n", "<leader>fr", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Find/replace word" })
map("v", "<leader>fr", function()
  require("grug-far").with_visual_selection()
end, { desc = "Find/replace selection" })
