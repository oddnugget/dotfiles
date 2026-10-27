local filename = { "filename", path = 1 }

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      -- Repaint so LSP progress in the statusline updates live
      vim.api.nvim_create_autocmd("LspProgress", {
        group = vim.api.nvim_create_augroup("LualineLspProgress", { clear = true }),
        command = "redrawstatus",
      })
    end,
    opts = {
      options = {
        disabled_filetypes = { winbar = { "snacks_dashboard" } },
      },
      sections = {
        lualine_x = {
          function()
            return vim.lsp.status()
          end,
          "encoding",
          "fileformat",
          "filetype",
        },
      },
      winbar = { lualine_c = { filename } },
      inactive_winbar = { lualine_c = { filename } },
    },
  },
}
