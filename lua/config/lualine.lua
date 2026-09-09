local statusline = require("utils.statusline")
local icons = require("utils.icons")

-- Allow lualine to resolve modules through the normal require.
local lualine_require = require("lualine_require")
lualine_require.require = require

-- Restore statusline now that lualine takes over (it was hidden on the starter page).
vim.o.laststatus = vim.g.lualine_laststatus

local disabled_filetypes = {
  statusline = {
    "grug-far",
    "lazy",
    "snacks_dashboard",
    "snacks_terminal",
    "TelescopePrompt",
    "vimpack",
  },
  winbar = {
    "",
    "grug-far",
    "snacks_dashboard",
    "snacks_terminal",
    "terminal",
    "toggleterm",
  },
}

local function winbar_cfg(components)
  for _, component in ipairs(components) do
    component.cond = function()
      return not vim.tbl_contains(disabled_filetypes.winbar, vim.bo.filetype)
    end
    component.color = component.color or {}
    component.color.bg = component.color.bg or "NONE"
  end
  -- stylua: ignore
  return {
    lualine_a = {},
    lualine_b = {},
    lualine_c = components,
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }
end

return {
  options = {
    globalstatus = true,
    icons_enabled = vim.g.icons_enabled,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = disabled_filetypes.statusline },
  },
  sections = {
    lualine_a = { { "fancy_mode", width = 3 } },
    lualine_b = {
      {
        "branch",
        icon = icons.ui.git_branch,
        separator = "",
      },
      "fancy_diff",
    },
    lualine_c = {
      "%=",
      { "filename", path = 1, color = { fg = "fg" } },
      "fancy_diagnostics",
    },
    lualine_x = {
      "fancy_macro",
      statusline.components.tab_indicator,
      {
        "encoding",
        cond = function()
          return vim.bo.fileencoding ~= "utf-8"
        end,
      },
      {
        "fileformat",
        cond = function()
          return vim.bo.fileformat ~= "unix"
        end,
      },
      "filetype",
    },
    lualine_y = { statusline.components.lsp_info },
  },
  winbar = winbar_cfg({
    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
    { "filename", path = 0 },
    {
      function()
        return require("nvim-navic").get_location()
      end,
      cond = function()
        return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
      end,
    },
  }),
  inactive_winbar = winbar_cfg({
    {
      "filetype",
      icon_only = true,
      separator = "",
      padding = { left = 1, right = 0 },
    },
    { "filename",    path = 1 },
    { "diagnostics", symbol = require("utils.icons").diagnostics },
  }),
  extensions = {
    "nvim-dap-ui",
    "oil",
    "quickfix",
    "trouble",
  },
}
