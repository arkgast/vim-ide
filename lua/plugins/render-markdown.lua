require("render-markdown").setup({
  file_types = { "markdown", "Avante" },
  heading = { sign = false },
  code = {
    sign = false,
    width = "block",
    right_pad = 4,
  },
  pipe_table = {
    preset = "round",
    style = "full",
    alignment_indicator = "─",
  },
  checkbox = {
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },
})

local function install_maps(buf)
  vim.keymap.set("n", "<leader>Mp", "<cmd>RenderMarkdown toggle<cr>", {
    buffer = buf,
    silent = true,
    desc = "Toggle markdown render",
  })
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("RenderMarkdownMaps", { clear = true }),
  pattern = "markdown",
  callback = function(args)
    install_maps(args.buf)
  end,
})

if vim.bo.filetype == "markdown" then
  install_maps(0)
end
