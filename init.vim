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
Plug 'jreybert/vimagit'
Plug 'mhinz/vim-signify'
Plug 'heavenshell/vim-jsdoc'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'Valloric/MatchTagAlways'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
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
set foldmethod=syntax
set foldnestmax=3
set relativenumber
set nowrap
set smartindent
set wildmenu
set wildignore+=*.pyc,*.zip
set nobackup
set noswapfile
set nowritebackup

" YouCompleteMe
let g:ycm_allow_changing_updatetime = 0
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'vertical-split'
let g:ycm_semantic_triggers = {
  \   'javascript,python': ['.'],
  \   'ruby': ['.', '::'],
  \   'php': ['->', '::']
  \ }

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

" vim-jsdoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_underscore_private = 1
let g:jsdoc_enable_es6 = 1

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" vim-jsx
let g:jsx_ext_required = 0

" emmet-vim
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
  \   'javascript.jsx': {
  \     'extends': 'jsx'
  \   }
  \ }

" MatchAlways
let g:mta_filetypes = {
  \ 'html': 1,
  \ 'xhtml': 1,
  \ 'xml': 1,
  \ 'htmldjango': 1,
  \ 'smarty': 1,
  \ 'javascript.jsx': 1,
  \ 'php': 1
  \ }

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
  call AirlineInit()
  call NERDTreeInit()
endfunction

function! VimBuffer()
  call NERDTreeBuffer()
endfunction

autocmd VimEnter * call VimInit()
autocmd bufenter * call VimBuffer()
