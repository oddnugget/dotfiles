local nnoremap = require("nugget.utils.bindkey").nnoremap

require("telescope").setup()

nnoremap('<Leader>ff', '<cmd> Telescope find_files<CR>')
