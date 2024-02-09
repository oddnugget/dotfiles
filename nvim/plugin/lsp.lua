local servers = require("oddnugget.servers")
local lsp = require("lspconfig")

local function setup_keymaps()
	vim.keymap.set("n","gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
	vim.keymap.set("n","gr", vim.lsp.buf.references, { desc = "References" })
	vim.keymap.set("n","gh", vim.lsp.buf.hover, { desc = "Hover" })
	vim.keymap.set("n","gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })
	vim.keymap.set("n","<leader>de", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
	vim.keymap.set("n","<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
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
