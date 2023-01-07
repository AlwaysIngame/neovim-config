-- This plugin by design loads nvim-lspconfig on it's setup
-- (Check lazy loading section on :h lazy.nvim-plugin-spec)
return {
	"williamboman/mason-lspconfig.nvim",
	cmd = { "LspInstall", "LspUninstall" },
	config = function() require("mason-lspconfig").setup() end,
}
