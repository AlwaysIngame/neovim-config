return {{
    "L3MON4D3/LuaSnip",
    dependencies = {"rafamadriz/friendly-snippets"},
    config = function(_, opts)
        if opts then
            require("luasnip").config.setup(opts)
        end
        vim.tbl_map(function(type)
            require("luasnip.loaders.from_" .. type).lazy_load()
        end, {"vscode", "snipmate", "lua"})
    end
}, {
    "hrsh7th/nvim-cmp",
    dependencies = {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp", "ray-x/lsp_signature.nvim", "neovim/nvim-lspconfig"},
    event = "InsertEnter",
    opts = function()
        local cmp = require "cmp"
        local snip_status_ok, luasnip = pcall(require, "luasnip")
        if not snip_status_ok then
            return
        end

        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
        end

        return {
		preselect = cmp.PreselectMode.Item,
            completion = {
                completeopt = "menu,menuone,noinsert,noselect"
            },
            formatting = {
                fields = {"abbr", "kind", "menu"},
                format = function(_, item)
                    local icons = {
                        Array = " ",
                        Boolean = " ",
                        Class = " ",
                        Color = " ",
                        Constant = " ",
                        Constructor = " ",
                        Copilot = " ",
                        Enum = " ",
                        EnumMember = " ",
                        Event = " ",
                        Field = " ",
                        File = " ",
                        Folder = " ",
                        Function = " ",
                        Interface = " ",
                        Key = " ",
                        Keyword = " ",
                        Method = " ",
                        Module = " ",
                        Namespace = " ",
                        Null = "ﳠ ",
                        Number = " ",
                        Object = " ",
                        Operator = " ",
                        Package = " ",
                        Property = " ",
                        Reference = " ",
                        Snippet = " ",
                        String = " ",
                        Struct = " ",
                        Text = " ",
                        TypeParameter = " ",
                        Unit = " ",
                        Value = " ",
                        Variable = " "
                    }
                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind
                    end
                    return item
                end
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            duplicates = {
                nvim_lsp = 1,
                luasnip = 1,
                cmp_tabnine = 1,
                buffer = 1,
                path = 1
            },
            mapping = {
                ["<Up>"] = cmp.mapping.select_prev_item {
                    behavior = cmp.SelectBehavior.Select
                },
                ["<Down>"] = cmp.mapping.select_next_item {
                    behavior = cmp.SelectBehavior.Select
                },
                ["<C-p>"] = cmp.mapping.select_prev_item {
                    behavior = cmp.SelectBehavior.Insert
                },
                ["<C-n>"] = cmp.mapping.select_next_item {
                    behavior = cmp.SelectBehavior.Insert
                },
                ["<C-k>"] = cmp.mapping.select_prev_item {
                    behavior = cmp.SelectBehavior.Insert
                },
                ["<C-j>"] = cmp.mapping.select_next_item {
                    behavior = cmp.SelectBehavior.Insert
                },
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
                ["<C-y>"] = cmp.config.disable,
                ["<C-e>"] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                },
                ["<CR>"] = cmp.mapping.confirm {
                    select = false
                },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            },
            sources = cmp.config.sources {{
                name = "nvim_lsp",
            }, {
                name = "luasnip",
            }, {
                name = "buffer",
            }, {
                name = "path",
            },
            }
        }
    end
}, {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,
        fast_wrap = {
            map = "<M-e>",
            chars = {"{", "[", "(", '"', "'"},
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr"
        }
    },
    config = function(_, opts)
        local npairs = require "nvim-autopairs"
        npairs.setup(opts)

        local cmp_status_ok, cmp = pcall(require, "cmp")
        if cmp_status_ok then
            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done {
                tex = false
            })
        end
    end
}, {
	"ray-x/lsp_signature.nvim",
	event = {"BufRead"},
	dependencies = {"neovim/nvim-lspconfig"},
    opts = {
        noice = true,
        hint_enable = false,
        handler_opts = {border = "none"},
        transparency = 20,
    },
	config = function (_, opts)
		require("lsp_signature").setup(opts)
	end
}}
