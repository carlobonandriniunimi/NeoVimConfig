local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
			},
			i = {
				["<C-t>"] = trouble.open_with_trouble,
				["<esc>"] = require("telescope.actions").close,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-f>"] = require("telescope.actions").preview_scrolling_down,
				["<C-b>"] = require("telescope.actions").preview_scrolling_up,
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
		find_files = {
			hidden = false, -- Show hidden files
		},
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			previewer = true,
			mappings = {
				i = { ["<c-d>"] = "delete_buffer" },
			},
		},
	},
})
