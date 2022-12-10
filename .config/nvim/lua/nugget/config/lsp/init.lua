local has_key = require("nugget.utils").has_key
local M = {}
local pid = vim.fn.getpid()

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
  print("format")
  vim.lsp.buf.format({
    filter = function(client)
      return has_key(servers_with_native_formatting, client.name)
    end,
    bufnr = bufnr,
  })
end

local format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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

  -- lspconfig.solargraph.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   settings = { solargraph = { diagnostics = true } },
  --   init_options = { formatting = true },
  -- })

  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  })

  lspconfig.astro.setup({ on_attach = on_attach, capabilities = capabilities })

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
    cmd = { "/home/odyrag/.local/bin/elixir-ls/language_server.sh" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      elixirLS = {
        dialyzerEnabled = true,
        fetchDeps = false,
      },
    },
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
          checkThirdParty = false,
        },
      },
    },
  })

  lspconfig.elmls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  local omnisharp_bin = "/usr/local/bin/omnisharp-roslyn/OmniSharp"

  lspconfig.omnisharp.setup({
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
    on_attach = on_attach,
    capabilities = capabilities,

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
  })

  lspconfig.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "handlebars", "astro" },
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
      -- null_ls.builtins.formatting.dprint.with({
      --   disabled_filetypes = { "rust", "css", "scss" },
      -- }),
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.formatting.rubocop,
      null_ls.builtins.formatting.prettierd.with({
        extra_filetypes = { "astro" },
      }),
      null_ls.builtins.diagnostics.credo,
      null_ls.builtins.formatting.mix,
      null_ls.builtins.formatting.elm_format,
    },
  })
end

return M
