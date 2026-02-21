local icons = require("utils.icons")
local statusline = require("utils.statusline")

return {
  -- Set statusline and winbar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-mini/mini.icons",
      "meuter/lualine-so-fancy.nvim",
    },
    event = { "BufReadPre", "BufWinEnter" },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require
      vim.o.laststatus = vim.g.lualine_laststatus
      local disabled_filetypes = {
        statusline = { "snacks_dashboard" },
        winbar = { "", "snacks_dashboard", "terminal", "toggleterm" },
      }
      local function winbar_cfg(components)
        for _, component in ipairs(components) do
          component.cond = function()
            return not vim.tbl_contains(disabled_filetypes.winbar, vim.bo.filetype)
          end
          component.color = { bg = "NONE" }
        end
        -- stylua: ignore
        return {
          lualine_a = {}, lualine_b = {}, lualine_c = components,
          lualine_x = {}, lualine_y = {}, lualine_z = {},
        }
      end
      local opts = {
        options = {
          theme = function()
            local auto = require("lualine.themes.auto")
            local modes = { "inactive", "insert", "normal", "replace", "visual" }
            for _, mode in ipairs(modes) do
              auto[mode].b.bg = "base"
              auto[mode].c.bg = "base"
            end
            return auto
          end,
          globalstatus = true,
          icons_enabled = vim.g.icons_enabled,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = disabled_filetypes.statusline },
        },
        -- some change
        sections = {
          lualine_a = { { "fancy_mode", width = 3 } },
          lualine_b = {
            { "branch", icon = icons.ui.git_branch, color = { bg = "base" } },
            { "fancy_diff", color = { bg = "base" } },
          },
          lualine_c = {
            "%=",
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1 },
            "fancy_diagnostics",
          },
          lualine_x = {
            "fancy_macro",
            statusline.components.tab_indicator,
            -- statusline.components.harpoon,
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
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 },
          { "fancy_diagnostics" },
        }),
        extensions = {
          "lazy",
          "mason",
          "neo-tree",
          "nvim-dap-ui",
          "oil",
          "quickfix",
          "trouble",
        },
      }
      return opts
    end,
  },
}
