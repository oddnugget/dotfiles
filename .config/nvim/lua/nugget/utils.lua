local M = {}

local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

M.bindkey = {
  nnoremap = bind("n"),
  vnoremap = bind("v"),
  xnoremap = bind("x"),
  inoremap = bind("i"),
  tnoremap = bind("t"),
  nmap = bind("n", { noremap = false }),
}

M.has_key = function(table, key)
  for _, value in ipairs(table) do
    if value == key then
      return true
    end
  end

  return false
end

return M
