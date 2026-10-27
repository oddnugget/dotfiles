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
    filetypes = { "sh", "zsh" },
    settings = {
      bashIde = {
        globPattern = "*@(.sh|.inc|.zsh|.bash|.command)",
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
  basedpyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
    before_init = function(_, config)
      -- Try to find the Python interpreter from uv
      local venv_path = vim.fn.getcwd() .. "/.venv"
      local uv_python = vim.fn.getcwd() .. "/.venv/bin/python"

      -- Check if .venv exists (uv project)
      if vim.fn.isdirectory(venv_path) == 1 then
        config.settings.python.pythonPath = uv_python
      end
    end,
  },
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
    root_markers = { "Gemfile", ".git" },
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
  lexical = function()
    local path = os.getenv("NVIM_LEXICAL_PATH")

    if not path or not utils.file_exists(path) then
      return
    end

    return { cmd = { path } }
  end,
}

return M
