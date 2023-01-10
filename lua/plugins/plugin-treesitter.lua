local function configure()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		auto_install = true,

		-- List of parsers to ignore installing (for "all")
		ignore_install = {},

		highlight = {
			-- `false` will disable the whole extension
			enable = true,

			-- list of language that will be disabled
			disable = {},

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},

		indent = {
			enable = true,
			disable = { "python" },
		},
		context_commentstring = {
			enable = true,
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
	config = configure,
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", 'numToStr/Comment.nvim' },
}
