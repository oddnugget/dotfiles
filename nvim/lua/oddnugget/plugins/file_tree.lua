return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle", "NvimTreeOpen" },
		keys = { {
			"<Leader>e",
			"<cmd> NvimTreeToggle <cr>",
			desc = "Toggle File Tree",
		} },
		opts = {
			update_focused_file = {
				enable = true,
			},
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"stevearc/oil.nvim",
		cmd = { "Oil" },
		opts = {
			float = {
				border = "rounded",
				max_width = 60,
				override = function(config)
					config.row = 0
					config.col = 0
					config.height = vim.api.nvim_win_get_height(0) - 1
					return config
				end,
				win_options = {
					conceallevel = 1,
				},
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},
}
