return {
  "ojroques/nvim-osc52",
  lazy = false,
  enabled = function()
    return vim.g.is_devbox
  end,
  config = function()
    local osc52 = require("osc52")
    osc52.setup({ silent = true })

    local function copy(lines, _)
      osc52.copy(table.concat(lines, "\n"))
    end

    local function paste()
      return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
    end

    vim.g.clipboard = {
      name = "osc52",
      copy = { ["+"] = copy, ["*"] = copy },
      paste = { ["+"] = paste, ["*"] = paste },
    }
  end,
}
