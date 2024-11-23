return {
	{
		enabled = false,
		"gelguy/wilder.nvim",
		event = "CmdlineEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("wilder").setup({
				modes = {
					"/",
					"?",
					":",
				},
			})

			local wilder = require("wilder")

			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline({
						fuzzy = 1,
						set_pcre2_pattern = 1,
					}),
					wilder.python_search_pipeline({
						pattern = "fuzzy",
					})
				),
			})

			local highlighters = {
				wilder.basic_highlighter(),
			}

			local render_popup = {
				highlighter = highlighters,
				left = {
					" ",
					wilder.popupmenu_devicons(),
				},
				highlights = {
					border = "Normal",
				},
				border = "rounded",
				pumblend = 4,
				max_height = 12,
			}

			wilder.set_option("renderer", wilder.popupmenu_renderer(render_popup))
		end,
	},
}
