---@diagnostic disable missing-fields
return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			local swap_next, swap_prev = (function()
				local swap_objects = {
					p = "@parameter.inner",
					f = "@function.outer",
					c = "@class.outer",
				}

				local n, p = {}, {}
				for key, obj in pairs(swap_objects) do
					n[string.format("<leader>cx%s", key)] = obj
					p[string.format("<leader>cX%s", key)] = obj
				end

				return n, p
			end)()

			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"rust",
					"tsx",
					"typescript",
					"vim",
					"yaml",
					"heex",
					"elixir",
				},
				highlight = { enable = true },
				indent = { enable = true, disable = { "python" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
			})
		end,
	},
}
