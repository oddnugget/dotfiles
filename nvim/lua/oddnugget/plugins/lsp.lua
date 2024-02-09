return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = function()
					require("mason").setup()
					require("mason-lspconfig").setup({ automatic_installation = true })
				end,
			},
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			{ "j-hui/fidget.nvim", config = true },
			"simrat39/rust-tools.nvim",
			"rust-lang/rust.vim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
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
