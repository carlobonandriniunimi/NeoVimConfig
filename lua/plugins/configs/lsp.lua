local M = {}

M.fidget = {
	text = {
		spinner = "bouncing_ball", -- animation shown when tasks are ongoing
		done = "✔", -- character shown when all tasks are complete
		commenced = "Started", -- message shown when task starts
		completed = "Completed", -- message shown when task completes
	},
	fmt = {
		stack_upwards = false, -- list of tasks grows upwards
	},
	window = {
		relative = "win", -- where to anchor, either "win" or "editor"
		blend = 0, -- &winblend for the window
	},
	timer = {
		fidget_decay = 0, -- how long to keep around empty fidget, in ms
		task_decay = 0, -- how long to keep around completed task, in ms
	},
}

return M
