return {
	general = {
		enable = function(buf, win)
			return not vim.api.nvim_win_get_config(win).zindex
				and vim.bo[buf].buftype == ""
				and vim.api.nvim_buf_get_name(buf) ~= ""
				and not vim.wo[win].diff
				and vim.filetype ~= "terminal"
				and vim.bo.filetype ~= "Trouble"
		end,
	},
	icons = {
		enable = true,
		kinds = {
			use_devicons = true,
			symbols = {
				Folder = "󰉋 ",
			},
		},
		ui = {
			bar = {
				separator = " ",
				extends = "…",
			},
			menu = {
				separator = " ",
				indicator = " ",
			},
		},
	},
	bar = {
		sources = function(buf, _)
			local sources = require("dropbar.sources")
			local utils = require("dropbar.utils")
			if vim.bo[buf].ft == "markdown" then
				return {
					sources.path,
					utils.source.fallback({
						sources.treesitter,
						sources.markdown,
						sources.lsp,
					}),
				}
			end
			return {
				sources.path,
				utils.source.fallback({
					sources.lsp,
					sources.treesitter,
				}),
			}
		end,
	},
	sources = {
		path = {
			-- Fullpath
			-- relative_to = function()
			-- 	return vim.fn.getcwd()
			-- end,
			-- Only filename
			relative_to = function(_)
				local fullpath = vim.api.nvim_buf_get_name(0)
				local filename = vim.fn.fnamemodify(fullpath, ":t")
				return fullpath:sub(0, #fullpath - #filename)
			end,
		},
	},
}
