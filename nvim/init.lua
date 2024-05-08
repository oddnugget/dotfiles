vim.g.is_devbox = os.getenv("DEVBOX") == "true"
vim.g.is_kitty_scrollback = os.getenv("KITTY_SCROLLBACK_NVIM") == "true"

require("oddnugget.config.autocmds")
require("oddnugget.config.options")

if not vim.g.is_kitty_scrollback then
	require("oddnugget.config.lazy")
end

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("oddnugget.config.keymaps")
	end,
})
