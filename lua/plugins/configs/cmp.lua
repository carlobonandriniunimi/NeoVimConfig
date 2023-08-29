local cmp = require("cmp")
local luasnip = require("luasnip")
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

local icons = require("plugins.configs.defaults").icons.kinds

-- Disable snippet expansion in normal mode
vim.api.nvim_create_autocmd("ModeChanged", {
	group = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true }),
	pattern = { "s:n", "i:*" },
	callback = function(event)
		if luasnip.session and luasnip.session.current_nodes[event.buf] and not luasnip.session.jump_active then
			luasnip.unlink_current()
		end
	end,
})

local types = require("luasnip.util.types")
luasnip.setup({
	-- Display a cursor-like placeholder in unvisited nodes
	-- of the snippet.
	ext_opts = {
		[types.insertNode] = {
			unvisited = {
				virt_text = { { "|", "Conceal" } },
				virt_text_pos = "inline",
			},
		},
		[types.exitNode] = {
			unvisited = {
				virt_text = { { "|", "Conceal" } },
				virt_text_pos = "inline",
			},
		},
	},
})

-- function for setting the border
-- local function border(hl_name)
-- 	return {
-- 		{ "╭", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╮", hl_name },
-- 		{ "│", hl_name },
-- 		{ "╯", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╰", hl_name },
-- 		{ "│", hl_name },
-- 	}
-- end

cmp.setup({
	-- preselect = cmp.PreselectMode.Item,
	completion = {
		autocomplete = {
			cmp.TriggerEvent.TextChanged,
			cmp.TriggerEvent.InsertEnter,
		},
		completeopt = "menu,menuone,noselect",
	},
	window = {
		completion = {
			-- border = border("CmpDocBorder"),
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel",
			-- winhighlight = "Normal:None",
			scrollbar = false,
			max_width = 5,
		},
		documentation = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
			-- winhighlight = "Normal:None",
			-- border = border("CmpDocBorder"),
			max_width = 80,
			max_height = 20,
		},
	},
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({
				symbol_map = icons,
				mode = "symbol",
				maxwidth = 35,
			})(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = (strings[1] or "") .. " "
			kind.menu = ""

			return kind
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		-- ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			local copilot = require("copilot.suggestion")

			if copilot.is_visible() then
				copilot.accept()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})
