return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				config = true,
			},
			{
				"folke/neodev.nvim",
				opts = {
					experimental = {
						pathStrict = true,
					},
				},
			},
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					prefix = "●",
				},
				severity_sort = true,
			},
			format = {
				timeout_ms = 2000,
			},
			servers = {
				lua_ls = {
					-- mason = false, -- set to false if you don't want this server to be installed with mason
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				rust_analyzer = {
					mason = false,
				},
				pyright = {
					mason = false,
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		config = function(_, opts)
			for name, icon in pairs({
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			}) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, {
					text = icon,
					texthl = name,
					numhl = "",
				})
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
			})
			require("mason-lspconfig").setup_handlers({ setup })
		end,
	}, -- formatters
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "NullLsInstall", "NullLsUninstall" },
		dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			local nls = require("null-ls")

			require("mason-null-ls").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					-- Handle mason sources
					function(source_name, methods)
						-- all sources with no handler get passed here
						require("mason-null-ls.automatic_setup")(source_name, methods)
					end,
					stylua = function(source_name, methods)
						nls.register(nls.builtins.formatting.stylua)
					end,
				},
			})
			nls.setup({
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
				sources = {
					-- ANything not supported by Mason
				},
			})
		end,
	}, -- cmdline tools and lsp servers
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall" },
		opts = {
			ensure_installed = {},
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
}
