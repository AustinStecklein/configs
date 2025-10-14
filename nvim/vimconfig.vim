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
set signcolumn=yes

packadd cfilter
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

" highlight trailing whitespace in red
set list
set listchars=trail:~,tab:>-,nbsp:␣
match errorMsg /\s\+$/
