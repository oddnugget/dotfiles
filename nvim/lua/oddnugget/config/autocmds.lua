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
