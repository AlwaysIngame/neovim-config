return {
	"williamboman/mason.nvim",
	config = function() require("mason").setup() end,
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
}
