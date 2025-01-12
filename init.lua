local vimrc = vim.fn.stdpath("config") .. "/vimconfig.vim"
vim.cmd.source(vimrc)
vim.o.pumheight = 5
require'nvim-treesitter.configs'.setup {
    ensure_install = {"c", "lua", "python"},
    sync_install = false,
	
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Harpoon keybindings
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)

-- Some helper functions for harpoon
vim.keymap.set("n", "<leader>c", function() harpoon:list():clear() end)
vim.keymap.set("n", "<leader>1a", function() harpoon:list():replace_at(1) end)
vim.keymap.set("n", "<leader>2a", function() harpoon:list():replace_at(2) end)
vim.keymap.set("n", "<leader>3a", function() harpoon:list():replace_at(3) end)
vim.keymap.set("n", "<leader>4a", function() harpoon:list():replace_at(4) end)

-- key mapping for delete without saving
vim.keymap.set("n", "<leader>dd", '"_dd')
vim.keymap.set("v", "<leader>d", '"_d')
 
-- key mapping for replace with default register
vim.keymap.set("v", "<leader>r", '"_dP')

-- FzfLua keybindings
local fzflua = require("fzf-lua")

-- I can't believe I haven't been using this. This is a great plugin
vim.keymap.set("n", "<Leader>f", function() fzflua.files() end)
vim.keymap.set("n", "<Leader>g", function() fzflua.live_grep() end)
vim.keymap.set("n", "<Leader>c", function() fzflua.git_commits() end)
vim.keymap.set("n", "<Leader>s", function() fzflua.git_status() end)

local neo_find = require("neo-find")
-- the ! -path's and the ! -name's are here to filter dirs that I don't want to see to clean up the search 
local ignore_args  = " ! -path '*/venv/*' ! -name 'venv' ! -path '*/.*/*' ! -name '.*' "
vim.keymap.set("n", "<Leader>df", function() neo_find.find_dir(ignore_args) end)
-- this command will not have the filter applied in case that I need to find dirs in the filtered files
vim.keymap.set("n", "<Leader>hf", function() neo_find.find_dir() end)

-- This is the bread and butter command
vim.keymap.set("n", "<Leader>ff", function() neo_find.find_dir_and_search(ignore_args, fzflua.files) end)
