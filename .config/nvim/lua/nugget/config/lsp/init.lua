local has_key = require("nugget.utils").has_key
local M = {}

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {

  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- Which LSP are going to use formatting?
local servers_with_native_formatting = { "rust_analyzer", "null-ls", "solargraph" }

local format_sync = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return has_key(servers_with_native_formatting, client.name)
    end,
    bufnr = bufnr,
  })
end

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, buffer = bufnr }

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_augroup,
      buffer = bufnr,
      callback = function()
        format_sync(bufnr)
      end,
    })
  end

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>fm", format_sync, bufopts)
end

function M.setup()
  local lspconfig = require("lspconfig")

  lspconfig.solargraph.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = { solargraph = { diagnostics = true } },
    init_options = { formatting = true },
  })

  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })

  lspconfig.elixirls.setup({
    cmd = { "/home/odyrag/.local/bin/elixir/language_server.sh" },
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })

  lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    },
  })
end

function M.null_ls()
  local null_ls = require("null-ls")

  null_ls.setup({
    on_attach = on_attach,
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.dprint.with({
        disabled_filetypes = { "rust" },
      }),
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.diagnostics.credo,
      null_ls.builtins.formatting.mix,
    },
  })
end

return M
