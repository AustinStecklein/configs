local vimrc = vim.fn.stdpath("config") .. "/vimconfig.vim"
vim.cmd.source(vimrc)
vim.o.pumheight = 5

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
-- This is the bread and butter commands
vim.keymap.set("n", "<Leader>F", function() neo_find.find_dir_and_search(ignore_args, fzflua.files) end)
vim.keymap.set("n", "<Leader>HF", function() neo_find.find_dir_and_search(ignore_args, fzflua.live_grep) end)
