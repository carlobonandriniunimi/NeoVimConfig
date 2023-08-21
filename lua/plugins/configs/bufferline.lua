return {
	options = {
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "icon", --'icon' | 'underline' | 'none',
		},
		buffer_close_icon = "󰅖",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		diagnostics_indicator = function(_, _, diag)
			local icons = require("plugins.configs.defaults").icons.diagnostics
			local ret = (diag.error and icons.Error .. diag.error .. " " or "")
				.. (diag.warning and icons.Warn .. diag.warning or "")
			return vim.trim(ret)
		end,
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				separator = true,
			},
		},
	},
}
