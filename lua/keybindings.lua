local map = vim.api.nvim_set_keymap

map("i", "jk", "<ESC>", { noremap = true })
map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })

map("n", "<Leader>w", ":write<CR>", { noremap = true })
map("n", "<Leader>q", ":quit<CR>", { noremap = true })
map("n", "<Leader>x", ":xit<CR>", { noremap = true })

map("n", "<C-s>", "<C-w>vnew", { noremap = true })
map("n", "<C-t>", ":tabnew<CR>", { noremap = true })
map("n", "<S-u>", ":redo<CR>", { noremap = true })

-- move between buffers
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })

-- git
map("n", "<Leader>g", ":Git<CR>", { noremap = true })

map("n", "<leader>dp", ":diffput<SPACE>", { noremap = true })
map("n", "<leader>dg", ":diffget<SPACE>", { noremap = true })

-- mundo
map("n", "<leader>u", ":MundoToggle<CR>", { noremap = true })

-- true-zen
map("n", "<leader>m", ":TZFocus<CR>", {})

-- telescope
map("n", "<C-p>", ":Telescope fd<CR>", {})
map("n", "<C-r>", ":Telescope oldfiles<CR>", {})
map("n", "<C-f>", ":Telescope live_grep<CR>", {})

-- nvim-tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
map("n", "<leader>n", ":NvimTreeFindFileToggle<CR>", { noremap = true })

-- copilot
map("i", "<C-,>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
