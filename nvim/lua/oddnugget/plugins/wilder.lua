return {
	{
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
