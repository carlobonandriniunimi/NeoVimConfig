require("noice").setup({
  presets = {
    bottom_search = true,       -- use a classic bottom cmdline for search
    command_palette = true,     -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,         -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true,      -- add a border to hover docs and signature help
  },
  lsp = {
    progress = {
      enabled = false,
      -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
      -- See the section on formatting for more details on how to customize.
      format = "lsp_progress",
      format_done = "lsp_progress_done",
      throttle = 1000 / 30, -- frequency to update lsp progress message
      view = "mini",
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = true,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      enabled = true,
      silent = true, -- set to true to not show a message if hover is not available
    },
  },
})
