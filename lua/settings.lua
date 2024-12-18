local api = vim.api
local cmd = vim.cmd
local g = vim.g
local o = vim.opt

-- options
o.termguicolors = true

-- map leader key to SPACE
g.mapleader = " "

-- colorscheme
o.background = "dark"

-- autocmd
cmd([[autocmd FileType solidity,cs,java,python,rust,php setlocal shiftwidth=4 softtabstop=4 tabstop=4 ]])

api.nvim_create_autocmd("CursorHold", {
  group = api.nvim_create_augroup("Diagnostic", {}),
  callback = function()
    api.nvim_command("silent! lua vim.diagnostic.open_float(nil, { focusable = false })")
  end,
})

-- indentation
o.autoindent = true
o.expandtab = true
o.smartindent = true
o.smarttab = true
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
o.undolevels = 50
o.undoreload = 500

-- edit
o.autoread = true
o.cursorline = true
o.number = true
o.relativenumber = true
o.wrap = false
o.list = true
o.listchars = "tab:»·,nbsp:_,trail:·,eol:¬"
o.showmode = false

-- completion
o.updatetime = 100
o.completeopt = "menuone"
-- o.shortmess = o.shortmess .. "c"

-- splitting
o.splitbelow = true
o.splitright = true

-- search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.scrolloff = 4

-- fold
o.foldmethod = "indent"
o.foldnestmax = 10
o.foldlevelstart = 5

-- diagnostic
vim.diagnostic.config({
  virtual_text = false,
})
