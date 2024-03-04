local utils = require("oddnugget.utils")
local M = {}

M.list = {
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				checkOnSave = {
					command = "cargo clippy",
					extraArgs = { "--no-deps" },
				},
			},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				completion = { callSnippet = "Replace" },
				telemetry = { enable = false },
				hint = {
					enable = false,
				},
			},
		},
	},
	tsserver = {
		disable_formatting = false,
	},
	dockerls = {},
	cssls = {},
	emmet_ls = {
		settings = {
			includeLanguages = {
				["html-eex"] = "html",
				["phoenix-heex"] = "html",
				eruby = "html",
			},
		},
		filetypes = {
			"html",
			"javascriptreact",
			"typescriptreact",
			"html.heex",
			"heex",
			"html_heex",
			"html_eex",
			"phoenix-heex",
			"phoenix_heex",
			"eruby",
		},
	},
	html = {
		settings = {
			includeLanguages = {
				["html-eex"] = "html",
				["phoenix-heex"] = "html",
				eruby = "html",
			},
			format = false,
		},
		filetypes = {
			"html",
			"react",
			"typescriptreact",
			"html.heex",
			"heex",
			"html_heex",
			"html_eex",
			"phoenix-heex",
			"phoenix_heex",
			"eruby",
		},

		init_options = {
			configurationSection = {
				"html",
				"css",
				"javascript",
				"heex",
				"html.heex",
				"html_heex",
				"html_eex",
				"phoenix-heex",
				"phoenix_heex",
				"eruby",
			},
			embeddedLanguages = {
				css = true,
				javascript = true,
				elixir = true,
			},
			provideFormatter = false,
		},
	},
	lexical = {
		settings = {
			dialyzerEnabled = true,
		},
	},
}

M.unofficial = {
	lexical = function()
		local path = "/Users/odyrag/dev/projects/lexical/_build/dev/package/lexical/bin/start_lexical.sh"
		local configs = require("lspconfig.configs")
		local exists = utils.file_exists(path)

		if not exists then
			vim.notify("Lexical server not found, skipping setup")
			return
		end

		if not configs.lexical then
			configs.lexical = {
				default_config = {
					cmd = { path },
					filetypes = { "elixir", "eelixir", "heex", "surface" },
					root_dir = require("lspconfig").util.root_pattern("mix.exs", ".git"),
					settings = {},
				},
			}
		end
	end,
}

M.load_unofficial = function()
	for _, loader in pairs(M.unofficial) do
		loader()
	end
end

return M
