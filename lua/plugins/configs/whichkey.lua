local wk = require("which-key")

wk.register({
	f = { name = "Find" },
	c = { name = "Code/Config" },
	g = { name = "Git" },
	h = { name = "Help" },
	r = { name = "Replace" },
	s = { name = "Search" },
	t = { name = "Terminal" },
	w = { name = "Workspace" },
}, { prefix = "<leader>" })
