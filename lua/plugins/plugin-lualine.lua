local function null_ls_registered_names(filetype)
	local s = require "null-ls.sources"
	local available_sources = s.get_available(filetype)
	local registered = {}
	for _, source in ipairs(available_sources) do
		if source.filetypes[filetype] then
			table.insert(registered, source.name)
		end
	end
	return registered
end

local function configure()
	-- Eviline config for lualine
	-- Author: shadmansaleh
	-- Credit: glepnir
	local lualine = require('lualine')

	local lsp_component = {
		function()
			local buf_clients = vim.lsp.get_active_clients()
			if next(buf_clients) == nil then return "LSP Inactive" end
			local buf_ft = vim.bo.filetype
			local buf_client_names = {}
			local copilot_active = false

			-- add client
			for _, client in pairs(buf_clients) do
				if client.name ~= "null-ls" and client.name ~= "copilot" then
					table.insert(buf_client_names, client.name)
				end

				if client.name == "copilot" then
					copilot_active = true
				end
			end

			vim.list_extend(buf_client_names, null_ls_registered_names(buf_ft))
			local unique_client_names = vim.fn.uniq(buf_client_names)

			local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

			if copilot_active then
				language_servers = language_servers .. "%#SLCopilot#" .. " " .. ' ' .. "%*"
			end

			return language_servers
		end,
		color = { gui = "bold" },
	}

	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed
			}
		end
	end

	-- Config
	local config = {
		options = {
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			globalstatus = false,
			refresh = {
				statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			}
		},
		sections = {
			lualine_a = {{'mode', fmt = function(a) return ' ' .. a end}},
			lualine_b = {'branch', {'diff', source = diff_source, symbols = { added = ' ', modified = ' ', removed = ' ' },}},
			lualine_c = {'%=','filetype', lsp_component},
			lualine_x = {'searchcount', 'diagnostics'},
			lualine_y = {{'fileformat', padding = 0},{'hostname', padding = {right = 0, left = 1}}, 'encoding'},
			lualine_z = {{'location', padding = 0}, 'progress'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {'branch', {'diff', source = diff_source, }},
			lualine_c = {'%=','filetype', 'filename'},
			lualine_x = {},
			lualine_y = {{'fileformat', padding = 0},{'hostname', padding = {right = 0, left = 1}}, 'encoding'},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
}

	lualine.setup(config)
end

return {
	'nvim-lualine/lualine.nvim',
	dependencies = {'kyazdani42/nvim-web-devicons'},
	config = configure,
	event = {'BufReadPre', 'BufNewFile'},

}
