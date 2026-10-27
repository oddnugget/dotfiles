return {
  {
    "catppuccin/nvim",
    lazy = false,
    enabled = true,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            ["@module.elixir"] = { fg = colors.peach },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
}
