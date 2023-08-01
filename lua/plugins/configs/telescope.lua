require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
      i = { ["<esc>"] = require("telescope.actions").close },
    },
  },
}
