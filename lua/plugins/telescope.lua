return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false, -- telescope did only one release, so use HEAD for now
	opts = {
		defaults = {
			winblend = 20,
			prompt_prefix = " ",
			selection_caret = " ",
		}
	}
}
