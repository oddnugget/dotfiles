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
  lua_ls = {},
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
      -- Use the project's uv virtualenv when there is one
      local venv_path = (config.root_dir or vim.fn.getcwd()) .. "/.venv"

      if vim.fn.isdirectory(venv_path) == 1 then
        config.settings.python.pythonPath = venv_path .. "/bin/python"
      end
    end,
  },
  ts_ls = {},
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
  -- Same servers as Zed; both are installed through mise
  expert = {},
  ruby_lsp = {},
}

return M
