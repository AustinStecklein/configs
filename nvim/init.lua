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
        {'tpope/vim-fugitive'},
        {'tommcdo/vim-fubitive'},
        {'tpope/vim-rhubarb'},
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
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "asm", "bash", "odin", "rust", "python", "ocaml"},
        auto_install = true,
        highlight = {
            enable = true,
      },
}
-- key mapping for delete without saving
vim.keymap.set("n", "<leader>dd", '"_dd')
vim.keymap.set("v", "<leader>d", '"_d')

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
vim.keymap.set("n", "<Leader>G", function() fzflua.live_grep_resume() end)
vim.keymap.set("n", "<Leader>c", function() fzflua.git_commits() end)
vim.keymap.set("n", "<Leader>s", function() fzflua.git_status() end)
vim.keymap.set("n", "<Leader>b", function() fzflua.git_blame() end)
vim.keymap.set("n", "<Leader>w", function() fzflua.grep_cword() end)
vim.keymap.set("n", "<Leader>W", function() fzflua.grep_cWORD() end)
vim.keymap.set("n", "<Leader>r", function() fzflua.resume() end)

require("oil").setup({
    view_options = {
        show_hidden = true,
    }
})
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('ocamllsp')

vim.diagnostic.config({virtual_text = true})
vim.keymap.set("n","<Leader>e", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})
