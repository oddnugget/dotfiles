vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("nugget.config.telescope")
    end,
  })

  if vim.fn.has("macunix") then
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  else
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })
  end

  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("nugget.config.colorscheme")
    end,
  })

  use({ "ggandor/lightspeed.nvim" })

  use({
    "romgrk/barbar.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  use({ "kyazdani42/nvim-web-devicons" })

  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("nugget.config.explorer")
    end,
  })

  use("tpope/vim-fugitive")
  use("tpope/vim-rails")
  use("tpope/vim-sleuth")
  use("tpope/vim-dispatch")
  use("tpope/vim-surround")
  use("tpope/vim-commentary")
  use("christoomey/vim-tmux-navigator")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nugget.config.treesitter")
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("nugget.config.lsp").setup()
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })

  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("nugget.config.cmp")
    end,
  })
  use({ "L3MON4D3/LuaSnip" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("nugget.config.lsp").null_ls()
    end,
  })
  use("windwp/nvim-ts-autotag")
  use({ "slim-template/vim-slim" })
end)
