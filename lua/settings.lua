vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])
vim.cmd[[autocmd FileType python,cs,java,rust setlocal tabstop=4 shiftwidth=4]]

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
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 10
vim.o.foldlevelstart = 2

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
  ['*'] = false,
  ['javascript'] = true,
  ['typescript'] = true,
  ['lua'] = true,
  ['rust'] = true,
  ['c'] = true,
  ['c#'] = true,
  ['c++'] = true,
  ['go'] = true,
  ['python'] = true,
}
