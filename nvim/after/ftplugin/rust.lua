vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gh", vim.lsp.buf.hover)
vim.keymap.set("n", "gK", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>ca", function()
	vim.cmd.RustLsp("codeAction")
end)
vim.keymap.set("n", "<Leader>rt", vim.lsp.codelens.run)

vim.keymap.set("n", "<Leader>fm", function()
	require("conform").format({ async = false, lsp_fallback = true })
end)

local bufnr = vim.api.nvim_get_current_buf()

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("LspFormat" .. bufnr, {}),
	buffer = bufnr,
	callback = function()
		require("conform").format({ async = false, bufnr = bufnr, lsp_fallback = true })
	end,
})
