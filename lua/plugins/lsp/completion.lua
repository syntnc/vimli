return {
  "Saghen/blink.cmp",
  version = "1.*",
  event = { "CmdLineEnter", "InsertEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
      opts = { history = true, delete_check_events = "TextChanged" },
    },
    "xzbdmw/colorful-menu.nvim",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "normal",
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      list = {
        selection = {
          auto_insert = function(cmp)
            return cmp.ctx ~= "cmdline"
          end,
          preselect = false,
        },
      },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = require("colorful-menu").blink_components_text,
              highlight = require("colorful-menu").blink_components_highlight,
            },
          },
          treesitter = { "lsp" },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
    },
    keymap = { preset = "default" },
    signature = { enabled = true },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.default",
  },
}
