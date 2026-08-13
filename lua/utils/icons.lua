local M = {}

M.ui = {
  edit = "󰏫 ",
  bug = " ",
  git_branch = "󰘬 ",
  keyboard = "󰌌 ",
  file = "󰈙 ",
  open_folder = "󰝰 ",
  bookmark = "󰃀 ",
}

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

M.statusline = {
  lsp_info = " ",
  tab_indicator = " ",
}

M.cmp = {
  sources = {
    buffer = "󰊄 ",
    nvim_lsp = "󰘧 ",
    luasnip = "󰺫 ",
    nvim_lua = " ",
    path = "󰙅 ",
  },
}

return M
