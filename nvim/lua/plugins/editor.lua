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
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup()
		end,
		keys = {
			{ "<leader>e", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>", desc = "Mini Files" },
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup()
		end,
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
			{
				"nvim-telescope/telescope-file-browser.nvim",
			},
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
				local files = require("mini.files")

				files.open(path)
			end

			telescope.setup({
				pickers = {
					find_files = {
						mappings = {
							n = {
								["<leader>o"] = function(prompt_bufnr)
									local entry = require("telescope.actions.state").get_selected_entry()
									navigate_to_directory(entry.path)
									-- require("telescope.actions").close(prompt_bufnr)
								end,
							},
						},
					},
				},
				extensions = {
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

			telescope.load_extension("file_browser")
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
}
