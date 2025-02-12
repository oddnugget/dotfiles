vim.g.is_devbox = os.getenv("DEVBOX") == "true"

require("oddnugget.config.autocmds")
require("oddnugget.config.options")
require("oddnugget.config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("oddnugget.config.keymaps")
  end,
})
