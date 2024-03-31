require("oddnugget.config.options")
require("oddnugget.config.lazy")

os.execute("kitten @ set-user-vars IS_NVIM=true")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("oddnugget.config.autocmds")
		require("oddnugget.config.keymaps")
	end,
})
