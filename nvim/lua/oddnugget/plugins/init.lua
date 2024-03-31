return {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{ "tpope/vim-fugitive", lazy = false },
	{
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",
		lazy = false,
		config = function()
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
		end,
	},
	{
		"tpope/vim-projectionist",
		lazy = false,
		config = function()
			vim.g.projectionist_heuristics = {
				["mix.exs"] = {
					["lib/**/controllers/*_controller.ex"] = {
						type = "controller",
						alternate = "test/{dirname}/controllers/{basename}_controller_test.exs",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Controller do",
							"  use {dirname|camelcase|capitalize}, :controller",
							"end",
						},
					},
					["test/**/controllers/*_controller_test.exs"] = {
						type = "test",
						alternate = "lib/{dirname}/controllers/{basename}_controller.ex",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ControllerTest do",
							"  use {dirname|camelcase|capitalize}.ConnCase, async: true",
							"end",
						},
					},
					["lib/**/controllers/*_html.ex"] = {
						type = "html",
						alternate = "test/{dirname}/controllers/{basename}_html_test.exs",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}HTML do",
							"  use {dirname|camelcase|capitalize}, :html",
							"",
							[[  embed_templates "{basename|snakecase}_html/*"]],
							"end",
						},
					},
					["test/**/controllers/*_html_test.exs"] = {
						type = "test",
						alternate = "lib/{dirname}/controllers/{basename}_html.ex",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}HTMLTest do",
							"  use {dirname|camelcase|capitalize}.ConnCase, async: true",
							"",
							"  alias {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}HTML",
							"end",
						},
					},
					["lib/**/live/*_live.ex"] = {
						type = "liveview",
						alternate = "test/{dirname}/live/{basename}_live_test.exs",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Live do",
							"  use {dirname|camelcase|capitalize}, :live_view",
							"end",
						},
					},
					["lib/**/live/*_live.html.heex"] = {
						type = "html",
						alternate = "lib/{dirname}/live/{basename}_live.ex",
					},
					["test/**/live/*_live_test.exs"] = {
						type = "test",
						alternate = "lib/{dirname}/live/{basename}_live.ex",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}LiveTest do",
							"  use {dirname|camelcase|capitalize}.ConnCase",
							"",
							"  import Phoenix.LiveViewTest",
							"end",
						},
					},
					["lib/**/live/*_component.ex"] = {
						type = "livecomponent",
						alternate = "lib/{dirname}/live/{basename}_component.html.heex",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Live do",
							"  use {dirname|camelcase|capitalize}, :live_view",
							"end",
						},
					},
					["lib/**/live/*_component.html.heex"] = {
						type = "html",
						alternate = "lib/{dirname}/live/{basename}_component.ex",
					},
					["lib/**/channels/*_channel.ex"] = {
						type = "channel",
						alternate = "test/{dirname}/channels/{basename}_channel_test.exs",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Channel do",
							"  use {dirname|camelcase|capitalize}, :channel",
							"end",
						},
					},
					["test/**/channels/*_channel_test.exs"] = {
						type = "test",
						alternate = "lib/{dirname}/channels/{basename}_channel.ex",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ChannelTest do",
							"  use {dirname|camelcase|capitalize}.ChannelCase, async: true",
							"",
							"  alias {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Channel",
							"end",
						},
					},
					["test/**/features/*_test.exs"] = {
						type = "feature",
						template = {
							"defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Test do",
							"  use {dirname|camelcase|capitalize}.FeatureCase, async: true",
							"end",
						},
					},
					["lib/*.ex"] = {
						type = "source",
						alternate = "test/{}_test.exs",
						template = { "defmodule {camelcase|capitalize|dot} do", "end" },
					},
					["test/*_test.exs"] = {
						type = "test",
						alternate = "lib/{}.ex",
						template = {
							"defmodule {camelcase|capitalize|dot}Test do",
							"  use ExUnit.Case, async: true",
							"",
							"  alias {camelcase|capitalize|dot}",
							"end",
						},
					},
				},
			}
		end,
	},
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
