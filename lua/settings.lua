local cmd = vim.cmd
local g = vim.g
local o = vim.o

-- map leader key to SPACE
g.mapleader = " "

o.background = "dark"
cmd([[colorscheme gruvbox]])
cmd([[autocmd FileType python,cs,java,rust setlocal tabstop=4 shiftwidth=4]])

-- identation
o.autoindent = true
o.backspace = 2
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2

-- backup
o.backup = false
o.swapfile = false
o.writebackup = false

-- undo
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"

-- edit
o.audoread = true
o.cursorline = true
o.hlsearch = true
o.number = true
o.relativenumber = true
o.spell = true
o.wrap = false
o.list = true
o.listchars = "tab:»·,nbsp:_,trail:·,eol:¬"

-- fold
o.foldmethod = "indent"
o.foldnestmax = 10
o.foldlevelstart = 2

-- copilot
g.copilot_no_tab_map = true
g.copilot_filetypes = {
  ["*"] = false,
  ["javascript"] = true,
  ["typescript"] = true,
  ["lua"] = true,
  ["rust"] = true,
  ["c"] = true,
  ["c#"] = true,
  ["c++"] = true,
  ["go"] = true,
  ["python"] = true,
}
