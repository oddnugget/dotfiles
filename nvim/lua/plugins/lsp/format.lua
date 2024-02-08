local M = {}

function M.on_attach(_client, buf)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
		buffer = buf,
		callback = function()
			require("conform").format({ bufnr = buf, lsp_fallback = true })
		end,
	})
end

return M
