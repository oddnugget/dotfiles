return {
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    keys = {
      {
        "<Leader>e",
        "<cmd> Oil <cr>",
        desc = "Toggle File Tree",
      },
    },
    opts = {
      default_file_explorer = true,
    },
    -- Optional dependencies
    dependencies = { "nvim-mini/mini.icons" },
    config = true,
  },
}
