local keymap = vim.keymap.set
local utils = require("oddnugget.utils")

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Tab nav maps
keymap("n", "<leader>t", "<cmd>tabe<cr>")
keymap("n", "<leader>tn", "<cmd>tabn<cr>")
keymap("n", "<leader>tp", "<cmd>tabp<cr>")
keymap("n", "<leader>tq", "<cmd>tabclose<cr>")

-- Terminal Maps
keymap("i", "jj", "<ESC>")
keymap("t", "<ESC>", "<C-\\><C-n>")
keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- jump buflist
keymap("n", "<Leader>o", "<cmd>bprevious<CR>")
keymap("n", "<Leader>i", "<cmd>bnext<CR>")

keymap("n", "<Leader>cn", "<cmd>cnext<CR>")
keymap("n", "<Leader>cp", "<cmd>cprev<CR>")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

keymap("n", "<Leader>uf", function()
  utils.copy_to_system_clipboard()
end)
keymap("n", "<Leader>cn", ":cnext<CR>")
keymap("n", "<Leader>cp", ":cprev<CR>")
