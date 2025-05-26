return {

  -- File management
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    opts = {
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { "-", "<cmd>Oil --float<CR>", silent = true, desc = "Open folder in Oil" },
    },
  },
}
