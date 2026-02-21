local M = {}

M.cmp_sources = {
  buffer = "󰊄 ",
  nvim_lsp = "󰘧 ",
  luasnip = "󰺫 ",
  nvim_lua = " ",
  path = "󰙅 ",
}

M.diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = "󰠠 ",
  Info = " ",
}

M.mason = {
  package_installed = "✓",
  package_pending = "➜",
  package_uninstalled = "✗",
}

M.ui = {
  bookmark = " ",
  bug = " ",
  file = " ",
  git_branch = "",
  keyboard = " ",
  open_folder = " ",
}

M.which_key = {
  Code = "",
  Debug = "",
  Find = "",
  Git = "",
  Hunk = "󰅪",
  Line = "󰞷",
  Next = "󰒭",
  Previous = "󰒮",
  Refactor = "",
  Session = "",
  Tab = "󰓩",
  Toggle = "󰔡",
  UI = "󰍹",
  Workspace = "󱒔",
  Trouble = "",
}

return M
