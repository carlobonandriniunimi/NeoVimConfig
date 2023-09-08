local M = {}

M.notify = {
	background_colour = "#000000",
	timeout = 0,
}

M.noice = {
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	lsp = {
		progress = {
			enabled = false,
		},
		override = {
			-- override the default lsp markdown formatter with Noice
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			-- override the lsp markdown formatter with Noice
			["vim.lsp.util.stylize_markdown"] = true,
			-- override cmp documentation with Noice (needs the other options to work)
			["cmp.entry.get_documentation"] = true,
		},
		hover = {
			enabled = true,
			silent = true, -- set to true to not show a message if hover is not available
		},
	},
	routes = {
		{
			view = "notify",
			filter = { event = "msg_showmode" },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
	},
}

M.dressing = {
	input = {
		-- Set to false to disable the vim.ui.input implementation
		enabled = true,
		-- Default prompt string
		default_prompt = "Input:",
		-- Can be 'left', 'right', or 'center'
		title_pos = "center",
		-- These are passed to nvim_open_win
		border = "rounded",
		-- 'editor' and 'win' will default to being centered
		relative = "cursor",

		min_width = { 40, 0.2 },

		win_options = {
			-- Increase this for more context when text scrolls off the window
			sidescrolloff = 8,
		},
	},
	select = {
		-- Set to false to disable the vim.ui.select implementation
		enabled = true,
		-- Priority list of preferred vim.select implementations
		backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
	},
}

return M
