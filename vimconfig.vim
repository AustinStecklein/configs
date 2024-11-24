" basic remaps and initial settings
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set showmatch
set ruler
inoremap jk <Esc>
let mapleader = " "
set ignorecase
set noswapfile
nnoremap <CR> :noh<CR><CR>
syntax on

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

" lsp plugins
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

" color scheme settings
colorscheme rose-pine

" FzfLua keybindings
" I can't believe I haven't been using this. This is a great plugin
nnoremap <Leader>f <cmd>lua require('fzf-lua').files()<CR>
nnoremap <Leader>g <cmd>lua require('fzf-lua').live_grep()<CR>
nnoremap <Leader>c <cmd>lua require('fzf-lua').git_commits()<CR>
nnoremap <Leader>s <cmd>lua require('fzf-lua').git_status()<CR>
