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
    "tpope/vim-commentary",
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql",
        callback = function()
          vim.opt_local.commentstring = "-- %s"
        end,
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = { default = true },
  },
}
