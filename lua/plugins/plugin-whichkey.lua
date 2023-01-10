return {
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeoutlen = 0
			require("which-key").setup{}
		end,
	},
}
