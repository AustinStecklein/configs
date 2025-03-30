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

-- Setup lazy.nvim
-- add all plugins
require("lazy").setup({
    checker = { enabled = true, notify = false },
    spec = {
        -- add your plugins here
        {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
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
        {"AustinStecklein/neo-find"},
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

local vimrc = vim.fn.stdpath("config") .. "/vimconfig.vim"
vim.cmd.source(vimrc)
vim.o.pumheight = 5
require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "asm", "bash", "odin", "rust", "python"},
        auto_install = true,
        highlight = {
            enable = true,
      },
}
-- key mapping for delete without saving
vim.keymap.set("n", "<leader>dd", '"_dd')
vim.keymap.set("v", "<leader>d", '"_d')

-- key mapping for replace with default register
vim.keymap.set("v", "<leader>r", '"_dP')

-- FzfLua keybindings
require("fzf-lua").setup({
    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept",
        },
    },
})

local fzflua = require("fzf-lua")
-- I can't believe I haven't been using this. This is a great plugin
vim.keymap.set("n", "<Leader>f", function() fzflua.files() end)
vim.keymap.set("n", "<Leader>g", function() fzflua.live_grep() end)
vim.keymap.set("n", "<Leader>c", function() fzflua.git_commits() end)
vim.keymap.set("n", "<Leader>s", function() fzflua.git_status() end)
vim.keymap.set("n", "<Leader>b", function() fzflua.git_blame() end)
vim.keymap.set("n", "<Leader>w", function() fzflua.grep_cword() end)
vim.keymap.set("n", "<Leader>W", function() fzflua.grep_cWORD() end)

local neo_find = require("neo-find")
-- the ! -path's and the ! -name's are here to filter dirs that I don't want to see to clean up the search
local ignore_args  = " ! -path '*/venv/*' ! -name 'venv' ! -path '*/.*/*' ! -name '.*' "
vim.keymap.set("n", "<Leader>df", function() neo_find.find_dir(ignore_args) end)
-- this command will not have the filter applied in case that I need to find dirs in the filtered files
vim.keymap.set("n", "<Leader>hf", function() neo_find.find_dir() end)
-- This is the bread and butter commands
vim.keymap.set("n", "<Leader>F", function() neo_find.find_dir_and_search(ignore_args, fzflua.files) end)
vim.keymap.set("n", "<Leader>HF", function() neo_find.find_dir_and_search(ignore_args, fzflua.live_grep) end)

require("oil").setup({
    view_options = {
        show_hidden = true,
    }
})
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}

-- better movement through quickfix lists
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
