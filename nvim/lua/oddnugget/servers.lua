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
	html = {
		filetypes = { "html" },
	},
  lexical = {
    settings = {
      dialyzerEnabled = true,
    },
  }
}

M.unofficial = {
  lexical = function ()
    local configs = require("lspconfig.configs")
    local exists = utils.file_exists("/projects/lexical/_build/dev/package/lexical/bin/start_lexical.sh")
    if not exists then
      vim.notify("Lexical server not found, skipping setup")
      return
    end

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
  end,
}


M.load_unofficial = function()
  for _, loader in pairs(M.unofficial) do
      loader()
  end
end

return M
