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
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
