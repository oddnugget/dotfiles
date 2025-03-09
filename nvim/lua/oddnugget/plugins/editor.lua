return {
  {
    "luckasRanarison/nvim-devdocs",
    event = "VeryLazy",
    keys = {
      {
        "<leader>dd",
        "<cmd> DevdocsOpenFloat <cr>",
      },
      {
        "<leader>dt",
        "<cmd> DevdocsToggle <cr>",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<Leader>hh",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<Leader>ha",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon add mark",
      },
      {
        "<Leader><Leader>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
      },
      {
        "<Leader><Leader>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
      },
      {
        "<Leader><Leader>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
      },
      {
        "<Leader><Leader>4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
      },
      {
        "<Leader><Leader>5",
        function()
          require("harpoon.ui").nav_file(5)
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
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    config = true,
    opts = {
      open_cmd = "vertical aboveleft 80new",
    },
    keys = {
      {
        "<leader>rw",
        function()
          -- open left side as a 60 widht panel
          require("spectre").toggle()
        end,
      },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      -- add any custom options here
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
