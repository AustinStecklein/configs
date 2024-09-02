local vimrc = vim.fn.stdpath("config") .. "/vimconfig.vim"
vim.cmd.source(vimrc)
require'nvim-treesitter.configs'.setup {
	ensure_install = {"c", "lua", "python"},
	sync_install = false,
	
	highlight = { 
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
