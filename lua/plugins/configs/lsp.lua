local M = {}

M.fidget = {
	text = {
		spinner = "pipe", -- animation shown when tasks are ongoing
		done = "✔", -- character shown when all tasks are complete
		commenced = "Started", -- message shown when task starts
		completed = "Completed", -- message shown when task completes
	},
	fmt = {
		stack_upwards = false, -- list of tasks grows upwards
	},
	timer = {
		fidget_decay = 0, -- how long to keep around empty fidget, in ms
		task_decay = 0, -- how long to keep around completed task, in ms
	},
}

return M
