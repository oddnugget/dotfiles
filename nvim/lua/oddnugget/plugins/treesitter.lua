local parsers = {
  "bash",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "tsx",
  "typescript",
  "vim",
  "yaml",
  "heex",
  "elixir",
}

local no_indent = { ruby = true }

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
        callback = function(event)
          -- Silently skip filetypes without an installed parser
          if not pcall(vim.treesitter.start, event.buf) then
            return
          end

          if not no_indent[event.match] then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter-textobjects").setup({ move = { set_jumps = true } })

      local move = require("nvim-treesitter-textobjects.move")

      vim.keymap.set({ "n", "x", "o" }, "gnf", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "gpf", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start" })
    end,
  },
}
