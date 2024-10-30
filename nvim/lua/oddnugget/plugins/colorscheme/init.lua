return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({ transparent_background = true })
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
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
