return {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	-- { "christoomey/vim-tmux-navigator", lazy = false },
	-- {
	-- 	lazy = false,
	-- 	"numToStr/Navigator.nvim",
	-- 	config = function()
	-- 		require("Navigator").setup()
	-- 		local opts = { noremap = true }

	-- 		vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", opts)
	-- 		vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", opts)
	-- 		vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", opts)
	-- 		vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", opts)
	-- 	end,
	-- },
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		config = function()
			require("smart-splits").setup()
			-- recommended mappings
			-- resizing splits
			-- these keymaps will also accept a range,
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
			vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
			-- swapping buffers between windows
			vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
			vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
			vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
			vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
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
