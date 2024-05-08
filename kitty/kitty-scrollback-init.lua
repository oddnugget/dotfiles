vim.g.mapleader = " "

vim.keymap.set({ "n" }, "q", ":q<cr>")
vim.keymap.set({ "v" }, "y", "<Plug>(KsbVisualYank)")

vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/kitty-scrollback.nvim") -- lazy.nvim
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site/pack/mikesmithgh/start/kitty-scrollback.nvim") -- pack

require("kitty-scrollback").setup({
	defaul_config = {
		keymaps_enabled = false,
		restore_options = true,
		paste_window = {
			yank_register_enabled = false,
		},
	},
})
