return {
	{
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      size = 10,
      open_mapping = [[<C-\>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
  },
  {
	'TimUntersberger/neogit',
	cmd = {'Neogit'},
	opts = {
		kind = "tab",
		disable_commit_confirmation = true,
	}
  }
}
