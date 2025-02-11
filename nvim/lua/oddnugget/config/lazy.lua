--- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local dev_path = vim.g.is_devbox and "~/projects/oddnugget" or "~/dev/projects/nvim"

-- Configure lazy.nvim
require("lazy").setup("oddnugget.plugins", {
	defaults = { lazy = true, version = nil },
	install = { missing = true, colorscheme = { "catppuccin" } },
	checker = { enabled = true },
	change_detection = { enabled = false },
	dev = {
		path = dev_path,
		fallback = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
