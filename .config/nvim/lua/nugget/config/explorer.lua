require("nvim-tree").setup({
  remove_keymaps = { "<C-k>" },
  view = {
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
