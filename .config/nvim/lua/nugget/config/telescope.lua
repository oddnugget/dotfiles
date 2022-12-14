local nnoremap = require("nugget.utils").bindkey.nnoremap

require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})

require("telescope").load_extension("fzf")

nnoremap("<Leader>ff", "<cmd> Telescope find_files<CR>")
nnoremap("<Leader>fw", "<cmd> Telescope live_grep<CR>")
nnoremap("<Leader>fW", "<cmd> Telescope grep_string<CR>")
nnoremap("<Leader>fb", "<cmd> Telescope buffers<CR>")
nnoremap("<Leader>f<Leader>", "<cmd> Telescope resume<CR>")
