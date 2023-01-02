vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  integrations = {
    telescope = true,
    nvimtree = true,
  },
})

vim.cmd([[colorscheme catppuccin]])
