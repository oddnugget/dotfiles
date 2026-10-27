local function setup_keymaps(bufnr)
  local opts_with_desc = function(desc)
    return { silent = true, buffer = bufnr, desc = desc }
  end

  -- References live on the built-in `grr` (0.11+); mapping `gr` would shadow grn/gra/grr/gri
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts_with_desc("Go to definition"))
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts_with_desc("Hover"))
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts_with_desc("Signature Help"))
  vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, opts_with_desc("Open Diagnostics"))
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts_with_desc("Code Action"))
  vim.keymap.set("n", "<Leader>rt", vim.lsp.codelens.run, opts_with_desc("Code lens"))

  vim.keymap.set("n", "<Leader>fm", function()
    require("conform").format({ async = false, lsp_format = "fallback" })
  end, opts_with_desc("Format"))
end

local config = function()
  local servers = require("oddnugget.servers")

  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
    callback = function(event)
      setup_keymaps(event.buf)
    end,
  })

  for name, cfg in pairs(servers.list) do
    if type(cfg) == "function" then
      cfg = cfg()
    end

    if cfg ~= nil then
      vim.lsp.config(name, cfg)
      vim.lsp.enable(name)
    end
  end
end

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    -- Only provides the default server configs under lsp/*.lua
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = config,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    opts = {
      log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
      -- Only format on save in buffers with an attached LSP client
      format_on_save = function(bufnr)
        if #vim.lsp.get_clients({ bufnr = bufnr }) == 0 then
          return
        end

        return { lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        ["*"] = { "trim_whitespace", "trim_newlines" },
        lua = { "stylua" },
        javascript = { "prettier" },
        scss = { "prettier" },
        css = { "prettier" },
        json = { "prettier", "fixjson" },
        jsonc = { "prettier", "fixjson" },
        html = { "prettier" },
        ruby = { "rubocop" },
        python = { "ruff_format", "ruff_organize_imports" },
      },
    },
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Only used for its Phoenix projectionist heuristics; expert (servers.lua) is the LSP
      require("elixir").setup({
        nextls = { enable = false },
        elixirls = { enable = false },
        projectionist = { enable = true },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
  },
}
