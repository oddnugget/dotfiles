local M = {}

M.file_exists = function(path)
  local file = io.open(path, "rb")

  if file then
    file:close()
  end

  return file ~= nil
end

M.copy_to_system_clipboard = function()
  if vim.g.is_devbox then
    local osc52 = require("osc52")
    osc52.copy(vim.fn.expand("%:."))
  else
    vim.fn.setreg("+", vim.fn.expand("%:."))
  end
end

return M
