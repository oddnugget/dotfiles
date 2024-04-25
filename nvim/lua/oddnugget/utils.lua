local M = {}

M.file_exists = function(path)
	local file = io.open(path, "rb")

	if file then
		file:close()
	end

	return file ~= nil
end

M.copy_to_system_clipboard = function()
	local osc52 = require("osc52")
	osc52.copy(vim.fn.expand("%:."))
end

return M
