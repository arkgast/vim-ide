set nocompatible
filetype off
let &runtimepath.='./plugged/ale'

call plug#begin('~/.config/nvim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

filetype plugin on

" Configurations
set backspace=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Ale configurations
let g:ale_sign_column_always = 1
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}

" Airline configuration
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_y = airline#section#create(['%p%%'])
let g:airline_section_z = airline#section#create_right(['%l', '%c'])
