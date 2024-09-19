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
				"<Leader>bb",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
			},
			{
				"<Leader>ba",
				function()
					require("harpoon.mark").add_file()
				end,
			},
			{
				"<Leader><Leader>1",
				function()
					require("harpoon.ui").nav_file(1)
				end,
			},
			{
				"<Leader><Leader>2",
				function()
					require("harpoon.ui").nav_file(2)
				end,
			},
			{
				"<Leader><Leader>3",
				function()
					require("harpoon.ui").nav_file(3)
				end,
			},
			{
				"<Leader><Leader>4",
				function()
					require("harpoon.ui").nav_file(4)
				end,
			},
			{
				"<Leader><Leader>5",
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
		enabled = false,
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
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			-- size can be a number or function which is passed the current terminal
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return vim.o.lines * 0.25
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = false,
				hide_numbers = true, -- hide the number column in toggleterm buffers
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
				start_in_insert = true,
				persist_size = false,
				direction = "horizontal",
				close_on_exit = false, -- close the terminal window when the process exits
				shell = vim.o.shell, -- change the default shell
				-- This field is only relevant if direction is set to 'float'
				float_opts = {
					-- The border key is *almost* the same as 'nvim_win_open'
					-- see :h nvim_win_open for details on borders however
					-- the 'curved' border is a custom border type
					-- not natively supported but implemented in this plugin.
					border = "single",
					width = math.floor(vim.o.columns * 0.9),
					height = math.floor(vim.o.lines * 0.9),
					winblend = 3,
					highlights = { border = "ColorColumn", background = "ColorColumn" },
				},
			})

			vim.keymap.set("n", "<C-t><C-t>", function()
				return "<cmd>" .. vim.v.count .. "ToggleTerm<cr>"
			end, { expr = true })

			vim.keymap.set("n", "<C-t><C-f>", function()
				return "<cmd>" .. vim.v.count .. "ToggleTerm direction=float <cr>"
			end, { expr = true })

			vim.keymap.set("n", "<C-t><C-h>", function()
				return "<cmd>" .. vim.v.count .. "ToggleTerm direction=horizontal<cr>"
			end, { expr = true })

			vim.keymap.set("n", "<C-t><C-v>", function()
				return "<cmd>" .. vim.v.count .. "ToggleTerm direction=vertical <cr>"
			end, { expr = true })
		end,
	},
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
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			-- add any custom options here
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
	},
}
