local utils = require("oddnugget.utils")
local M = {}

M.list = {
	astro = {
		settings = {
			astro = {
				enable = true,
				lint = {
					enable = true,
					onSave = true,
				},
			},
		},
	},
	taplo = {
		settings = {
			taplo = {
				enable = true,
				lint = {
					enable = true,
					onSave = true,
				},
			},
		},
	},
	bashls = {
		filetypes = { "sh", "zsh", "zshrc", ".zshrc" },
		settings = {
			{
				bashIde = {
					globPattern = "*@(.sh|.inc|.zsh|.bash|.command)",
				},
			},
		},
	},
	lua_ls = {
		-- settings = {
		-- 	Lua = {
		-- 		workspace = {
		-- 			checkThirdParty = false,
		-- 		},
		-- 		globals = {
		-- 			"vim",
		-- 			"Snacks",
		-- 		},
		-- 		completion = { callSnippet = "Replace" },
		-- 		telemetry = { enable = false },
		-- 		hint = {
		-- 			enable = false,
		-- 		},
		-- 	},
		-- },
	},
	pyright = {},
	ts_ls = {
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
	solargraph = {
		cmd = { "./tmp/devbox/binwrappers/solargraph", "stdio" },
		root_dir = require("lspconfig").util.root_pattern("Gemfile", ".git"),
		settings = {
			solargraph = {
				autoformat = false,
				completion = true,
				diagnostic = true,
				folding = true,
				references = true,
				rename = true,
				symbols = true,
			},
		},
	},
	-- lexical = {
	-- 	settings = {
	-- 		dialyzerEnabled = true,
	-- 	},
	-- },
}

M.unofficial = {
	lexical = function()
		local path = os.getenv("NVIM_LEXICAL_PATH")

		if not path then
			return
		end
		local configs = require("lspconfig.configs")
		local exists = utils.file_exists(path)

		if not exists then
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
