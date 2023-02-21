local map = vim.keymap.set
local dgs = vim.diagnostic

local opts = { noremap = true, silent = true }

map("i", "jk", "<ESC>", { noremap = true })
map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })

map("n", "<Leader>w", ":silent write<CR>", { silent = true, noremap = true })
map("n", "<Leader>q", ":quit<CR>", { noremap = true })
map("n", "<Leader>x", ":xit<CR>", { noremap = true })

map("n", "<C-s>", "<C-w>vnew", opts)
map("n", "<C-t>", ":tabnew<CR>", opts)

-- move between buffers
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- git
map("n", "<leader>g", ":Git<CR>", opts)
map("n", "<leader>d", ":Gvdiffsplit<CR>", opts)

map("n", "<leader>dp", ":diffput<SPACE>", opts)
map("n", "<leader>dg", ":diffget<SPACE>", opts)

-- diagnostics
map("n", "<leader>e", dgs.open_float, opts)
map("n", "<leader>l", dgs.setloclist, opts)
map("n", "[d", dgs.goto_prev, opts)
map("n", "]d", dgs.goto_next, opts)

-- mundo
map("n", "<leader>u", ":MundoToggle<CR>", opts)

-- true-zen
map("n", "<leader>m", ":TZFocus<CR>", opts)

-- telescope
map("n", "<C-p>", ":Telescope fd<CR>", opts)
map("n", "<leader>p", ":Telescope frecency<CR>", opts)
map("n", "<C-f>", ":Telescope live_grep<CR>", opts)
map("n", "<leader>r", ":Telescope lsp_references<CR>", opts)

-- session manager
map("n", "<C-s>l", ":SessionManager load_last_session<CR>", opts)
map("n", "<C-s>s", ":SessionManager save_current_session<CR>", opts)
map("n", "<C-s>d", ":SessionManager delete_session<CR>", opts)

-- nvim-tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>n", ":NvimTreeFindFile<CR>", opts)

-- copilot
map("i", "<C-c>a", 'copilot#Accept("<CR>")', { silent = true, expr = true })
