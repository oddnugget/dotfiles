-- windows to close
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"OverseerForm",
		"OverseerList",
		"floggraph",
		"fugitive",
		"git",
		"help",
		"lspinfo",
		"man",
		"neotest-output",
		"neotest-summary",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"toggleterm",
		"term",
		"tsplayground",
		"vim",
		"oil",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true }),
	callback = function()
		io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
	callback = function()
		io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = { "term://*" },
	group = vim.api.nvim_create_augroup("TerminalMappings", { clear = true }),
	callback = function()
		vim.keymap.set("n", "gf", "<Cmd>execute 'wincmd t | edit ' . expand('<cfile>')<cr>", { buffer = true })
	end,
})

local win_focus_grp = vim.api.nvim_create_augroup("WindowFocusedEvents", { clear = true })
local win_blur_grp = vim.api.nvim_create_augroup("WindowBlurredEvents", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
	group = win_focus_grp,
	callback = function()
		if vim.bo.filetype ~= "help" and vim.bo.filetype ~= "TelescopePrompt" then
			vim.wo.cursorline = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "WinLeave" }, {
	group = win_blur_grp,
	callback = function()
		vim.wo.cursorline = false
	end,
})

local sear_hl_group = vim.api.nvim_create_augroup("SearchHighlighs", { clear = true })

vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
	group = sear_hl_group,
	pattern = { "/", "?" },
	callback = function()
		vim.cmd([[:let @/ = ""]])
		vim.opt.hlsearch = true
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
	group = sear_hl_group,
	pattern = { "/", "?" },
	callback = function()
		vim.opt.hlsearch = false
	end,
})
