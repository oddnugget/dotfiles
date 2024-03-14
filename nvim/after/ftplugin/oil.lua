vim.opt.conceallevel = 3
vim.opt.concealcursor = "n"
vim.opt.list = false
vim.opt.wrap = false
vim.opt.signcolumn = "no"

vim.keymap.set("n", "q", "<cmd>q<cr>", { desc = "oil: quit", buffer = 0 })
vim.keymap.set("n", "<leader>e", "<cmd> lua require('oil').toggle_float() <CR>", { desc = "oil: quit", buffer = 0 })
