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

" best remap there has ever been
inoremap jk <Esc>
let mapleader = " "

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
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'will/rose-pine-neovim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}
" my very own plugin 
Plug 'AustinStecklein/neo-find'

" lsp plugins
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

" color scheme settings
colorscheme rose-pine

" lsp keybindings. I don't want to be bothered :)
let g:lsp_diagnostics_virtual_text_enabled = 0
