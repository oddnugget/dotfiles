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
		keys = {
			{
				"<leader>e",
				function()
					local oil = require("oil")
					oil.toggle_float()
				end,
				desc = "oil: open(edit)",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{
				"<leader>fw",
				function()
					require("telescope").extensions.live_grep_args.live_grep_args()
				end,
				desc = "Grep",
			},
			{
				"<leader>zc",
				function()
					require("telescope.builtin").colorscheme({ enable_preview = true })
				end,
				desc = "Colorscheme",
			},
			{
				"<leader>fW",
				function()
					require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
				end,
			},
			{
				"<leader>f<leader>",
				"<cmd> Telescope resume<cr>",
			},
		},
		config = function()
			local lga_actions = require("telescope-live-grep-args.actions")
			local telescope = require("telescope")

			local function navigate_to_directory(path)
				local files = require("oil")

				files.open(path)
			end

			telescope.setup({
				pickers = {
					find_files = {
						mappings = {
							n = {
								["<leader>o"] = function(_)
									local entry = require("telescope.actions.state").get_selected_entry()
									navigate_to_directory(entry.path)
								end,
							},
						},
					},
				},
				extensions = {
					extensions = {
						fzf = {
							fuzzy = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter = true, -- override the file sorter
							case_mode = "smart_case", -- or "ignore_case" or "respect_case"
							-- the default case_mode is "smart_case"
						},
					},
					live_grep_args = {
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<S-C-k>"] = lga_actions.quote_prompt(),
								["<S-C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							},
						},

						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
		end,
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
			vim.g.slime_target = "tmux"
		end,
		event = "BufReadPost",
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
