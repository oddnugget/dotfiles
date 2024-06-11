return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		enabled = false,
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
		keys = {
			{
				"<Leader>e",
				"<cmd> Oil <cr>",
				desc = "Toggle File Tree",
			},
		},
		opts = {
			default_file_explorer = true,
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},
}
