vim.g.mapleader = " "

vim.cmd[[autocmd FileType python,cs,java,rust setlocal tabstop=4 shiftwidth=4]]

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })

vim.keymap.set('n', '<Leader>w', ':write<CR>')

vim.api.nvim_set_keymap('n', '<C-s>', '<C-w>vnew', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- nnoremap <leader>dp :diffput<SPACE>
vim.api.nvim_set_keymap('n', '<leader>dp', ':diffput<SPACE>', { noremap = true })
-- nnoremap <leader>dg :diffget<SPACE>
vim.api.nvim_set_keymap('n', '<leader>dg', ':diffget<SPACE>', { noremap = true })

-- identation
vim.o.autoindent = true
vim.o.backspace = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- backup
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false

-- edit
vim.o.audoread = true
vim.o.cursorline = true
vim.o.hlsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.spell = true
vim.o.wrap = false
vim.o.list = true
vim.o.listchars = 'tab:»·,nbsp:_,trail:·,eol:¬'

-- fold
-- set CustomFoldText method as foldtext
vim.o.foldtext = "CustomFoldText()"
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 10
vim.o.foldlevelstart = 2

function CustomFoldText()
  return 'folded :)'
--   local fs = vim.o.foldstart
--   while vim.fn.getline(fs) == '' or vim.fn.getline(fs) == '\n' do
--     fs = vim.fn.nextnonblank(fs + 1)
--   end
--   if fs > vim.o.foldend then
--     local line = vim.fn.getline(vim.o.foldstart)
--   else
--     -- BUG <name> expected near repeat
--     local line = vim.fn.substitute(vim.fn.getline(fs), '\t', vim.fn.repeat(' ', vim.o.tabstop), 'g')
--   end
--   local w = vim.fn.winwidth(0) - vim.o.foldcolumn - (vim.o.number and 8 or 0)
--   local foldSize = 1 + vim.o.foldend - vim.o.foldstart
--   local foldSizeStr = "+ | " .. foldSize .. " lines | "
--   local foldLevelStr = vim.fn.repeat('+--', vim.o.foldlevel)
--   local lineCount = vim.fn.line('$')
--   local expansionString = vim.fn.repeat('-', w - vim.fn.strwidth(foldSizeStr .. line .. foldLevelStr))
--   return line .. expansionString .. foldSizeStr .. foldLevelStr
end

vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-,>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_filetypes = {
  ["*"] = false,
  ["javascript"] = true,
  ["typescript"] = true,
  ["lua"] = false,
  ["rust"] = true,
  ["c"] = true,
  ["c#"] = true,
  ["c++"] = true,
  ["go"] = true,
  ["python"] = true,
}

-- plugins
require('plugins')

-- nvim-tree
require("nvim-tree").setup {
  disable_netrw = true,
  hijack_netrw = true,
  view = {
    number = true,
    relativenumber = true,
  },
  filters = {
    custom = { ".git" },
  },
}
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true })

-- true-zen
require("true-zen").setup {}
vim.api.nvim_set_keymap("n", "<leader>m", ":TZFocus<CR>", {})

-- lualine
require('lualine').setup({
  options = { theme = 'gruvbox' },
})

-- telescope
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope grep_string<CR>', {})
