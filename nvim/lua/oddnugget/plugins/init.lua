return {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	-- { "christoomey/vim-tmux-navigator", lazy = false },
	{
		lazy = false,
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
			local opts = { noremap = true }

			vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", opts)
			vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", opts)
			vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", opts)
			vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", opts)
		end,
	},
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
