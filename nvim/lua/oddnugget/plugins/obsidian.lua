return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre /Users/odyrag/notebook/**.md",
		"BufNewFile /Users/odyrag/dev/auctionet/megavault/**.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/notebook",
			},
			{
				name = "work",
				path = "~/dev/auctionet/work/megavault",
			},
		},

		-- see below for full list of options 👇
	},
}
