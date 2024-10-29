local port = os.getenv("GDScript_Port") or "6005"
local cmd = vim.lsp.rpc.connect("127.0.0.1", port)
local pipe = "/tmp/godot.pipe"

vim.lsp.start({
	name = "Godot",
	cmd = cmd,
	root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
	on_attach = function(client, bufnr)
		vim.api.nvim_command('echo serverstart("' .. pipe .. '")')

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
	end,
})
