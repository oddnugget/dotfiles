return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "MunifTanjim/nougat.nvim",
    event = "VeryLazy",
    config = function()
      local nougat = require("nougat")
      local Bar = require("nougat.bar")
      local sep = require("nougat.separator")
      local color = require("nougat.color").get()

      local nut = {
        buf = {
          filename = require("nougat.nut.buf.filename").create,
        },
        spacer = require("nougat.nut.spacer").create,
      }

      local winbar = Bar("winbar")

      winbar:add_item(nut.buf.filename({
        prefix = " ",
        suffix = " ",
      }))

      nougat.set_winbar(winbar, { global = true })
    end,
  },
}
