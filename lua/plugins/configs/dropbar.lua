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
			local filename = {
				get_symbols = function(buff, win, cursor)
					local path = sources.path.get_symbols(buff, win, cursor)
					return { path[#path] }
				end,
			}
			if vim.bo[buf].ft == "markdown" then
				return {
					filename,
					utils.source.fallback({
						sources.treesitter,
						sources.markdown,
						sources.lsp,
					}),
				}
			end
			return {
				filename,
				utils.source.fallback({
					sources.lsp,
					sources.treesitter,
				}),
			}
		end,
	},
}
