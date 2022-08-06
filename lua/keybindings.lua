-- map leader key to SPACE
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })

vim.api.nvim_set_keymap('n', '<Leader>s', ':write<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-s>', '<C-w>vnew', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })


-- move between buffers
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- git merge
vim.api.nvim_set_keymap('n', '<leader>dp', ':diffput<SPACE>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dg', ':diffget<SPACE>', { noremap = true })

-- true-zen
vim.api.nvim_set_keymap('n', '<leader>m', ':TZFocus<CR>', {})

-- telescope
vim.api.nvim_set_keymap('n', '<leader>p', ':Telescope fd<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>w', ':Telescope live_grep<CR>', {})

-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true })

-- copilot
vim.api.nvim_set_keymap('i', '<C-,>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
