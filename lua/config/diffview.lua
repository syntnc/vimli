return {
  enhanced_diff_hl = true,
  key_bindings = {
    file_panel = { q = "<Cmd>DiffviewClose<CR>" },
    file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
    view = { q = "<Cmd>DiffviewClose<CR>" },
  },
  view = {
    default = {
      layout = "diff2_horizontal",
      winbar_info = true,
    },
    merge_tool = {
      layout = "diff3_mixed",
      winbar_info = true,
    },
  },
}
