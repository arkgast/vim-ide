set nocompatible
filetype off
let &runtimepath.=',~/.vim/plugged/ale'
let filetypesWithTag = ['html', 'htmldjango', 'php', 'javascript.jsx', 'smarty', 'xml', 'xhtml']

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer --omnisharp-completer' }
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'arkgast/nerdtree-execute', { 'on': 'NERDTreeToggle', 'branch': 'standard_linux_opener' }
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-signify'
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript.jsx' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript.jsx' }
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }
Plug 'mattn/emmet-vim', { 'for': filetypesWithTag }
Plug 'Valloric/MatchTagAlways', { 'for': filetypesWithTag }
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'gko/vim-coloresque', { 'for': ['css', 'scss', 'sass'] }
Plug 'alampros/vim-styled-jsx', { 'for': 'javascript.jsx' }
Plug 'jparise/vim-graphql', { 'for': 'javascript.jsx' }
Plug 'OrangeT/vim-csharp', { 'for': 'cs' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'alpertuna/vim-header'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-fugitive'
call plug#end()

filetype plugin indent on

" Configurations
colorscheme gruvbox
set background=dark
set backspace=2
set encoding=utf8
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set foldtext=CustomFoldText()
set foldmethod=indent
set foldnestmax=3
set foldlevel=2
set relativenumber
set nowrap
set hlsearch
set incsearch
set wildmenu
set wildignore+=*.pyc,*.zip
set showmatch
set nobackup
set noswapfile
set nowritebackup
set noshowmode
set noshowcmd
set mouse=a
set autoread
set laststatus=2
autocmd CursorHold * checktime
set list
exec "set listchars=tab:»·,nbsp:_,trail:·,eol:¬"

let mapleader = ","
call matchadd('ColorColumn', '\%81v', 100)
highlight Normal ctermbg=none

autocmd FileType python,cs,java setlocal tabstop=4 shiftwidth=4
autocmd Filetype gitcommit setlocal spell textwidth=72

" Custom mappings
noremap ;l :
inoremap jk <ESC>
inoremap <C-t> <Esc>:tabnew<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <F3> :set hlsearch!<CR>
noremap % v%
" Move lines, up or down
vnoremap > >gv
vnoremap < <gv
" Move many lines, up or down
nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==
inoremap <C-Down> <Esc>:m .+1<CR>==gi
inoremap <C-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv

" YouCompleteMe
let g:ycm_allow_changing_updatetime = 0
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'vertical-split'
let g:ycm_error_symbol='✗'
let g:ycm_warning_symbol='⚠'
nnoremap <leader>kk :YcmCompleter GoTo<CR>
nnoremap <leader>kj :YcmCompleter GetDoc<CR>
nnoremap <leader>kf :YcmCompleter FixIt<CR>
nnoremap <leader>kr :YcmCompleter ReloadSolution<CR>

" ale - linter
let g:ale_sign_column_always = 1
let g:ale_sign_error='✗'
let g:ale_sign_warning='⚠'
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'python': ['flake8'],
  \   'php': ['php'],
  \   'css': ['stylelint'],
  \   'sass': ['stylelint']
  \ }
let g:ale_python_flake8_args = '--ignore=E501'

" eclim
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimJavascriptValidate = 0
let g:EclimLogLevel = 'trace'

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
let NERDTreeIgnore=["\.pyc$", "node_modules"]
let NERDTreeMouseMode=2

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist|build\/)|(\.(git|hg|svn))$'

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
let g:user_emmet_install_global = 1
let g:user_emmet_settings = {
  \   'javascript.jsx': {
  \     'extends': 'jsx'
  \   }
  \ }

" MatchAlways
nnoremap <leader>% :MtaJumpToOtherTag<cr>
let g:mta_filetypes = {
  \ 'html': 1,
  \ 'xhtml': 1,
  \ 'xml': 1,
  \ 'htmldjango': 1,
  \ 'smarty': 1,
  \ 'javascript.jsx': 1,
  \ 'php': 1
  \ }

" vim-header
let g:header_field_filename = 0
let g:header_field_author = 'Arnold Gandarillas Castillo'
let g:header_field_author_email = 'arkgast@gmail.com'
let g:header_auto_add_header = 0
map <C-h>h :AddHeader<CR>
map <C-h>a :AddApacheLicense<CR>
map <C-h>m :AddMITLicense<CR>
map <C-h>g :AddGNULicense<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

" Functions
" Airline
function! AirlineInit()
  let g:airline_section_y = airline#section#create(['%p%%'])
  let g:airline_section_z = airline#section#create_right(['%l:%c'])
endfunction

" NERDTree
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

" Goyo
function! s:goyo_enter()
  highlight Normal ctermbg=235
  set background=dark
  set norelativenumber
endfunction

function! s:goyo_leave()
  highlight Normal ctermbg=none
  set relativenumber
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

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
