-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_transparent = true
-- vim.opt.background = "dark"

vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
  integrations = {
    telescope = true,
    nvimtree = true,
  },
})

vim.cmd([[colorscheme catppuccin]])

-- vim.cmd("colorscheme tokyonight")
--
-- require("monokai").setup({ palette = require("monokai").pro })
