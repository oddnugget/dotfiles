return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      {
        "<Leader>hh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<Leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon add mark",
      },
      {
        "<Leader><Leader>1",
        function()
          require("harpoon"):list():select(1)
        end,
      },
      {
        "<Leader><Leader>2",
        function()
          require("harpoon"):list():select(2)
        end,
      },
      {
        "<Leader><Leader>3",
        function()
          require("harpoon"):list():select(3)
        end,
      },
      {
        "<Leader><Leader>4",
        function()
          require("harpoon"):list():select(4)
        end,
      },
      {
        "<Leader><Leader>5",
        function()
          require("harpoon"):list():select(5)
        end,
      },
    },
  },
  {
    "slim-template/vim-slim",
    ft = "slim",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "tmux"
    end,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {
      windowCreationCommand = "vertical aboveleft 80new",
    },
    keys = {
      {
        "g/",
        function()
          require("grug-far").toggle_instance({ instanceName = "far", staticTitle = "Find and Replace" })
        end,
        desc = "Search and replace",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
