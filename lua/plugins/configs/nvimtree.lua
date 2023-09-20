local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<bs>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "r", api.fs.rename_basename, opts("Rename"))
	vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
end

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

require("nvim-tree").setup({
	on_attach = my_on_attach,
	filters = {
		dotfiles = false,
	},
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		adaptive_size = false,
		side = "left",
		width = 30,
		preserve_window_proportions = true,
	},
	-- Floating window
	-- view = {
	-- 	float = {
	-- 		enable = true,
	-- 		open_win_config = function()
	-- 			local screen_w = vim.opt.columns:get()
	-- 			local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
	-- 			local window_w = screen_w * WIDTH_RATIO
	-- 			local window_h = screen_h * HEIGHT_RATIO
	-- 			local window_w_int = math.floor(window_w)
	-- 			local window_h_int = math.floor(window_h)
	-- 			local center_x = (screen_w - window_w) / 2
	-- 			local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
	-- 			return {
	-- 				border = "rounded",
	-- 				relative = "editor",
	-- 				row = center_y,
	-- 				col = center_x,
	-- 				width = window_w_int,
	-- 				height = window_h_int,
	-- 			}
	-- 		end,
	-- 	},
	-- 	width = function()
	-- 		return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
	-- 	end,
	-- },
	git = {
		enable = false,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
		change_dir = {
			enable = true,
			global = true,
		},
	},
	renderer = {
		root_folder_label = false,
		highlight_git = false,
		highlight_opened_files = "none",
		indent_markers = {
			enable = false,
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
})
