return {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "tpope/vim-fugitive", lazy = false },
	{ "tpope/vim-rails", ft = { "ruby", "slim" } },
	{ "tpope/vim-projectionist", lazy = false },
	{ "tpope/vim-dispatch", lazy = false },
	{
		"tpope/vim-commentary",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "sql",
				callback = function()
					vim.opt_local.commentstring = "-- %s"
				end,
			})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = { default = true },
	},
}
