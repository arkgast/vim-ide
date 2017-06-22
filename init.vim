set nocompatible
filetype off
let &runtimepath.='./plugged/ale'

call plug#begin('~/.config/nvim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'arkgast/nerdtree-execute', { 'on': 'NERDTreeToggle', 'branch': 'standard_linux_opener' }
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

filetype plugin on

" Configurations
colorscheme gruvbox
set background=dark
set backspace=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set wildignore+=*.pyc,*.zip

" ale - linter
let g:ale_sign_column_always = 1
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}

" airline status/tabline
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" nerdtree
map <C-n> :NERDTreeToggle<CR>
nmap <leader>p :NERDTreeFind <CR>
autocmd StdinReadPre * let s:std_in=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist)|(\.(git|hg|svn))$'


" Functions
function! AirlineInit()
  let g:airline_section_y = airline#section#create(['%p%%'])
  let g:airline_section_z = airline#section#create_right(['%l', '%c'])
endfunction

function! NERDTreeInit()
  if argc() == 0 && !exists("s:std_in")
    NERDTree
  endif
endfunction

function! NERDTreeBuffer()
  if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
    quit
  endif
endfunction

function! VimInit()
  call NERDTreeInit()
  call AirlineInit()
endfunction

function! VimBuffer()
  call NERDTreeBuffer()
endfunction

autocmd VimEnter * call VimInit()
autocmd bufenter * call VimBuffer()
