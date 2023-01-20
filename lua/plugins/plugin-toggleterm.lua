return {
	"akinsho/toggleterm.nvim",
	config = function()
		require('toggleterm').setup {
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			open_mapping = [[<c-\>]],
		}
	end,
	lazy = false,
	tag = '2.3.0'
}
