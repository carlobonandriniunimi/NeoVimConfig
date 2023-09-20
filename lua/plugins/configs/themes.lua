local M = {}

-- Fidget.nvim color to remove the background
vim.api.nvim_set_hl(0, "FidgetTask", { bg = "#1E1E2D" })

M.catppuccin = {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	transparent_background = false, -- disables setting the background color.
	term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = true, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	custom_highlights = function(colors)
		return {
			PmenuSbar = { fg = colors.none, bg = colors.none },
			PmenuThumb = { fg = colors.none, bg = colors.none },
			TelescopeNormal = { bg = colors.base },
			TelescopeBorder = { fg = colors.base, bg = colors.base },
			LazyNormal = { bg = colors.base },
			MasonNormal = { bg = colors.base },
			NoicePopup = { bg = colors.base },
		}
	end,
	integrations = {
		alpha = true,
		cmp = true,
		flash = true,
		gitsigns = true,
		illuminate = true,
		indent_blankline = { enabled = true },
		lsp_trouble = false,
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

M.tokyonight = {
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true,
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = true, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	on_highlights = function(highlights, colors) end,
}

return M
