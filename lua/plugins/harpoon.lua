local harpoon = require("harpoon")

harpoon:setup({
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  },
})

local map = vim.keymap.set
map("n", "<leader>Ha", function()
  harpoon:list():add()
end, { desc = "Harpoon add file" })
map("n", "<leader>HH", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })
map("n", "<leader>Hn", function()
  harpoon:list():next()
end, { desc = "Harpoon next" })
map("n", "<leader>Hp", function()
  harpoon:list():prev()
end, { desc = "Harpoon prev" })

for i = 1, 5 do
  map("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon file " .. i })
end
