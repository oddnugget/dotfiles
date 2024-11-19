return {
	{
		"catppuccin/nvim",
		lazy = false,
		enabled = true,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				custom_highlights = function(colors)
					return {
						["@module.elixir"] = { fg = colors.peach },
					}
				end,
			})
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = function()
			require("kanagawa").setup({
				theme = "dragon",
				transparent = true,
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
			vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},
}
