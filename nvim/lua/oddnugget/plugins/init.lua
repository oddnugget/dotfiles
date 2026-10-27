return {
  "nvim-lua/plenary.nvim",
  { "tpope/vim-fugitive", lazy = false },
  {
    "tpope/vim-projectionist",
    lazy = false,
    config = function() end,
  },
  { "tpope/vim-dispatch", lazy = false },
  { "tpope/vim-sleuth", event = "BufReadPost" },
  {
    "nvim-tree/nvim-web-devicons",
    config = { default = true },
  },
}
