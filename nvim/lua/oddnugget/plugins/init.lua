return {
  { "tpope/vim-fugitive", lazy = false },
  {
    "tpope/vim-projectionist",
    lazy = false,
    config = function() end,
  },
  { "tpope/vim-sleuth", event = "BufReadPost" },
  {
    "nvim-mini/mini.icons",
    opts = {},
    init = function()
      -- Serve plugins that still require nvim-web-devicons from mini.icons
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
