local lines = require("utils.lines")
local icons = require("utils.icons")

-- Allow lualine to resolve modules through the normal require.
local lualine_require = require("lualine_require")
lualine_require.require = require

-- Restore statusline now that lualine takes over (it was hidden on the starter page).
vim.o.laststatus = vim.g.lualine_laststatus

return {
  options = {
    globalstatus = true,
    icons_enabled = vim.g.icons_enabled,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = lines.disabled_filetypes.statusline },
  },
  sections = {
    lualine_a = { { "fancy_mode", width = 3 } },
    lualine_b = { { "branch", icon = icons.ui.git_branch, separator = "" } },
    lualine_c = {
      "%=",
      lines.navic_location,
      { "filename", color = { fg = "fg" }, cond = lines.navic_missing, },
    },
    lualine_x = {
      "fancy_macro",
      lines.tab_indicator,
      { "encoding",   cond = lines.show_encoding },
      { "fileformat", cond = lines.show_fileformat },
    },
    lualine_y = {
      { "diagnostics", sources = { "nvim_workspace_diagnostic" }, symbols = lines.diag_symbols },
      "progress",
    },
  },
  winbar = lines.winbar_cfg(lines.winbar_left({ lines.winbar_filename_text }), lines.winbar_right()),
  inactive_winbar = lines.winbar_cfg(
    lines.winbar_left({
      "filename",
      path = 1,
      symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]" },
    }),
    lines.winbar_right()
  ),
  extensions = {
    "nvim-dap-ui",
    "oil",
    "quickfix",
    "trouble",
  },
}
