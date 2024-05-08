return {
	{
		"MunifTanjim/nougat.nvim",
		event = "VeryLazy",
		config = function()
			local nougat = require("nougat")
			local Bar = require("nougat.bar")

			local nut = {
				buf = {
					filename = require("nougat.nut.buf.filename").create,
				},
				spacer = require("nougat.nut.spacer").create,
			}

			local winbar = Bar("winbar")

			winbar:add_item(nut.buf.filename({
				prefix = "    ",
				suffix = " ",
			}))

			nougat.set_winbar(winbar, { global = true })
		end,
	},
	{
		"luckasRanarison/nvim-devdocs",
		event = "VeryLazy",
		keys = {
			{
				"<leader>dd",
				"<cmd> DevdocsOpenFloat <cr>",
			},
			{
				"<leader>dt",
				"<cmd> DevdocsToggle <cr>",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				"§<Space>",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
			},
			{
				"§a",
				function()
					require("harpoon.mark").add_file()
				end,
			},
			{
				"§q",
				function()
					require("harpoon.ui").nav_file(1)
				end,
			},
			{
				"§w",
				function()
					require("harpoon.ui").nav_file(2)
				end,
			},
			{
				"§e",
				function()
					require("harpoon.ui").nav_file(3)
				end,
			},
			{
				"§r",
				function()
					require("harpoon.ui").nav_file(4)
				end,
			},
			{
				"§t",
				function()
					require("harpoon.ui").nav_file(5)
				end,
			},
		},
	},
	{
		"slim-template/vim-slim",
		ft = "slim",
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<C-Y>",
						accept_word = false,
						accept_line = false,
						next = "<C-n>",
						prev = "<C-p>",
						dismiss = "<C-x>",
					},
				},
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"jpalardy/vim-slime",
		config = function()
			vim.g.slime_target = "kitty"
		end,
		event = { "BufReadPost", "BufNewFile" },
	},
	{ "kassio/neoterm", event = "VeryLazy" },
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		config = true,
		opts = {
			open_cmd = "vertical aboveleft 80new",
		},
		keys = {
			{
				"<leader>rw",
				function()
					-- open left side as a 60 widht panel
					require("spectre").toggle()
				end,
			},
		},
	},
}
