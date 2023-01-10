local server_settings = {}
server_settings.sumneko_lua = {
	Lua = {
		diagnostics = {
			globals = { "vim" },
		},
	},
}

local function configure()
	-- Loads in mason-lspconfig plugin automatically

	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		signs = {
			active = signs, -- show signs
		},
		virtual_text = {
			prefix = "",
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		focusable = false,
		relative = "cursor",
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	require("mason-lspconfig").setup_handlers({
		function (server_name)
			require("lspconfig")[server_name].setup {
				capabilities = capabilities,
				settings = server_settings.sumneko_lua or {}
			}
		end,
	-- add custom lsp configurations below
	})
end

return {
	"neovim/nvim-lspconfig",
	event = {"BufReadPre", "BufNewFile",},
	config = configure,
	dependencies = {"ray-x/lsp_signature.nvim", }
}
