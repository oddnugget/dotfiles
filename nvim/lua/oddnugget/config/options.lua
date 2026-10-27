vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.opt.clipboard = "unnamedplus"

-- Copy through the terminal over SSH, but paste from the unnamed register:
-- most terminals (and tmux) ignore OSC 52 paste requests, which stalls `p`
if vim.g.is_devbox then
  local osc52 = require("vim.ui.clipboard.osc52")

  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end

  vim.g.clipboard = {
    name = "osc52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end
vim.o.formatoptions = "jcroqlnt"
vim.o.shortmess = "filnxtToOFWIcC"
vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.joinspaces = false
vim.opt.mouse = "a"
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.sidescrolloff = 20
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.updatetime = 500
vim.opt.wildmode = "longest:full,full"
vim.opt.laststatus = 3
