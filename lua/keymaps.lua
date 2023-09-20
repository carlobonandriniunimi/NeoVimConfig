local map = vim.keymap.set

-- general mappings
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", ";", ":")
map("n", "<leader>x", function()
	-- If there is only one window, act as close buffer
	if vim.fn.winbufnr(2) == -1 then
		vim.cmd("bd")
	-- Else, close window
	else
		vim.cmd("q")
	end
end, { desc = "Close buffer" })
map("n", "<leader>q", "<cmd> qa <CR>", { desc = "Quit all" })
map("n", "<leader>cc", "<cmd> cd ~/.config/nvim <CR>", { desc = "CD Config" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- split windows
map("n", "<C-w>h", "<cmd> split <CR>")
map("n", "<C-w>v", "<cmd> vsplit <CR>")

-- move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- buffer manipulation
map("n", "H", "<cmd> bprev <CR>")
map("n", "L", "<cmd> bnext <CR>")
map("n", "<leader>,", "<cmd> Telescope buffers <cr>", { desc = "Find buffers" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- mason
map("n", "<leader>hm", "<cmd>Mason<cr>", { desc = "Mason" })

-- neotree
map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", { desc = "NvimTree" })

-- telescope
map("n", "<leader><leader>", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fr", "<cmd> Telescope oldfiles <CR>", { desc = "Find recent files" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Find word" })
map("n", "<leader>hc", "<cmd> Telescope colorscheme <CR>", { desc = "Find colorscheme" })

-- toggleterm
map("n", "<C-t>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })

-- trouble
map("n", "gr", function()
	require("trouble").open("lsp_references")
end, { desc = "Goto references" })
map("n", "ge", function()
	require("trouble").open("document_diagnostics")
end, { desc = "File Diagnostics" })
map("n", "gt", "<cmd>TodoTrouble<cr>", { desc = "Todo Trouble" })
