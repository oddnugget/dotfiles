-- Like Zed's `g h`: show the line's diagnostics if there are any, otherwise hover
local function hover_or_diagnostic()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

  if #vim.diagnostic.get(0, { lnum = lnum }) > 0 then
    vim.diagnostic.open_float()
  else
    vim.lsp.buf.hover()
  end
end

local function setup_keymaps(bufnr)
  local opts_with_desc = function(desc)
    return { silent = true, buffer = bufnr, desc = desc }
  end

  -- Keys follow Zed's vim mode defaults (gA, gh, g.)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts_with_desc("Go to definition"))
  vim.keymap.set("n", "gA", vim.lsp.buf.references, opts_with_desc("Go to references"))
  vim.keymap.set("n", "gh", hover_or_diagnostic, opts_with_desc("Diagnostics or hover"))
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts_with_desc("Signature Help"))
  vim.keymap.set("n", "g.", vim.lsp.buf.code_action, opts_with_desc("Code Action"))
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
    vim.lsp.config(name, cfg)
    vim.lsp.enable(name)
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
