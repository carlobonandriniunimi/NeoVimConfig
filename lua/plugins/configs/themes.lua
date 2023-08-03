local M = {}

M.catppuccin = {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	transparent_background = false, -- disables setting the background color.
	term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = true, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	integrations = {
		alpha = true,
		cmp = true,
		flash = true,
		gitsigns = true,
		illuminate = true,
		indent_blankline = { enabled = true },
		lsp_trouble = true,
		mason = true,
		mini = true,
		native_lsp = {
			enabled = true,
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
		navic = { enabled = true, custom_bg = "lualine" },
		neotest = true,
		nvimtree = true,
		noice = true,
		notify = true,
		neotree = true,
		semantic_tokens = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		treesitter = true,
		which_key = true,
	},
}

return M
