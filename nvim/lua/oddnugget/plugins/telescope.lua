return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = true,
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			-- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			-- { "<leader>fF", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files" },
			-- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			-- { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			-- {
			-- 	"<leader>fw",
			-- 	function()
			-- 		require("telescope").extensions.live_grep_args.live_grep_args()
			-- 	end,
			-- 	desc = "Grep",
			-- },
			-- {
			-- 	"<leader>zc",
			-- 	function()
			-- 		require("telescope.builtin").colorscheme({ enable_preview = true })
			-- 	end,
			-- 	desc = "Colorscheme",
			-- },
			-- {
			-- 	"<leader>gw",
			-- 	function()
			-- 		require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
			-- 	end,
			-- },
			-- {
			-- 	"<leader>f<leader>",
			-- 	"<cmd> Telescope resume<cr>",
			-- },
			-- {
			-- 	"<leader>do",
			-- 	"<cmd> Telescope diagnostics<cr>",
			-- },
		},
		config = function()
			local lga_actions = require("telescope-live-grep-args.actions")
			local telescope = require("telescope")
			local actions = require("telescope.actions")

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
					buffers = {
						mappings = {
							n = {
								["<c-d>"] = actions.delete_buffer + actions.move_to_top,
							},
						},
					},
				},
				extensions = {
					extensions = {
						fzf = {
							fuzzy = true,
							override_generic_sorter = true,
							override_file_sorter = true,
							case_mode = "smart_case",
						},
					},
					live_grep_args = {
						mappings = {
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-n>s"] = lga_actions.quote_prompt({ postfix = " -i '!spec' " }),
							},
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
		end,
	},
}
