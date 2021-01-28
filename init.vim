call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer --rust-completer --java-completer --clang-completer' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'arkgast/nerdtree-execute', { 'on': 'NERDTreeToggle', 'branch': 'standard_linux_opener' }
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'preservim/nerdcommenter'
Plug 'chaoren/vim-wordmotion'
Plug 'takac/vim-hardtime'
Plug 'mbbill/undotree'
Plug 'SirVer/ultisnips'
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mattn/emmet-vim'
Plug 'rust-lang/rust.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'junegunn/goyo.vim'
call plug#end()

syntax on
filetype plugin indent on

colorscheme gruvbox
set background=dark
set noerrorbells
set tabstop=2
set softtabstop=2
set shiftwidth=2
set foldtext=CustomFoldText()
set foldmethod=indent
set foldnestmax=10
set foldlevel=2
set expandtab
set smartindent
set relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set mouse=a
set wildmenu
set wildignore+=*.pyc,*.zip
set clipboard=autoselect
set list
exec "set listchars=tab:»·,nbsp:_,trail:·,eol:¬"

call matchadd('ColorColumn', '\%81v', 100)

let mapleader = " "
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

noremap ;l :
inoremap jk <ESC>
inoremap <C-t> <Esc>:tabnew<CR>
nnoremap <C-t> :tabnew<CR>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>ps :Ack<SPACE>
nnoremap <leader>dp :diffput<SPACE>
nnoremap <leader>dg :diffget<SPACE>

" YCM
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>gi :YcmCompleter GoToImplementation<CR>
nnoremap <silent> <leader>yf :YcmCompleter FixIt<CR>
nnoremap <silent> <leader>yd :YcmCompleter GetDoc<CR>
nmap <leader>yh <plug>(YCMHover)

let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'vertical-split'
let g:ycm_error_symbol='✗'
let g:ycm_warning_symbol='⚠'

" ale - linter
nmap <silent> <C-m> <Plug>(ale_previous_wrap)
nmap <silent> <C-S-m> <Plug>(ale_next_wrap)

let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_sign_error='✗'
let g:ale_sign_warning='⚠'
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'typescript': ['eslint'],
  \   'rust': ['rustfmt'],
  \ }
let g:ale_fixers = {
  \ 'javascript': ['prettier', 'prettier-standard'],
  \ 'typescript': ['prettier'],
  \ }
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_open_list = 0

" nerdtree
map <C-n> :NERDTreeToggle<CR>
nmap <leader>n :NERDTreeFind <CR>
autocmd StdinReadPre * let s:std_in=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore=["\.pyc$", "\.class$", "node_modules", "Pods"]
let NERDTreeMouseMode=2

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist|build$|Pods|\.class$\/)|(\.(git|hg|svn))$'

" NERDCommenter
let g:NERDSpaceDelims = 1

" ultisnips
let g:UltiSnipsExpandTrigger="<C-S-j>"
let g:UltiSnipsJumpForwardTrigger="<C-S-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-S-k>"
let g:UltiSnipsEditSplit="vertical"

" Fold
function! CustomFoldText()
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = "+ | " . foldSize . " lines | "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let lineCount = line("$")
  let expansionString = repeat("-", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endf
