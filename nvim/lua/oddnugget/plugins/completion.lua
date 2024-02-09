---@diagnostic disable missing-fields

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local icons = require("oddnugget.config.icons")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local tab = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end

			local shift_tab = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-n>"] = cmp.mapping(tab, { "i", "s", "c" }),
					["<C-p>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
					["<Tab>"] = { i = tab, s = tab },
					["<S-Tab>"] = { i = shift_tab, s = shift_tab },
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						local max_width = 0
						local source_names = {
							nvim_lsp = "(LSP)",
							path = "(Path)",
							luasnip = "(Snippet)",
							buffer = "(Buffer)",
						}
						local duplicates = {
							buffer = 1,
							path = 1,
							nvim_lsp = 0,
							luasnip = 1,
						}
						local duplicates_default = 0
						if max_width ~= 0 and #item.abbr > max_width then
							item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
						end
						item.kind = icons.kind[item.kind]
						item.menu = source_names[entry.source.name]
						item.dup = duplicates[entry.source.name] or duplicates_default
						return item
					end,
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		config = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
}
