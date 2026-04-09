-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
  vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 6
vim.opt.spell = false
--vim.opt.spelllang = { "en_us" }
vim.opt.list = true
vim.opt.listchars = { trail = "~", tab = ">-", nbsp = "␣" }
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.keymap.set("n", "<CR>", ":noh<CR><CR>")
vim.cmd("packadd cfilter")

-- Setup lazy.nvim
-- add all plugins
require("lazy").setup({
    checker = { enabled = true, notify = false },
    spec = {
        -- add your plugins here
        {
        "rebelot/kanagawa.nvim",
        -- config = function()
        --     vim.cmd("colorscheme  kanagawa")
        -- end
        },
        {
          'stevearc/oil.nvim',
          opts = {},
          dependencies = { { "echasnovski/mini.icons", opts = {} } },
          lazy = false,
        },
        {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
        {"neovim/nvim-lspconfig"},
        {"ibhagwan/fzf-lua"},
        { 'nvim-mini/mini.nvim', version = false },
        {'tpope/vim-fugitive'},
        {'kamykn/spelunker.vim'},

        {
          'stevearc/overseer.nvim',
          opts = {},
        },
        {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            signature = { enabled = true }
        },
        opts_extend = { "sources.default" }
        }
    },
    install = { colorscheme = { "habamax" } },
})
-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.cmd("hi clear SpellBad")
        vim.cmd("hi SpellBad cterm=underline ctermfg=red")
    end
})

-- Run commands from neovim... I almost switched to emacs until I found this.
require("overseer").setup({
    task_list = {
    direction = "left",
    }
})
vim.keymap.set("n", "<Leader>s", ':OverseerShell<CR>')
vim.keymap.set("n", "<Leader>t", ':OverseerToggle<CR>')

vim.o.pumheight = 5
require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "asm", "bash", "odin", "rust", "python", "ocaml"},
        auto_install = true,
        highlight = {
            enable = true,
      },
}
-- key mapping for delete without saving
vim.keymap.set("n", "<leader>xx", '"_dd')
vim.keymap.set("v", "<leader>x", '"_d')

-- FzfLua keybindings
require("fzf-lua").setup({
    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept",
            ["ctrl-j"]      = "half-page-down",
            ["ctrl-k"]      = "half-page-up",
        },
    },
})

local fzflua = require("fzf-lua")
-- I can't believe I haven't been using this. This is a great plugin
vim.keymap.set("n", "<Leader>f", function() fzflua.files() end)
vim.keymap.set("n", "<Leader>g", function() fzflua.live_grep() end)
vim.keymap.set("n", "<Leader>G", function() fzflua.live_grep_resume() end)
vim.keymap.set("n", "<Leader>w", function() fzflua.grep_cword() end)
vim.keymap.set("n", "<Leader>W", function() fzflua.grep_cWORD() end)
vim.keymap.set("n", "<Leader>r", function() fzflua.resume() end)
vim.keymap.set("n", "<Leader>b", function() fzflua.buffers() end)

require("oil").setup({
    view_options = {
        show_hidden = true,
    }
})
vim.keymap.set("n", "<Leader>o", ':Oil<CR>')
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('ocamllsp')

-- fugitive keybindings
vim.keymap.set("n", "<Leader>d", ":Git<CR>:exe 'resize'.(winheight(0)/2)<CR>")
vim.keymap.set("n", "<Leader>D", ':Gvdiffsplit<CR>')

vim.diagnostic.config({virtual_text = true})
vim.keymap.set("n","<Leader>e", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})
