local required_servers = require("nugget.lsp_servers")

require("nvim-lsp-installer").setup({
  ensure_installed = required_servers,
})
