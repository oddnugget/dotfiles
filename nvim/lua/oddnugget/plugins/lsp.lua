local function get_server_capabilities()
	local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	return vim.tbl_deep_extend("force", lsp_capabilities, cmp_capabilities)
end

local function setup_formatting(_, bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormat" .. bufnr, {}),
		buffer = bufnr,
		callback = function()
			require("conform").format({ async = false, bufnr = bufnr, lsp_fallback = true })
		end,
	})
end

local function setup_keymaps(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	local opts_with_desc = function(desc)
		return vim.tbl_extend("force", bufopts, { desc = desc })
	end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts_with_desc("Go to definition"))
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts_with_desc("Go to references"))
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts_with_desc("Hover"))
	vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts_with_desc("Signature Help"))
	vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, opts_with_desc("Open Diagnostics"))
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts_with_desc("Code Action"))
	vim.keymap.set("n", "<Leader>fm", function()
		require("conform").format({ async = false, lsp_fallback = true })
	end, opts_with_desc("Format"))
end

local function get_server_config(servers, name)
	local config = name and servers.list[name] or {}

	if type(config) == "function" then
		config = config()
		if not config or config == nil then
			return
		end
	end

	config.on_attach = function(client, bufnr)
		if not client or not bufnr then
			vim.notify("No LSP client found, aborting on_attach")
			return
		end

		setup_formatting(client, bufnr)
		setup_keymaps()
	end

	config.capabilities = get_server_capabilities()

	return config
end

local config = function()
	local lspconfig = require("lspconfig")
	local servers = require("oddnugget.servers")

	if servers ~= nil then
		servers.load_unofficial()

		for server_name, _ in pairs(servers.list) do
			local cfg = get_server_config(servers, server_name)

			if cfg ~= nil then
				lspconfig[server_name].setup(cfg)
			end
		end
	end
end

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
		config = config,
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
