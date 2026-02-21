local icons = require("utils.icons")

return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    preset = "helix",
    win = {
      border = "none",
      padding = { 1, 4 },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    -- Document existing key chains
    local function make_which_key_group(keymap, group, mode)
      local icon = icons.which_key[group] or " "
      wk.add({
        { keymap, group = group, icon = icon, mode = mode or "n" },
        { keymap .. "_", hidden = true },
      })
    end
    local groups = {
      { keymap = "<leader>c", group = "Code" },
      { keymap = "<leader>d", group = "Debug" },
      { keymap = "<leader>f", group = "Find" },
      { keymap = "<leader>g", group = "Git" },
      { keymap = "<leader>gh", group = "Hunk" },
      { keymap = "<leader>gt", group = "Toggle" },
      { keymap = "<leader>l", group = "Line" },
      { keymap = "<leader>n", group = "Next" },
      { keymap = "<leader>p", group = "Previous" },
      { keymap = "<leader>r", group = "Refactor" },
      { keymap = "<leader>s", group = "Session" },
      { keymap = "<leader>t", group = "Tab" },
      { keymap = "<leader>u", group = "UI" },
      { keymap = "<leader>w", group = "Workspace" },
      { keymap = "<leader>x", group = "Trouble" },
    }
    for _, spec in ipairs(groups) do
      make_which_key_group(spec.keymap, spec.group)
    end
  end,
}
