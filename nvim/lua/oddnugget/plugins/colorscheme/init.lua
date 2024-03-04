return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				theme = "wave",
				transparent = "true",
				overrides = function(colors)
					return {
						["@module.elixir"] = { fg = colors.palette.waveAqua2 },
					}
				end,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
}

-- "@module.elixir"
