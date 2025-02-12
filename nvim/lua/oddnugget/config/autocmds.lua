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

local win_focus_grp = vim.api.nvim_create_augroup("WindowFocusedEvents", { clear = true })
local win_blur_grp = vim.api.nvim_create_augroup("WindowBlurredEvents", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = win_focus_grp,
  callback = function()
    vim.wo.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = win_focus_grp,
  pattern = { "Telescope*", "help" },
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "WinLeave", "BufWinEnter" }, {
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
