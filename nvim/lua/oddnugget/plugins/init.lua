return {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	-- { "christoomey/vim-tmux-navigator", lazy = false },
	{
		-- "mrjones2014/smart-splits.nvim",
		dir = "/projects/nvim-forks/smart-splits.nvim",
		lazy = false,
		config = function()
			require("smart-splits").setup({ log_level = "trace", at_edge = "stop" })
			-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
			-- vim.keymap.set("n", "<SC-h>", require("smart-splits").resize_left)
			-- vim.keymap.set("n", "<SC-j>", require("smart-splits").resize_down)
			-- vim.keymap.set("n", "<SC-k>", require("smart-splits").resize_up)
			-- vim.keymap.set("n", "<SC-l>", require("smart-splits").resize_right)
			-- moving between splits
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
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
