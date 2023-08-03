local icons = require("plugins.configs.defaults").icons

require("lualine").setup({
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "dashboard", "alpha" },
		},
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"diagnostics",
				symbols = {
					error = icons.diagnostics.Error,
					warn = icons.diagnostics.Warn,
					info = icons.diagnostics.Info,
					hint = icons.diagnostics.Hint,
				},
			},
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ "filename" },
		},
		lualine_x = {},
		lualine_y = {
			{ "location", padding = { left = 0, right = 1 } },
		},
		lualine_z = {
			{ "progress", separator = " ", padding = { left = 1, right = 1 } },
		},
	},
	extensions = { "neo-tree", "lazy" },
})
