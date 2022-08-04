call plug#begin('~/.vim/plugged')
" Autocomplete and syntax hightlight
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer --rust-completer' }
Plug 'w0rp/ale'

" Nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-buffer-ops'

Plug 'ctrlpvim/ctrlp.vim'

" Theme
Plug 'morhetz/gruvbox'
Plug 'mbbill/undotree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Utils
Plug 'ledesmablt/vim-run'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'szw/vim-maximizer'
Plug 'mileszs/ack.vim'
Plug 'mattn/emmet-vim'

" Languages
Plug 'rust-lang/rust.vim'
Plug 'tomlion/vim-solidity'
" Plug 'chrisbra/csv.vim'
call plug#end()

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

noremap ;l :
inoremap jk <ESC>
inoremap <C-t> <Esc>:tabnew<CR>
nnoremap <C-t> :tabnew<CR>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>dp :diffput<SPACE>
nnoremap <leader>dg :diffget<SPACE>
nnoremap <leader>ps :Ack<SPACE>
nnoremap <leader>g :Git<CR>
nnoremap <leader>m :MaximizerToggle<CR>

" YCM
nnoremap <silent> <leader>gt :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>fi :YcmCompleter FixIt<CR>
nnoremap <silent> <leader>gd :YcmCompleter GetDoc<CR>
nnoremap <silent> <leader>oi :YcmCompleter OrganizeImports<CR>
" nnoremap <silent> <leader>rn :YcmCompleter RefactorRename <C-R>=Abolish.Coercions.s(expand("<cword>"))<CR>
nnoremap <leader>rn :YcmCompleter RefactorRename<SPACE>
nmap <leader>yh <plug>(YCMHover)

let g:ycm_auto_hover = ''
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_error_symbol='✗'
let g:ycm_goto_buffer_command = 'vertical-split'
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
  \ 'javascript': ['prettier', 'prettier-standard', 'standard'],
  \ 'typescript': ['prettier'],
  \ }
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_open_list = 0

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>
let g:NERDTreeIgnore=['^node_modules$', '^build$', '^dist$']
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist|build$|Pods|\.class$\/)|(\.(git|hg|svn))$'

" Ultisnip
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsEditSplit="vertical"

" Ack
nnoremap <Leader>ps :Ack!<Space>

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
