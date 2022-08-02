local nnoremap = require("nugget.utils.bindkey").nnoremap
local inoremap = require("nugget.utils.bindkey").inoremap

inoremap('jk', '<Esc>')
nnoremap('<Leader>e', ':NvimTreeToggle<CR>')
