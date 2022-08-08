local nnoremap = require("nugget.utils").bindkey.nnoremap
local inoremap = require("nugget.utils").bindkey.inoremap

inoremap("jk", "<Esc>")

-- Explorer
nnoremap("<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Window jump
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-l>", "<C-w>l")

-- QF List Jump
nnoremap("<M-j>", ":cnext<CR>")
nnoremap("<M-k>", ":cprev<CR>")
