local map = vim.keymap.set

-- general mappings
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", ";", ":")
map("n", "<leader>x", "<cmd> bdelete <CR>")
map("n", "<leader>q", "<cmd> qa <CR>")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- buffer manipulation
map("n", "H", "<cmd> bprev <CR>")
map("n", "L", "<cmd> bnext <CR>")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- mason
map("n", "<leader>hm", "<cmd>Mason<cr>", { desc = "Mason" })

-- neotree
map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>")

-- telescope
map("n", "<leader><leader>", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fr", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>hc", "<cmd> Telescope colorscheme <CR>")

-- comment.nvim
map("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end)
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- toggleterm
map("n", "<C-t>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Tab" })
