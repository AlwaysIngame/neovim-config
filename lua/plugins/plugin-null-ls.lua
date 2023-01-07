local function configure()
	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.stylua,
		}
	})
end

return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {'nvim-lua/plenary.nvim'},
	config = configure,
	event = { 'BufReadPre', 'BufNewFile',},
}
