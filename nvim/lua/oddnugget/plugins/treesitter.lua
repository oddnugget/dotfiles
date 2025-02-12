---@diagnostic disable missing-fields
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.plantuml = {
        install_info = {
          url = "~/dev/neovim/tree-sitter-plantuml",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "plantuml",
      }

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
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["gnf"] = "@function.outer",
            },
            goto_previous_start = {
              ["gpf"] = "@function.outer",
            },
          },
        },
        highlight = { enable = true, additional_vim_regex_highlights = false },
      })
    end,
  },
}
