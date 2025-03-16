" basic remaps and initial settings
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set showmatch
set ruler
set ignorecase
set noswapfile

" Make find recursive
set path+=**
set wildignore+=**/.py*/**
packadd cfilter

" Make the files browser better
let g:netrw_banner=0

" best remap there has ever been
inoremap jk <Esc>
let mapleader = " "

" ctags!
command! MakeTags !ctags -R .
" This will keep looking up one folder for a tags file
set tags=./tags;/


" I want my search to clear after hitting enter
nnoremap <CR> :noh<CR><CR>
syntax on

" This is an attempt to make the clipboard work
set clipboard^=unnamed,unnamedplus

" Keep 3 lines below and above the cursor
set scrolloff=6

"spell checker settings
set spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
nnoremap <Leader>z z=

" Plug in section
call plug#begin()
Plug 'ibhagwan/fzf-lua'
Plug 'will/rose-pine-neovim'
Plug 'stevearc/oil.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
" my very own plugin 
Plug 'AustinStecklein/neo-find'
call plug#end()

" color scheme settings
colorscheme rose-pine
