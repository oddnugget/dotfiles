local servers = require("oddnugget.servers")
local lsp = require("lspconfig")

local function setup_keymaps()
	vim.keymap.set("n","gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
	vim.keymap.set("n","gr", "Telescope lsp_references", { desc = "References" })
	vim.keymap.set("n","gD", "Telescope lsp_declarations", { desc = "Goto Declaration" })
	vim.keymap.set("n","gI", "Telescope lsp_implementations", { desc = "Goto Implementation" })
	vim.keymap.set("n","gb", "Telescope lsp_type_definitions", { desc = "Goto Type Definition" })
	vim.keymap.set("n","gh", vim.lsp.buf.hover, { desc = "Hover" })
	vim.keymap.set("n","gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })
	vim.keymap.set("n","<leader>de", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
	vim.keymap.set("n","<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
	vim.keymap.set("n","<leader>cs", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
	vim.keymap.set("n","<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
end


local function get_server_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local function on_attach(client, bufnr)
  if not client or not bufnr then
    vim.notify("No LSP client found, aborting on_attach")
    return
  end

  setup_keymaps()
end

local function get_config(name)
  local config = name and servers.list[name] or {}

  if type(config) == "function" then
    config = config()
    if not config or config == nil then return end
  end

  config.on_attach = on_attach
  config.capabilities = get_server_capabilities()

  return config
end

if servers ~= nil then
  for server, _ in pairs(servers.list) do
    local cfg = get_config(server)

    servers.load_unofficial()
    if cfg ~= nil then
      lsp[server].setup(cfg)
    end
  end
end
