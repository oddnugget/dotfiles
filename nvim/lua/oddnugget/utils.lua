local M = {}

M.copy_to_system_clipboard = function()
  vim.fn.setreg("+", vim.fn.expand("%:."))
end

return M
