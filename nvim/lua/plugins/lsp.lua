return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			{ "j-hui/fidget.nvim", config = true },
			"simrat39/rust-tools.nvim",
			"rust-lang/rust.vim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function(plugin)
			local configs = require("lspconfig.configs")

			if not configs.lexical then
				configs.lexical = {
					default_config = {
						cmd = { "/projects/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
						filetypes = { "elixir", "eelixir", "heex", "surface" },
						root_dir = require("lspconfig").util.root_pattern("mix.exs", ".git"),
						settings = {},
					},
				}
			end

			require("plugins.lsp.servers").setup(plugin)
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		ensure_installed = {
			"stylua",
		},
		config = function(plugin)
			require("mason").setup()
			local mr = require("mason-registry")
			for _, tool in ipairs(plugin.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		event = "BufReadPre",
		config = function()
			require("conform").setup({
				log_level = vim.log.levels.DEBUG,
				notify_on_error = true,
				formatters_by_ft = {
					lua = { "stylua" },
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettierd", "prettier" } },
					scss = { { "prettierd", "prettier" } },
				},
			})
		end,
	},
}
