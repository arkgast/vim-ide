vim.g.table_mode_corner = "|"
vim.g.table_mode_disable_mappings = 1

local function install_maps(buf)
  vim.keymap.set("n", "<leader>Mt", "<cmd>TableModeToggle<cr>", { buffer = buf, silent = true, desc = "Toggle table mode" })
  vim.keymap.set("n", "<leader>Mr", "<cmd>TableModeRealign<cr>", { buffer = buf, silent = true, desc = "Realign table" })
  vim.keymap.set("v", "<leader>MT", ":Tableize<cr>", { buffer = buf, silent = true, desc = "Tableize selection" })
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TableModeMaps", { clear = true }),
  pattern = "markdown",
  callback = function(args)
    install_maps(args.buf)
  end,
})

if vim.bo.filetype == "markdown" then
  install_maps(0)
end
