local map = vim.keymap.set
local dgs = vim.diagnostic

local opts = { noremap = true, silent = true }

map("i", "jk", "<ESC>", { noremap = true })
map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })

map("n", "<Leader>w", ":write<CR>", { noremap = true })
map("n", "<Leader>q", ":quit<CR>", { noremap = true })
map("n", "<Leader>x", ":xit<CR>", { noremap = true })

map("n", "<C-s>", "<C-w>vnew", opts)
map("n", "<C-t>", ":tabnew<CR>", opts)
map("n", "tt", ":tabnext<CR>", opts)
map("n", "tT", ":tabprevious<CR>", opts)

-- move between buffers
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)

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
map("n", "<C-f>", ":Telescope live_grep<CR>", opts)
map("n", "<C-R>", ":Telescope lsp_references<CR>", opts)

-- session manager
map("n", "<C-s>l", ":SessionManager load_last_session<CR>", opts)
map("n", "<C-s>s", ":SessionManager save_current_session<CR>", opts)
map("n", "<C-s>d", ":SessionManager delete_session<CR>", opts)

-- nvim-tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>n", ":NvimTreeFindFile<CR>", opts)

-- gitsigns
map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
map("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", opts)
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
map("n", "<leader>hR", ":Gitsigns reset_hunk<CR>", opts)
map("n", "<leader>hn", ":Gitsigns next_hunk<CR>", opts)
map("n", "<leader>hN", ":Gitsigns prev_hunk<CR>", opts)
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts)
map("n", "<leader>hi", ":Gitsigns preview_hunk_inline<CR>", opts)
map("n", "<leader>hr", ":Gitsigns refresh<CR>", opts)
