---@diagnostic disable-next-line
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"html",
		"css",
		"python",
		"json",
		"markdown",
		"markdown_inline",
		"regex",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	auto_install = true,
	indent = {
		enable = true,
		disable = {
			"python",
		},
	},
})
