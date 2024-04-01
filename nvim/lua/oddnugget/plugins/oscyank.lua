return {
	"ojroques/nvim-osc52",
	lazy = false,
	enabled = function()
		return os.getenv("DEVBOOX") == "true"
	end,
	config = function()
		local function copy()
			if vim.v.event.regname == "+" then
				require("osc52").copy_register("+")
			end
		end

		vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
	end,
}
