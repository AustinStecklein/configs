set tabstop=4
set shiftwidth=4
set number
set relativenumber
set showmatch
set ruler
inoremap jk <Esc>
let mapleader = "'"
set ignorecase
set noswapfile
syntax on
set spell spelllang=en_us
nnoremap <CR> :noh<CR><CR>
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'will/rose-pine-neovim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()
colorscheme rose-pine
