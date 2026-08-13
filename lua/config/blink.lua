local colorful_menu = require("colorful-menu")

---@module 'blink.cmp'
---@type blink.cmp.Config
return {
  keymap = {
    preset = "default",
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-j>"] = { "select_and_accept" },
    ["<C-k>"] = { "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "cancel" },
    ["<C-y>"] = { "select_and_accept" },
  },
  appearance = {
    nerd_font_variant = "normal",
  },
  completion = {
    trigger = {
      show_on_keyword = true,
      show_on_trigger_character = true,
    },
    ghost_text = { enabled = true },
    menu = {
      auto_show = true,
      border = "none",
      draw = {
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            width = { fill = true },
            text = colorful_menu.blink_components_text,
            highlight = colorful_menu.blink_components_highlight,
          },
        },
      },
    },
    documentation = { auto_show = true, window = { border = "solid" } },
  },
  signature = { enabled = true },
  sources = { default = { "lsp", "path", "buffer" } },
  cmdline = {
    enabled = true,
    keymap = { preset = "cmdline" },
  },
}
