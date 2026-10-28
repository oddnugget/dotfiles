-- Not lazy: smart-splits sets tmux's @pane-is-vim on startup, which tmux.conf
-- checks to decide whether C-h/j/k/l go to nvim or move between panes
return {
  "smart-splits-nvim/smart-splits.nvim",
  version = "^3",
  lazy = false,
  dependencies = {
    { "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux" },
  },
  opts = {
    mux = { backend = "smart-splits-backend-tmux" },
  },
  keys = {
    {
      "<c-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Window left",
    },
    {
      "<c-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Window down",
    },
    {
      "<c-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Window up",
    },
    {
      "<c-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Window right",
    },
    { "<c-\\>", "<cmd>wincmd p<cr>", desc = "Previous window" },
  },
}
