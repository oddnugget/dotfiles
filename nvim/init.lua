require("oddnugget.config.options")
require("oddnugget.config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("oddnugget.config.autocmds")
    require("oddnugget.config.keymaps")
  end,
})
