local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.rubocop,

    -- null_ls.builtins.diagnostics.rubocop.with({
    --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    -- }),
    --
    null_ls.builtins.formatting.rustfmt,

    null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
    }),

    null_ls.builtins.diagnostics.credo,
    null_ls.builtins.formatting.mix,
    -- null_ls.builtins.diagnostics.codespell,
    -- null_ls.builtins.completion.spell,
  },
})
